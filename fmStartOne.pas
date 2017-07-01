unit fmStartOne;

interface

function Init_Mutex(mid: string): boolean;

implementation

uses Windows;

var
  mut: thandle;

function mut_id(s: string): string;
var
  f: integer;
begin
  result := s;
  for f := 1 to length(s) do
    if result[f] = '\' then
      result[f] := '_';
end;

function Init_Mutex(mid: string): boolean;
begin
  Mut := CreateMutex(nil, false, pchar(mut_id(mid)));
  Result := not ((Mut = 0) or (GetLastError = ERROR_ALREADY_EXISTS));
end;

initialization
  mut := 0;
finalization
 if mut <> 0 then CloseHandle(mut);
end.
