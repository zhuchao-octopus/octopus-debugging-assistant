unit CRC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  StdCtrls;




  var
  //生成多项式的值（多项式因子）
  //注意：CRC16是数据流的高位先计算，多项式因子不变
  //而CRC32和CRC8都是数据流的低位先计算，所以多项式因子的高/低位对调
  //比如CRC32由$04C11DB7变为$EDB88320，CRC8由$31变为$8C
  GenPoly32: DWord; // CRC-32 = X32+X26+X23+X22+X16+X12+X11+X10+X8+X7+X5+X4+X2+X1+1
                    // 00000100 11000001 00011101 10110111($04C11DB7) 低位先行($EDB88320)
  GenPoly16: Word;  // CRC-CCITT16 = X16+X12+X5+1, 00010000 00100001($1021) 高位先行
                    // CRC-16      = X16+X15+X2+1, 10000000 00000101($8005) 高位先行
  GenPoly8:  Byte;  // CRC-8 = X8+X5+X4+1, 00110001($31) 低位先行($8C)
  GenPoly4:  Byte;  // CRC-4 = X4+X1+1, 0011($03)

  CRC32Tab: array [0..255] of DWord; // CRC32快速计算查表
  CRC16Tab: array [0..255] of Word;  // CRC16快速计算查表
  CRC8Tab : array [0..255] of Byte;  // CRC8 快速计算查表


  function CalCRC8(data, crc, genpoly: Byte): Byte;
  function QuickCRC8(data, crc: Byte): Byte;

  procedure InitCRC8Tab(genpoly: DWord);


implementation



///////////////////////////////////////////////////////////
// 16位CRC：按位计算，速度最慢，占用空间最少
// 注：数据流是高位先行
///////////////////////////////////////////////////////////
function CalCRC16(data, crc, genpoly: Word): Word;
var i: Integer;
begin
  // 方法1：摘自XMODEM协议
  crc := crc xor (data shl 8);
  for i:=0 to 7 do
    if (crc and $8000) <> 0 then // 只测试最高位
      crc := (crc shl 1) xor genpoly // 最高位为1，移位和异或处理
    else crc := crc shl 1;           // 否则只移位（乘2）
  Result := crc;
{
  // 方法2：算法有些不同，但结果相同
  data := data shl 8; // 移到高字节
  for i:=7 downto 0 do
  begin
    if ((data xor crc) and $8000) <> 0 then // 只测试最高位
      crc := (crc shl 1) xor genpoly // 最高位为1，移位和异或处理
    else crc := crc shl 1;           // 否则只移位（乘2）
    data := data shl 1; // 处理下一位
  end;
  Result := crc;

  // 方法3：摘自<<CRC算法原理及C语言实现>>
  for i:=7 downto 0 do
  begin
    if (crc and $8000) <> 0 then
      crc := (crc*2) xor genpoly // 余式CRC乘以2再求CRC
    else crc := crc*2;
    if (data and (1 shl i)) <> 0 then
      crc := crc xor genpoly; // 再加上本位的CRC
  end;
  Result := crc;
}
{
; MCS51的CRC-16计算函数(多项式因子为$1021, 高位先行)
; 调用：CRC16H/CRC16L=原CRC16值(16位，初始值为0000h)，A=待计算数据(8位)
; 结果：CRC16H/CRC16L=计算后的CRC16值(16位)
CalCRC16:
        push  00h          ; Save R0
        push  acc          ; Save Acc
        mov   r0,#08       ; 8 Bits In A Byte
        xrl   CRC16H,a     ; CRC16H ^= Data
lp1:    clr   c            ; 0 Into Low Bit
        mov   a,CRC16L     ; CRC16H/CRC16L <<= 1
        rlc   a
        mov   CRC16L,a
        mov   a,CRC16H
        rlc   a
        mov   CRC16H,a
        jnc   lp2          ; Skip If Bit 15 Wasn't Set
        xrl   CRC16H,#10h  ; CRC16H/CRC16L ^= $1021
        xrl   CRC16L,#21h
lp2:    djnz  r0,lp1       ; Repeat R0 More Times
        pop   acc          ; Recover Acc
        pop   00h          ; Recover R0
        ret
}
end;

