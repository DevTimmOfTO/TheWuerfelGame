program TheWuerfelGame_Client;

uses
  Vcl.Forms,
  StartUp in 'StartUp.pas' {Form1},
  MainPlayer1 in 'MainPlayer1.pas' {Form2},
  Vcl.Themes,
  Vcl.Styles,
  UnicodeEmoji in 'UnicodeEmoji.pas',
  Statistics in 'Statistics.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
