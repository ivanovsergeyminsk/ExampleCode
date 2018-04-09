unit cl_pirit_parser;

interface

uses
  System.Generics.Collections,
  cs_pirit, System.Classes, System.SysUtils;

type

  TPiritParamList = TList<string>;

  TPiritParam = class(TPiritParamList)
  private
    procedure _SetWString(AValue: string);
    function _GetText: string;
  public
    property WString: string read _GetText write _SetWString;
    constructor Create;
    destructor Destroy; override;
  end;

  TPiritResultCMD = class
    ErrorNum: integer;
    PiritParamResult: TPiritParam;
  public
    constructor Create;
    Destructor Destroy; override;
  end;

  TPiritResultBytesCMD = class
    ErrorNum: Integer;
    ResultBytes: TBytes;
  end;

  TIntegerSet = set of 0..SizeOf(Integer)*8 - 1;
  //  Include(TIntegerSet(I), N);     // установили N-ный бит в 1
  //  Exclude(TIntegerSet(I), N);     // сбросили N-ный бит в 0


  TParserStatusFlags = class
  private
    FWideString: WideString;

    FStatusFatalState: Integer;
    FStatusCurrentFlags: Integer;

    FStateDocument: Integer;

    procedure _ParseString;

    function _GetStatusFatalState: TStatusFatalState;
    function _GetStatusCurrentFlags: TStatusCurrentFlags;

    function _GetStatusDocument: TStatusDocument;
    function _GetTypeDocument: TTypeDocumentDevice;
    function _GetStateDocument: TStateDocumentDevice;


  public
    function GetStatusFlagsDevice: TStatusFlagsDevice;
    constructor Create(AWideString: WideString);
    destructor Destroy; override;
  end;

  function PiritParseString(AString: WideString): TList<String>;

  function PiritParseIntegerToStatePrinting(AInteger: integer): TStatePrinting;

  function PiritStringToDate(AString: String): TDate;
  function PiritStringToTime(AString: String): TTime;
  function PiritStringToDateTime(AStringDate, AStringTime: String): TDateTime;

  function PiritDateToString(ADate: TDate): string;
  function PiritTimeToString(ATime: TTime): string;

  function GenerateTypeModeDocumentValue(AType: TTypeDocumentDevice;
                                         AModeGenerate: TModeGenerateDocument;
                                         AModePrint: TModePrintRequsite): integer;

  function GenerateAttributeTextValue(AAttributeText: TAttributeText): integer;
  function SetDontSaveBit(ACodeRequsite: integer): integer;


  function BitMaskGetValueBoolean(ABitMaskValue: Integer; ANumBit: Integer): Boolean;
  function BitMaskGetValueInteger(ABitMaskValue: Integer; ANumBit: Integer; ACountBit: integer): Integer;

  function BitMaskSetValueBoolean(ABitMaskValue: Integer; ANumBit: Integer; AValue: boolean): Integer;
  function BitMaskSetValueInteger(ABitMaskValue: Integer; ANumBit: Integer; ACountBit: Integer; AValue: Integer): Integer;

  // Функции для HEX->ASCII->cp1251
  function StrOemToAnsi(const S: AnsiString): AnsiString;
  function StrAnsiToOem(const S: AnsiString): AnsiString;

  function HexToString(AHEXStr: string): string;
  function HtoB(AHEXStr: string): TBytes;


implementation

uses
  DateUtils, Winapi.Windows;

function StrOemToAnsi(const S: AnsiString): AnsiString;
begin
  if Length(S) = 0 then Result := ''
  else
    begin
      SetLength(Result, Length(S));
      OemToAnsiBuff(@S[1], @Result[1], Length(S));
    end;
end;

function StrAnsiToOem(const S: AnsiString): AnsiString;
begin
  if Length(S) = 0 then Result := ''
  else
    begin
      SetLength(Result, Length(S));
      AnsiToOemBuff(@S[1], @Result[1], Length(S));
    end;
end;

function HexToString(AHEXStr: string): string;
var
  FBytes: TBytes;
  FAStr: AnsiString;
begin
  FBytes := HtoB(AHEXStr);
  FAStr := TEncoding.ANSI.GetString(FBytes);
  Result := StrOemToAnsi(FAStr);
end;

function HtoB(AHEXStr: string): TBytes;
var
  FLen, FRes: integer;
  FHEXStr: string;
