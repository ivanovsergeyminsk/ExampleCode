unit cl_pirit;

interface

uses
  intrf_FiscalRegister,
  cs_FiscalManager,
  intrf_pirit,
  cs_pirit,
  cl_pirit_parser,
  cl_pirit_aboutdevice,
  cl_pirit_params,
  cl_pirit_operations,
  System.Classes, System.Generics.Collections, cl_pirit_dll, cl_pirit_bep,
  cl_pirit_controltape, cl_pirit_extdevice, cl_pirit_systems;

type
  TFiscalPirit = class;

  TFiscalPiritDevice = class(TInterfacedObject, IFiscalPiritDevice)
  strict private
    FFPDrv: IFPDriver;
    FOnResultCommand: TOnResultNotify;
    FFiscalAboutDevice: TFiscalAboutDevice;
    FFiscalPiritParams: TFiscalPiritParams;
    FFiscalPiritOperations: TFiscalPiritMainOperation;
    FFiscalPiritBEP: TFiscalPiritBEP;
    FFiscalPiritControlTape: TFiscalPiritControlTape;
    FFiscalPiritExtDevice: TFiscalPiritExtDevice;
    FFiscalPiritSystem: TFiscalPiritSystem;
    FFiscalPiritLastResultNum: integer;
  private

  protected
    procedure DoOnResult(const ACommand: string; const AResultCode: integer);

    /// <summary>
    ///   Установка сеанса связи с КСА
    /// </summary>
    /// <param name="APort">
    ///   Номер COM-порта, например: "COM1".
    /// </param>
    /// <param name="ABaud">
    ///   Скорость обмена.
    /// </param>
    /// <param name="APass">
    ///   Пароль связи.
    /// </param>
    /// <returns>
    ///   Код ошибки.
    ///   0 - В случае успешного выполнения.
    /// </returns>
    function Open(APort: string; ABaud: Integer; APass: string): integer;

    /// <summary>
    ///   Завершение сеанса связи.
    /// </summary>
    function Close: Integer;

    function PiritExecuteCMD(ACMD: string; AParam: TPiritParam): TPiritResultCMD; overload;
    function PiritExecuteCMDBytes(ACMD: string; AParam: TPiritParam): TPiritResultBytesCMD; overload;

  public
    property OnResultCommand: TOnResultNotify read FOnResultCommand write FOnResultCommand;

    function GetLastResultNum: integer;

    procedure AbortExecutionReport;
    function CheckingСonnection: boolean;
    procedure PaperWrapping;

    /// <summary>
    ///   Получить описание ошибки.
    /// </summary>
    /// <param name="AErrorCode">
    ///   Код ошибки.
    /// </param>
    /// <returns>
    ///   Описание ошибки.
    /// </returns>
    function GetErrorString(AErrorCode: integer): string;
    /// <summary>
    ///   Данные о КСА.
    /// </summary>
    property AboutDevice: TFiscalAboutDevice read FFiscalAboutDevice;
    /// <summary>
    ///   Основные операции КСА.
    /// </summary>
    property Operations: TFiscalPiritMainOperation read FFiscalPiritOperations;
    /// <summary>
    ///   Команы для работы с БЭП.
    /// </summary>
    property BEP: TFiscalPiritBEP read FFiscalPiritBEP;
    /// <summary>
    ///   Настройки параметров.
    /// </summary>
    property Params: TFiscalPiritParams read FFiscalPiritParams;
    property ControlTape: TFiscalPiritControlTape read FFiscalPiritControlTape;
    property ExtDevice: TFiscalPiritExtDevice read FFiscalPiritExtDevice;
    property System: TFiscalPiritSystem read FFiscalPiritSystem;

    procedure NewCompanyName;


    constructor Create;
    destructor Destroy; override;
  end;

  TFiscalPirit = class(TFiscalPiritDevice, IFiscalRegister)
  private
    FIniFile: string;
    FPort: string;
    FBaud: integer;
    FPass: string;

    FFiscal_isPrintXReportCloseShift: Boolean;
    FFiscal_isRequestPrintBufferControlTape: Boolean;

    function _ValidateStatePrintDevice: Integer;
    function _ValidateFatalStatusDevice: integer;
    function _ValidateDateTimeDevice: integer;
  protected
    /// <summary>
    ///   Данные о КСА.
    /// </summary>
    property AboutDevice;
    /// <summary>
    ///   Основные операции КСА.
    /// </summary>
    property Operations;
    /// <summary>
    ///   Команы для работы с БЭП.
    /// </summary>
    property BEP;
    /// <summary>
    ///   Настройки параметров.
    /// </summary>
    property Params;
    property ControlTape;
    property ExtDevice;
    property System;

    function _ProcessingErrors(const AErrorResult: integer): Integer;

    function _OpenShift(ADateTime: TDateTime): Integer;

    /// <returns>
    ///   <para>
    ///     Номер ошибки ФР.
    ///   </para>
    ///   <para>
    ///     0 - без ошибок.
    ///   </para>
    /// </returns>
    function _PrintCheckPayment(const ANumDepartment: Integer;
                                const ANumDoc: integer;
                                const ANameOperator: string;
                                const AAmountFromPurchaser: Double;
                                const AIsCash: Boolean;
                                const AListPositions: TList<TFiscalProductPosition>;
                                var CheckNum: integer): integer;
    /// <returns>
    ///   <para>
    ///     Номер ошибки ФР.
    ///   </para>
    ///   <para>
    ///     0 - без ошибок.
    ///   </para>
    /// </returns>
    function _PrintAnnulationCheck(const ANumDoc: Integer;
                                   const AAmount: double;
                                   const AIsCash: boolean;
                                   const ANameOperator: string): Integer;

    function _PrintCheckRefund(const ANumDepartment: Integer;
                               const ANumDoc: integer;
                               const ANameOperator: string;
                               const AAmountFromPurchaser: Double;
                               const AIsCash: Boolean;
                               const APosition: TFiscalProductPosition;
                               var CheckNum: integer): Integer;

    function _CloseShift(const ANameOperator: string): Integer;
  public
    procedure LoadIniSettings;
    procedure SaveIniSettings;

    property Port: string read FPort write FPort;
    property Baud: integer read FBaud write FBaud;
    property Pass: string read FPass write FPass;
    property IsPrintXReportCloseShift: Boolean read FFiscal_isPrintXReportCloseShift write FFiscal_isPrintXReportCloseShift;
    property IsRequestPrintBufferControlTape: Boolean read FFiscal_isRequestPrintBufferControlTape write FFiscal_isRequestPrintBufferControlTape;

    //=== IFiscalRegistrator ===================================================
    function Connect(const ADateTime: TDateTime): integer;
    function Disconnect: integer;

    function OpenShift(ADateTime: TDateTime): integer;
    procedure CloseShift(const ANameOperator: string);

    function PrintCheckPayment(const ANumDepartment: Integer;
                                const ANumDoc: integer;
                                const ANameOperator: string;
                                const AAmountFromPurchaser: Double;
                                const AIsCash: Boolean;
                                const AListPositions: TList<TFiscalProductPosition>): integer;

    function PrintAnnulationCheck(const ANumDoc: Integer;
                                  const AAmount: Double;
                                  const AIsCash: boolean;
                                  const ANameOperator: string): Integer;

    function PrintCheckRefund(const ANumDepartment: Integer;
                              const ANumDoc: integer;
                              const ANameOperator: string;
                              const AAmountFromPurchaser: Double;
                              const AIsCash: Boolean;
                              const APosition: TFiscalProductPosition): Integer;

    procedure ShowSettingsForm;

    function GetTypeDevice: TFiscalType;
    //==========================================================================

    function GetServiceInfo: TList<string>;

    constructor Create(const AIniFile: string = '');
    destructor Destroy; override;
  end;

  const
   CS_TXT_RESULT_FISCAL_PIRIT_1 = '[Result Fiscal Pirit |CMD: %s|]: %s';
   CS_TXT_RESULT_FISCAL_PIRIT_2 = '[Result Fiscal Pirit |CMD: %s|]: %s -%s';

