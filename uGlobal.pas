unit uGlobal;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Dialogs, Forms,
 ShellApi, IniFiles, ComCtrls, TypInfo;

Type
 IniRead = (Str,Int,Bol);

  function CheckError: Boolean;
  function IncDelim(S: string): string;
  function CheckPath(APath: WideString): Boolean;

  function ReadIniPrm(Path, Sect, Param: string; Read: IniRead): Variant;
  function PropertyExists(const Prop: string; Obj: TObject): Boolean;
  function GetProperty(Obj: TComponent; const AName: WideString; const APrefer: Boolean): Variant;
  procedure WriteIniPrm(Path,Sect,Param: string; Write: IniRead; Value: Variant);
  procedure SetProperty(Obj: TComponent; const AName: WideString; const AValue: Variant);
  procedure ReadIniParam(Form: TForm);
  procedure WriteIniParam(Form: TForm);
  procedure SetFormToCenter(Form: TForm);
  procedure Localize(Form: TForm; Country: string);

const
 DllName = 'FRBase.dll';
 ConfName = 'FRConfig.ini';

var
 FRPath, FRLanguag, FRLngPath: string; // шдях до директорії з програмою

implementation


uses
 main;

{ **************************** Позиціювання форми  *************************** }
procedure SetFormToCenter(Form: TForm);
begin
  with Form do
  begin
    Left := Round((Screen.Width / 2) - (Form.Width / 2));
    Top := Round((Screen.Height / 2) - (Form.Height / 2));
  end;
end;
{*******************  Функції доступу до параметрів ************************** }
function PropertyExists(const Prop: string; Obj: TObject): Boolean;
begin
  Result := GetPropInfo(Obj, Prop) <> nil;
end;
procedure SetProperty(Obj: TComponent; const AName: WideString; const AValue: Variant);
begin
   SetPropValue(Obj, AName, AValue);
end;
function GetProperty(Obj: TComponent; const AName: WideString; const APrefer: Boolean): Variant;
begin
 Result := GetPropValue(Obj, AName, APrefer);
end;
{*******************  Якщо директорії немає то створюємо її ****************** }
function CheckPath(APath: WideString): Boolean;
begin
 Result := True;
 if APath[2] = ':' then Exit;
 if not DirectoryExists(APath) then
  if not CreateDir(APath) then Result := False;
end;
{*******************  Якщо невистачає \ то дописуєм його ********************* }
function IncDelim(S: string): string;
begin
 Result := IncludeTrailingPathDelimiter(S);
end;
{*******************  Перевірка наявності зображення ************************* }
function CheckError: Boolean;
begin
 Result := False;
 if MainForm.Image.Picture.Graphic = nil then Result := True;
end;
{*******************  Зчитуванняя ini параметру ****************************** }
function ReadIniPrm(Path,Sect,Param: string;Read: IniRead): Variant;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(Path);
  try
   case Read of
     Int: Result := ini.ReadInteger(Sect, Param, 0);
     Str: Result := ini.ReadString(Sect, Param, '');
     Bol: Result := ini.ReadBool(Sect, Param, false);
    end;
  finally
    FreeAndNil(ini);
  end;
end;
{*******************  Запис ini параметру ****************************** }
procedure WriteIniPrm(Path,Sect,Param: string; Write: IniRead; Value: Variant);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(Path);
  try
   case Write of
     Int: ini.WriteInteger(Sect, Param, Value);
     Str: ini.WriteString(Sect, Param, Value);
     Bol: ini.WriteBool(Sect, Param, Value);
    end;
  finally
    FreeAndNil(ini);
  end;
end;
{******************* записуєм параметри компонентів ************************** }
// так як спочатку записуєм індкс потім text компоненти в яких цих
// параметрів двої відбувається затирання тому в Checkbox ItemIndex ми неотримуємо
procedure WriteIniParam(Form: TForm);
var
  j: Word;
  ini: TIniFile;
