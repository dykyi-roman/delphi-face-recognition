unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Spin, Buttons;

type

 TBArray=array of TBitmap;


  TForm2 = class(TForm)
    Image2: TImage;
    Image3: TImage;
    Button2: TButton;
    CheckBox2: TCheckBox;
    edCountRect: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    labelRed: TLabel;
    labelBlue: TLabel;
    labelGreen: TLabel;
    Shape4: TShape;
    labelYellow: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
   imgThumbW,imgThumbH: Integer;
  end;

var
  Form2: TForm2;
  prScr: Word = 0;

implementation

uses main;

{$R *.dfm}


procedure TForm2.Button2Click(Sender: TObject);

const
 path = 'e:\mask\';

begin
 inc(PrScr);
 if not DirectoryExists(path) then CreateDir(path);

 MainForm.Image.Picture.SaveToFile(path + 'img_' + IntToStr(PrScr) + '.bmp');
 Image2.Picture.SaveToFile(path + 'img__' + IntToStr(PrScr) + '.bmp');
end;


procedure TForm2.FormCreate(Sender: TObject);
begin
 imgThumbW := 32;
 imgThumbh := 24;
end;

procedure MakeThumbnail(src, dest: TBitmap; ThumbW,ThumbH: Word);
type
  PRGB24 = ^TRGB24;
  TRGB24 = packed record
    B: Byte;
    G: Byte;
    R: Byte;
  end;
var
  x, y, ix, iy: integer;
  x1, x2, x3: integer;

  xscale, yscale: single;
  iRed, iGrn, iBlu, iRatio: Longword;
  p, c1, c2, c3, c4, c5: tRGB24;
  pt, pt1: pRGB24;
  iSrc, iDst, s1: integer;
  i, j, r, g, b, tmpY: integer;

  RowDest, RowSource, RowSourceStart: integer;
  w, h: integer;
  dxmin, dymin: integer;
  ny1, ny2, ny3: integer;
  dx, dy: integer;
  lutX, lutY: array of integer;

  ImgLength: Integer;

begin

  if src.PixelFormat <> pf24bit then src.PixelFormat := pf24bit;
  if dest.PixelFormat <> pf24bit then dest.PixelFormat := pf24bit;
  dest.Width := ThumbW;
  dest.Height := ThumbH;
  w := ThumbW;
  h := ThumbH;

  if (src.Width <= ThumbW) and (src.Height <= ThumbH) then
  begin
    dest.Assign(src);
    exit;
  end;

  iDst := (w * 24 + 31) and not 31;
  iDst := iDst div 8;  //  change div 8-> shr 3
  iSrc := (Src.Width * 24 + 31) and not 31;
  iSrc := iSrc div 8;

  xscale := 1 / (w / src.Width);
  yscale := 1 / (h / src.Height);

  // X lookup table
  SetLength(lutX, w);
  x1 := 0;
  x2 := trunc(xscale);
  for x := 0 to w - 1 do
  begin
    lutX[x] := x2 - x1;
    x1 := x2;
    x2 := trunc((x + 2) * xscale);
  end;

  // Y lookup table
  SetLength(lutY, h);
  x1 := 0;
  x2 := trunc(yscale);
  for x := 0 to h - 1 do
  begin
    lutY[x] := x2 - x1;
    x1 := x2;
    x2 := trunc((x + 2) * yscale);
  end;

  dec(w);
  dec(h);
  RowDest := integer(Dest.Scanline[0]);
  RowSourceStart := integer(Src.Scanline[0]);
  RowSource := RowSourceStart;
  for y := 0 to h do
  begin
    dy := lutY[y];
    x1 := 0;
    x3 := 0;
    for x := 0 to w do
    begin
      dx := lutX[x];
      iRed := 0;
      iGrn := 0;
      iBlu := 0;
      RowSource := RowSourceStart;
      for iy := 1 to dy do
      begin
        pt := PRGB24(RowSource + x1);
        for ix := 1 to dx do
        begin
          iRed := iRed + pt.R;
          iGrn := iGrn + pt.G;
          iBlu := iBlu + pt.B;
          inc(pt);
        end;
        RowSource := RowSource - iSrc;
      end;
      iRatio := 65535 div (dx * dy);
      pt1 := PRGB24(RowDest + x3);
      pt1.R := (iRed * iRatio) shr 16;
      pt1.G := (iGrn * iRatio) shr 16;
      pt1.B := (iBlu * iRatio) shr 16;
      x1 := x1 + 3 * dx;
      inc(x3, 3);
    end;
    RowDest := RowDest - iDst;
    RowSourceStart := RowSource;
  end;

  if dest.Height < 3 then exit;

  // Sharpening...
  s1 := integer(dest.ScanLine[0]);
  iDst := integer(dest.ScanLine[1]) - s1;
  ny1 := Integer(s1);
  ny2 := ny1 + iDst;
  ny3 := ny2 + iDst;
  for y := 1 to dest.Height - 2 do
  begin
    for x := 0 to dest.Width - 3 do
    begin
      x1 := x * 3;
      x2 := x1 + 3;
      x3 := x1 + 6;

      c1 := pRGB24(ny1 + x1)^;
      c2 := pRGB24(ny1 + x3)^;
      c3 := pRGB24(ny2 + x2)^;
      c4 := pRGB24(ny3 + x1)^;
      c5 := pRGB24(ny3 + x3)^;

      r := (c1.R + c2.R + (c3.R * -12) + c4.R + c5.R) div -8;
      g := (c1.G + c2.G + (c3.G * -12) + c4.G + c5.G) div -8;
      b := (c1.B + c2.B + (c3.B * -12) + c4.B + c5.B) div -8;

      if r < 0 then r := 0 else if r > 255 then r := 255;
      if g < 0 then g := 0 else if g > 255 then g := 255;
      if b < 0 then b := 0 else if b > 255 then b := 255;

      pt1 := pRGB24(ny2 + x2);
      pt1.R := r;
      pt1.G := g;
      pt1.B := b;
    end;
    inc(ny1, iDst);
    inc(ny2, iDst);
    inc(ny3, iDst);
  end;
end;


procedure TForm2.SpeedButton1Click(Sender: TObject);
var
 c: Byte;
begin
 c := StrToInt(edCountRect.Text);
 if c<5 then inc(c);
 edCountRect.Text := IntToStr(c);
 FRecog.FaceCount := StrToInt(edCountRect.Text);
end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
var
 c: Byte;
begin
 c := StrToInt(edCountRect.Text);
 if c > 1 then dec(c);
 edCountRect.Text := IntToStr(c);
FRecog.FaceCount := StrToInt(edCountRect.Text);
end;

end.
