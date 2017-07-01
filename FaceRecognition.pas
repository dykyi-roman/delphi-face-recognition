unit
 FaceRecognition;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Contnrs,
 DSPack,
 IntegralImage;

type
 TFaceRect = array[1..5] of TRect;

TPointRect = record
   TLeft: Pointer;
   TRight: Pointer;
   BLeft: Pointer;
   BRight: Pointer;
 end;

 TRGB = record
   r,g,b: byte;
  end;

  trgba = array[0..1024] of trgb;
  prgba = ^trgba;

  T3D = record
    X,Y,Z: Word;
  end;

 Tmas = array of T3D;
 pmas = ^Tmas;

 TFacePrm = class(TCollectionItem)
  private
   FShow: Boolean;
   FSize: Byte;
   FName: string;
   FColor: TColor;
  public
   constructor Create(Collection: TCollection); override;
  published
   property Show: Boolean read FShow write FShow;
   property Size: Byte read FSize write FSize;
   property Name: string read FName write FName;
   property Color: TColor read FColor write FColor;
 end;

 TFaceObjects = class(TCollection)
  protected
   function GetItem(Index: Integer): TFacePrm;
  public
   function Add: TFacePrm;
   property Items[Index: Integer]: TFacePrm read GetItem;
 end;


 TRecognitionFace = class
   private
    FActive: Boolean;
    FBitmap: TBitmap;
    FPrepareBitmap: TBitmap;
    FFaceCount: Byte;
    FIntegralPrm1: Byte;
    FIntegralPrm2: Byte;
    TimeRecognition: Cardinal;

    FFaceObjects: TFaceObjects;
    procedure SetActive(const Value: Boolean);
    procedure SetFaceCount(const Value: Byte);
    procedure SetIntegralPrm1(const Value: Byte);
    procedure SetIntegralPrm2(const Value: Byte);
   protected
    function CheckBitmap: Boolean;
    function CreateIngegralImage(InBitmap: TBitMap; param1,param2: Byte): TBitmap;
    procedure ResizeBitmap(src, dest: TBitmap; ThumbW,ThumbH: Word);
    procedure GrayScale(var clip: tbitmap);
    procedure Recog(inBitmap: TBitmap; outBitmap: TObject); //32x24
   public
    constructor Create;
    destructor Destroy; override;
    function GetTimeRecognition: Cardinal;
    procedure Recognition(inBitmap: TBitmap; outBitmap: TObject);
   published
    property PrepareBitmap: TBitmap read FPrepareBitmap;
    property Active: boolean read FActive write SetActive default False;
    property MoreOneFace: boolean read FActive write SetActive default False;
    property FaceObjects: TFaceObjects read FFaceObjects write FFaceObjects;
    property FaceCount: Byte read FFaceCount write SetFaceCount default 1;
    property IntegralPrm1: Byte read FIntegralPrm1 write SetIntegralPrm1 default 90;
    property IntegralPrm2: Byte read FIntegralPrm2 write SetIntegralPrm2 default 90;
 end;

implementation

uses unit2;

{ TFacePrm }

constructor TFacePrm.Create(Collection: TCollection);
begin
  inherited;
  FShow := False;
  FSize := 1;
end;

{ TFaceObjects }

function TFaceObjects.Add: TFacePrm;
begin
  Result := (inherited Add) as TFacePrm;
end;

function TFaceObjects.GetItem(Index: Integer): TFacePrm;
begin
 Result := (inherited GetItem(Index)) as TFacePrm;
end;

{ TRecognitionFace }

function TRecognitionFace.CheckBitmap: Boolean;
begin
 Result := False;
 if Assigned(FBitmap) then Result := True;
end;

constructor TRecognitionFace.Create;
begin
 FBitmap := TBitmap.Create;
 FPrepareBitmap := TBitmap.Create;
 FBitmap.PixelFormat := pf24bit;
 FFaceObjects := TFaceObjects.Create(TFacePrm);
 // додавання до колекції обличчя
 with FaceObjects.Add do
  begin
   FShow := true;
   FName := 'Face';
  end;
 // додавання до колекції обличчя органи
 with FaceObjects.Add do FName := 'Eyes';
 with FaceObjects.Add do FName := 'EyeBrows';
 with FaceObjects.Add do FName := 'Nose';
 with FaceObjects.Add do FName := 'Mouth';

 FActive := False;
 FFaceCount := 1;
 FIntegralPrm1 := 90;
 FIntegralPrm2 := 90;