implementation

uses
  Winapi.Windows, cl_pirit_base, frm_pirit_settings, System.SysUtils,
  System.IniFiles, Vcl.Dialogs, System.UITypes;

procedure TFiscalPiritDevice.PaperWrapping;
var
  FResultCMD: TPiritResultCMD;
begin

  FResultCMD := Self.PiritExecuteCMD(CMDPirit.CMD_SPC_PROMOTION_PAPER,
                                     nil);

  FResultCMD.Free;
end;

function TFiscalPiritDevice.PiritExecuteCMDBytes(ACMD: string;
  AParam: TPiritParam): TPiritResultBytesCMD;
var
  FResultError: Integer;
  FResultBytes: TBytes;
  FPiritParamResult: TPiritResultBytesCMD;
  FParamResult: WideString;

begin
  Result := TPiritResultBytesCMD.Create;
  FParamResult := AParam.WString;

  if Assigned(AParam) then
    FResultError := Self.FFPDrv.ExecuteCommand(ACMD,
                                               FParamResult)
  else
    FResultError := Self.FFPDrv.ExecuteCommand(ACMD,
                                               '');
   Result.ErrorNum := FResultError;
  OutputDebugString(PWideChar(Format(CS_TXT_RESULT_FISCAL_PIRIT_1, [ACMD, FResultError.ToString])));
  if FResultError = 0 then
    begin
      FResultBytes := Self.FFPDrv.ResultBytes;

      FPiritParamResult := TPiritResultBytesCMD.Create;
      FPiritParamResult.ResultBytes := FResultBytes;

      Result := FPiritParamResult;
    end
  else
      Self.DoOnResult(ACMD,
                     FResultError);
end;

function TFiscalPiritDevice.PiritExecuteCMD(ACMD: string; AParam: TPiritParam): TPiritResultCMD;
var
  FResultError: Integer;
  FWResult: WideString;
  FPiritParamResult: TPiritParam;
  FParamResult: WideString;
  FStrError: string;

begin
  Result := TPiritResultCMD.Create;

  FParamResult := AParam.WString;


  if Assigned(AParam) then
    FResultError := Self.FFPDrv.ExecuteCommand(ACMD,
                                               FParamResult)
  else
    FResultError := Self.FFPDrv.ExecuteCommand(ACMD,
                                               '');
  Result.ErrorNum := FResultError;
  FStrError := Self.GetErrorString(FResultError);
  OutputDebugString(PWideChar(Format(CS_TXT_RESULT_FISCAL_PIRIT_2, [ACMD, FResultError.ToString, FStrError])));
  if FResultError = 0 then
    begin
      FWResult := Self.FFPDrv.ResultString;

      FPiritParamResult := TPiritParam.Create;
      FPiritParamResult.WString := FWResult;

      Result.PiritParamResult := FPiritParamResult;
    end;

   Self.FFiscalPiritLastResultNum := Result.ErrorNum;
   Self.DoOnResult(ACMD,
                   FResultError);

end;



procedure TFiscalPirit.CloseShift(const ANameOperator: string);
var
  FResult: integer;
begin
  FResult := Self._CloseShift(ANameOperator);
  Self._ProcessingErrors(FResult);
end;

function TFiscalPirit.Connect(const ADateTime: TDateTime): integer;
var
 FStatusFlagsDevice: TStatusFlagsDevice;
