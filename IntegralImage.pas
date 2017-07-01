unit IntegralImage;

interface

uses Graphics,Types;
type
TRGB=record
r,g,b:byte;
end;
trgba=array[0..1024]of trgb;
prgba=^trgba;
//Класс интегрального изображения
TIntegralImage=class(TObject)
private
matrix:array of array of integer;
function Awidth:integer;
function Aheight:integer;
public
procedure Assign(bmp:TBitmap);
function GetRect(r:Trect):integer;
property width:integer read AWidth;
property Height:integer read AHeight;
end;

implementation

{ TIntegralImage }

function TIntegralImage.Aheight: integer;
begin
result:=length(self.matrix[0]);
end;

procedure TIntegralImage.Assign(bmp: TBitmap);
var
i,j,w,h,s:integer;
l:prgba;
begin
//Создаем матрицу соразмерную изображению
bmp.PixelFormat:=pf24bit;
w:=bmp.Width;
h:=bmp.Height;
setlength(matrix,w);
for i:=0 to w-1 do
setlength(matrix[i],h);
//Вычисляем интегральную матрицу
for j:=0 to h-1 do
begin
l:=bmp.ScanLine[j];
for i:=0 to w-1 do
begin
s:=l[i].r;
if i>0 then s:=s+matrix[i-1,j];
if j>0 then s:=s+matrix[i,j-1];
if (i>0)and(j>0)then s:=s-matrix[i-1,j-1];
matrix[i,j]:=s;
end;
end;
end;

function TIntegralImage.Awidth: integer;
begin
result:=length(self.matrix);
end;

function TIntegralImage.GetRect(r: Trect): integer;
begin
// так як в масиві рахунок від нуля то робимо перевірку чи не вилізли ми за масив
 if (Length(matrix) = r.Right) or (Length(matrix) =  r.Bottom) then
  begin
   Result := 0;
   Exit;
  end;

  result:=matrix[r.Right,r.Bottom];

 if r.top > 0 then result := result - matrix[r.Right,r.top-1];
 if r.left > 0 then result := result - matrix[r.Left-1,r.bottom];
 if (r.left > 0) and (r.Top > 0) then result := result + matrix[r.Left-1,r.top-1];
end;

end.
