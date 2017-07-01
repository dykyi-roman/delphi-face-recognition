unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TAboutForm = class(TForm)
    Cancel: TButton;
    Image1: TImage;
    ProgText: TStaticText;
    Bevel1: TBevel;
    labelReadMe: TLabel;
    labelSite: TLabel;
    labelIcq: TLabel;
    labelmail: TLabel;
    labelemail2: TLabel;
    Label1: TLabel;
    procedure CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure labelReadMeClick(Sender: TObject);
    procedure labelSiteClick(Sender: TObject);
    procedure labelReadMeMouseEnter(Sender: TObject);
    procedure labelReadMeMouseLeave(Sender: TObject);
    procedure labelmailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

uses
 Shellapi,uGlobal;

{$R *.dfm}

procedure SetIcon(Icon: TIcon; pic: TImage);
begin
 pic.Picture.Icon := Icon;
end;

procedure TAboutForm.CancelClick(Sender: TObject);
begin
 Close;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
 SetIcon(Application.Icon,Image1);
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  Localize(AboutForm, FRLanguag);
end;

procedure TAboutForm.labelmailClick(Sender: TObject);
begin
ShellExecute(0,
            PWideChar('open'),
            PwideChar('mailto:dukuyteam-admin@s1.ho.ua'),
            nil,nil,
            SW_SHOWNORMAL
            );
end;

procedure TAboutForm.labelReadMeClick(Sender: TObject);
begin
 ShellExecute(0,PWideChar('open'),PwideChar(FRPath + 'FRReadMe.txt'),nil,nil,SW_SHOWNORMAL);
end;

procedure TAboutForm.labelReadMeMouseEnter(Sender: TObject);
begin
 TLabel(Sender as TObject).Font.Color := clBlue;
end;

procedure TAboutForm.labelReadMeMouseLeave(Sender: TObject);
begin
 TLabel(Sender as TObject).Font.Color := clBlack;
end;

procedure TAboutForm.labelSiteClick(Sender: TObject);
begin
 ShellExecute(0,
              PWideChar('open'),
              PwideChar('http://www.dukuyteam.ho/html/face.php'),
              nil,nil,
              SW_SHOWNORMAL
             );
end;

end.