begin
  Result := self.Open(FPort,
                      FBaud,
                      FPass);

  if Result > 0 then
    Exit;
  FStatusFlagsDevice := Self.AboutDevice.StatusFlags;
  if scfNotCallStartWork in FStatusFlagsDevice.AStatusCurrentFlags
  then
    Self.Params.StartWork(ADateTime);

//    Self.Operations.CancelDocument;

end;



constructor TFiscalPirit.Create(const AIniFile: string = '');
begin
  inherited Create;
  if AIniFile = ''
  then
    Self.FIniFile := ExtractFilePath(ParamStr(0))+CS_PIRIT_INI_FILENAME
  else
    Self.FIniFile := AIniFile;

  Self.LoadIniSettings;
end;

destructor TFiscalPirit.Destroy;
begin

  inherited;
end;

function TFiscalPirit.Disconnect: integer;
begin
  Result := Self.Close;
end;


function TFiscalPirit.GetServiceInfo: TList<string>;
var
  FList: TList<string>;
  Volt, TermHead, CountSnip, ResTermHead, VoltBattery: integer;
  FStatusFatalState: TStatusFatalState;
  FStatusCurrentFlags: TStatusCurrentFlags;
  FStatusDocument: TStatusDocument;
begin
  FList := TList<string>.Create;

  Volt := Self.AboutDevice.ServiceInfo.VoltagePower;
  TermHead := Self.AboutDevice.ServiceInfo.TemperatureThermalhead;
  CountSnip := Self.AboutDevice.ServiceInfo.CountSnip;
  ResTermHead := Self.AboutDevice.ServiceInfo.ResourceThermalhead;
  VoltBattery := Self.AboutDevice.ServiceInfo.VoltageBattery;

  FStatusFatalState := Self.AboutDevice.StatusFlags.AStatusFatalState;
  FStatusCurrentFlags := Self.AboutDevice.StatusFlags.AStatusCurrentFlags;
  FStatusDocument := Self.AboutDevice.StatusFlags.AStatusDocument;


  FList.Add(Format('Напряжение питания: %d', [volt]));
  FList.Add(Format('Температура термоголовки: %d', [TermHead]));
  FList.Add(Format('Количество отрезов резчика: %d', [CountSnip]));
  FList.Add(Format('Ресурс термоголовки: %d', [ResTermHead]));
  FList.Add(Format('Напряжение на батарейке: %d', [VoltBattery]));

{
    FList.Add('---------------------------');
    FList.Add('СТАТУС ТЕКУЩИХ ФЛАГОВ КСА:');
    for FStatusFSD in FStatusFatalState do
}


  Result := FList;
end;

function TFiscalPirit.GetTypeDevice: TFiscalType;
begin
  Result := TFiscalType.Pirit;
end;

procedure TFiscalPirit.LoadIniSettings;
var
  FMemIni: TMemIniFile;
begin
  FMemIni := TMemIniFile.Create(Self.FIniFile,TEncoding.UTF8); //ConnectionStringToMemIni(AConnectionString);
  try
    Self.FPort := FMemIni.ReadString (CS_PIRIT_INI_SECTION,  CS_PIRIT_INI_com_port, 'COM1');
    Self.FBaud := FMemIni.ReadInteger(CS_PIRIT_INI_SECTION,  CS_PIRIT_INI_baud    ,  57600);
    Self.FPass := FMemIni.ReadString (CS_PIRIT_INI_SECTION,  CS_PIRIT_INI_pass    , 'PIRI');
    Self.FFiscal_isPrintXReportCloseShift := FMemIni.ReadBool(CS_PIRIT_INI_SECTION, CS_PIRIT_INI_isPrintXReportCloseShift, False);
    Self.FFiscal_isRequestPrintBufferControlTape := FMemIni.ReadBool(CS_PIRIT_INI_SECTION, CS_PIRIT_INI_isRequestPrintBufferControlTape, False);
  finally
    if Assigned(FMemIni)
    then
      FMemIni.Free;
  end
end;

function TFiscalPirit.OpenShift(ADateTime: TDateTime): integer;
var
  FResult: Integer;
begin
  FResult := Self._OpenShift(ADateTime);
  Self._ProcessingErrors(FResult);
end;

procedure TFiscalPiritDevice.AbortExecutionReport;
var
  FResultCMD: TPiritResultCMD;
begin

  FResultCMD := Self.PiritExecuteCMD(CMDPirit.CMD_SPC_ABORT_REPORT,
                                     nil);

  FResultCMD.Free;
end;

function TFiscalPiritDevice.CheckingСonnection: boolean;
var
  FResultCMD: TPiritResultCMD;
begin

  FResultCMD := Self.PiritExecuteCMD(CMDPirit.CMD_SPC_CONNECTIONCHECK,
                                     nil);

  if FResultCMD.ErrorNum = 0
  then
    Result := True
  else
    Result := False;


  FResultCMD.Free;
end;

function TFiscalPiritDevice.Close: Integer;
begin
  Result := Self.FFPDrv.Close;
end;

constructor TFiscalPiritDevice.Create;
begin
  inherited;
  Self.FFPDrv := TFPDriver.Create;

  TPiritCustomBase.Owner := Self;

  Self.FFiscalAboutDevice      := TFiscalAboutDevice.Create;
  Self.FFiscalPiritParams      := TFiscalPiritParams.Create;
  Self.FFiscalPiritOperations  := TFiscalPiritMainOperation.Create;
  Self.FFiscalPiritBEP         := TFiscalPiritBEP.Create;
  Self.FFiscalPiritControlTape := TFiscalPiritControlTape.Create;
  Self.FFiscalPiritExtDevice   := TFiscalPiritExtDevice.Create;
  Self.FFiscalPiritSystem      := TFiscalPiritSystem.Create;