///////////////////////////////////////////////////////////
// 16位CRC：生成CRC16表(256项)，用于快速查表计算
// 在程序初始化时就先调用，预先生成CRC16Tab[256]查表数据
///////////////////////////////////////////////////////////
procedure InitCRC16Tab(genpoly: DWord);
var i: Integer;
begin
  for i:=0 to 255 do
    CRC16Tab[i] := CalCRC16(i,0,genpoly);
end;

///////////////////////////////////////////////////////////
// 16位CRC：通过查表快速计算，速度快，占用空间多
// 要预先生成CRCTab[256]查表数据
///////////////////////////////////////////////////////////
function QuickCRC16(data, crc: Word): Word;
begin
  // 方法1：按字节计算CRC，通过查表(256项)快速计算
  //        速度最快，占用空间最多，需要256项数据的表格空间
  crc := CRC16Tab[(crc shr 8) xor data] xor (crc shl 8);
  Result := crc;
{
  // 方法2：按半字节计算CRC，通过查表(16项)快速计算
  //        速度比较快，占用空间也比较少，只需要表格的前16项数据
  crc := CRCTab[(crc shr 12) xor (data shr 4)] xor (crc shl 4);
  crc := CRCTab[(crc shr 12) xor (data and $0F)] xor (crc shl 4);
  Result := crc;
}
{
; MCS51的CRC-16快速查表计算函数
; 要预先生成CRC16查表数据，起始地址CRC16Tab，按高/低字节顺序存放(512字节)
; 调用：CRC16H/CRC16L=原CRC16值(16位，初始值为0000h)，A=待计算数据(8位)
; 结果：CRC16H/CRC16L=计算后的CRC16值(16位)
QuickCRC16:
        push  dph             ; Save DPH
        push  dpl             ; Save DPL
        push  acc             ; Save Acc
        mov   dptr,#CRC16Tab  ; Point To Table
        xrl   a,CRC16H        ; XOR High Of CRC With Character
        call  UTIL_ADCAD      ; Add 'A' To 'DPTR'
        call  UTIL_ADCAD      ; Add 'A' To 'DPTR' (Yes, Twice)
        clr   a               ; Get High Byte From Table Entry
        movc  a,@a+dptr
        xrl   a,CRC16L        ; XOR With Low
        mov   CRC16H,a        ; Store To High Of CRC
        clr   a               ; Get Low Byte From Table Entry
        inc   dptr
        movc  a,@a+dptr
        mov   CRC16L,a        ; Store To Low Of CRC
        pop   acc             ; Recover Acc
        pop   dpl             ; Recover DPL
        pop   dph             ; Recover DPH
        ret
}
end;



///////////////////////////////////////////////////////////////////////////////////////////

Function CalXOR8(data, crc: Byte): Byte;
begin
    result:= data xor crc;
end;
Function CalXOR82(databuffer:array of Byte;crcStart: Byte;Length:Integer): Byte;
var
 i:Integer;
 co:Byte;
begin
  co:=co xor crcStart;
  for i:=0 to Length-1 do
  begin
      co:= databuffer[i] xor co;
  end;
  result:=co;
end;

///////////////////////////////////////////////////////////
// 8位CRC：按位计算，速度最慢，占用空间最少
// 注：数据流是低位先行，与16位CRC相反
///////////////////////////////////////////////////////////
function CalCRC8(data, crc, genpoly: Byte): Byte;
var i: Integer;
begin
  // 方法1：摘自XMODEM协议, 模仿CRC16计算方法, 但是低位先行
  crc := crc xor data;
  for i:=0 to 7 do
    if (crc and $01) <> 0 then // 只测试最低位
      crc := (crc shr 1) xor genpoly // 最低位为1，移位和异或处理
    else crc := crc shr 1;           // 否则只移位（除2）
  Result := crc;
{
  // 方法2：算法有些不同，但结果相同
  for i:=0 to 7 do
  begin
    if ((data xor crc) and $01) <> 0 then // 只测试最低位
      crc := (crc shr 1) xor genpoly // 最低位为1，移位和异或处理
    else crc := crc shr 1;           // 否则只移位（除2）
    data := data shr 1; // 处理下一位
  end;
  Result := crc;
}
{
; MCS51的CRC-8计算函数(多项式因子为$8C, 低位先行)
; 调用：B=原CRC8值(8位，初始值为00h)，A=待计算数据(8位)
; 结果：B=计算后的CRC8值(8位)
CalCRC8:
        push  00h          ; Save R0
        push  acc          ; Save Acc
        mov   r0,#08       ; 8 Bits In A Byte
        xrl   b,a          ; CRC8 ^= Data
lp1:    clr   c            ; 0 Into High Bit
        mov   a,b          ; CRC8 >>= 1
        rrc   a
        mov   b,a
        jnc   lp2          ; Skip If Bit 0 Wasn't Set
        xrl   b,#8Ch       ; CRC8 ^= $8C
lp2:    djnz  r0,lp1       ; Repeat R0 More Times
        pop   acc          ; Recover Acc
        pop   00h          ; Recover R0
        ret
}
end;