end;

destructor TRecognitionFace.Destroy;
begin
  FreeAndNil( FBitmap );
  FreeAndNil( FPrepareBitmap );
  FreeAndNil( FFaceObjects );
 inherited;
end;

procedure TRecognitionFace.SetFaceCount(const Value: Byte);
begin
 if FFaceCount <> Value then
  FFaceCount := Value;
end;

procedure TRecognitionFace.SetIntegralPrm1(const Value: Byte);
begin
 if FIntegralPrm1 <> Value then
  FIntegralPrm1 := 79 + Value;       // -1 - ділення на 0
end;

procedure TRecognitionFace.SetIntegralPrm2(const Value: Byte);
begin
 if FIntegralPrm2 <> Value then
  FIntegralPrm2 := 80 + Value; // обмежимо область
end;

procedure TRecognitionFace.SetActive;
begin
 if Value <> FActive then
  FActive := Value;
end;

////////////////////////////////////////////////////////////////////////////////
///////////////////////        Методи роботи з класом      /////////////////////
////////////////////////////////////////////////////////////////////////////////

function TRecognitionFace.GetTimeRecognition: Cardinal;
begin
 if TimeRecognition = 0 then
  Result := 0
 else
 Result := GetTickCount() - TimeRecognition;
end;

////////////////////////////////////////////////////////////////////////////////
///////////////////////     Методи розпізнавання           /////////////////////
////////////////////////////////////////////////////////////////////////////////

{ ************************ Зменшення зображення *******************************}
procedure TRecognitionFace.ResizeBitmap(src, dest: TBitmap; ThumbW,ThumbH: Word);
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
    Exit;
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

  if dest.Height < 3 then Exit;

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
{ ************************ Монохромне зображення ******************************}
procedure TRecognitionFace.GrayScale(var clip: tbitmap);
var
 p0: pbytearray;
 Gray,x,y: Integer;
begin
  for y:=0 to clip.Height-1 do
  begin
    p0:=clip.scanline[y];
    for x:=0 to clip.Width-1 do
    begin
      Gray:=Round(p0[x*3]*0.3+p0[x*3+1]*0.59+p0[x*3+2]*0.11);
      p0[x*3]:=Gray;
      p0[x*3+1]:=Gray;
      p0[x*3+2]:=Gray;
    end;
  end;
end;
{ ******************* Приведення зображення до інтегр вигляду *****************}
function TRecognitionFace.CreateIngegralImage(InBitmap: TBitMap; param1,param2: Byte): TBitmap;
var
  iX1, iY1,
  iX2, iY2,
  ii, jj,
  s, s2,
  iSum, iCount,  index,
  iHeight, iWidth : Integer;
  iSize: Integer;

  row : ^TRGBTriple;
  black : TRGBTriple;
  aIntegralIm: array  of Integer;
  aGrays : array of Byte;

  bBitmap: TBitmap;
