program rgr;
{$mode objfpc}
uses System;

function Sym(number: integer): char;
{функция перевода десятичного числа в символьное представление}
begin
  case abs(number) of
    0..9: Sym := chr(48 + abs(number));
    10: Sym := 'A';
  end;
end;

function DecToX(num: real; baseNumber: integer): string;
var
  intResult, fracResult: string;
  I_num, FI_num: longint;
  F_num: single;
begin
  fracResult := '.';
  
  try
    I_num := trunc(num);
  except
    Writeln('Слишком большое или слишком маленькое число.');
    Writeln('Значение числа должно быть в диапазоне от -2147483648 до 2147483647');
    Readln();
    halt;
  end;
  
  try
    F_num := frac(num);
  except
    Writeln('Дробная часть числа не должна быть меньше, чем 1,5*10^(-45)');
    Readln();
    halt;
  end;
  
  while abs(I_num) > 0 do
  begin
    intResult := Sym(abs(I_num) mod baseNumber) + intResult;   
    I_num := abs(I_num) div baseNumber;
  end;
  
  
  for i: integer := 0 to 12 do
  begin
    F_num := F_num * baseNumber;
    FI_num := trunc(F_num);
    F_num := frac(F_num);
    fracResult := fracResult + Sym(FI_num);
  end;
  
  
  DecToX := intResult + fracResult;
end;

const
  notWrong = ['0'..'9', '.', '-'];

var
  res, number: string[13];
  floatNumber: real;
  baseNumberSystem: integer;
  endProgram: string;
  quit: boolean;

begin
  repeat
    write('Введите число в десятичной системе счисления -> ');  
    readln(number);
    
    for i: integer := 1 to Length(number) do
    begin
      if not (number[i] in notWrong) then
      begin
        Writeln('Недопустимый символ на позиции ', i);
        Readln();
        exit;      
      end;
    end;
    
    write('Введите систему счисления, в которую надо перевести (2 или 11) -> ');
    Readln(baseNumberSystem);
    if (baseNumberSystem <> 2) then
      if (baseNumberSystem <> 11) then
      begin
        Writeln('Введена неверная система счисления');
        exit;
      end;
    
    floatNumber := StrToFloat(number);
    res := DecToX(floatNumber, baseNumberSystem);
    if floatNumber > 0 then
      writeln(number, '(10) = ', res, '(', baseNumberSystem, ')')
    else if floatNumber < 0 then
      writeln(number, '(10) = ', '-', res, '(', baseNumberSystem, ')')
    else if floatNumber = 0 then
      writeln(number, '(10) = ', 0, '(', baseNumberSystem, ')');
    
    Writeln('Вы хотите выйти из программы? Если да, то введите quit. Если нет, то нажмите любую клавишу.');
    Readln(endProgram);
    if endProgram = 'quit' then quit := true;
  until quit;
  
end.