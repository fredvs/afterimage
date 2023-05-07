unit main;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes, sysutils, mseglob, mseguiglob, mseguiintf, mseapplication, msestat,
 msemenus,msegui,msegraphics, msegraphutils, mseevent, mseclasses, msewidgets,
 mseforms,mseimage, msetimer, msesimplewidgets, BGRABitmap,BGRADefaultBitmap,
 BGRABitmapTypes, msebitmap, mseact, msedataedits,msedropdownlist, mseedit,
  mseificomp, mseificompglob, mseifiglob, msestatfile,msestream, msedatanodes,
  msedragglob, msegrids, msegridsglob,mselistbrowser,msesys, 
  msefiledialogx;

type
 tmainfo = class(tmainform)
   image: TBGRABitmap;
   ttimer1: ttimer;
   timage2: timage;
   tbutton2: tbutton;
   tbutton3: tbutton;
   tlabel1: tlabel;
   tlabel2: tlabel;
   tbutton4: tbutton;
   ttimer2: ttimer;
   tpaintbox1: tpaintbox;
   tbutton5: tbutton;
   timagelist3: timagelist;
   tframecomp2: tframecomp;
   tfilenameedit1: tfilenameeditx;
   procedure onblinck(const sender: TObject);
   procedure ontim(const sender: TObject);
   procedure onstop(const sender: TObject);
   procedure onauto(const sender: TObject);
   procedure ontim2(const sender: TObject);
   procedure oncrea(const sender: TObject);
   procedure onpaint(const sender: twidget; const acanvas: tcanvas);
   procedure onnegat(const sender: TObject);
   procedure ondots(const sender: TObject);
   procedure onchang(const sender: TObject);
   procedure ondest(const sender: TObject);
 end;
var
 mainfo: tmainfo;
 theinc: integer = 0;
implementation
uses
 main_mfm;

procedure Invert(Bitmap: TBGRABitmap);
    var
      i: integer;
      p: PBGRAPixel;
    begin
      p := Bitmap.Data;
     
      for i := Bitmap.NBPixels - 1 downto 0 do
      begin
        p^.red := not p^.red;
        p^.green := not p^.green;
        p^.blue := not p^.blue;
        //p^.alpha := not p^.alpha;
        Inc(p);
      end;
    end; 
    
    
procedure tmainfo.onblinck(const sender: TObject);
begin
tbutton3.visible := true;
ttimer2.enabled := false;
theinc := 0;
tlabel1.caption := 'Stare at the red dot for 20 seconds';
timage2.visible := true;
ttimer1.enabled := true;
tpaintbox1.visible := false;
end;

procedure tmainfo.ontim(const sender: TObject);
begin
if timage2.color = cl_white then  timage2.color := cl_black else  timage2.color := cl_white;
end;

procedure tmainfo.onstop(const sender: TObject);
begin
tpaintbox1.visible := true;
tbutton2.visible := true;
tbutton4.visible := true;
tbutton3.visible := false;
ttimer2.enabled := false;
theinc := 0;
timage2.visible := false;
ttimer1.enabled := false;
tlabel2.visible := true;
tlabel1.caption := 'Stare at red dot for 20 sec and click Blink.';
end; 

procedure tmainfo.onauto(const sender: TObject);
begin
theinc := 0;
tlabel1.caption := 'Stare at the red dot for 20 seconds.';
ttimer2.enabled := true;
tlabel2.visible := false;
tbutton2.visible := false;
tbutton3.visible := true;
tbutton4.visible := false;
tpaintbox1.visible := true;
end;

procedure tmainfo.ontim2(const sender: TObject);
begin
theinc := theinc + 1;
if theinc < 21 then 
tlabel1.caption := 'Stare at the red dot for ' + inttostr(20-theinc) + ' seconds.'
else onblinck(sender);
end;

procedure tmainfo.oncrea(const sender: TObject);
begin
  image := TBGRABitmap.Create('cheet.png');
  tpaintbox1.width := image.width;
  tpaintbox1.height := image.height;
  width := image.width + 8;
  height := image.height + tpaintbox1.top + 4;
  Invert(image);
  ondots(sender);
end;

procedure tmainfo.onpaint(const sender: twidget; const acanvas: tcanvas);
begin
  image.Draw(aCanvas,0,0,True);
end;

procedure tmainfo.onnegat(const sender: TObject);
begin
Invert(image);
tpaintbox1.invalidate;
end;

procedure tmainfo.ondots(const sender: TObject);
begin
image.FillEllipseAntialias(image.Width/2,image.Height/3,6,6, BGRA(255,0,0));
image.FillEllipseAntialias((image.Width/2) -11,(image.Height/3) +14 ,6,6, BGRA(0,255,0));
image.FillEllipseAntialias((image.Width/2) +11,(image.Height/3) +14 ,6,6, BGRA(0,0,255));
end;

procedure tmainfo.onchang(const sender: TObject);
begin
 image.free;
 image := TBGRABitmap.Create(tfilenameedit1.value);
  tpaintbox1.width := image.width;
  tpaintbox1.height := image.height;
  width := image.width + 8;
  height := image.height + tpaintbox1.top + 4;
  Invert(image);
  ondots(sender);
end;

procedure tmainfo.ondest(const sender: TObject);
begin
image.free;
end;
 
end.