begin

 bBitmap := TBitmap.Create;
 bBitmap.Assign(InBitmap);
 bBitmap.PixelFormat := pf24bit;


 Result := TBitmap.Create;
 Result.PixelFormat := pf24bit;

 Result.SetSize(InBitmap.Width,InBitmap.Height);

  iWidth := bBitmap.Width;
  iHeight := bBitmap.Height;
  iSize := iWidth * iHeight;

  SetLength(aGrays, iSize);
  SetLength(aIntegralIm, iSize);

  black.rgbtRed  := (clBlack and $0000FF);
  black.rgbtGreen := (clBlack and $00FF00) shr 8;
  black.rgbtBlue := (clBlack and $FF0000) shr 16;

  Result.Canvas.Brush.Color := clWhite;
  Result.Canvas.FillRect(Rect(0, 0, Result.Width, Result.Height));

  s := Round(iWidth / (100 - param1));
    s2 := Round(s / 2);

  index := 0;

  for ii := 0 to iHeight - 1 do begin
     row := bBitmap.ScanLine[ii];
     for jj := 0 to iWidth - 1 do begin
       aGrays[index] := ((row.rgbtRed * 77 + row.rgbtGreen * 150 + row.rgbtBlue * 29) shr 8);
       inc(index);
       inc(row);
     end;
  end;


  for ii := 0 to iWidth - 1 do begin
     iSum := 0;
     for jj := 0 to iHeight - 1 do begin
       index := jj*iWidth+ii;
       iSum := iSum + aGrays[index];
       if ii = 0 then aIntegralIm[index] := iSum
       else aIntegralIm[index] := aIntegralIm[index - 1] + iSum;
     end;
  end;


  for jj := 0 to iHeight - 1 do begin
     row := Result.ScanLine[jj];
     for ii := 0 to iWidth - 1 do begin

       index := jj*iWidth+ii;

       iX1 := ii-s2;
       iX2 := ii+s2;
       iY1 := jj-s2;
       iY2 := jj+s2;

       if (iX1 < 0) then iX1 := 0;
         if (iX2 >= iWidth) then  iX2 := iWidth-1;
           if (iY1 < 0) then  iY1 := 0;
             if (iY2 >= iHeight) then  iY2 := iHeight-1;

       iCount := (iX2 - iX1) * (iY2 - iY1);

       iSum := aIntegralIm[iY2*iWidth+iX2]
              - aIntegralIm[iY1*iWidth+iX2]
              - aIntegralIm[iY2*iWidth+iX1]
              + aIntegralIm[iY1*iWidth+iX1];

       if (aGrays[index] * iCount) < (iSum * (100 - 15) / param2) then  row^ :=  black;

       inc(row);

     end;
  end;
  bBitmap.Free;
end;
{ *************************** Cаме розпізнавання ******************************}
procedure TRecognitionFace.Recog(inBitmap: TBitmap; outBitmap: TObject);
var
 l: prgba;
 x,y,w,h: Word;
 p:  TPoint;
 pmas: Tmas;
 a: integer;

// пошук світлої області мінімум на 3 pix (лоб)
function isMayByFace : Boolean;
const
 max_color = 255;
 min_color = 225;
begin
 Result := False;
 if (l[x].r in [min_color..max_color] ) and
    (l[x + 1].r in [min_color..max_color]) and
    (l[x + 2].r in [min_color..max_color]) then
 Result := True;
end;
// пошук темної області діапазон 8 pix (рамка обличчя)
function isTrues : Boolean;

const
 sum_col = 10;
// 4 - довжина чорної полоски
// 3 - кількість співпадінь
// 1 рівень пошуку вгору
function Check_1: Boolean;
var
 sum,i: Word;
begin
 sum := 0;
 Result := False;
 for I := 0 to 4 do
  if (x + i in [0..w-4]) then
   if GetRValue(inBitmap.Canvas.Pixels[x + i, y - 1]) <= sum_col
    then inc(sum);

 if sum >= 3 then Result := True;
end;
// 2 рівень пошуку вгору
function Check_2: Boolean;
var
 sum,i: Word;
begin
 sum := 0;
 Result := False;
 for I := 0 to 4 do
  if (x + i in [0..w-4]) then begin
   if GetRValue(inBitmap.Canvas.Pixels[x + i, y - 2]) <= sum_col
    then inc(sum);
  end;

 if sum >= 3 then Result := True;
end;

begin
 Result := False;
 if (Check_1) or (Check_2) then Result := True;
end;
// видаляємо повторення якщо лоб товстий то ліній білого буде > 1 радіус 5 pix
function DelRepeat: Boolean;
begin
  Result := True;
  if ((p.X + 1 = x) and (p.Y = Y)) or
     ((p.X in [ X..X+5]) or (p.X in [X-5..X]) and (p.Y + 1 = Y)) then
  Result := False;
  p := Point(x,y);
end;
// сортування пікселів по 3-ому параметру
procedure Sort(var mas: Tmas);
var
 i,j,k: Byte;
 a: T3D;
