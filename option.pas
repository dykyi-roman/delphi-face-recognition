unit option;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DSPack, DSUtil, DirectShow9, ComCtrls, ExtCtrls, IniFiles,
  Spin, Buttons, Mask, FRListBox;

type
  TOptionForm = class(TForm)
    VideoSourceFilter: TFilter;
    AudioSourceFilter: TFilter;
    PageControl: TPageControl;
    AudVidSheet: TTabSheet;
    CodecSheet: TTabSheet;
    PageControl1: TPageControl;
    WebSheet: TTabSheet;
    AudioSheet: TTabSheet;
    Panel1: TPanel;
    InputLines: TComboBox;
    Panel2: TPanel;
    gbAVSouns: TGroupBox;
    PanelBtn: TPanel;
    Cancel: TButton;
    HelpBtn: TButton;
    PageControl2: TPageControl;
    CodecVideo: TTabSheet;
    AudioCodec: TTabSheet;
    CodecBox: TGroupBox;
    GroupBox2: TGroupBox;
    SystemSheet: TTabSheet;
    FontSheet: TTabSheet;
    Effect: TTabSheet;
    PageControl3: TPageControl;
    Filtesr: TTabSheet;
    Fraime: TTabSheet;
    cbAutostart: TCheckBox;
    gbEffect: TGroupBox;
    EffectTrackBar: TTrackBar;
    rgMirror: TRadioGroup;
    cbEffect: TCheckBox;
    GroupBox: TGroupBox;
    labelAudioVideo1: TLabel;
    labelAV2: TLabel;
    GroupMode: TRadioGroup;
    EditKadr: TTrackBar;
    KadrEdit: TTrackBar;
    Panel3: TPanel;
    tsVideo: TTabSheet;
    tsPhoto: TTabSheet;
    btnVideoPath: TBitBtn;
    cbVideoFormat: TComboBox;
    labelVideo: TLabel;
    cbVideo: TCheckBox;
    cbVideo2: TCheckBox;
    btnPhotoPath: TBitBtn;
    cbPhoto: TCheckBox;
    labelPhoto: TLabel;
    cbPhotoFormat: TComboBox;
    labelPhoto2: TLabel;
    seVideo: TSpinEdit;
    sePhoto: TSpinEdit;
    sePhoto2: TSpinEdit;
    VideoCapFilters: TComboBox;
    labelAVCamera: TLabel;
    gbDataTime: TGroupBox;
    cbPhotoDate: TCheckBox;
    Bevel1: TBevel;
    labelPhotoDate: TLabel;
    labelPhotoTime: TLabel;
    cbPhotoTime: TCheckBox;
    cbPhotoDateTime: TComboBox;
    labelPhotoDateTime: TLabel;
    CaptureGraph: TFilterGraph;
    btnDefault: TButton;
    labelAVAudio: TLabel;
    AudioCapFilters: TComboBox;
    lbVideoCodec: TFRListBox;
    lbAudioCodec: TFRListBox;
    lbEffect: TFRListBox;
    lbEffectFraime: TFRListBox;
    AudioFormats: TFRListBox;
    SglagBox: TCheckBox;
    edVideo: TEdit;
    labelVideoPath: TLabel;
    edPhoto: TEdit;
    labelPhotoPath: TLabel;
    lavelSystem: TLabel;
    cbSystemLanguage: TComboBox;
    TimerTime: TTimer;
    cbSticky: TCheckBox;
    cbSaveFormPos: TCheckBox;
    PageControl4: TPageControl;
    tsColorAndRaise: TTabSheet;
    tsRecognitionOption: TTabSheet;
    gbMouth: TGroupBox;
    labellMouth2: TLabel;
    labellMouth: TLabel;
    seMouth4: TSpinEdit;
    cbMouth4: TCheckBox;
    gbNose: TGroupBox;
    labelNose2: TLabel;
    labelNose: TLabel;
    seNose3: TSpinEdit;
    cbNose3: TCheckBox;
    gbEyebrows: TGroupBox;
    labelEyebrows2: TLabel;
    labelEyebrows: TLabel;
    seEyebrows2: TSpinEdit;
    cbEyeBrowse2: TCheckBox;
    gbEyes: TGroupBox;
    labelEyes2: TLabel;
    labelEyes: TLabel;
    seEsys1: TSpinEdit;
    cbEyes1: TCheckBox;
    seFace0: TSpinEdit;
    labelFace: TLabel;
    labelFace2: TLabel;
    labelRecognition: TLabel;
    tbSensitivity: TTrackBar;
    Bevel2: TBevel;
    Bevel3: TBevel;
    btnRecogDefault: TButton;
    cbFiceCount: TCheckBox;
    tbMedianFilter: TTrackBar;
    VideoSheet: TTabSheet;
    labelFilter: TLabel;
    labelRecogLight: TLabel;
    tbRecogLight: TTrackBar;
    labelContrast: TLabel;
    tbRecogContrast: TTrackBar;
    btnWebDefault: TBitBtn;
    Bevel4: TBevel;
    Brightness: TTrackBar;
    labelVideoBright: TLabel;
    labelVideoContrast: TLabel;
    Contrast: TTrackBar;
    Hue: TTrackBar;
    Saturation: TTrackBar;
    AspectRatio: TCheckBox;
    labelVideoSaturation: TLabel;
    labelVideoHue: TLabel;
    labelVideoPX: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    PositionX: TTrackBar;
    PositionY: TTrackBar;
    SizeX: TTrackBar;
    SizeY: TTrackBar;
    tbSensitivity2: TTrackBar;
    labelRecognition2: TLabel;
    imgIntegral: TImage;
    imgIntegral2: TImage;
    clEyes1: TColorBox;
    clEyebrows2: TColorBox;
    clNose3: TColorBox;
    clMouth4: TColorBox;
    clFace0: TColorBox;
    procedure FormCreate(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure AudioCapFiltersClick(Sender: TObject);
    procedure GroupModeClick(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbSystemLanguageChange(Sender: TObject);
    procedure TimerTimeTimer(Sender: TObject);
    procedure cbPhotoDateClick(Sender: TObject);
    procedure cbPhotoClick(Sender: TObject);
    procedure cbVideoClick(Sender: TObject);
    procedure btnVideoPathClick(Sender: TObject);
    procedure btnPhotoPathClick(Sender: TObject);
    procedure cbAutostartClick(Sender: TObject);
    procedure lbEffectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbEffectFraimeDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure btnRecogDefaultClick(Sender: TObject);
    procedure tbSensitivityChange(Sender: TObject);
    procedure btnWebDefaultClick(Sender: TObject);
    procedure BrightnessChange(Sender: TObject);
    procedure ContrastChange(Sender: TObject);
    procedure HueChange(Sender: TObject);
    procedure SizeYChange(Sender: TObject);
    procedure AspectRatioClick(Sender: TObject);
    procedure tbSensitivity2Change(Sender: TObject);
    procedure cbEyes1Click(Sender: TObject);
    procedure seFace0Change(Sender: TObject);
    procedure cbEffectClick(Sender: TObject);
    procedure cbFiceCountClick(Sender: TObject);
  private
    procedure LoadAudioFilter;
    procedure EffectPrepare;
    procedure SetEnabled(GB: TWinControl; Enabled: Boolean);
    procedure SaveFaceChange(Obj: TObject);
    procedure FindFile(Dir: string;
                   Ext: string;
                   List: TStringList;
                   const ShowDir: Boolean = false;
                   const ShowExt: Boolean = true
                  );
  public
    procedure ReadStreamProperties;
    procedure SetDefaultParametrs;
  end;

const
 CSIDL_STARTUP = 7;

var
  OptionForm: TOptionForm;
  CapEnum: TSysDevEnum;
  ProcAmpControl: TVMR9ProcAmpControl;
  NormalizedRect: TVMR9NormalizedRect;
  VideoMediaTypes: TEnumMediaType;
  AudFilters  : TSysDevEnum;
  CapFilters  : TSysDevEnum;

implementation

uses
  main, uGlobal, FileCtrl, Shellapi, Unit2;

 function GetSpecialPath(CSIDL: Word): WideString; external DllName name 'GetSpecialPath';

{$R *.dfm}

function SetItemIndex(obj: TObject): Integer;
begin
 if (obj is TComboBox) then
  TComboBox(obj).ItemIndex  := Round( TComboBox(obj).Items.Count div 2);

 if (obj is TListBox) or (obj is TFRListBox) then
  TComboBox(obj).ItemIndex := Round( TListBox(obj).Items.Count div 2);
end;

{ ******************* читаємо властивості відео ****************************** }
procedure TOptionForm.ReadStreamProperties;
var ProcAmpControlRange: TVMR9ProcAmpControlRange;
  procedure Configure(TrackBar: TTrackBar; Prop: DWord);
  begin
    with (MainForm.VideoWindow as IVMRMixerControl9) do
    begin
      ZeroMemory(@ProcAmpControlRange, SizeOf(ProcAmpControlRange));
      ProcAmpControlRange.dwSize := SizeOf(ProcAmpControlRange);
      ProcAmpControlRange.dwProperty := Prop;
      if Succeeded(GetProcAmpControlRange(0, @ProcAmpControlRange)) then
      begin
        TrackBar.Min := Trunc(ProcAmpControlRange.MinValue);
        TrackBar.Max := Trunc(ProcAmpControlRange.MaxValue);
        if TrackBar.Min = TrackBar.Max then
          TrackBar.Enabled := False else
          begin
           TrackBar.Position := Trunc(ProcAmpControlRange.DefaultValue);
           TrackBar.Frequency := Trunc(ProcAmpControlRange.StepSize);
           TrackBar.Enabled := True;
          end;
      end else
      begin
        TrackBar.Min := 0;
        TrackBar.Max := 0;
        TrackBar.Position := 0;
        TrackBar.Frequency := 0;
        TrackBar.Enabled := False;
      end;
    end;
  end;
begin
  Configure(Contrast, ProcAmpControl9_Contrast);
  Configure(Brightness, ProcAmpControl9_Brightness);
  Configure(Hue, ProcAmpControl9_Hue);
  Configure(Saturation, ProcAmpControl9_Saturation);


  with (MainForm.VideoWindow as IVMRMixerControl9) do
  begin
    if succeeded(GetOutputRect(0, @NormalizedRect)) then
    begin
      PositionX.Enabled := True;
      PositionY.Enabled := True;
      SizeX.Enabled := True;
      SizeY.Enabled := True;
    end else
    begin
      PositionX.Enabled := False;
      PositionY.Enabled := False;
      SizeX.Enabled := False;
      SizeY.Enabled := False;
    end;
  end;
end;
{ --------------- завантаження фреймів із директорії ------------------------- }
procedure LoadFraime(ListBox: TListBox; List: TStringList);
var
 Bitmap, Bitmap2: TBitmap;
 i: Word;
begin
 if List.Count = 0 then Exit;
 with ListBox.Items do begin
   for i := 0 to List.Count - 1 do begin
     Bitmap := TBitmap.create;
     Bitmap2 := TBitmap.create;
     Bitmap2.SetSize(90,90);
     try
      Bitmap.LoadFromFile(List.Strings[i]);
      Bitmap2.Canvas.StretchDraw(Rect(0,0,90,90),Bitmap);
      AddObject('fraime_+' + IntToStr(i), Bitmap2);
     finally
      Bitmap.Free;
     end;  // try
   end; // for
 end; // with
end;
{ ----------------------- список файлів в директорії ------------------------- }
procedure TOptionForm.FindFile(Dir: string;
                   Ext: string;
                   List: TStringList;
                   const ShowDir: Boolean = false;
                   const ShowExt: Boolean = true
                  );
var
  F: TSearchRec;
  Path: string;
  Attr: Integer;

function Check(s: string): string;
begin
 if ShowExt then Result := s
  else Result := Copy(s, 1, length(s)-4);
end;

begin
  Path := dir + Ext;
  {которые имеют атрибуты "Только для чтения" и "Архивный"}
  Attr := faReadOnly + faAnyFile;
  FindFirst(Path, Attr, F);
  {Если хотя бы один файл найден, то продолжить поиск}
  if F.name <> '' then
  begin
    if ShowDir then List.Add(dir + Check(F.Name)) else List.Add(Check(F.Name));
    while FindNext(F) = 0 do
     if ShowDir then List.Add(dir + Check(F.Name)) else List.Add(Check(F.Name));
  end;
  FindClose(F);
end;

////////////////////////////////////////////////////////////////////////////////
/////////////////////////  TOptionForm    //////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

{ ----------------------- список Сховати/показати елементи контейнера -------- }
procedure TOptionForm.SetEnabled(GB: TWinControl; Enabled: Boolean);
var
 i: Byte;
begin
 for i := 0 to GB.ControlCount - 1 do
  if GB.Controls[i].Tag <> -2 then GB.Controls[i].Enabled := Enabled;
end;

procedure TOptionForm.SaveFaceChange(Obj: TObject);
var
 i,index: Byte;
 name: string;
begin
 name := string(TColorBox(Obj as TObject).Name);
 index := StrToInt(copy(name,length(name),1));
 with FRecog.FaceObjects do begin
 case index of
   0:
    begin
     Items[index].Size := seFace0.Value;
     Items[index].Color := clFace0.Selected;
    end;
   1:
    begin
     Items[index].Show := cbEyes1.Checked;
     Items[index].Size := seEsys1.Value;
     Items[index].Color := clEyes1.Selected;
    end;
   2:
    begin
     Items[index].Show := cbEyeBrowse2.Checked;
     Items[index].Size := seEyebrows2.Value;
     Items[index].Color := clEyebrows2.Selected;
    end;
   3:
    begin
     Items[index].Show := cbNose3.Checked;
     Items[index].Size := seNose3.Value;
     Items[index].Color := clNose3.Selected;
    end;
   4:
    begin
     Items[index].Show := cbMouth4.Checked;
     Items[index].Size := seMouth4.Value;
     Items[index].Color := clMouth4.Selected;
    end;
  end;
 end;
end;

procedure TOptionForm.seFace0Change(Sender: TObject);
begin
 SaveFaceChange(Sender);
end;

procedure TOptionForm.SizeYChange(Sender: TObject);
begin
  NormalizedRect.left   := PositionX.Position / 100;
  NormalizedRect.right  := (PositionX.Position + SizeX.Position) / 100;
  NormalizedRect.Top    := PositionY.Position / 100;
  NormalizedRect.Bottom := (PositionY.Position + SizeY.Position) / 100;
  with (MainForm.VideoWindow as IVMRMixerControl9) do
    SetOutputRect(0, @NormalizedRect);
end;

{ ----------------------- список файлів в директорії ------------------------- }
procedure TOptionForm.LoadAudioFilter;
var
  PinList: TPinList;
  i, LineIndex: integer;
  ABool: LongBool;
begin
  CapEnum.SelectGUIDCategory(CLSID_AudioInputDeviceCategory);
  if AudioCapFilters.ItemIndex <> -1 then
  begin
    AudioSourceFilter.BaseFilter.Moniker := CapEnum.GetMoniker(AudioCapFilters.ItemIndex);
    AudioSourceFilter.FilterGraph := CaptureGraph;
    CaptureGraph.Active := true;
    PinList := TPinList.Create(AudioSourceFilter as IBaseFilter);
    AudioFormats.Clear;
    i := 0;
    while i < PinList.Count do
      if PinList.PinInfo[i].dir = PINDIR_OUTPUT then
        begin
          AudioMediaTypes.Assign(PinList.Items[i]);
          PinList.Delete(i);
        end else inc(i);

    for i := 0 to AudioMediaTypes.Count - 1 do
    begin
      AudioFormats.Items.Add(AudioMediaTypes.MediaDescription[i]);
    end;

    CaptureGraph.Active := false;
    InputLines.Clear;
    LineIndex := -1;
    for i := 0 to PinList.Count - 1 do
    begin
      InputLines.Items.Add(PinList.PinInfo[i].achName);
      with (PinList.Items[i] as IAMAudioInputMixer) do get_Enable(ABool);
      if ABool then LineIndex := i;
    end;
    InputLines.ItemIndex := LineIndex;
    PinList.Free;
  end;
end;
{ ----------------------- список Параметри програми по замовченню ------------ }
procedure TOptionForm.SetDefaultParametrs;
begin
 // -- Audio and Video --
 GroupMode.ItemIndex := 0;
 EditKadr.Position := 15;
 KadrEdit.Position := 20;
 SglagBox.Checked := True;
 if VideoCapFilters.Items.Count > 0 then SetItemIndex(VideoCapFilters);
 if AudioCapFilters.Items.Count > 0 then SetItemIndex(AudioCapFilters);
 if AudioFormats.Items.Count > 0 then SetItemIndex(AudioFormats);
 // -- Codecs --
 if lbVideoCodec.Items.Count > 0 then SetItemIndex(lbVideoCodec);
 if lbAudioCodec.Items.Count > 0 then SetItemIndex(lbAudioCodec);
 // -- System --
 cbAutostart.Checked := False;
 cbSticky.Checked := false;
 cbSaveFormPos.Checked := False;
 if cbSystemLanguage.Items.Count > 0 then
  begin
    cbSystemLanguage.ItemIndex := 0;
    cbSystemLanguage.Text := cbSystemLanguage.Items[0];
    Localize(MainForm,cbSystemLanguage.Items[0] + '.lng');
    Localize(OptionForm,cbSystemLanguage.Items[0] + '.lng');
    FRLanguag := cbSystemLanguage.Items[0] + '.lng';
    FRLngPath := FRPath + 'Language\' + cbSystemLanguage.Items[0] + '.lng';
  end;
 // -- Recognition --
 seFace0.Value := 1; seEsys1.Value := 1; seEyebrows2.Value := 1; seNose3.Value := 1;
 seMouth4.Value := 1;
 cbEyes1.Checked := False; cbEyeBrowse2.Checked := False; cbNose3.Checked := False;
 cbMouth4.Checked := False;
 clFace0.Selected := clRed;
 clEyes1.Selected :=  clFuchsia;
 clEyebrows2.Selected := clOlive;
 clNose3.Selected := clYellow;
 clMouth4.Selected := clGreen;
 tbSensitivity.Position := 0;
 tbRecogLight.Position := 50;
 tbRecogContrast.Position := 0;
 cbFiceCount.Checked := False;
 tbMedianFilter.Position := 0;
 tbSensitivity2.Position := 11;
 tbSensitivity.Position := 10;
 // -- Effect --
 lbEffect.ItemIndex := 0;
 EffectTrackBar.Position := 0;
 cbEffect.Checked := False;
 if lbEffectFraime.Items.Count > 0 then lbEffectFraime.ItemIndex := 0;
 // -- Video --
 cbVideoFormat.ItemIndex := 0;
 cbVideo2.Checked := true;
 cbVideo.Checked := true;
 seVideo.Value := 5;
 VideoFile := FRPath + 'Video\';
 if not CheckPath(VideoFile) then ShowMessage('Error !!!') else
 edVideo.Text := VideoFile;
 // -- Photo --
 cbPhotoFormat.ItemIndex := 0;
 sePhoto.Value := 1;
 sePhoto2.Value := 5;
 cbPhoto.Checked := true;
 cbPhotoDate.Checked := true;
 cbPhotoTime.Checked := false;
 cbPhotoDateTime.Text := 'Left';
 cbPhotoDateTime.ItemIndex := 0;
 PhotoFile := FRPath + 'Photo\';
 if not CheckPath(PhotoFile) then ShowMessage('Error !!!') else
   edPhoto.Text := PhotoFile;
end;
{ **************************** Відобреження налаштувань ефектів ***************}
procedure TOptionForm.EffectPrepare;
begin
  // налаштування дзеркала
  if lbEffect.ItemIndex = lbEffect.Items.Count - 1 then
   rgMirror.Visible := True
  else
   rgMirror.Visible := False;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TOptionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteIniParam(OptionForm);
end;

procedure TOptionForm.FormCreate(Sender: TObject);

procedure LoadLanguage;
var
 LngList: TStringList;
begin
  LngList := TStringList.Create;
  try
    FindFile(FRPath + 'Language\','*.lng',LngList,false,false);
    cbSystemLanguage.Items.AddStrings(LngList);
  finally
  LngList.Free;
  end;
end;

procedure LoadCodeck;
var
 i: Word;
begin
 // вывод доступных кодеков в системе
  AudFilters  := TSysDevEnum.Create(CLSID_AudioCompressorCategory);
  CapFilters := TSysDevEnum.create(CLSID_VideoCompressorCategory);
  For i := 0 to CapFilters.CountFilters - 1 do
    lbVideoCodec.Items.Add(CapFilters.Filters[i].FriendlyName);
  For i := 0 to AudFilters.CountFilters - 1 do
    lbAudioCodec.Items.Add(AudFilters.Filters[i].FriendlyName);
end;

procedure VideoAudioInitialization;
var
 i: Word;
begin
  CapEnum := TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
  if CapEnum.CountFilters <= 0 then
   begin
    MainForm.N4.Enabled := false;
    MainForm.btnWeb.Enabled := false;
    Exit;
   end;

  for i := 0 to CapEnum.CountFilters - 1 do
    VideoCapFilters.Items.Add(CapEnum.Filters[i].FriendlyName);

  CapEnum.SelectGUIDCategory(CLSID_AudioInputDeviceCategory);
  for i := 0 to CapEnum.CountFilters - 1 do
    AudioCapFilters.Items.Add(CapEnum.Filters[i].FriendlyName);

  VideoMediaTypes := TEnumMediaType.Create;
  AudioMediaTypes := TEnumMediaType.Create;
end;

procedure LoadFraimes;
var
 List: TStringList;
begin
 List := TStringList.Create;
 try
  FindFile(FRPath + 'Fraime\', '*.bmp', List, true);
  LoadFraime(lbEffectFraime,List);
 finally
  List.Free;
 end;
 if lbEffectFraime.Items.Count > 0 then lbEffectFraime.ItemIndex := 0;
end;

procedure SetFormSize;
begin
 with MainForm do begin
  Width := StrToInt(copy(OptionForm.GroupMode.Items.Strings[GroupMode.ItemIndex],1,3)) + Width - ClientWidth;
  Height := StrToInt(copy(OptionForm.GroupMode.Items.Strings[GroupMode.ItemIndex],7,9)) +  Height - ClientHeight + StatusBar.Height + panelButton.Height;
 end;
end;

function ConfigExist: Boolean;
begin
 Result := False;
 with MainForm do begin
 if not FileExists(FRPath + ConfName) then
  begin
    SetDefaultParametrs;
    WriteIniParam(OptionForm);
    SetFormSize;
    SetFormToCenter(MainForm);
    Result := True;
  end;
 end;
end;

procedure LoadFaceParam;
begin
 SaveFaceChange(clFace0);
 SaveFaceChange(clEyes1);
 SaveFaceChange(clEyebrows2);
 SaveFaceChange(clNose3);
 SaveFaceChange(clMouth4);
end;

begin
  VideoAudioInitialization;
  LoadCodeck;
  LoadLanguage;
  if not ConfigExist then
   begin
    Localize(MainForm, FRLanguag);
    Localize(OptionForm, FRLanguag);
  end;
  ReadIniParam(OptionForm);
  // after read prm
  LoadFaceParam;
  EffectPrepare;
  LoadFraimes;
end;

procedure TOptionForm.FormShow(Sender: TObject);
begin
 // запук на 1 раз
 LoadAudioFilter;
 AudioFormats.ItemIndex := ReadIniPrm(FRPath + ConfName, 'Int', 'AudioFormats', Int);
 if lbVideoCodec.ItemIndex = -1 then SetItemIndex(lbVideoCodec);
 if lbAudioCodec.ItemIndex = -1 then SetItemIndex(lbAudioCodec);
 if AudioFormats.ItemIndex = -1 then SetItemIndex(AudioFormats);
end;

procedure TOptionForm.TimerTimeTimer(Sender: TObject);
begin
  // визначення дати та часу
 if cbPhotoDate.Checked then
  labelPhotoDate.Caption := FormatDateTime('dd/mm/yy',Now)
 else
  labelPhotoDate.Caption := '';

 if cbPhotoTime.Checked then
  labelPhotoTime.Caption := FormatDateTime('hh:mm:ss',Now)
 else
  labelPhotoTime.Caption := '';
end;

procedure TOptionForm.GroupModeClick(Sender: TObject);
begin
 with MainForm do begin
  Width := StrToInt(copy(OptionForm.GroupMode.Items.Strings[GroupMode.ItemIndex],1,3)) + Width - ClientWidth;
  Height := StrToInt(copy(OptionForm.GroupMode.Items.Strings[GroupMode.ItemIndex],7,9)) +  Height - ClientHeight + StatusBar.Height + panelButton.Height;
  if WebStart then
    begin
     CreateWeb.Execute;
     CreateWeb.Execute;
    end;
 end;
end;

procedure TOptionForm.HueChange(Sender: TObject);
begin
  ProcAmpControl.dwSize := sizeof(ProcAmpControl);
  ProcAmpControl.Hue := Hue.Position;
  ProcAmpControl.dwFlags := ProcAmpControl9_Hue;
  with (MainForm.VideoWindow as IVMRMixerControl9) do
    SetProcAmpControl(0, @ProcAmpControl);
end;

procedure TOptionForm.tbSensitivity2Change(Sender: TObject);
begin
 FRecog.IntegralPrm1 := tbSensitivity2.Position;
end;

procedure TOptionForm.tbSensitivityChange(Sender: TObject);
begin
 FRecog.IntegralPrm2 := tbSensitivity.Position;
end;

procedure TOptionForm.lbEffectClick(Sender: TObject);
begin
 EffectPrepare;
end;

procedure TOptionForm.lbEffectFraimeDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  btn: TButton;
begin
   with (Control as TListBox).Canvas do
    // рисуем на холсте элемента управления, не на форме
  begin
    FillRect(Rect); // очищаем прямоугольник
    btn := TButton((Control as TListBox).Items.Objects[Index]);
      // получаем иконку для данного элемента
    if Icon <> nil then
    begin
      Draw(Rect.Left + 13, Rect.Top + 5, TIcon((Control as TListBox).Items.Objects[Index]));
      //TextOut(Rect.Left + Offset, Rect.Top + 30, (Control as TListBox).Items[Index]);
    end;
  end;
end;

procedure TOptionForm.btnWebDefaultClick(Sender: TObject);
begin
 tbRecogLight.Position := 50;
 tbRecogContrast.Position := 0;
end;

procedure TOptionForm.BrightnessChange(Sender: TObject);
begin
  ProcAmpControl.dwSize := sizeof(ProcAmpControl);
  ProcAmpControl.Brightness := Brightness.Position;
  ProcAmpControl.dwFlags := ProcAmpControl9_Brightness;
  with (MainForm.VideoWindow as  IVMRMixerControl9) do
    SetProcAmpControl(0, @ProcAmpControl);
end;

procedure TOptionForm.btnDefaultClick(Sender: TObject);
begin
 if MessageDlg(ReadIniPrm(FRLngPath,'Dialog','setdefault',Str),mtConfirmation,mbYesNo,0) = mrYes
  then begin
    SetDefaultParametrs;
    WriteIniParam(OptionForm);
   end;
end;

procedure TOptionForm.btnPhotoPathClick(Sender: TObject);
var
 options : TSelectDirOpts;
 chosenDirectory: string;
begin
 if SelectDirectory(chosenDirectory,options,0)
  then edPhoto.Text := chosenDirectory;
end;

procedure TOptionForm.btnRecogDefaultClick(Sender: TObject);
begin
 tbSensitivity2.Position := 11;
 tbSensitivity.Position := 10;
 tbMedianFilter.Position := 0;
end;

procedure TOptionForm.btnVideoPathClick(Sender: TObject);
var
 options : TSelectDirOpts;
 chosenDirectory: string;
begin
 if SelectDirectory(chosenDirectory,options,0)
  then edVideo.Text := chosenDirectory;
end;

procedure TOptionForm.CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TOptionForm.cbAutostartClick(Sender: TObject);

procedure DllCreateLink;
type
 TCreateLink = procedure(ilname, LiskDir, WorkDir, desc,ExeName: Pchar);
var
        DLLInstance : THandle;
        CreateLink : TCreateLink;
begin
        DLLInstance := LoadLibrary(DllName);
        if DLLInstance = 0 then
         begin
            MessageDlg('Can`t load DLL', mtError, [mbOK], 0);
            Exit;
         end;
        @CreateLink := GetProcAddress(DLLInstance, 'CreateLink');

        CreateLink('FaceRecognition.lnk',
                 Pchar(GetSpecialPath(CSIDL_STARTUP)),
                 '', '',
                 Pchar(Application.ExeName)
                 );
      FreeLibrary(DLLInstance);
end;

function WideStringToString(const ws: WideString; codePage: Word): AnsiString;
var
  l: integer;
begin
  if ws = '' then
    Result := ''
else
  begin
    l := WideCharToMultiByte(codePage,
      WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
      @ws[1], -1, nil, 0, nil, nil);
    SetLength(Result, l - 1);
    if l > 1 then
      WideCharToMultiByte(codePage,
        WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
        @ws[1], -1, @Result[1], l - 1, nil, nil);
  end;
end; { WideStringToString }

var
 s: string;

begin
 s := WideStringToString(GetSpecialPath(CSIDL_STARTUP),0);
 s := IncDelim(s) + 'FaceRecognition.lnk';
 if cbAutostart.Checked then
  begin
   if not FileExists(s) then  DllCreateLink;
  end else
  if FileExists(s)then DeleteFile(s);
end;

procedure TOptionForm.cbEffectClick(Sender: TObject);
begin
 SetEnabled(gbEffect,cbEffect.Checked);
end;

procedure TOptionForm.cbEyes1Click(Sender: TObject);
begin
 SetEnabled(TGroupBox(Sender as TObject).Parent,TCheckBox(Sender as TObject).Checked);
 SaveFaceChange(Sender);
end;

procedure TOptionForm.cbFiceCountClick(Sender: TObject);
begin
 FRecog.MoreOneFace := cbFiceCount.Checked;
end;

procedure TOptionForm.cbPhotoClick(Sender: TObject);
begin
 sePhoto2.Enabled := cbPhoto.Checked;
end;

procedure TOptionForm.cbPhotoDateClick(Sender: TObject);
begin
 if cbPhotoDate.Checked or cbPhotoTime.Checked then
  TimerTime.Enabled := True
 else
  TimerTime.Enabled := False;

 // визначення дати та часу
 if cbPhotoDate.Checked then
  labelPhotoDate.Caption := FormatDateTime('dd/mm/yy',Now)
 else
  labelPhotoDate.Caption := '';

 if cbPhotoTime.Checked then
  labelPhotoTime.Caption := FormatDateTime('hh:mm:ss',Now)
 else
  labelPhotoTime.Caption := '';
end;

procedure TOptionForm.cbSystemLanguageChange(Sender: TObject);
begin
  // локалізація
  FRLanguag := cbSystemLanguage.Text + '.lng';
  Localize(OptionForm, FRLanguag);
  Localize(MainForm, FRLanguag);
end;

procedure TOptionForm.cbVideoClick(Sender: TObject);
begin
 seVideo.Enabled := cbVideo.Checked;
end;

procedure TOptionForm.ContrastChange(Sender: TObject);
begin
  ProcAmpControl.dwSize := sizeof(ProcAmpControl);
  ProcAmpControl.Contrast := Contrast.Position;
  ProcAmpControl.dwFlags := ProcAmpControl9_Contrast;
  with (MainForm.VideoWindow as IVMRMixerControl9) do
    SetProcAmpControl(0, @ProcAmpControl);
end;

procedure TOptionForm.AspectRatioClick(Sender: TObject);
begin
 MainForm.VideoWindow.VMROptions.KeepAspectRatio := AspectRatio.Checked;
end;

procedure TOptionForm.AudioCapFiltersClick(Sender: TObject);
begin
 LoadAudioFilter;
end;

end.

