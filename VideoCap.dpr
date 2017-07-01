program VideoCap;

uses
  fmStartOne,
  Forms,
  windows,
  SysUtils,
  Dialogs,
  main in 'main.pas' {MainForm},
  option in 'option.pas' {OptionForm},
  Unit2 in 'Unit2.pas' {Form1},
  uGlobal in 'uGlobal.pas',
  FaceRecognition in 'FaceRecognition.pas';

{$R *.res}

const
  UniqueString = 'FaceRecognition';

begin

   if not init_mutex(UniqueString) then
   begin
    ShowWindow(FindWindow(nil,'FaceRocognition'),SW_SHOWNORMAL);
    Exit;{Выходим,если мьютекс уже есть}
   end;

   Application.Initialize;

   if not FileExists(ExtractFilePath(Application.ExeName) + 'FRBase.dll') then begin
    MessageDlg('Can`t find FRBase.dll', mtError, [mbOK], 0);
    Exit;
   end else begin
    Application.Title := 'FaceRocognition';
    Application.CreateForm(TMainForm, MainForm);
    Application.CreateForm(TOptionForm, OptionForm);
    Application.CreateForm(TForm2, Form2);
  end;
  Application.Run;
end.