///////////////////////////////////////////////////////////
// 8位CRC：生成CRC8表(256项)，用于快速查表计算
// 在程序初始化时就先调用，预先生成CRC8Tab[256]查表数据
///////////////////////////////////////////////////////////
procedure InitCRC8Tab(genpoly: DWord);
var i: Integer;
begin
  for i:=0 to 255 do
    CRC8Tab[i] := CalCRC8(i,0,genpoly);
end;

///////////////////////////////////////////////////////////
// 8位CRC：通过查表快速计算，速度快，占用空间多
// 注：数据流是低位先行，与16位CRC相反
// 要预先生成CRC8Tab[256]查表数据
///////////////////////////////////////////////////////////
function QuickCRC8(data, crc: Byte): Byte;
begin
  crc := CRC8Tab[crc xor data];
  Result := crc;
{
; MCS51的CRC-8快速查表计算函数
; 要预先生成CRC8查表数据，起始地址CRC8Tab，按顺序存放(256字节)
; 调用：B=原CRC8值(8位，初始值为00h)，A=待计算数据(8位)
; 结果：B=计算后的CRC8值(8位)
QuickCRC8:
        push  dph             ; Save DPH
        push  dpl             ; Save DPL
        push  acc             ; Save Acc
        mov   dptr,#CRC8Tab   ; Point To Table
        xrl   a,b             ; XOR In CRC
        movc  a,@a+dptr       ; Get New CRC Byte
        mov   b,a             ; Store Back
        pop   acc             ; Recover Acc
        pop   dpl             ; Recover DPL
        pop   dph             ; Recover DPH
        ret
}
end;



/////////////////////////////////////////////////////////////////////////////////////////////





///////////////////////////////////////////////////////////
// 32位CRC：按位计算，速度最慢，占用空间最少
// 注：数据流是低位先行，与16位CRC相反
///////////////////////////////////////////////////////////
function CalCRC32(data, crc, genpoly: DWord): DWord;
var i: Integer;
begin
  // 方法1：摘自XMODEM协议, 模仿CRC16计算方法, 但是低位先行
  crc := crc xor data;
  for i:=0 to 7 do
    if (crc and $01) <> 0 then // 只测试最低位
      crc := (crc shr 1) xor genpoly // 最低位为1，移位和异或处理  //去掉高位
    else crc := crc shr 1;           // 否则只移位（除2）
  Result := crc;
end;

///////////////////////////////////////////////////////////
// 32位CRC：生成CRC32表(256项)，用于快速查表计算
// 在程序初始化时就先调用，预先生成CRC32Tab[256]查表数据
///////////////////////////////////////////////////////////
procedure InitCRC32Tab(genpoly: DWord);
var i: Integer;
begin
  for i:=0 to 255 do
    CRC32Tab[i] := CalCRC32(i,0,genpoly);
end;

///////////////////////////////////////////////////////////
// 32位CRC：通过查表快速计算，速度快，占用空间多
// 注：数据流是低位先行，与16位CRC相反
// 要预先生成CRC32Tab[256]查表数据
///////////////////////////////////////////////////////////
function QuickCRC32(data, crc: DWord): DWord;
begin
  crc := CRC32Tab[Byte(crc xor data)] xor (crc shr 8);
  Result := crc;
end;



///////////////////////////////////////////////////////////////////////////////////////////


end.
