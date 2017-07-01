unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DSPack, DSUtil, DirectShow9, ComCtrls, ExtCtrls, IniFiles,
  XPMan,ToolWin, ActnMan, ActnCtrls, ActnMenus, XPStyleActnCtrls, ActnList, ImgList,
  OleCtrls, Buttons, StrUtils, ScktComp, Sockets, AppEvnts,
  ProEffectImage, ExtDlgs, Menus, ComObj, ActiveX, FRPanel, FaceRecognition,
  WinSevenConnect;

type
  TPictureSize = (psNormal, psBig, psSmall);

type
  TRGB = record
    r, g, b: byte;
  end;

  trgba = array [0 .. 1024] of TRGB;
  prgba = ^trgba;

  TMainForm = class(TForm)
    CaptureGraph: TFilterGraph;
    VideoSourceFilter: TFilter;
    StatusBar: TStatusBar;
    ActionManager: TActionManager;
    CreateWeb: TAction;
    FormExit: TAction;
    OnTop: TAction;
    Help: TAction;
    About: TAction;
    OptionVideo: TAction;
    AudioSourceFilter: TFilter;
    ImageList: TImageList;
    VideoWindow: TVideoWindow;
    ApplicationEvents: TApplicationEvents;
    SampleGrabber: TSampleGrabber;
    TimerGetImage: TTimer;
    Recognation: TAction;
    TimerRecognation: TTimer;
    panelButton: TPanel;
    btnPhoto: TBitBtn;
    btnWeb: TBitBtn;
    btnRecognation: TBitBtn;
    CreateVideo: TAction;
    CreatePhoto: TAction;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    LoadPicture: TAction;
    bt1: TImage;
    bt2: TImage;
    TimerCreatePhoto: TTimer;
    TimerCountDown: TTimer;
    btnVideo: TBitBtn;
    LoadVideos: TAction;
    VideoWindow2: TVideoWindow;
    TimerCreateVideo: TTimer;
    ToolBarVideo: TToolBar;
    btPlay: TToolButton;
    btPause: TToolButton;
    btStop: TToolButton;
    SoundLevel: TTrackBar;
    Play: TAction;
    Pouse: TAction;
    Stop: TAction;
    PopupMenu: TPopupMenu;
    Play1: TMenuItem;
    Pause1: TMenuItem;
    Stop1: TMenuItem;
    PanelTrack: TPanel;
    tbVideoTrack: TDSTrackBar;
    OpenVideo: TOpenDialog;
    Image: TProEffectImage;
    TimerWinSeven: TTimer;
    OpenImage: TOpenPictureDialog;
    WinSevenConnect: TWinSevenConnect;
    procedure OnTopExecute(Sender: TObject);
    procedure CreateWebExecute(Sender: TObject);
    procedure PrepareRec;
    procedure OptionVideoExecute(Sender: TObject);
    procedure FormExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AboutExecute(Sender: TObject);
    procedure Rec;
    procedure CreateProgressDialog;
    function SetVideoParams(CB_B2: ICaptureGraphBuilder2; Category: TGUID;
      fSource: IBaseFilter): HResult;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerGetImageTimer(Sender: TObject);
    procedure RecognationExecute(Sender: TObject);
    procedure TimerRecognationTimer(Sender: TObject);
    procedure CreateVideoExecute(Sender: TObject);
    procedure LoadPictureExecute(Sender: TObject);
    procedure TimerCreatePhotoTimer(Sender: TObject);
    procedure CreatePhotoExecute(Sender: TObject);
    procedure TimerCountDownTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure LoadVideosExecute(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure TimerCreateVideoTimer(Sender: TObject);
    procedure HelpExecute(Sender: TObject);
    procedure StopExecute(Sender: TObject);
    procedure PlayExecute(Sender: TObject);
    procedure PouseExecute(Sender: TObject);
    procedure SoundLevelChange(Sender: TObject);
    procedure tbVideoTrackTimer(sender: TObject; CurrentPos, StopPos: Cardinal);
    procedure WinSevenConnectClick1(Sender: TObject);
    procedure WinSevenConnectClick2(Sender: TObject);
    procedure WinSevenConnectClick3(Sender: TObject);
    procedure TimerWinSevenTimer(Sender: TObject);
  private
    function GetVideoPathFile: Boolean;
    function GetPhotoPathFile: Boolean;
    function PrepareDateText: string;

    procedure WMWINDOWPOSCHANGING(var Msg: TWMWINDOWPOSCHANGING);
    message WM_WINDOWPOSCHANGING;
    procedure SetGliph(BitButton: TBitBtn; ImageList: TImageList; Index: Word);
    procedure VideoSnapShot(DisplayPanel: TCustomControl; b: TBitmap);
    procedure SetFraime(FraimeNumber: Word);
    procedure OnInitialization;
    procedure ClearArea;
    procedure GetVideoGraber(DisplayPanel: TVideoWindow; b: TBitmap);
  public

  end;

const
  ThumbW = 32;
  ThumbH = 24;

var
  // глобальные переменные
  MainForm: TMainForm;
  CapEnum: TSysDevEnum;
  VideoMediaTypes, AudioMediaTypes: TEnumMediaType;
  VideoFile, PhotoFile: string;
  multiplexer: IBaseFilter;
  Writer: IFileSinkFilter;
  PinList: TPinList;
  CompFilter: TFilterList;

  first: Boolean = true;
  i: Integer = 0;

  rectime: Cardinal;

  FRecog: TRecognitionFace;
  VMRBitmap: TVMRBitmap;

  VideoStart, RecStart, WebStart: Boolean;
  Timercount,CountDown, PhotoNumber: byte;


implementation

uses
  option, About, Math, ShellApi, Unit2, uGlobal;

{$R *.dfm}

{ **************************** Завження позицій форми ************************ }
procedure FormLoad(Form: TForm; FileName: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(FileName);
  try
    with Form do
    begin
      Left := ini.ReadInteger(Form.Name, 'Left', 0);
      Top := ini.ReadInteger(Form.Name, 'Top', 0);
      Width := ini.ReadInteger(Form.Name, 'Width', 0);
      Height := ini.ReadInteger(Form.Name, 'Height', 0);
    end;
  finally
    FreeAndNil(ini);
  end;
end;
{ **************************** Збереження позицій форми ********************** }
procedure FormSave(Form: TForm; FileName: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(FRPath + ConfName);
  try
    with Form do
    begin
      ini.WriteInteger(Form.Name, 'Left', Left);
      ini.WriteInteger(Form.Name, 'Top', Top);
      ini.WriteInteger(Form.Name, 'Width', Width);
      ini.WriteInteger(Form.Name, 'Height', Height);
    end;
  finally
    FreeAndNil(ini);
  end;
end;
{ ----------------------- Відображення Зворотнього відліку ------------------- }
procedure DrawTimeBack(b: TBitmap; Text: string);
begin
  b.Canvas.Font.Color := clWhite;
  b.Canvas.Font.Size := 72;
  b.Canvas.Brush.Style := TBrushStyle(1);
  b.Canvas.TextOut(Round(b.Width / 2) - Round(b.Canvas.TextWidth(Text) / 2),
    Round(b.Height / 2) - Round(b.Canvas.TextHeight(Text) / 2), Text);
end;
{ ************************* Липке вікно ************************************** }
procedure TMainForm.WMWINDOWPOSCHANGING(var Msg: TWMWINDOWPOSCHANGING);
var
  WorkArea: TRect;
  StickAt: Word;
begin
  if ReadIniPrm(FRPath + ConfName, 'Bol', 'cbSticky', bol) then
    StickAt := 10
  else
    StickAt := 0;

  SystemParametersInfo(SPI_GETWORKAREA, 0, @WorkArea, 0);
  with WorkArea, Msg.WindowPos^ do
  begin
    // Сдвигаем границы для сравнения с левой и верхней сторонами
    Right := Right - cx;
    Bottom := Bottom - cy;
    if abs(Left - X) <= StickAt then
      X := Left;
    if abs(Right - X) <= StickAt then
      X := Right;
    if abs(Top - Y) <= StickAt then
      Y := Top;
    if abs(Bottom - Y) <= StickAt then
      Y := Bottom;
  end;
  inherited;
end;
{ ************************* завантаження гліфіф для кнопки ******************* }
procedure TMainForm.SetGliph(BitButton: TBitBtn; ImageList: TImageList;
  Index: Word);
var
  b: TBitmap;
begin
  b := TBitmap.Create;
  try
    ImageList.GetBitmap(Index, b);
    BitButton.Glyph.Assign(b);
  finally
    b.Free;
  end;
end;
{ ************************* захват кадру з відео потоку *********************** }
procedure TMainForm.GetVideoGraber(DisplayPanel: TVideoWindow; b: TBitmap);
begin
  with b do
  begin
    b.Width := DisplayPanel.Width;
    b.Height := DisplayPanel.Height;
    b.PixelFormat := pf24bit;
    b.Canvas.CopyRect(b.Canvas.ClipRect, MainForm.Canvas, Rect
        (DisplayPanel.Left, DisplayPanel.Top, DisplayPanel.Left + b.Width,
        DisplayPanel.Top + b.Height));
  end;
end;
{ ----------------------- Draw Photo DateTime -------------------------------- }
function TMainForm.PrepareDateText: string;
begin
  with OptionForm do
  begin
    if cbPhotoDate.Checked then
      Result := labelPhotoDate.Caption;
    if cbPhotoTime.Checked then
      Result := Result + ' ' + labelPhotoTime.Caption;
  end;
end;
{ ************************* Очищення зони відображення *********************** }
procedure TMainForm.ClearArea;
begin
  VideoWindow.Canvas.Brush.Color := 0;
  VideoWindow.Canvas.FillRect(Rect(0, 0, Image.Width, Image.Height));

  Image.Canvas.Brush.Color := 0;
  Image.Canvas.FillRect(Rect(0, 0, Image.Width, Image.Height));
  Image.Picture.Graphic := nil;
end;
{ ----------------------- Шлях до відеофайлу --------------------------------- }
function TMainForm.GetVideoPathFile: Boolean;
begin
  Result := true;
  with OptionForm do
  begin
    if not CheckPath(edVideo.Text) then
      Result := False
    else
      VideoFile := IncDelim(edVideo.Text) + FormatDateTime('dd_mm_yy', Now) + '_' +
      FormatDateTime('hh.mm.ss', Now) + Copy(OptionForm.cbVideoFormat.Text, length(OptionForm.cbVideoFormat.Text)
          - 4, 4);
  end;
end;
{ ----------------------- Шлях до фотофайлу ---------------------------------- }
function TMainForm.GetPhotoPathFile: Boolean;
begin
  Result := true;
  with OptionForm do
  begin
    if not CheckPath(edPhoto.Text) then
      Result := False
    else
      PhotoFile := IncDelim(edPhoto.Text) + FormatDateTime('dd_mm_yy', Now)
        + '_' + FormatDateTime('hh.mm.ss', Now) + Copy
        (OptionForm.cbPhotoFormat.Text, length(OptionForm.cbPhotoFormat.Text)
          - 4, 4);
  end;
end;
{ **************************** Показ фрейма  ********************************* }
procedure TMainForm.SetFraime(FraimeNumber: Word);
var
  b: TBitmap;
begin
  b := TBitmap.Create;
  try
    b.LoadFromFile(FRPath + 'Fraime\' + 'fraime' + IntToStr(FraimeNumber) + '.bmp');
    b.TransparentColor := clWhite;
    b.Transparent := true;
    Image.Canvas.StretchDraw(Rect(0, 0, Image.Width, Image.Height), b);
  finally
    b.Free;
  end;
end;
{ ************************* Предстартові налашьтування *********************** }
procedure TMainForm.OnInitialization;
begin
  FRecog := TRecognitionFace.Create;
  // завантаженян гліфів
  SetGliph(btnWeb, ImageList, 6);
  SetGliph(btnPhoto, ImageList, 7);
  // створення змінної для захоплення відео
  VMRBitmap := TVMRBitmap.Create(VideoWindow);
  // позиціювання головного вікна
  if ReadIniPrm(FRPath + ConfName, 'Bol', 'cbSaveFormPos', bol) then
    FormLoad(MainForm,FRPath + ConfName)
  else
    SetFormToCenter(MainForm);
end;
{ ************************* Захват кадра з відео ***************************** }
procedure TMainForm.VideoSnapShot(DisplayPanel: TCustomControl; b: TBitmap);
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    if VideoWindow.VMRGetBitmap(Stream) then
      b.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////// Робота з графикой ///////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// функция установки параметров видео потока с web камеры
function TMainForm.SetVideoParams(CB_B2: ICaptureGraphBuilder2;
  Category: TGUID; fSource: IBaseFilter): HResult;
var
  StreamConf: IAMStreamConfig;
  PAMT: PAMMediaType;
begin
  Result := E_FAIL;
  StreamConf := nil;
  PAMT := nil;
  try
    // получаем интерфейс устройства для работы
    Result := CB_B2.FindInterface(@Category, @MEDIATYPE_Video, fSource,
      IID_IAMStreamConfig, StreamConf);
    if Assigned(StreamConf) then
    begin
      // связываемся с настройками устройства
      StreamConf.GetFormat(PAMT);
      if Assigned(PAMT) then
      begin
        if PAMT.cbFormat = sizeOf(TVideoInfoHeader) then
        begin
          // установка параметров видео потока
          PVIDEOINFOHEADER(PAMT^.pbFormat)^.bmiHeader.biWidth := StrToInt
            (Copy(OptionForm.GroupMode.Items.Strings
                [OptionForm.GroupMode.ItemIndex], 1, 3));
          PVIDEOINFOHEADER(PAMT^.pbFormat)^.bmiHeader.biHeight := StrToInt
            (Copy(OptionForm.GroupMode.Items.Strings
                [OptionForm.GroupMode.ItemIndex], 7, 9));
          PVIDEOINFOHEADER(PAMT^.pbFormat)^.bmiHeader.biBitCount := 1;
          PVIDEOINFOHEADER(PAMT^.pbFormat)^.AvgTimePerFrame :=
            10000000 div OptionForm.EditKadr.Position;
          // устанавливаем скорость отображения кадров/секунду
          with PVIDEOINFOHEADER(PAMT^.pbFormat)^.bmiHeader do
            PAMT^.lSampleSize := ((biWidth + 3) and (not(3)))
              * biHeight * biBitCount shr 3;
          PVIDEOINFOHEADER(PAMT^.pbFormat)^.bmiHeader.biSizeImage := PAMT^.lSampleSize;
        end;
        Result := StreamConf.SetFormat(PAMT^)
      end;
    end;
    Result := S_OK;
  except
    // еси ощибка, то сообщаем пользователю об этом
    on E: Exception do
      MessageBox(0, PChar(E.Message), '', MB_OK or MB_ICONERROR);
  end;
  StreamConf := nil;
  // удаляем связь с устройством
  if Assigned(PAMT) then
    DeleteMediaType(PAMT);
end;

procedure TMainForm.SoundLevelChange(Sender: TObject);
begin
 CaptureGraph.Volume := SoundLevel.Position;
end;

/// /////////////////////////////////////////////////////////////////////////////
/// /////////////////// Работа з  MPEG, камерой и звуком ////////////////////////
/// /////////////////////////////////////////////////////////////////////////////

// подготовка к записи, тоесть установка кодеков для аудио и видео
procedure TMainForm.PrepareRec;
var
  i: Integer;
begin
  // подготовка видео
  // приводим все обработчики в неактивное состояние
  CaptureGraph.Active := False;
  // назначаем граф для фильта
  VideoWindow2.FilterGraph := nil;
  VideoWindow.FilterGraph := CaptureGraph;
  // создаем интерфейс для устройства
  CapEnum := TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
  CapEnum.SelectGUIDCategory(CLSID_VideoInputDeviceCategory);
  // назначем фильтру один из подерживаемых им форматов
  VideoSourceFilter.BaseFilter.Moniker := CapEnum.GetMoniker
    (OptionForm.VideoCapFilters.ItemIndex);
  VideoSourceFilter.FilterGraph := CaptureGraph;
  // запускаем граф в работу
  CaptureGraph.Active := true;
  // получем в переменнуюю список видео фильтров, установленных нами
  PinList := TPinList.Create(VideoSourceFilter as IBaseFilter);
  // назначаем фильтры VideoMediaTypes
  VideoMediaTypes.Assign(PinList.first);
  PinList.Free;
  // Подготовка аудио
  CapEnum.SelectGUIDCategory(CLSID_AudioInputDeviceCategory);
  AudioSourceFilter.BaseFilter.Moniker := CapEnum.GetMoniker
    (OptionForm.AudioCapFilters.ItemIndex);
  AudioSourceFilter.FilterGraph := CaptureGraph;
  CaptureGraph.Active := true;
  PinList := TPinList.Create(AudioSourceFilter as IBaseFilter);
  i := 0;
  while i < PinList.Count do
    if PinList.PinInfo[i].dir = PINDIR_OUTPUT then
    begin
      AudioMediaTypes.Assign(PinList.Items[i]);
      PinList.Delete(i);
    end
     else
      inc(i);
  CaptureGraph.Active := False;
  PinList.Free;
end;

// процедура непосрдественной записи в файл с применением кодека
procedure TMainForm.Rec;
var
  i: Integer;
begin
  CompFilter.Clear;
  // активация графа
  CaptureGraph.Active := true;
  // конфигурация аудио
  if AudioSourceFilter.FilterGraph <> nil then
  begin
    PinList := TPinList.Create(AudioSourceFilter as IBaseFilter);
    i := 0;
    while i < PinList.Count do
      if PinList.PinInfo[i].dir = PINDIR_OUTPUT then
      begin
        if OptionForm.AudioFormats.ItemIndex <> -1 then
          with (PinList.Items[i] as IAMStreamConfig) do
            SetFormat(AudioMediaTypes.Items[OptionForm.AudioFormats.ItemIndex]
                .AMMediaType^);
        PinList.Delete(i);
      end
      else
        inc(i);
    // в соответствии с установленными настройками пользователя
    if OptionForm.InputLines.ItemIndex <> -1 then
      with (PinList.Items[OptionForm.InputLines.ItemIndex]
          as IAMAudioInputMixer) do
        put_Enable(true);
    PinList.Free;
  end;
  // конфигурация видео настроек
  SetVideoParams(CaptureGraph as ICaptureGraphBuilder2, PIN_CATEGORY_CAPTURE,
    VideoSourceFilter as IBaseFilter);
  // добавление видео фильтров
  CompFilter.Add(CapFilters.GetBaseFilter(OptionForm.lbVideoCodec.ItemIndex));
  with CaptureGraph as IGraphBuilder do
    AddFilter(CompFilter.Last, StringToOleStr
        (OptionForm.lbVideoCodec.Items.Strings
          [OptionForm.lbVideoCodec.ItemIndex]));
  // добавление аудио фильтров
  CompFilter.Add(AudFilters.GetBaseFilter(OptionForm.lbAudioCodec.ItemIndex));
  // запис із звуком
  if OptionForm.cbVideo2.Checked then
    with CaptureGraph as IGraphBuilder do
      AddFilter(CompFilter.Last, StringToOleStr
          (OptionForm.lbAudioCodec.Items.Strings
            [OptionForm.lbAudioCodec.ItemIndex]));
  // работа с потоком
  with CaptureGraph as ICaptureGraphBuilder2 do
  begin
    // установить файл


    SetOutputFileName(MEDIASUBTYPE_Avi, PwideChar(VideoFile), multiplexer,
      Writer);
    if VideoSourceFilter.FilterGraph <> nil then
      // направляем поток в файл, тоесть здесь происходит непосрдетсвенное сжатие
      RenderStream(@PIN_CATEGORY_CAPTURE, nil,
        VideoSourceFilter as IBaseFilter, CompFilter.Items[0],
        multiplexer as IBaseFilter);
    if AudioSourceFilter.FilterGraph <> nil then
    begin
      // направляем  аудио  поток на соотв. устройство
      RenderStream(nil, nil, AudioSourceFilter as IBaseFilter,
        CompFilter.Items[1], multiplexer as IBaseFilter);
    end;
    // установить связь с видео // отображать
    if (VideoSourceFilter.BaseFilter.DataLength > 0) then
      RenderStream(@PIN_CATEGORY_PREVIEW, nil,
        VideoSourceFilter as IBaseFilter, nil, VideoWindow as IBaseFilter);
  end;
  CaptureGraph.Play;
end;

////////////////////////////////////////////////////////////////////////////////
/////////////////////////////// TForm  /////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// обработка события закрытия формы приложения
procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    if RecStart then
     begin
       RecStart := false;
       CreateVideo.Execute;
     end;
    TimerGetImage.Enabled := False;
    TimerRecognation.Enabled := False;
    CaptureGraph.ClearGraph;
    if CapEnum <> nil then FreeAndNil(CapEnum);
    FreeAndNil(FRecog);
    VideoMediaTypes.Free;
    AudioMediaTypes.Free;
    VMRBitmap.Free;
    // збереження позиції форми
    FormSave(MainForm,FRPath + ConfName);
  except
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FormLoad(MainForm, FRPath + ConfName);
  // завантаження налаштувань
  OnInitialization;
  // вывод прогресс диалога
  try
    CreateProgressDialog;
  except
    ShowMessage(ReadIniPrm(FRLngPath, 'Dialog', 'notloadresource', Str));
  end;
  // Справка в право
  ModifyMenu(MainMenu.Handle, 2, mf_ByPosition or mf_Popup or mf_Help, N3.Handle, PChar(N3.Caption));
end;


procedure TMainForm.CreateProgressDialog;
var
  AMsgDialog: TForm;
  AProgressBar: TProgressBar;
begin
  AMsgDialog := CreateMessageDialog('Please waite...', mtCustom, []);
  AProgressBar := TProgressBar.Create(AMsgDialog);

  with AMsgDialog do
    try
      Caption := 'FaceRecognition';
      Height := 120;

      with AProgressBar do
      begin
        Parent := AMsgDialog;
        Top := 50;
        Left := 5;
        Width := 90;
        min := 0;
        max := 100;
      end;
      Show;
      // создание объектов Graphic
      bt1.Picture.Graphic := TBitmap.Create;

      AProgressBar.Position := 10;
      Application.ProcessMessages;

      bt2.Picture.Graphic := TBitmap.Create;

      CompFilter := TFilterList.Create;
      CapFilters := TSysDevEnum.Create(CLSID_VideoCompressorCategory);
      CapEnum := TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
      CapEnum.SelectGUIDCategory(CLSID_AudioInputDeviceCategory);

      AProgressBar.Position := 30;
      Application.ProcessMessages;

      VideoMediaTypes := TEnumMediaType.Create;
      AudioMediaTypes := TEnumMediaType.Create;

      AProgressBar.Position := 50;
      Application.ProcessMessages;

      try
        // загрузка настроек программыs
        AProgressBar.Position := 70;
        Application.ProcessMessages;

        AProgressBar.Position := 90;
        Application.ProcessMessages;
      except
        ShowMessage('Fatal error!');
      end;
      AProgressBar.Position := 100;
      Application.ProcessMessages;

      /// ///////////////////////////////////////////////////////////////////////
    finally
      AProgressBar.Free;
      Free;
    end;
end;

procedure TMainForm.tbVideoTrackTimer(sender: TObject; CurrentPos,
  StopPos: Cardinal);
begin
  WinSevenConnect.ProgressValueMax := StopPos;
  WinSevenConnect.ProgressValue := CurrentPos;
  StatusBar.Panels[0].Text := format('%s / %s',
   [TimeToStr(CurrentPos / MiliSecPerDay), TimeToStr(StopPos / MiliSecPerDay)]);
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  btnPhoto.Width := Round(panelButton.Width / 4);
  btnVideo.Width := btnPhoto.Width;
  btnWeb.Width := btnPhoto.Width;
  btnRecognation.Width := panelButton.Width - (btnPhoto.Width * 3);
end;
procedure TMainForm.N4Click(Sender: TObject);
begin
  if WebStart then Exit;
  if VideoStart then Exit;
  // вимкнення
  if RecStart then
   begin
    RecStart := False;
    CreateVideo.Execute;
    Exit;
   end;
  // перевірка шляху
  if not GetVideoPathFile then
  begin
    ShowMessage(ReadIniPrm(FRLngPath, 'Dialog', 'notvideosave', Str));
    RecStart := False;
    Exit;
  end;
 // перевірка повторень
  if FileExists(VideoFile) then
   begin
    ShowMessage(ReadIniPrm(FRLngPath, 'Dialog', 'notvideosave', Str));
    RecStart := False;
    Exit;
   end;
  // Запуск
   RecStart := not RecStart;
    CountDown := OptionForm.seVideo.Value;
    if OptionForm.cbVideo.Checked then
     TimerCreateVideo.Enabled := true
    else
     CreateVideo.Execute;
end;

procedure TMainForm.TimerRecognationTimer(Sender: TObject);
var
 b: TBitmap;
begin
  if WebStart then
    FRecog.Recognition(Image.Picture.Bitmap, Image.Picture.Bitmap);

  if VideoStart then
   begin
    b := TBitmap.Create;
    b.SetSize(VideoWindow.Width,VideoWindow.Height);
    try
     GetVideoGraber(VideoWindow,b);
     FRecog.Recognition(b, VMRBitmap);
    finally
      b.Free;
    end;
   end;
end;

procedure TMainForm.TimerWinSevenTimer(Sender: TObject);

procedure DllSecontToTime(Sec: Cardinal);
type
 TSecondtoTime = function(const Seconds: Cardinal): Double;
var
        DLLInstance : THandle;
        SecondToTime : TSecondToTime;
begin
        DLLInstance := LoadLibrary(DllName);
        if DLLInstance = 0 then
         begin
            MessageDlg('Can`t load DLL', mtError, [mbOK], 0);
            Exit;
         end;
        @SecondToTime := GetProcAddress(DLLInstance, 'SecondToTime');
        StatusBar.Panels[0].Text := TimeToStr( SecondToTime(rectime));
      FreeLibrary(DLLInstance);
end;


begin
 inc(rectime);
 DllSecontToTime(rectime);
 if (rectime mod 2 = 0) then
  WinSevenConnect.SetOverIcon(4)
 else
  WinSevenConnect.SetOverIcon(-1);
end;

procedure TMainForm.TimerCreateVideoTimer(Sender: TObject);
begin
  if CountDown = 0 then
  begin
    CreateVideo.Execute;
    TimerCreateVideo.Enabled := False;
  end;
  Image.Canvas.Brush.Color := clBlack;
  Image.Canvas.FillRect(Rect(0, 0, Image.Width, Image.Height));
  if CountDown > 0 then
    DrawTimeBack(Image.Picture.Bitmap, IntToStr(CountDown));
  dec(CountDown);
end;

procedure TMainForm.TimerCountDownTimer(Sender: TObject);
begin
  // if CheckError then Exit;
  // робимо відповідку кількість знімків
  if CountDown = 1 then
  begin
    TimerCreatePhoto.Enabled := true;
    TimerCountDown.Enabled := False;
  end;
  // робимо відповідк до запису відео
  dec(CountDown);
end;

procedure TMainForm.TimerCreatePhotoTimer(Sender: TObject);

procedure SaveVideoSnap(Filename: string);
var
  b: TBitmap;
begin
  if RecStart or VideoStart then
  begin
    b := TBitmap.Create;
    try
      VideoSnapShot(VideoWindow, b);
      b.SaveToFile(Filename);
    finally
      b.Free;
    end;
  end
   else
    Image.Picture.SaveToFile(Filename);
end;

procedure SaveVideoSnapWithDate(Filename,Text: string);
var
  bit: TBitmap;
begin
  bit := TBitmap.Create;
  if (RecStart or VideoStart) then
    VideoSnapShot(VideoWindow, bit)
  else
    bit.Assign(Image.Picture.Bitmap);
  try
    bit.Canvas.Font.Color := clRed;
    bit.Canvas.Brush.Style := TBrushStyle(1);
    case OptionForm.cbPhotoDateTime.Text[1] of
      'L': bit.Canvas.TextOut(10, 15, Text);
      'C': bit.Canvas.TextOut(Round(bit.Width / 2 - Canvas.TextWidth(Text) / 2), 15, Text);
      'R': bit.Canvas.TextOut(Round(bit.Width - Canvas.TextWidth(Text) - 10), 15, Text);
    end;
    bit.SaveToFile(PhotoFile);
  finally
    bit.Free;
  end;
end;

begin
  // робимо відповідку кількість знімків
  if PhotoNumber = 1 then
    TimerCreatePhoto.Enabled := False;
   // збереження
 try
  with OptionForm do
    if PrepareDateText = '' then
     SaveVideoSnap(PhotoFile)
    else
     SaveVideoSnapWithDate(PhotoFile,PrepareDateText);
 except
   TimerCreatePhoto.Enabled := false;
   ShowMessage(ReadIniPrm(FRLngPath, 'Dialog', 'notvideosave', Str));
 end;
  Application.ProcessMessages;
  dec(PhotoNumber);
end;

procedure TMainForm.TimerGetImageTimer(Sender: TObject);
var
  i: byte;

  procedure SetLight;
  begin
    with OptionForm do
      if OptionForm.tbRecogLight.Position > 50 then
        Image.Effect_Lightness((tbRecogLight.Position - 50) * 4)
      else
        Image.Effect_Darkness((50 - tbRecogLight.Position) * 4);
  end;

  procedure SetContrast;
  begin
    with OptionForm do
      if tbRecogContrast.Position > 0 then
        Image.Effect_Contrast(tbRecogContrast.Position * 5);
  end;

  procedure SetMedianFilter;
  var
    i: byte;
  begin
    with OptionForm do
      if tbMedianFilter.Position > 0 then
        for i := 1 to tbMedianFilter.Position do
          Image.Effect_MedianFilter;
  end;

begin
  // вивід кадра на екран
  SampleGrabber.GetBitmap(Image.Picture.Bitmap);
  // яскравість та контрастність
  SetLight;
  SetContrast;
  SetMedianFilter;
  // вивід фрейма
  if OptionForm.lbEffectFraime.ItemIndex > 0 then
    SetFraime(OptionForm.lbEffectFraime.ItemIndex);
  // зворотній відлік
  if TimerCountDown.Enabled then
    DrawTimeBack(Image.Picture.Bitmap, IntToStr(CountDown));
  // вивід спец ефектів
  if OptionForm.cbEffect.Checked then
  begin
    with OptionForm do
    begin
      Case lbEffect.ItemIndex of
        0: Image.Effect_GaussianBlur(EffectTrackBar.Position);
        1: Image.Effect_SplitBlur(EffectTrackBar.Position);
        2: Image.Effect_AddColorNoise(EffectTrackBar.Position * 3);
        3: Image.Effect_AddMonoNoise(EffectTrackBar.Position * 3);
        4: For i := 1 to EffectTrackBar.Position do Image.Effect_AntiAlias;
        5: Image.Effect_Contrast(EffectTrackBar.Position * 3);
        6: Image.Effect_FishEye(EffectTrackBar.Position div 10 + 1);
        7: Image.Effect_Lightness(EffectTrackBar.Position * 2);
        8: Image.Effect_Darkness(EffectTrackBar.Position * 2);
        9: Image.Effect_Saturation(255 - ((EffectTrackBar.Position * 255) div 100));
        10: Image.Effect_Mosaic(EffectTrackBar.Position div 2);
        11: Image.Effect_Twist(200 - (EffectTrackBar.Position * 2) + 1);
        12: Image.Effect_Splitlight(EffectTrackBar.Position div 20);
        13: Image.Effect_Tile(EffectTrackBar.Position div 10);
        14: Image.Effect_SpotLight(EffectTrackBar.Position, Rect
             (EffectTrackBar.Position, EffectTrackBar.Position,
              EffectTrackBar.Position + EffectTrackBar.Position * 2,
              EffectTrackBar.Position + EffectTrackBar.Position * 2));
        15: Image.Effect_Trace(EffectTrackBar.Position div 10);
        16: Image.Effect_Emboss;
        17: Image.Effect_Solorize(255 - ((EffectTrackBar.Position * 255) div 100));
        18: Image.Effect_Posterize(((EffectTrackBar.Position * 255) div 100) + 1);
        19: Image.Effect_Grayscale;
        20: Image.Effect_Invert;
        21: Image.Effect_Double;
        22: Image.Effect_Mirror(rgMirror.ItemIndex);
      End; // case
    end; // with
  end; // if
end;


////////////////////////////////////////////////////////////////////////////////
/////////////////////////////// Action   ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.PouseExecute(Sender: TObject);
begin
 CaptureGraph.Pause;
 WinSevenConnect.SetOverIcon(0);
end;

procedure TMainForm.PlayExecute(Sender: TObject);
begin
 if not CaptureGraph.Active then
   begin
     CaptureGraph.Active := true;
     CaptureGraph.ClearGraph;
     CaptureGraph.RenderFile(OpenVideo.FileName);
     CaptureGraph.Play;
   end
    else
      CaptureGraph.Play;
 WinSevenConnect.SetOverIcon(2);
end;

procedure TMainForm.StopExecute(Sender: TObject);
begin
 WinSevenConnect.ProgressValue := 0;
 WinSevenConnect.SetOverIcon(1);
 CaptureGraph.Stop;
 CaptureGraph.Active := False;
 ClearArea;
end;

procedure TMainForm.HelpExecute(Sender: TObject);
begin
  if not FileExists(FRPath + 'FRHelp.chm') then
    MessageDlg(ReadIniPrm(FRLngPath, 'Dialog', 'notfindhelp', Str), mtInformation, [mbOk], 0)
  else
    ShellExecute(0, PwideChar('open'), PwideChar(FRPath + 'FRHelp.chm'), nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.RecognationExecute(Sender: TObject);
begin
  if WebStart or VideoStart then
    TimerRecognation.Enabled := true
  else
    FRecog.Recognition(Image.Picture.Bitmap, Image.Picture.Bitmap);
  Form2.Show;
  FRecog.Active := not FRecog.Active;
end;

procedure TMainForm.CreateWebExecute(Sender: TObject);

  procedure Play;
  begin
    WinSevenConnect.ProgressState := Identerminate;
    SetGliph(btnWeb, ImageList, 9);
    // переназначаем визуальный интрфейс
    VideoWindow.FilterGraph := nil; // Free for before use
    VideoWindow2.FilterGraph := CaptureGraph;
    // создаем интерфейс для устройства
    CapEnum := TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
    // назначаем фильтры
    VideoSourceFilter.BaseFilter.Moniker := CapEnum.GetMoniker
      (OptionForm.VideoCapFilters.ItemIndex);
    VideoSourceFilter.FilterGraph := CaptureGraph;
    CaptureGraph.Active := true;
    // устанавливаем нужные параметры отображения
    SetVideoParams(CaptureGraph as ICaptureGraphBuilder2, PIN_CATEGORY_CAPTURE,
      VideoSourceFilter as IBaseFilter);
    // направляем видео поток на экран
    with CaptureGraph as ICaptureGraphBuilder2 do
      RenderStream(@PIN_CATEGORY_PREVIEW, nil,
        VideoSourceFilter as IBaseFilter, SampleGrabber as IBaseFilter,
        VideoWindow2 as IBaseFilter);
    CaptureGraph.Play;
    // cоздаем отделный поток на передачу данных
    // TSendThread.Create(false); {!!!! - память витікає
    FRecog.Active := false;
    TimerGetImage.Enabled := true;
    // запускаємо розпізнавання
  end;

  procedure Stop;
  begin
    WinSevenConnect.ProgressState := Noprogres;
    SetGliph(btnWeb, ImageList, 6);
    CapEnum.Free;
    CapEnum := nil;
    CaptureGraph.ClearGraph;
    CaptureGraph.Active := False;
    FRecog.Active := false;
    ClearArea;
    TimerGetImage.Enabled := False;
  end;

begin
  // перевірка чи не йде запис
  if RecStart then Exit;
  if VideoStart then Exit;
  // зупиняємо розпізенавання
  Caption := 'FaceRecognition';
  TimerRecognation.Enabled := False;
  // зупиняємо потік з камери
  try
   if WebStart then Stop else Play;
   WebStart := not WebStart;
  except
    ShowMessage(ReadIniPrm(FRLngPath, 'Dialog', 'notсonnect', Str));
    WebStart := False;
    Stop;
  end;
end;

procedure TMainForm.OptionVideoExecute(Sender: TObject);
begin
  OptionForm.Show;
end;

procedure TMainForm.FormExitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.AboutExecute(Sender: TObject);
begin
  if not Assigned(AboutForm) then
  begin
    AboutForm := TAboutForm.Create(Self);
    AboutForm.ShowModal;
    AboutForm.Free;
    AboutForm := nil;
  end;
end;

procedure TMainForm.OnTopExecute(Sender: TObject);
begin
  if OnTop.Checked then
    MainForm.FormStyle := fsStayOnTop
  else
    MainForm.FormStyle := fsNormal;
end;

procedure TMainForm.CreateVideoExecute(Sender: TObject);

procedure Play;
begin
  PrepareRec;
  Rec;
  Rectime := 0;
  N4.ImageIndex := 1;
  WinSevenConnect.ProgressState := Identerminate;
  TimerWinSeven.Enabled := true;
end;

procedure Stop;
begin
  CaptureGraph.Active := False;
  FreeAndNil(CapEnum);
  CaptureGraph.ClearGraph;
  CaptureGraph.Stop;
  VideoWindow.FilterGraph.Stop;
  VideoWindow.FilterGraph := nil;
  N4.ImageIndex := 2;
  StatusBar.Panels[0].Text := '';
  ClearArea;
  TimerWinSeven.Enabled := false;
  WinSevenConnect.ProgressState := Noprogres;
end;

begin
 try
  if RecStart then Play else Stop;
 except
  RecStart := False;
 end;
end;

procedure TMainForm.LoadPictureExecute(Sender: TObject);

var
  w, h: Word;
  b: TBitmap;

function CheckPictureSize(b: TBitmap): TPictureSize;
begin
  // туту буде завантаження з файла параметра
  if ((b.Width = w) and (b.Height = h)) then Result := psNormal;
  if ((b.Width > w) or (b.Height > h)) then Result := psBig;
  if ((b.Width < w) or (b.Height < h)) then Result := psSmall;
end;

procedure PictureMinimaze;
// procedure ResizeBitmap(src, dest: TBitmap; ThumbW, ThumbH: Word); external DllName name 'ResizeBitmap';
var
  b2: TBitmap;

procedure LoadDllResize;
type
 TLoadResize = procedure(src, dest: TBitmap; ThumbW, ThumbH: Word); stdcall;
var
 hndDLLHandle: THandle;
 LoadResize: TLoadResize;
 buf: array [0..244] of Char;
 hBmp: HBITMAP;
begin
 try
  hndDLLHandle := LoadLibrary(StrPCopy(buf,DllName));
  @LoadResize := getProcAddress(hndDLLHandle,'ResizeBitmap');
  if addr(LoadREsize) <> nil then  LoadResize(b, b2, w, h);
 finally
  FreeLibrary(hndDLLHandle);
 end;
end;

begin
  b2 := TBitmap.Create;
  b2.SetSize(w, h);
  try
    LoadDllResize;
    Image.Picture.Bitmap.Assign(b2);
  finally
    b2.Free;
  end;
end;

procedure PictureMaximaze;
var
  b2: TBitmap;
begin
  b2 := TBitmap.Create;
  b2.SetSize(w, h);
  try
    b2.Canvas.StretchDraw(Rect(0, 0, w, h), b);
    Image.Picture.Bitmap.Assign(b2);
  finally
    b2.Free;
  end;
end;

procedure LoadImg(Path: string);

procedure LoadDllImage(DllName,Dllfunction,ImagePath: string);
type
 TLoadImage = procedure(Path: Pchar; var hBmp: HBITMAP); stdcall;
var
 hndDLLHandle: THandle;
 LoadImage: TLoadImage;
 buf: array [0..244] of Char;
 hBmp: HBITMAP;
begin
 try
  hndDLLHandle := LoadLibrary(StrPCopy(buf,DllName));
  @LoadImage := getProcAddress(hndDLLHandle,StrPCopy(buf,Dllfunction));
  if addr(LoadImage) <> nil then
    begin
     hBmp := b.Handle;
     LoadImage(PChar(ImagePath),hBmp);
     b.Handle:=hBmp;  // не обезательно. А var параметр подразумевает что
       // будет передаваться инициализированная переменная.
    end;
 finally
  FreeLibrary(hndDLLHandle);
 end;
end;

 begin
    StatusBar.Panels[0].Text := ReadIniPrm(FRLngPath,'Dialog','fileload',Str);
    try
     if AnsiCompareText(ExtractFileExt(Path),'.bmp') = 0 then
      b.LoadFromFile(Path);
     if AnsiCompareText(ExtractFileExt(Path),'.png') = 0 then
      LoadDllImage(DllName,'LoadPng',Path);
     if AnsiCompareText(ExtractFileExt(Path),'.tga') = 0 then
      LoadDllImage(DllName,'LoadTga',Path);
     if (AnsiCompareText(ExtractFileExt(Path),'.jpg') = 0) or
       (AnsiCompareText(ExtractFileExt(Path),'.jpe') = 0) or
       (AnsiCompareText(ExtractFileExt(Path),'.jpeg') = 0) then
         LoadDllImage(DllName,'LoadJpg',Path);
    finally
     StatusBar.Panels[0].Text := '';
    end;
  end;

begin
  // перевірка чи вільна зона завантаження
  if RecStart then Exit;
  if WebStart then CreateWeb.Execute;

  w := VideoWindow.Width;
  h := VideoWindow.Height;
  // завантаження фото
  OpenImage.Filter := 'BMP|*.bmp|JPEG|*.jpg;*.jpeg;*.jpe|PNG|*.png|TGA|*.tga|All|*.*';
  if OpenImage.Execute then
  begin
    FRecog.Active := true;
    b := TBitmap.Create;
    try
      LoadImg(OpenImage.Filename);
      case CheckPictureSize(b) of
        psNormal: Image.Picture.Bitmap.Assign(b);
        psBig: PictureMinimaze;
        psSmall: PictureMaximaze;
      end;
    finally
      b.Free;
    end;

  MainForm.Caption := OpenImage.FileName;
  end
end;

procedure TMainForm.LoadVideosExecute(Sender: TObject);

  procedure Play;
  begin
    OpenVideo.Filter := 'Windows File|*.avi|All File|*.*';
    if OpenVideo.Execute then
    begin
      OptionForm.GroupBox.Enabled := false;
      VideoWindow2.FilterGraph := nil; // Free for before use
      VideoWindow.FilterGraph := CaptureGraph;
       PlayExecute(Self);
      VideoWindow.PopupMenu := PopupMenu;
      SoundLevel.Position := CaptureGraph.Volume;

      OptionForm.ReadStreamProperties;
      WinSevenConnect.ProgressState := Normal;
      MainForm.Caption := OpenVideo.FileName;
      WinSevenConnect.ThumbButton.THBtn1.Flags := [];
      WinSevenConnect.ThumbButton.THBtn2.Flags := [];
      WinSevenConnect.ThumbButton.THBtn3.Flags := [];
      SetGliph(btnVideo, ImageList, 11);
      VideoStart := true;
      FRecog.Active := false;
      tbVideoTrack.Visible := True;
      ToolBarVideo.Visible := True;
      MainForm.Height := MainForm.Height + tbVideoTrack.Height + ToolBarVideo.Height;
    end;
  end;

  procedure Stop;
  begin
    VideoWindow.PopupMenu := nil;
    StatusBar.Panels[0].Text := '';
    tbVideoTrack.Visible := False;
    ToolBarVideo.Visible := False;
    MainForm.Height := MainForm.Height - tbVideoTrack.Height - ToolBarVideo.Height;
    OptionForm.GroupBox.Enabled := true;

    VideoStart := false;
    CaptureGraph.ClearGraph;
    CaptureGraph.Active := False;
    SetGliph(btnVideo, ImageList, 10);
    WinSevenConnect.ProgressState := Noprogres;
    WinSevenConnect.SetOverIcon(-1);
    MainForm.Caption := 'FaceRecognition';
    WinSevenConnect.ThumbButton.THBtn1.Flags := [tfDisable];
    WinSevenConnect.ThumbButton.THBtn2.Flags := [tfDisable];
    WinSevenConnect.ThumbButton.THBtn3.Flags := [tfDisable];
    FRecog.Active := false;
    ClearArea;
  end;

begin
  // перевірка чи вільна зона завантаження
  if RecStart then Exit; { !!! }
  if WebStart then Exit;
  // завантажоня відел
  try
   if VideoStart then Stop else Play;
  except
    VideoStart := false;
  end;
end;

procedure TMainForm.CreatePhotoExecute(Sender: TObject);
begin
  // Перевіряємо чи є що фоткать
  // if CheckError then Exit;
  // Перевіряємо чи не йде відлік при запису відео
  if TimerCreateVideo.Enabled = true then Exit;
  if (not VideoStart) and (CheckError) then Exit;
   // пкрквірка шляху
  if not GetPhotoPathFile then
  begin
    ShowMessage(ReadIniPrm(FRLngPath, 'Dialog', 'notphotosave', Str));
    Exit;
  end;

  PhotoNumber := OptionForm.sePhoto.Value;
  CountDown := OptionForm.sePhoto2.Value;
  // робимо відповідку кількість знімків
  if OptionForm.cbPhoto.Checked then
    TimerCountDown.Enabled := true
  else
    TimerCreatePhoto.Enabled := true;
end;

procedure TMainForm.WinSevenConnectClick1(Sender: TObject);
begin
 Pouse.Execute;
end;

procedure TMainForm.WinSevenConnectClick2(Sender: TObject);
begin
 Stop.Execute;
end;

procedure TMainForm.WinSevenConnectClick3(Sender: TObject);
begin
  Play.Execute;
end;

procedure TMainForm.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

end.