begin
  FHexStr := AHexStr.ToUpper;
  FHexStr := FHexStr.Replace(' ','');
  FLen := Length(FHexStr) div 2;
  SetLength(Result, FLen);
  FRes := HexToBin(PWideChar(FHexStr),0,Result,0, FLen);
end;


  function BitMaskGetValueInteger(ABitMaskValue: Integer; ANumBit: Integer; ACountBit: integer): Integer;
  var
    I, G : Integer;
    K: Integer;
  begin
    K := 0;
    G := 0;
  //  Include(TIntegerSet(I), N);     // установили N-ный бит в 1
  //  Exclude(TIntegerSet(I), N);     // сбросили N-ный бит в 0
    for I := ANumBit to ACountBit - 1 do
    begin
      if I in TIntegerSet(ABitMaskValue) then
        Include(TIntegerSet(K),G);

      G := G+1;
    end;

    Result := K;
  end;

  function BitMaskSetValueInteger(ABitMaskValue: Integer; ANumBit: Integer; ACountBit: Integer; AValue: Integer): Integer;
  var
    I, G : Integer;
    K: Integer;
  begin
    K := ABitMaskValue;
    G := 0;

    for I := ANumBit to ACountBit - 1 do
    begin
      if I in TIntegerSet(AValue) then
        Include(TIntegerSet(K),G)
      else
        Exclude(TIntegerSet(K), G);

      G := G+1;
    end;

    Result := K;
  end;
  function BitMaskGetValueBoolean(ABitMaskValue: Integer; ANumBit: Integer): Boolean;
  begin
    Result := False;
    if ANumBit in TIntegerSet(ABitMaskValue) then
      Result := True;
  end;

  function BitMaskSetValueBoolean(ABitMaskValue: Integer; ANumBit: Integer; AValue: boolean): Integer;
  var
    FResult: Integer;
  begin
    FResult := ABitMaskValue;
    if AValue
    then
      Include(TIntegerSet(FResult), ANumBit)
    else
      Exclude(TIntegerSet(FResult), ANumBit);
    Result := FResult;
  end;





function SetDontSaveBit(ACodeRequsite: integer): integer;
var
  FCode: integer;
begin
  FCode := ACodeRequsite;
  Include(TIntegerSet(FCode), 7);
  Result := FCode;
end;

function GenerateAttributeTextValue(AAttributeText: TAttributeText): integer;
var
  FResult: integer;
  I, FFontText: integer;
begin
  FResult := 0;
  FFontText := ord(AAttributeText.AFont);

//  Include(TIntegerSet(I), N);     // установили N-ный бит в 1
//  Exclude(TIntegerSet(I), N);     // сбросили N-ный бит в 0

// Устанавливаем биты для шрифта.
  for I := 0 to 3 do
  if I in TIntegerSet(FFontText) then
    Include(TIntegerSet(FResult), I);

// Устанавливаем 5-й бит
  if TPiritTextSize.pfsDoubleHeight in AAttributeText.ATextSize then
    Include(TIntegerSet(FResult), 4);

// Устанавливаем 6-й бит
  if TPiritTextSize.pfsDoubleWight in AAttributeText.ATextSize then
    Include(TIntegerSet(FResult), 5);

  Result := FResult;
end;

function GenerateTypeModeDocumentValue(AType: TTypeDocumentDevice;
                                       AModeGenerate: TModeGenerateDocument;
                                       AModePrint: TModePrintRequsite): integer;
var
  FResult: integer;
  I, TypeDoc: integer;
begin
  FResult := 0;
  TypeDoc := ord(AType);

//  Include(TIntegerSet(I), N);     // установили N-ный бит в 1
//  Exclude(TIntegerSet(I), N);     // сбросили N-ный бит в 0

//Устанавливаем биты для типа документа.
  for I := 0 to 3 do
  if I in TIntegerSet(TypeDoc) then
    Include(TIntegerSet(FResult), I);

//Устанавливаем 5-й бит для режима формирования документа
  if AModeGenerate = TModeGenerateDocument.mgdPackage then
    Include(TIntegerSet(FResult), 4);

//Устанавливаем 6-й бит для режима печати
  if AModePrint = TModePrintRequsite.mprDelay then
    Include(TIntegerSet(FResult), 5);

  Result := FResult;
end;

function PiritParseString(AString: WideString): TList<String>;
var
  FWTemp: WideString;
  FListResult:  TList<String>;
  I: Integer;