begin
  ini := TIniFile.Create(FRPath + ConfName);
  try
    j := 0;
   with Form do begin
    while j < ComponentCount do
    begin
     if Components[j].Tag <> -1 then
      begin
        if PropertyExists('Text',Components[j]) then
           ini.WriteString('Str',Components[j].name,
           GetProperty(Components[j],'Text',true));

        if PropertyExists('ItemIndex',Components[j]) then
           ini.WriteInteger('Int',Components[j].name,
           GetProperty(Components[j],'ItemIndex',true));

        if PropertyExists('ListItemIndex',Components[j]) then
           ini.WriteInteger('Int',Components[j].name,
           GetProperty(Components[j],'ListItemIndex',true));

        if PropertyExists('Checked',Components[j]) then
           ini.WriteBool('Bol',Components[j].name,
           GetProperty(Components[j],'Checked',true));

        if PropertyExists('Position',Components[j]) then
           ini.WriteInteger('Int',Components[j].name,
           GetProperty(Components[j],'Position',true));

        if PropertyExists('Selected',Components[j]) then
           ini.WriteInteger('Col',Components[j].name,
           GetProperty(Components[j],'Selected',true));

        if PropertyExists('Value',Components[j]) then
           ini.WriteInteger('Int',Components[j].name,
           GetProperty(Components[j],'Value',true));
       end;
      inc(j);
    end;
   end;
  finally
    FreeAndNil(ini);
  end;
end;
{******************* Читаємо параметри компонентів *************************** }
procedure ReadIniParam(Form: TForm);
var
  j: Word;
  ini: TIniFile;
begin
  ini := TIniFile.Create(FRPath +  ConfName);
  try
    j := 0;
   with Form do begin
    while j < ComponentCount do
    begin
      if Components[j].Tag <> -1 then
       begin
        if PropertyExists('Text',Components[j]) then
           SetProperty(Components[j],'Text',
           ini.ReadString('Str',Components[j].name,''));

        if PropertyExists('ItemIndex',Components[j]) then
           SetProperty(Components[j],'ItemIndex',
           ini.ReadInteger('Int',Components[j].name,0));

        if PropertyExists('Checked',Components[j]) then
           SetProperty(Components[j],'Checked',
           ini.ReadBool('Bol',Components[j].name,False));

        if PropertyExists('ListItemIndex',Components[j]) then
           SetProperty(Components[j],'ListItemIndex',
           ini.ReadInteger('Int',Components[j].name,0));

        if PropertyExists('Position',Components[j]) then
           SetProperty(Components[j],'Position',
           ini.ReadInteger('Int',Components[j].name,0));

        if PropertyExists('Selected',Components[j]) then
           SetProperty(Components[j],'Selected',
           ini.ReadInteger('Col',Components[j].name,0));

        if PropertyExists('Value',Components[j]) then
           SetProperty(Components[j],'Value',
           ini.ReadFloat('Int',Components[j].name,0));
       end;
      inc(j);
    end; // while
   end;  // with
  finally
    FreeAndNil(ini);
  end; // try
end;
{*********************************  Локалізація ****************************** }
procedure Localize(Form: TForm; Country: string);
var
  j: Word;
  ini: TIniFile;
begin
  ini := TIniFile.Create(FRPath + 'Language\' +  Country);
  try
    j := 0;
   with Form do begin
    while j < ComponentCount do
    begin
     if Components[j].Tag <> -2 then
        if PropertyExists('Caption',Components[j]) then
           SetProperty(Components[j],'Caption',
           ini.ReadString('Language',Components[j].name,''));
      inc(j);
    end;
   end;
  // Set TForm(Caption)
  Form.Caption := ReadIniPrm(
                             FRPath + 'Language\' +  Country,
                             'FormCaption',
                             Form.Name,
                             Str
                            );
  finally
    FreeAndNil(ini);
  end;
end;

initialization
   FRPath := ExtractFilePath(ParamStr(0));
   FRLanguag := ReadIniPrm(FRPath + ConfName,'Str','cbSystemLanguage', Str) + '.lng';
   FRLngPath := FRPath + 'Language\' + FRLanguag;
finalization

end.
