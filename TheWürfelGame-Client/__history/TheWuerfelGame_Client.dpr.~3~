program TheWuerfelGame_Client;

uses
  Vcl.Forms,
  StartUp in 'StartUp.pas' {Form1},
  MainPlayer1 in 'MainPlayer1.pas' {Form2},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