begin
  FWTemp := '';
  FListResult := TList<String>.Create;

  for I:=1 to Length(AString) do
  begin
  if AString[I] <> DelimiterPirit then
    FWTemp := FWTemp + AString[I]
  else
    begin
      FListResult.Add(WideCharToString(PWideChar(FWTemp)));
      FWTemp := '';
    end;
  if I = Length(AString) then
    begin
      FListResult.Add(WideCharToString(PWideChar(FWTemp)));
      FWTemp := '';
    end;
  end;

  Result := FListResult;
end;

function PiritParseIntegerToStatePrinting(AInteger: integer): TStatePrinting;
var
  I : Integer;
begin
  Result := [];
//  Include(TIntegerSet(I), N);     // установили N-ный бит в 1
//  Exclude(TIntegerSet(I), N);     // сбросили N-ный бит в 0
  for I := 0 to 6 do
  if I in TIntegerSet(AInteger) then
    Result := Result + [TStatePrintingDevice(I)]
end;

function PiritDateToString(ADate: TDate): string;
var
  FWYear, FWMonth, FWDay: Word;

  FStrDate, FSYear, FSMonth, FSDay: string;
begin
  DecodeDate(ADate,FWYear,FWMonth, FWDay);

  FSDay   := FWDay.ToString;
  if Length(FSDay) = 1
  then
    FSDay := '0'+FSDay;

  FSMonth := FWMonth.ToString;
  if Length(FSMonth) = 1
  then
    FSMonth := '0'+FSMonth;

  FSYear  := FWYear.ToString;
  FSYear := FSYear.Remove(0,2);

  FStrDate := FSDay + FSMonth + FSYear;

  Result := FStrDate;

end;

function PiritTimeToString(ATime: TTime): string;
var
  FWHour, FWMin, FWSec: Word;

  FStrTime, FSHour, FSMin, FSSec: string;
begin
{TODO:...}
(*
    DecodeTime(ATime, FWHour, FWMin, FWSec);

    FSHour := FWHour.ToString;
    if Length(FSHour) = 1
    then
      FSHour := '0'+FSHour;

    FSMin := FWMin.ToString;
    if Length(FSMin) = 1
    then
      FSMin := '0'+FSMin;

    FSSec := FWSec.ToString;
    if Length(FSSec) = 1
    then
      FSSec := '0'+FSSec;

    FStrTime := FSHour + FSMin + FSSec;
    Result := FStrTime;
*)

end;

function PiritStringToDate(AString: String): TDate;
var
  FStrDay, FStrMonth, FStrYear: string;
begin
  FStrDay   := AString[1] + AString[2];
  FStrMonth := AString[3] + AString[4];
  FStrYear  := '20'+AString[5] + AString[6];

  Result := EncodeDate(FStrYear.ToInteger,
                       FStrMonth.ToInteger,
                       FStrDay.ToInteger);
end;

function PiritStringToTime(AString: String): TTime;
var
  FStrHour, FStrMin, FStrSec: string;
begin
  FStrHour := AString[1] + AString[2];
  FStrMin  := AString[3] + AString[4];
  FStrSec  := AString[5] + AString[6];

  Result := EncodeTime(FStrSec.ToInteger,
                       FStrMin.ToInteger,
                       FStrHour.ToInteger,
                       0);
end;

function PiritStringToDateTime(AStringDate, AStringTime: String): TDateTime;
var
  FStrDay, FStrMonth, FStrYear: string;
  FStrHour, FStrMin, FStrSec: string;
begin
  FStrHour  := AStringTime[1] + AStringTime[2];
  FStrMin   := AStringTime[3] + AStringTime[4];
  FStrSec   := AStringTime[5] + AStringTime[6];

  FStrDay   := AStringDate[1] + AStringDate[2];
  FStrMonth := AStringDate[3] + AStringDate[4];
  FStrYear  := '20'+AStringDate[5] + AStringDate[6];

  Result := EncodeDateTime(FStrYear.ToInteger,
                           FStrMonth.ToInteger,
                           FStrDay.ToInteger,
                           FStrHour.ToInteger,
                           FStrMin.ToInteger,
                           FStrSec.ToInteger,
                           0);
end;

{ TParserStatusFlags }

constructor TParserStatusFlags.Create(AWideString: WideString);
begin
  self.FWideString := AWideString;
  Self._ParseString;
end;

destructor TParserStatusFlags.Destroy;
begin

  inherited;
