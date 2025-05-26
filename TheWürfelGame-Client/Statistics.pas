unit Statistics;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.Generics.Collections, // Wichtig für TList<Integer> und TDictionary
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VclTee.TeEngine,
  VclTee.Series, Vcl.ExtCtrls, VclTee.TeeProcs, VclTee.Chart, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit13: TEdit;
    Edit14: TEdit;
    Chart1: TChart;
    Series2: TPieSeries;
    GroupBox3: TGroupBox;
    Label15: TLabel;
    Edit15: TEdit;
    // Die UpdateStatistics Prozedur muss jetzt einen Parameter bekommen
    procedure UpdateStatistics(const ADiceValues: array of Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

// uses MainPlayer1; // Diese Zeile ist hier nicht mehr notwendig, da wir keine direkten Variablen mehr von dort ziehen.

procedure TForm3.UpdateStatistics(const ADiceValues: array of Integer);
var
  Häufigkeit: TDictionary<Integer, Integer>; // Verwende TDictionary für Häufigkeiten
  Relativ: array [1 .. 6] of Double;
  i, Wert, GesamtAnzahl: Integer;
  MaxHäufigkeit, MinHäufigkeit, Häufigster, Seltenster, Summe: Integer;
  Mittelwert: real;
begin
  Häufigkeit := TDictionary<Integer, Integer>.Create; // Dictionary initialisieren
  try
    // Initialisiere Häufigkeit für alle Würfelwerte von 1 bis 6 auf 0
    for i := 1 to 6 do
      Häufigkeit.Add(i, 0);

    // Absolute Häufigkeit zählen basierend auf den übergebenen Werten
    for Wert in ADiceValues do
      if (Wert >= 1) and (Wert <= 6) then // Sicherstellen, dass die Werte gültig sind
        Häufigkeit.Items[Wert] := Häufigkeit.Items[Wert] + 1;

    // Gesamtanzahl der Würfel
    GesamtAnzahl := Length(ADiceValues); // Nimm die Länge des übergebenen Arrays

    // Relative Häufigkeit berechnen
    for i := 1 to 6 do
      if GesamtAnzahl > 0 then
        Relativ[i] := Häufigkeit.Items[i] / GesamtAnzahl // Zugriff über Items[i]
      else
        Relativ[i] := 0;

    // Häufigster und seltenster Wert finden
    MaxHäufigkeit := -1;
    MinHäufigkeit := MaxInt;
    Häufigster := 0; // Standardwert setzen
    Seltenster := 0; // Standardwert setzen

    for i := 1 to 6 do
    begin
      if Häufigkeit.Items[i] > MaxHäufigkeit then
      begin
        MaxHäufigkeit := Häufigkeit.Items[i];
        Häufigster := i;
      end;
      // Seltenster Wert: Muss größer als 0 sein, um wirklich gewürfelt worden zu sein
      if (Häufigkeit.Items[i] < MinHäufigkeit) then // Häufigkeit kann 0 sein, was ok ist
      begin
        MinHäufigkeit := Häufigkeit.Items[i];
        Seltenster := i;
      end;
    end;

    // Wenn alle Würfel die gleiche Häufigkeit haben, ist "Seltenster" möglicherweise nicht sinnvoll.
    // Aber für den Kniffel-Kontext ist das meist ein unwahrscheinlicher Fall.

    // GUI: Absolute Häufigkeit eintragen
    Edit7.Text := IntToStr(Häufigkeit.Items[1]);
    Edit10.Text := IntToStr(Häufigkeit.Items[2]);
    Edit8.Text := IntToStr(Häufigkeit.Items[3]);
    Edit11.Text := IntToStr(Häufigkeit.Items[4]);
    Edit9.Text := IntToStr(Häufigkeit.Items[5]);
    Edit12.Text := IntToStr(Häufigkeit.Items[6]);

    // GUI: Relative Häufigkeit eintragen
    Edit1.Text := Format('%.2f %%', [Relativ[1] * 100]);
    Edit4.Text := Format('%.2f %%', [Relativ[2] * 100]);
    Edit2.Text := Format('%.2f %%', [Relativ[3] * 100]);
    Edit5.Text := Format('%.2f %%', [Relativ[4] * 100]);
    Edit3.Text := Format('%.2f %%', [Relativ[5] * 100]);
    Edit6.Text := Format('%.2f %%', [Relativ[6] * 100]);

    // Häufigste/wenigste Werte eintragen
    // Füge eine Bedingung hinzu, falls Häufigster/Seltenster nicht gefunden wurde (z.B. bei leeren ADiceValues)
    if Häufigster > 0 then
      Edit13.Text := Format('%d (%d×)', [Häufigster, MaxHäufigkeit])
    else
      Edit13.Text := 'N/A'; // Not Applicable

    if Seltenster > 0 then
      Edit14.Text := Format('%d (%d×)', [Seltenster, MinHäufigkeit])
    else
      Edit14.Text := 'N/A';


    // Mittelwert
    Summe := 0;
    for Wert in ADiceValues do
      Summe := Summe + Wert;

    if GesamtAnzahl > 0 then
      Mittelwert := Summe / GesamtAnzahl
    else
      Mittelwert := 0;

    Edit15.Text := Format('%.2f', [Mittelwert]);

    // Kreisdiagramm (Series2) aktualisieren
    Series2.Clear;
    for i := 1 to 6 do
      if Häufigkeit.Items[i] > 0 then
        Series2.Add(Häufigkeit.Items[i], IntToStr(i), clTeeColor);
    // clTeeColor sorgt für automatische Farbe;
  finally
    Häufigkeit.Free; // Wichtig: Dictionary freigeben
  end;
end;

end.
