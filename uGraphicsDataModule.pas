unit uGraphicsDataModule;

interface

uses
  System.SysUtils, System.Classes, Vcl.ImgList, Vcl.Controls, cxGraphics,
  System.ImageList, cxImageList;

type
  TdmRCGraphics = class(TDataModule)
    NavIcons32: TcxImageList;
    Icons24: TcxImageList;
    Icons32: TcxImageList;
    Icons16: TcxImageList;
  private
  public
  end;

var
  dmRCGraphics: TdmRCGraphics;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

initialization
  dmRCGraphics := TdmRCGraphics.Create(nil);
finalization
  dmRCGraphics.Free;

end.