end;

function TParserStatusFlags.GetStatusFlagsDevice: TStatusFlagsDevice;
begin
  Result.AStatusFatalState   := Self._GetStatusFatalState;
  Result.AStatusCurrentFlags := Self._GetStatusCurrentFlags;
  Result.AStatusDocument     := Self._GetStatusDocument;
end;

function TParserStatusFlags._GetStateDocument: TStateDocumentDevice;
var
  I, G : Integer;
  K: Integer;
begin
  K := 0;
  G := 0;
//  Include(TIntegerSet(I), N);     // установили N-ный бит в 1
//  Exclude(TIntegerSet(I), N);     // сбросили N-ный бит в 0
  for I := 4 to 7 do
  begin
    if I in TIntegerSet(Self.FStateDocument) then
      Include(TIntegerSet(K),G);
    G := G+1;
  end;

  Result := TStateDocumentDevice(K);
end;

function TParserStatusFlags._GetStatusCurrentFlags: TStatusCurrentFlags;
var
  I : Integer;
begin
  Result := [];
//  Include(TIntegerSet(I), N);     // установили N-ный бит в 1
//  Exclude(TIntegerSet(I), N);     // сбросили N-ный бит в 0
  for I := 0 to 8 do
  if I in TIntegerSet(Self.FStatusCurrentFlags) then
    Result := Result + [TCurrentFlagsDevice(I)]
end;

function TParserStatusFlags._GetStatusDocument: TStatusDocument;
begin
  Result.ATypeDocument  := Self._GetTypeDocument;
  Result.AStateDocument := Self._GetStateDocument;
end;

function TParserStatusFlags._GetStatusFatalState: TStatusFatalState;
var
  I : Integer;
begin
  Result := [];
//  Include(TIntegerSet(I), N);     // установили N-ный бит в 1
//  Exclude(TIntegerSet(I), N);     // сбросили N-ный бит в 0
  for I := 0 to 6 do
  if I in TIntegerSet(Self.FStatusFatalState) then
    Result := Result + [TFlagsFatalStateDevice(I)]

end;

function TParserStatusFlags._GetTypeDocument: TTypeDocumentDevice;
var
  I : Integer;
  K: Integer;
begin
  K := 0;
//  Include(TIntegerSet(I), N);     // установили N-ный бит в 1
//  Exclude(TIntegerSet(I), N);     // сбросили N-ный бит в 0
  for I := 0 to 3 do
  if I in TIntegerSet(Self.FStateDocument) then
    Include(TIntegerSet(K),I);

  Result := TTypeDocumentDevice(K);
end;

procedure TParserStatusFlags._ParseString;
var
  FListResult:  TList<String>;
begin
  FListResult := PiritParseString(Self.FWideString);

  Self.FStatusFatalState   := FListResult.Items[0].ToInteger;
  Self.FStatusCurrentFlags := FListResult.Items[1].ToInteger;
  Self.FStateDocument      := FListResult.Items[2].ToInteger;

  FListResult.Free;
end;


{ TPiritParam }

constructor TPiritParam.Create;
begin
  inherited;
end;

destructor TPiritParam.Destroy;
begin

  inherited;
end;


function TPiritParam._GetText: string;
var
  I, CountItems, k: Integer;
  FString: string;
begin
  FString := '';
  if assigned(Self) then
    begin
      CountItems := Self.Count;
      for I := 0 to CountItems - 1 do
        begin
          FString := FString + Self.Items[i];
          if I < CountItems - 1 then
            FString := FString + DelimiterPirit;
        end;
    end;

  Result := FString;
end;


procedure TPiritParam._SetWString(AValue: String);
var
  FValue: string;
  I: Integer;
begin
  Self.Clear;
  FValue := '';

  for I:=1 to Length(AValue) do
  begin
  if AValue[I] <> DelimiterPirit then
    FValue := FValue + AValue[I]
  else
    begin
      Self.Add(FValue);
      FValue := '';
    end;
  if I = Length(AValue) then
    begin
      Self.Add(FValue);
      FValue := '';
    end;
  end;
end;

{ TPiritResultCMD }

constructor TPiritResultCMD.Create;
begin
  inherited;
  self.PiritParamResult := nil;
end;

destructor TPiritResultCMD.Destroy;
begin
  if Assigned(self.PiritParamResult) then
    FreeAndNil(Self.PiritParamResult);
  inherited;
end;

end.