end;

destructor TFiscalPiritDevice.Destroy;
begin
  Self.FFiscalPiritOperations.Free;
  Self.FFiscalPiritParams.Free;
  Self.FFiscalAboutDevice.Free;
  Self.FFiscalPiritBEP.Free;
  Self.FFiscalPiritControlTape.Free;
  Self.FFiscalPiritExtDevice.Free;
  Self.FFiscalPiritSystem.Free;

  TPiritCustomBase.Owner := nil;

  FFPDrv := nil;
  inherited;
end;

procedure TFiscalPiritDevice.DoOnResult(const ACommand: string; Const AResultCode: Integer);
var
  FErrorString: string;
begin
  FErrorString := Self.GetErrorString(AResultCode);

  if Assigned(self.FOnResultCommand) then
    Self.FOnResultCommand(ACommand, AResultCode, FErrorString);
end;

function TFiscalPiritDevice.GetErrorString(AErrorCode: integer): string;
var
  FErrorString: WideString;
begin
  FErrorString := FFPDrv.GetErrorString(AErrorCode);
  Result := WideCharToString(PWideChar(FErrorString));
end;



function TFiscalPiritDevice.GetLastResultNum: integer;
begin
  Result := Self.FFiscalPiritLastResultNum;
end;

procedure TFiscalPiritDevice.NewCompanyName;
var
  FStatusFlag: TStatusFlagsDevice;
  FResultString, FErrorString: string;