begin
 k := Length(pmas);
 if k = 0 then Exit;
 for i := 0 to k - 1 do
  for j := k - 1 downto i + 1 do
   if mas[j - 1].Y > mas[j].Y then // <- по максимуму  >- по мінімуму
    begin
      a := mas[j];
      mas[j] := mas[j - 1];
      mas[j - 1] := a;
    end;
end;
// перетворення координат з 32x24 в (320x240,649,480)
procedure Positioning(var mas: Tmas);
var
 i,k,o: Byte;
begin
 k := Length(mas);
 case FBitmap.Width of
  320: o := 10;
  640: o := 20;
 end;
 if k = 0 then Exit;
 for i := 0 to k - 1 do begin
  mas[i].X := mas[i].X * o;
  mas[i].Y := mas[i].Y * o;
 end;
end;
// визначаємо яскравість переданої області
function GetRectLight(r: TRect): Word;
var
 i,j: Byte;
begin
 Result := 0;
 for I := r.left to r.Right do
  for j := r.Top to r.Bottom do
   begin
    if GetRValue(inBitmap.Canvas.Pixels[i,j]) > 225 then
    Result := Result + 1;
   end;
end;
// прибираємо шуми
function notNoise: Boolean;
var
 intImage: TIntegralImage;
 i : integer;
begin
 // 79 + 16 = 95 - діапазон після якого не нада  рибирати мусор, бо сильно розмивається обличчя
 // 3300 - початок замусореної області
 // 4080 - білий квадрат
 // 1300 -  темні області
  Result := True;
  if IntegralPrm1 <= 95 then begin
   intImage := TIntegralImage.Create;
   try
    intImage.Assign(inBitmap);
    i := intImage.GetRect(Rect(x + 1,y + 1,x + 4,y + 4));
    if (( i > 3300) and ( i < 4080)) or // сильно світла область
       (i < 1300) or     // сильно темна область
       (y + 4 > h) // облиичя вийшло за межі камери
    then
     Result := False;
   finally
     intImage.Free;
   end;
  end;
end;

// записуємо в масив можливу область обличчя
procedure WriteFace;
begin
 inc(a);
 SetLength(pmas,a + 1);
 pmas[a].X := X;
 pmas[a].Y := Y;
 pmas[a].Z := GetRectLight(Rect(x,y,x + 5,y + 9)); // face rect 7 - обмежим область обличчя
end;
// малювання знайдених областей
procedure RectDraw(FaceNum: Byte);

procedure Draw_(c: TCanvas);
begin
 with c do begin
    Brush.Style := TBrushStyle(1);
    Pen.Color := FaceObjects.Items[0].FColor;
    Pen.Width := FaceObjects.Items[0].FSize;
    // помилка при виході за розмір картинки
    case FBitmap.Width of
     320: Rectangle(pmas[FaceNum].X - 10, pmas[FaceNum].Y, pmas[FaceNum].X + 60, pmas[FaceNum].Y + 70);
     640: Rectangle(pmas[FaceNum].X - 20, pmas[FaceNum].Y, pmas[FaceNum].X + 120, pmas[FaceNum].Y + 140);
    end;
 end;
end;

begin
 if (outBitmap is TVMRBitmap) then
  begin
   with TVMRBitmap(outBitmap), Canvas do begin
   LoadEmptyBitmap(FBitmap.Width,FBitmap.Height,pf24bit, clSilver);
   Source := TVMRBitmap(outBitmap).Canvas.ClipRect;
   Options := TVMRBitmap(outBitmap).Options + [vmrbSrcColorKey];
   ColorKey := clSilver;
   Draw_(TVMRBitmap(outBitmap).Canvas);
   DrawTo(0,0,1,1,1);
  end;
  end;

 if (outBitmap is TBitmap) then
    Draw_(TBitmap(outBitmap).Canvas);

end;
// вивід знайдених областей
procedure FindFace;
var
 i,k: Byte;
begin
 k := Length(pmas); if k = 0 then Exit;
 Sort(pmas);
 Positioning(pmas);
 if FFaceCount > 1 then
  for i := 0 to FFaceCount - 1 do RectDraw(i)
 else
  RectDraw(0);
end;

