program TheWuerfelGame_Server;

uses
  Vcl.Forms,
  MainServer in 'MainServer.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