begin

  FErrorString := Self.FFPDrv.GetErrorString(32);

  // В документации указано, что запись параметров конфигурации 30, 31 и 52
  //    выполняется только при закрытой смене
  FStatusFlag := Self.FFiscalAboutDevice.StatusFlags;
  if scfShiftOpened in FStatusFlag.AStatusCurrentFlags
  then
    begin
      if scfNotCallStartWork in FStatusFlag.AStatusCurrentFlags
      then
        Self.Params.StartWork(Now);
      Self.Operations.PrintReportZ('Иванов Иван');
    end;

  Self.FFPDrv.ExecuteCommand('12', '30'+#$1B+'1'+#$1B+'*ENG         ООО "Компания"              *');
  Self.FFPDrv.ExecuteCommand('11', '30'+#$1B+'1');
  FResultString := Self.FFPDrv.ResultString;

  //    Self.FFPDrv.ExecuteCommand('12', '30'+#$1B+'0'+#$1B+'*******************************************');
  //    Self.FFPDrv.ExecuteCommand('12', '30'+#$1B+'2'+#$1B+'*    РБ, г. Минск, ул. Уличная, 15     *');
  //    Self.FFPDrv.ExecuteCommand('12', '30'+#$1B+'3'+#$1B+'*******************************************');
  //    Self.FFPDrv.ExecuteCommand('12', '31'+#$1B+'0'+#$1B+'*******************************************');
  //    Self.FFPDrv.ExecuteCommand('12', '31'+#$1B+'1'+#$1B+'* Праздник к нам приходит *');
  //*)
  end;


function TFiscalPiritDevice.Open(APort: string; ABaud: Integer;
  APass: string): integer;
  var
    FError: string;
begin
 Result := FFPDrv.Open(APort,
                       ABaud,
                       APass);
end;


function TFiscalPirit.PrintCheckRefund(const ANumDepartment: Integer;
                                       const ANumDoc: integer;
                                       const ANameOperator: string;
                                       const AAmountFromPurchaser: Double;
                                       const AIsCash: Boolean;
                                       const APosition: TFiscalProductPosition): Integer;
var
  FNumCheck: integer;
  FResult: integer;

begin

  repeat
    FResult := Self._PrintCheckRefund(ANumDepartment,
                                       ANumDoc,
                                       ANameOperator,
                                       AAmountFromPurchaser,
                                       AIsCash,
                                       APosition,
                                       FNumCheck);

    FResult := _ProcessingErrors(FResult);
  until (FResult = 0) or (FResult = -1);

  if FResult = 0 then
    Result := FNumCheck
  else
    Result := -1;

end;

function TFiscalPirit.PrintAnnulationCheck(const ANumDoc: Integer; const AAmount: double;
  const AIsCash: boolean; const ANameOperator: string): Integer;
var
  FList: Tlist<Double>;
  I: Integer;
  FResult: integer;
begin

  repeat
    FResult := Self._PrintAnnulationCheck(ANumDoc,
                                          AAmount,
                                          AIsCash,
                                          ANameOperator);

    FResult := _ProcessingErrors(FResult);
  until (FResult = 0) or (FResult = -1);

  Result := FResult;

end;

function TFiscalPirit.PrintCheckPayment(const ANumDepartment: Integer;
                                        const ANumDoc: integer;
                                        const ANameOperator: string;
                                        const AAmountFromPurchaser: Double;
                                        const AIsCash: Boolean;
                                        const AListPositions: TList<TFiscalProductPosition>): integer;

var
  FNumCheck: integer;
  FResult: integer;

begin

  repeat
    FResult := Self._PrintCheckPayment(ANumDepartment,
                                       ANumDoc,
                                       ANameOperator,
                                       AAmountFromPurchaser,
                                       AIsCash,
                                       AListPositions,
                                       FNumCheck);

    FResult := _ProcessingErrors(FResult);
  until (FResult = 0) or (FResult = -1);

  if FResult = 0 then
    Result := FNumCheck
  else
    Result := -1;

end;

function TFiscalPirit._ProcessingErrors(const AErrorResult: integer): Integer;
var
  FErrResult: Integer;
  FErrorText: string;
begin
    case AErrorResult of
      0:   begin
            Result := AErrorResult;
           end;
      1:   begin
             FErrResult := Self._ValidateFatalStatusDevice;
             Self.Operations.CancelDocument;
             FErrResult := self.GetLastResultNum;
             Result := -1;
           end;
      2:   begin
            FErrorText := 'В конманде указан неверный номер функции.';
            MessageDlg('Ошибка выполнения команды: '+#13+#10+
                       FErrorText+#13+#10+
                       'Обратитесь к системному администратору.',
                       TMsgDlgType.mtWarning,
                       [mbOK],
                      0);
            Result := -1;
           end;
      3:   begin
            FErrorText := 'Некорректный формат или параметр команды.';
            MessageDlg('Ошибка выполнения команды: '+#13+#10+
                       FErrorText+#13+#10+
                       'Обратитесь к системному администратору.',
                       TMsgDlgType.mtWarning,
                       [mbOK],
                      0);
            Result := -1;
           end;
      4:   begin
            FErrorText := 'Переполнение буфера коммуникационного порта.';
            MessageDlg('Ошибка протокола передачи данных: '+#13+#10+
                       FErrorText+#13+#10+
                       'Обратитесь к системному администратору.',
                       TMsgDlgType.mtWarning,
                       [mbOK],
                      0);
            Result := -1;
           end;
      5:   begin
            FErrorText := 'Таймаут при передаче байта информации.';
            MessageDlg('Ошибка протокола передачи данных: '+#13+#10+
                       FErrorText+#13+#10+
                       'Обратитесь к системному администратору.',
                       TMsgDlgType.mtWarning,
                       [mbOK],
                      0);
            Result := -1;
           end;
      6:   begin
            FErrorText := 'В протоколе указан неверный пароль.';
            MessageDlg('Ошибка протокола передачи данных: '+#13+#10+
                       FErrorText+#13+#10+
                       'Обратитесь к системному администратору.',
                       TMsgDlgType.mtWarning,
                       [mbOK],
                      0);
            Result := -1;
           end;
      7:   begin
            FErrorText := 'Ошибка контрольной суммы в команде.';
            MessageDlg('Ошибка протокола передачи данных: '+#13+#10+
                       FErrorText+#13+#10+
                       'Обратитесь к системному администратору.',
                       TMsgDlgType.mtWarning,
                       [mbOK],
                      0);
            Result := -1;
           end;
      8,9: begin
            FErrResult := Self._ValidateStatePrintDevice;
            if FErrResult = mrNo then
              Result := -1;

            Self.Operations.CancelDocument;
            FErrResult := self.GetLastResultNum;
           end;
      10:  begin
            FErrResult := Self._ValidateDateTimeDevice;
            Result := -1;
           end;
      11:  begin
            FErrorText := 'Разница во времени, КСА и указанной в команде начала работы,'+#13+#10+
                          'больше 8 минут.';
            MessageDlg('Ошибка даты/времени: '+#13+#10+
                       FErrorText,
                       TMsgDlgType.mtWarning,
                       [mbOK],
                      0);
            Result := -1;
           end;
      12:  begin
            FErrorText := 'Вводимая дата более ранняя,'+#13+#10+
                          'чем дата последней операции БЭП.';
            MessageDlg('Ошибка даты/времени: '+#13+#10+
                       FErrorText,
                       TMsgDlgType.mtWarning,
                       [mbOK],
                      0);
            Result := -1;
           end;
      13:  begin
            MessageDlg('Неверный пароль доступа к БЭП.',
                       TMsgDlgType.mtWarning,
                       [mbOK],
                      0);
            Result := -1;
           end;
      14:  begin
             MessageDlg('Отрицательный результат.',
                        TMsgDlgType.mtWarning,
                        [mbOK],
                       0);
             Result := -1;
           end;
      15:  begin
             MessageDlg('Для выполнения команды необходимо закрыть смену.',
                        TMsgDlgType.mtWarning,
                        [mbOK],
                       0);
             Result := -1;
           end;
      16: begin
             MessageDlg('Есть незакрытыте заказы в смене.',
                        TMsgDlgType.mtWarning,
                        [mbOK],
                       0);
             Result := -1;
          end;
      72: begin
             MessageDlg('Нет запрошенных данных',
                        TMsgDlgType.mtWarning,
                        [mbOK],
                       0);
             Result := -1;
          end;
      32: begin
            FErrResult := Self._ValidateFatalStatusDevice;
            Self.Operations.CancelDocument;
            FErrResult := self.GetLastResultNum;
            Result := -1;;
          end;
      33: begin
            FErrorText := 'Нет свободного места в памяти КСА.';
            MessageDlg('Фатальная ошибка: '+#13+#10+
                       FErrorText,
                       TMsgDlgType.mtWarning,
                       [mbOK],
                      0);
            Result := -1;
          end;
      145:  begin
              FErrorText := 'Отсутствует связь с СКНО.';
              MessageDlg('Фатальная ошибка: '+#13+#10+
                         FErrorText,
                         TMsgDlgType.mtWarning,
                         [mbOK],
                        0);
              Result := -1;
            end;
      146:  begin
              FErrorText := 'Отсутствует СКЗИ.';
              MessageDlg('Фатальная ошибка: '+#13+#10+
                         FErrorText,
                         TMsgDlgType.mtWarning,
                         [mbOK],
                        0);
              Result := -1;
            end;
      147:  begin
              FErrorText := 'Неисправно СКНО.';
              MessageDlg('Фатальная ошибка: '+#13+#10+
                         FErrorText,
                         TMsgDlgType.mtWarning,
                         [mbOK],
                        0);
              Result := -1;
            end;
      148:  begin
              FErrorText := 'Идентификация не прошла успешно.';
              MessageDlg('Фатальная ошибка: '+#13+#10+
                         FErrorText,
                         TMsgDlgType.mtWarning,
                         [mbOK],
                        0);
              Result := -1;
            end;
      150:  begin
              FErrorText := 'Запрет обслуживания по окончанию сертификацта СКЗИ.';
              MessageDlg('Фатальная ошибка: '+#13+#10+
                         FErrorText,
                         TMsgDlgType.mtWarning,
                         [mbOK],
                        0);
              Result := -1;
            end;
      151:  begin
              FErrorText := 'Запрет обслуживания по непереданным Z-отчетам.';
              MessageDlg('Фатальная ошибка: '+#13+#10+
                         FErrorText,
                         TMsgDlgType.mtWarning,
                         [mbOK],
                        0);
              Result := -1;
            end;
      152:  begin
              FErrorText := 'Запрет обслуживания по переполнению памяти СКНО.';
              MessageDlg('Фатальная ошибка: '+#13+#10+
                         FErrorText,
                         TMsgDlgType.mtWarning,
                         [mbOK],
                        0);
              Result := -1;
            end;
    else
            begin
              FErrorText := AErrorResult.ToString;
              FErrorText := FErrorText+ ' - ' +
                            Self.GetErrorString(AErrorResult);

              MessageDlg('Ошибка КСА: '+
                         FErrorText,
                         TMsgDlgType.mtWarning,
                         [mbOK],
                        0);
              Result := -1;
            end;
    end;
{$ENDREGION}
end;


procedure TFiscalPirit.SaveIniSettings;
var
  FMemIni: TMemIniFile;
begin
  FMemIni := TMemIniFile.Create(Self.FIniFile,TEncoding.UTF8); //ConnectionStringToMemIni(AConnectionString);
  try
//    Self.Disconnect;
    FMemIni.WriteString (CS_PIRIT_INI_SECTION,  CS_PIRIT_INI_com_port, Self.FPort);
    FMemIni.WriteInteger(CS_PIRIT_INI_SECTION,  CS_PIRIT_INI_baud    , Self.FBaud);
    FMemIni.WriteString (CS_PIRIT_INI_SECTION,  CS_PIRIT_INI_pass    ,  Self.FPass);
    FMemIni.WriteBool(CS_PIRIT_INI_SECTION, CS_PIRIT_INI_isPrintXReportCloseShift, Self.FFiscal_isPrintXReportCloseShift);
    FMemIni.WriteBool(CS_PIRIT_INI_SECTION, CS_PIRIT_INI_isRequestPrintBufferControlTape, Self.FFiscal_isRequestPrintBufferControlTape);
    FMemIni.UpdateFile;
  finally
    FMemIni.Free;

//    Self.Connect;
  end
end;

procedure TFiscalPirit.ShowSettingsForm;
begin
  if Assigned(FormPiritSettings)
  then
    FreeAndNil(FormPiritSettings);

  FormPiritSettings := TFormPiritSettings.Create(nil);
  FormPiritSettings.FiscalPirit := self;
  FormPiritSettings.Show;
end;

function TFiscalPirit._CloseShift(const ANameOperator: string): Integer;
begin
  if Self.FFiscal_isRequestPrintBufferControlTape
  then
    begin
      Self.Operations.PrintBuferControlTape;
      Result := Self.GetLastResultNum;
      if Result <> 0 then
        Exit;
    end;

  if Self.FFiscal_isPrintXReportCloseShift
  then
    begin
      Self.Operations.PrintReportX(ANameOperator);
      Result := Self.GetLastResultNum;
      if Result <> 0 then
        Exit;
    end;

  Self.Operations.PrintReportZ(ANameOperator);
  Result := Self.GetLastResultNum;
  if Result <> 0 then
    Exit;
end;

function TFiscalPirit._OpenShift(ADateTime: TDateTime): Integer;
begin
  Self.Params.SetDateTimeDevice(ADateTime);
  Result := Self.GetLastResultNum;
  if Result <> 0 then
    Exit;

  Self.Operations.OpenShift;
  Result := Self.GetLastResultNum;
  if Result <> 0 then
    Exit;
end;

function TFiscalPirit._PrintAnnulationCheck(const ANumDoc: Integer;
  const AAmount: double; const AIsCash: boolean;
  const ANameOperator: string): Integer;
var
  FList: Tlist<Double>;
  I: Integer;
begin
  Result := -1;
  FList := TList<Double>.Create;
  try
    if AIsCash
    then
      begin
        FList.Add(AAmount);
      end
    else
      begin
        FList.Add(0.00);
        FList.Add(AAmount);
      end;


    Self.Operations.AnnulateDocument(ANumDoc,
                                    FList,
                                    ANameOperator);
    Result := Self.GetLastResultNum;

  finally
    FList.Free;
  end;
end;

function TFiscalPirit._PrintCheckPayment(const ANumDepartment, ANumDoc: integer;
  const ANameOperator: string; const AAmountFromPurchaser: Double;
  const AIsCash: Boolean;
  const AListPositions: TList<TFiscalProductPosition>; var CheckNum: integer): integer;
var
  FODoc: TOpenDocument;
  I: integer;
  FFiscalProductPosition: TFiscalProductPosition;
  FResultCompleteDocument: TResultCompleteDocument;
begin
  Result := 0;

  {$REGION 'OpenDocument'}
  FODoc.ATypeDocument := tddPayment;
  FODoc.AModeGenerateDocument := mgdSimple;
  FODoc.AModePrintRequsite:= mprSimple;
  FODoc.ANumDepartment := ANumDepartment;
  FODoc.ANameOperator := ANameOperator;
  FODoc.ANumDocument := ANumDoc;
  
  Self.Operations.OpenDocument(FODoc);
  Result := Self.GetLastResultNum;
  if Result <> 0
  then
    Exit;
  {$ENDREGION}

  {$REGION 'AddPositions/Discount/Markup'}
  for I := 0 to AListPositions.Count - 1
  do
    begin
      FFiscalProductPosition := AListPositions[I];
  
        {$REGION 'AddPosition'}
        if FFiscalProductPosition.ANumTax > -1
        then
          begin
            Self.Operations.ProductPositionAdd(FFiscalProductPosition.ANameProduct,
                                               FFiscalProductPosition.ABarCode,
                                               FFiscalProductPosition.ACountProduct,
                                               FFiscalProductPosition.APriceProduct,
                                               FFiscalProductPosition.ANumTax);
            Result := Self.GetLastResultNum;
          end
        else
          begin
            Self.Operations.ProductPositionAdd(FFiscalProductPosition.ANameProduct,
                                               FFiscalProductPosition.ABarCode,
                                               FFiscalProductPosition.ACountProduct,
                                               FFiscalProductPosition.APriceProduct);
            Result := Self.GetLastResultNum;
          end;
    
        if Result <> 0 then
          Exit;
        {$ENDREGION}

        {$REGION 'AddDiscount'}
        if FFiscalProductPosition.ATypeDiscount >=0
        then
          begin
            Self.Operations.Discount(TPiritTypeDisMark(FFiscalProductPosition.ATypeDiscount),
                                     FFiscalProductPosition.ANameDiscount,
                                     FFiscalProductPosition.AValueDiscount);
            Result := Self.GetLastResultNum;
            if Result <> 0 then
              Exit;
          end;
        {$ENDREGION}

        {$REGION 'AddMarkup'}
        if FFiscalProductPosition.ATypeMarkup >=0
        then
          begin
            Self.Operations.Markup(TPiritTypeDisMark(FFiscalProductPosition.ATypeMarkup),
                                   FFiscalProductPosition.ANameMarkup,
                                   FFiscalProductPosition.AValueMarkup);
            Result := Self.GetLastResultNum;
            if Result <> 0 then
              exit;
          end;
        {$ENDREGION}
    end;
  {$ENDREGION}

  {$REGION 'Subtotal1'}
  Self.Operations.SubTotal;
    Result := Self.GetLastResultNum;
    if Result <> 0 then
      Exit;
  {$ENDREGION}

  {$REGION 'Subtotal2'}
  Self.Operations.SubTotal;
    Result := Self.GetLastResultNum;
    if Result <> 0 then
      Exit;
  {$ENDREGION}

  {$REGION 'Payment'}
    if AIsCash = true then
        Self.Operations.Payment(0,
                                AAmountFromPurchaser,
                                '')
      else
        Self.Operations.Payment(1,
                                AAmountFromPurchaser,
                                '');
    
      Result := Self.GetLastResultNum;
      if Result <> 0 then
        Exit;
  {$ENDREGION}

  {$REGION 'CompeleteDocument'}
   FResultCompleteDocument := Self.Operations.CompleteDocument(False);
   Result := Self.GetLastResultNum;
   if Result <> 0 then
    Exit;
  {$ENDREGION}
   
 CheckNum := FResultCompleteDocument.ANumDocument;
end;

function TFiscalPirit._PrintCheckRefund(const ANumDepartment, ANumDoc: integer;
  const ANameOperator: string; const AAmountFromPurchaser: Double;
  const AIsCash: Boolean;
  const APosition: TFiscalProductPosition; var CheckNum: integer): Integer;
var
  FODoc: TOpenDocument;
  I: integer;
  FFiscalProductPosition: TFiscalProductPosition;
  FResultCompleteDocument: TResultCompleteDocument;
begin
  Result := 0;


  {$REGION 'OpenDocument'}
  FODoc.ATypeDocument := tddRefund;
  FODoc.AModeGenerateDocument := mgdSimple;
  FODoc.AModePrintRequsite:= mprSimple;
  FODoc.ANumDepartment := ANumDepartment;
  FODoc.ANameOperator := ANameOperator;
  FODoc.ANumDocument := ANumDoc;

  Self.Operations.OpenDocument(FODoc);
  Result := Self.GetLastResultNum;
  if Result <> 0
  then
    Exit;
  {$ENDREGION}

  {$REGION 'AddPositions/Discount/Markup'}
      FFiscalProductPosition := APosition;

        {$REGION 'AddPosition'}
        if FFiscalProductPosition.ANumTax > -1
        then
          begin
            Self.Operations.ProductPositionAdd(FFiscalProductPosition.ANameProduct,
                                               FFiscalProductPosition.ABarCode,
                                               FFiscalProductPosition.ACountProduct,
                                               FFiscalProductPosition.APriceProduct,
                                               FFiscalProductPosition.ANumTax);
            Result := Self.GetLastResultNum;
          end
        else
          begin
            Self.Operations.ProductPositionAdd(FFiscalProductPosition.ANameProduct,
                                               FFiscalProductPosition.ABarCode,
                                               FFiscalProductPosition.ACountProduct,
                                               FFiscalProductPosition.APriceProduct);
            Result := Self.GetLastResultNum;
          end;

        if Result <> 0 then
          Exit;
        {$ENDREGION}

        {$REGION 'AddDiscount'}
        if FFiscalProductPosition.ATypeDiscount >=0
        then
          begin
            Self.Operations.Discount(TPiritTypeDisMark(FFiscalProductPosition.ATypeDiscount),
                                     FFiscalProductPosition.ANameDiscount,
                                     FFiscalProductPosition.AValueDiscount);
            Result := Self.GetLastResultNum;
            if Result <> 0 then
              Exit;
          end;
        {$ENDREGION}

        {$REGION 'AddMarkup'}
        if FFiscalProductPosition.ATypeMarkup >=0
        then
          begin
            Self.Operations.Markup(TPiritTypeDisMark(FFiscalProductPosition.ATypeMarkup),
                                   FFiscalProductPosition.ANameMarkup,
                                   FFiscalProductPosition.AValueMarkup);
            Result := Self.GetLastResultNum;
            if Result <> 0 then
              exit;
          end;
        {$ENDREGION}
  {$ENDREGION}

  {$REGION 'Subtotal1'}
  Self.Operations.SubTotal;
    Result := Self.GetLastResultNum;
    if Result <> 0 then
      Exit;
  {$ENDREGION}

  {$REGION 'Subtotal2'}
  Self.Operations.SubTotal;
    Result := Self.GetLastResultNum;
    if Result <> 0 then
      Exit;
  {$ENDREGION}

  {$REGION 'Payment'}
    if AIsCash = true then
        Self.Operations.Payment(0,
                                AAmountFromPurchaser,
                                '')
      else
        Self.Operations.Payment(1,
                                AAmountFromPurchaser,
                                '');

      Result := Self.GetLastResultNum;
      if Result <> 0 then
        Exit;
  {$ENDREGION}

  {$REGION 'CompeleteDocument'}
   FResultCompleteDocument := Self.Operations.CompleteDocument(False);
   Result := Self.GetLastResultNum;
   if Result <> 0 then
    Exit;
  {$ENDREGION}

 CheckNum := FResultCompleteDocument.ANumDocument;
end;

function TFiscalPirit._ValidateDateTimeDevice: integer;
var
  FStatusFlags: TStatusFlagsDevice;
  FErrorText: string;
begin
  Result := -1;
  FStatusFlags := Self.AboutDevice.StatusFlags;
  if scfShift24 in FStatusFlags.AStatusCurrentFlags
  then
    begin
      FErrorText := 'Текущая смена фискального регистратора больше 24 часов.'+#13+#10+
                  'Для продолжения работы, закройте текущую смену и откройте новую.';
      MessageDlg('Ошибка даты/времени: '+#13+#10+
                  FErrorText,
                 TMsgDlgType.mtWarning,
                 [mbOK],
                 0);
      Result := -1;
  end
  else
    Result := 0;
end;

function TFiscalPirit._ValidateFatalStatusDevice: integer;
var
  FStatusFlags: TStatusFlagsDevice;
  FFlagsFatalStateDevice: TFlagsFatalStateDevice;
  FErrorText: string;
begin
  Result := -1;
  FStatusFlags := Self.AboutDevice.StatusFlags;
  if [] <> FStatusFlags.AStatusFatalState
  then
    begin
      for FFlagsFatalStateDevice := Low(TFlagsFatalStateDevice) to High(TFlagsFatalStateDevice) do
      begin
        if FFlagsFatalStateDevice in FStatusFlags.AStatusFatalState then
          case FFlagsFatalStateDevice of
            sfsInvalidChecksumNVR:          FErrorText := FErrorText + 'Неверная контрольная сумма NVR.'+#13+#10;
            sfsInvalidChecksumConfig:       FErrorText := FErrorText + 'Неверная контрольная сумма в конфигруации.'+#13+#10;
            sfsErrorInterfaceBEP:           FErrorText := FErrorText + 'Ошибка интерфейса с БЭП'+#13+#10;
            sfsInvalidChecksumBEP:          FErrorText := FErrorText + 'Неверная контрольная сумма блока энергонезависимой памяти.'+#13+#10;
            sfsErrorWriteBEP:               FErrorText := FErrorText + 'Ошибка записи в БЭП.'+#13+#10;
            sfsNotAuthorizeBEP:             FErrorText := FErrorText + 'БЭП не авторизован.'+#13+#10;
            sfsErrorFatalMemoryControlTape: FErrorText := FErrorText + 'Фатальная ошибка памяти контрольной ленты.'+#13+#10;
          end;
      end;
      MessageDlg('Фатальный статус КСА: '+#13+#10+
                  FErrorText+
                 'Все функции КСА заблокированы. Обратитесь к системному администратору.',
                 TMsgDlgType.mtWarning,
                 [mbOK],
                 0);
      Result := -1;
    end
  else
    Result := 0;
end;

function TFiscalPirit._ValidateStatePrintDevice: Integer;
var
  FStatePrintingDevice: TStatePrintingDevice;
  FErrorText: string;
  mrResult: integer;
  FStatePrintDevice: TStatePrinting;
begin
  Result := -1;
  FStatePrintDevice := Self.AboutDevice.StatePrintDevice;
  if [] <> FStatePrintDevice
  then
    begin
      for FStatePrintingDevice := Low(TStatePrintingDevice) to High(TStatePrintingDevice)
      do
        begin
          if FStatePrintingDevice in FStatePrintDevice then
            case FStatePrintingDevice of
              spdNotReady:      FErrorText := FErrorText+'Принтер не готов.'+#13+#10;
              spdNoPaper:       FErrorText := FErrorText+'В принтере нет бумаги.'+#13+#10;
              spdLidIsOpen:     FErrorText := FErrorText+'Открыта крышка принтера.'+#13+#10;
              spdErrorCutter:   FErrorText := FErrorText+'Ошибка резчика принтера.'+#13+#10;
              spdNoConnection:  FErrorText := FErrorText+'Нет связи с принтером.'+#13+#10;
            end;
        end;

      mrResult :=  MessageDlg(FErrorText+
                             'Выполнить еще одну попытку выполнения данной операции?',
                              mtWarning,
                              [mbYes, mbNo],
                              0);
      Result := mrResult;
    end
  else
    Result := 0;
end;

end.