begin
 a := -1;
 TimeRecognition := GetTickCount();
 inBitmap.PixelFormat := pf24bit;
 w := inBitmap.Width;
 h := inBitmap.Height;
 if (w = 0) or (h = 0) then Exit;

  for y := 0 to h - 1 do
   begin
    l := inBitmap.ScanLine[y];
    for x := 0 to w - 1 do
      if isMayByFace then
        if isTrues then
          if DelRepeat then
           begin
            with Form2.Image3.Canvas do begin

              if notNoise then
                begin
                 Pen.Color := clRed;
                 if GetRectLight(Rect(x+1,y+1,x+5,y+5)) <= 3 then Pen.Color := clYellow;
                end
              else
                Pen.Color := clBlue;

              if y + 4 > h then
                Pen.Color := clGreen;

                Brush.Style := TBrushStyle(1);
                Rectangle(x,y,x + 6,y + 6);
              end;

             if notNoise then
             WriteFace;
           end;
   end;
   FindFace;
end;
{ ******************* Головна функція розпізнавання ***************************}
procedure TRecognitionFace.Recognition(inBitmap: TBitmap; outBitmap: TObject);
const
 ThumbW = 32;
 ThumbH = 24;
var
 b2,b3: TBitmap;
begin
 if not Active then Exit; // перевірка на всластивість активності
 if Assigned(inBitmap) then FBitmap.Assign(inBitmap); // перевірка наявності бітмапа
 GrayScale(FBitmap);
 b2 := CreateIngegralImage(FBitmap,FIntegralPrm1,FIntegralPrm2);
 b3 := TBitmap.Create;
 b3.SetSize(ThumbW,ThumbH);
 try
   ResizeBitmap(b2,b3,ThumbW,ThumbH);
   // вивід предобробного зображення !!!
//   form2.Image2.Picture.Bitmap.Assign(b3);
//   form2.Image3.Picture.Bitmap.Assign(b3);
   Recog(b3,outBitmap);
 finally
   b2.Free;
   b3.Free;
 end;
end;

end.

procedure FindEyse(p: TPoint);

var
 a: Integer;
 mmm: Tmas;

procedure FindLeft;
var
 i,j: Byte;
begin
  for i := p.X to p.X + 1 do
   for j := p.Y to p.Y + 5 do
    begin
     inc(a);
     SetLength(mmm,a + 1);
     mmm[a].X := i;
     mmm[a].Y := j;
     mmm[a].Z := GetRValue(inBitmap.Canvas.Pixels[i,j]);


//    Form2.Image2.Canvas.Pixels[i,j] := clred;
    end;

 Sort(mmm);
 Positioning(mmm);

  with TBitmap(outBitmap).Canvas do begin
   Brush.Style := TBrushStyle(1);
   Pen.Color := clBlue;
   // Draw left eyes
    Rectangle(mmm[0].X, mmm[0].Y, mmm[0].X + 7, mmm[0].Y + 7)          // !!!
   // Draw right eyes  from evristik method
   // Rectangle(mmm[0].X+28, mmm[0].Y, mmm[0].X + 35, mmm[0].Y + 7);
  end;
end;

procedure FindRight;
var
 i,j: Byte;
begin

 i := p.X;
 j := p.Y;
 // danger zone
 while GetRValue(inBitmap.Canvas.Pixels[i,j]) in [225..255] do
  begin
   inc(i);
  end;

  p.X := i - 2;

  for i := p.X to p.X + 1 do
   for j := p.Y to p.Y + 5 do
    begin
     inc(a);
     SetLength(mmm,a + 1);
     mmm[a].X := i;
     mmm[a].Y := j;
     mmm[a].Z := GetRValue(inBitmap.Canvas.Pixels[i,j]);


   // Form2.Image2.Canvas.Pixels[i,j] := clred;
    end;

 Sort(mmm);
 Positioning(mmm);

  with MainForm.Image.Canvas do begin
   Brush.Style := TBrushStyle(1);
   Pen.Color := clBlue;
   Rectangle(mmm[0].X, mmm[0].Y, mmm[0].X + 7, mmm[0].Y + 7);
  end;
end;

begin
 a := -1;
 FindLeft;
 FindRight;
end;

