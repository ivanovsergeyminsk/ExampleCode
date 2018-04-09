unit cl_pirit_settings;

interface

uses
  intrf_pirit, cl_pirit_base, System.Generics.Collections,
  cs_pirit;

type

  TFiscalPiritPrintDeviceSetting              = class;
  TFiscalPiritCheckSetting                    = class;
  TFiscalPiritReportZSetting                  = class;
  TFiscalPiritExtDeviceSetting                = class;
  TFiscalPiritCalculationSetting              = class;
  TFiscalPiritTaxSetting                      = class;
  TFiscalPiritRoundSetting                    = class;
  TFiscalPiritLogicalNumberSetting            = class;
  TFiscalPiritExtCellSetting                  = class;
  TFiscalPiritParamPrintDeviceSetting         = class;
  TFiscalPiritPassConnectSetting              = class;
  TFiscalPiritCompanyInfoSetting              = class;
  TFiscalPiritTextEndCheckSetting             = class;
  TFiscalPiritNamesPaymentsTypesSetting       = class;
  TFiscalPiritTaxRateSetting                  = class;
  TFiscalPiritNameGroupTaxSetting             = class;
  TFiscalPiritNamesSectionsSetting            = class;
  TFiscalPiritNameGroupSectionSetting         = class;
  TFiscalPiritNameRequisiteSetting            = class;
  TFiscalPiritServiceCenterRequisiteSetting   = class;


  /// <summary>
  ///   Класс. агрегирующий команды чтения/записи таблицы настроек.
  /// </summary>
  TFiscalSettingsDevice = class(TPiritCustomBase)
  strict private
    FFiscalPiritPrintDeviceSetting:            TFiscalPiritPrintDeviceSetting;
    FFiscalPiritCheckSetting:                  TFiscalPiritCheckSetting;
    FFiscalPiritReportZSetting:                TFiscalPiritReportZSetting;
    FFiscalPiritExtDeviceSetting:              TFiscalPiritExtDeviceSetting;
    FFiscalPiritCalculationSetting:            TFiscalPiritCalculationSetting;
    FFiscalPiritTaxSetting:                    TFiscalPiritTaxSetting;
    FFiscalPiritRoundSetting:                  TFiscalPiritRoundSetting;
    FFiscalPiritLogicalNumberSetting:          TFiscalPiritLogicalNumberSetting;
    FFiscalPiritExtCellSetting:                TFiscalPiritExtCellSetting;
    FFiscalPiritParamPrintDeviceSetting:       TFiscalPiritParamPrintDeviceSetting;
    FFiscalPiritPassConnectSetting:            TFiscalPiritPassConnectSetting;
    FFiscalPiritCompanyInfoSetting:            TFiscalPiritCompanyInfoSetting;
    FFiscalPiritTextEndCheckSetting:           TFiscalPiritTextEndCheckSetting;
    FFiscalPiritNamesPaymentsTypesSetting:     TFiscalPiritNamesPaymentsTypesSetting;
    FFiscalPiritTaxRateSetting:                TFiscalPiritTaxRateSetting;
    FFiscalPiritNameGroupTaxSetting:           TFiscalPiritNameGroupTaxSetting;
    FFiscalPiritNamesSectionsSetting:          TFiscalPiritNamesSectionsSetting;
    FFiscalPiritNameGroupSectionSetting:       TFiscalPiritNameGroupSectionSetting;
    FFiscalPiritNameRequisiteSetting:          TFiscalPiritNameRequisiteSetting;
    FFiscalPiritServiceCenterRequisiteSetting: TFiscalPiritServiceCenterRequisiteSetting;
  public
    /// <summary>
    ///   Параметры ПУ.
    /// </summary>
    property PrintDeviceSetting:            TFiscalPiritPrintDeviceSetting read  FFiscalPiritPrintDeviceSetting;
    /// <summary>
    ///   Параметры чека.
    /// </summary>
    property CheckSetting:                  TFiscalPiritCheckSetting read FFiscalPiritCheckSetting;
    /// <summary>
    ///   Параметры Z-отчета.
    /// </summary>
    property ReportZSetting:                TFiscalPiritReportZSetting read FFiscalPiritReportZSetting;
    /// <summary>
    ///   Управление внешними устройствами.
    /// </summary>
    property ExtDeviceSetting:              TFiscalPiritExtDeviceSetting read FFiscalPiritExtDeviceSetting;
    /// <summary>
    ///   Управление расчетами.
    /// </summary>
    property CalculationSetting:            TFiscalPiritCalculationSetting read FFiscalPiritCalculationSetting;
    /// <summary>
    ///   Управление расчетами и печатью налогов.
    /// </summary>
    property TaxSetting:                    TFiscalPiritTaxSetting read FFiscalPiritTaxSetting;
    /// <summary>
    ///   Значение округления.
    /// </summary>
    property RoundSetting:                  TFiscalPiritRoundSetting read FFiscalPiritRoundSetting;
    /// <summary>
    ///   Логический номер КСА.
    /// </summary>
    property LogicalNumberSetting:          TFiscalPiritLogicalNumberSetting read FFiscalPiritLogicalNumberSetting;
    /// <summary>
    ///   Дополнительная ячейка.
    /// </summary>
    property ExtCellSetting:                TFiscalPiritExtCellSetting read FFiscalPiritExtCellSetting;
    /// <summary>
    ///   Настройки ПУ.
    /// </summary>
    property ParamPrintDeviceSetting:       TFiscalPiritParamPrintDeviceSetting read FFiscalPiritParamPrintDeviceSetting;
    /// <summary>
    ///   Пароль для связи.
    /// </summary>
    property PassConnectSetting:            TFiscalPiritPassConnectSetting read FFiscalPiritPassConnectSetting;
    /// <summary>
    ///   Информация об организации.
    /// </summary>
    property CompanyInfoSetting:            TFiscalPiritCompanyInfoSetting read FFiscalPiritCompanyInfoSetting;
    /// <summary>
    ///   Строки окончания чеков.
    /// </summary>
    property TextEndCheckSetting:           TFiscalPiritTextEndCheckSetting read FFiscalPiritTextEndCheckSetting;
    /// <summary>
    ///   Названия типов платежей.
    /// </summary>
    property NamesPaymentsTypesSetting:     TFiscalPiritNamesPaymentsTypesSetting read FFiscalPiritNamesPaymentsTypesSetting;
    /// <summary>
    ///   Название и процент ставки налога.
    /// </summary>
    property TaxRateSetting:                TFiscalPiritTaxRateSetting read FFiscalPiritTaxRateSetting;
    /// <summary>
    ///   Строка названия налоговой группы в чеке.
    /// </summary>
    property NameGroupTaxSetting:           TFiscalPiritNameGroupTaxSetting read FFiscalPiritNameGroupTaxSetting;
    /// <summary>
    ///   Наименование отдела/секции.
    /// </summary>
    property NamesSectionsSetting:          TFiscalPiritNamesSectionsSetting read FFiscalPiritNamesSectionsSetting;
    /// <summary>
    ///   Строка названия группы отделов/секции на Z-отчете.
    /// </summary>
    property NameGroupSectionSetting:       TFiscalPiritNameGroupSectionSetting read FFiscalPiritNameGroupSectionSetting;
    /// <summary>
    ///   Наименование реквизита.
    /// </summary>
    property NameRequisiteSetting:          TFiscalPiritNameRequisiteSetting read FFiscalPiritNameRequisiteSetting;
    /// <summary>
    ///   Реквизиты ЦТО.
    /// </summary>
    property ServiceCenterRequisiteSetting: TFiscalPiritServiceCenterRequisiteSetting read FFiscalPiritServiceCenterRequisiteSetting;

    constructor Create;
    destructor Destroy; override;
  end;

//------------------------------------------------------------------------------

  TFiscalPiritCustomSetting = class(TPiritCustomBase)
  private
    class var FIsInstantСhanges: boolean;
    FValue: integer;
  protected
    function GetValueFromDeviceInt(ANum: integer; AIndex: Integer): integer;
    function GetValueFromDevice(ANum: integer; AIndex: Integer): string;

    procedure SetValueToDevice(ANum: integer; AIndex: Integer; AValue: integer); overload;
    procedure SetValueToDevice(ANum: integer; AIndex: Integer; AValue: string); overload;
  public
    constructor Create;
    class property IsInstantСhanges: boolean read FIsInstantСhanges write FIsInstantСhanges;
  end;

//------------------------------------------------------------------------------

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Параметры ПУ".
  /// </summary>
  TFiscalPiritPrintDeviceSetting = class(TFiscalPiritCustomSetting)
  strict private
    function GetValueEcPrinting: boolean;
    function GetValueFullSnip: Boolean;
    function GetValuePrintLogo: Boolean;
    function GetValuePrintVertLines: boolean;

    procedure SetValueEcPrinting(AValue: boolean);
    procedure SetValueFullSnip(AValue: boolean);
    procedure SetValuePrintLogo(AValue: boolean);
    procedure SetValuePrintVertLines(AValue: boolean);


  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Печать с уменьшенным межстрочным интервалом, для экономии бумаги.
    /// </summary>
    /// <remarks>
    ///   <para>
    ///     False - Нормальный режим печати.
    ///   </para>
    /// </remarks>
    property EcPrinting: Boolean read GetValueEcPrinting write SetValueEcPrinting;
    /// <summary>
    ///   Полная отрезка чека.
    /// </summary>
    /// <remarks>
    ///   False - Частичная отрезка чека.
    /// </remarks>
    property FullSnip: Boolean read GetValueFullSnip write SetValueFullSnip;
    /// <summary>
    ///   Печатать графический логотип.
    /// </summary>
    /// <remarks>
    ///   Логотип должен быть предварительно загружен.
    /// </remarks>
    property PrintLogo: Boolean read GetValuePrintLogo write SetValuePrintLogo;
    /// <summary>
    ///   Печатать вертикальные полосы на сервисных документах.
    /// </summary>
    property PrintVertLines: boolean read GetValuePrintVertLines write SetValuePrintVertLines;

  end;

  /// <summary>
  ///   Класс. реализующий доступ к настройкам "Параметры чека".
  /// </summary>
  TFiscalPiritCheckSetting = class(TFiscalPiritCustomSetting)
  strict private
    function GetNumDesignCheck: integer;
    function GetValueNumberingOfChecksExt: Boolean;

    procedure SetNumDesignCheck(ANum: integer);
    procedure SetValueNumberingOfChecksExt(AValue: Boolean);

  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Номер дизайна чека.
    /// </summary>
    /// <remarks>
    ///   Номер дизайна чека:
    ///   <list type="bullet">
    ///     <item>
    ///       0 - Обычный;
    ///     </item>
    ///     <item>
    ///       1 - Расширенный;
    ///     </item>
    ///     <item>
    ///       2 - Экономный;
    ///     </item>
    ///     <item>
    ///       3 - Для бумаги 57мм;
    ///     </item>
    ///     <item>
    ///       16 и выше - Дополнительные загружаемые дизайны.
    ///     </item>
    ///   </list>
    /// </remarks>
    property NumDesignCheck: Integer read GetNumDesignCheck write SetNumDesignCheck;
    /// <summary>
    ///   Нумерация чеков внешней программой.
    /// </summary>
    /// <value>
    ///   False - Нумерация чеков КСА.
    /// </value>
    property NumberingChecksExt: boolean read GetValueNumberingOfChecksExt write SetValueNumberingOfChecksExt;

  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Параметры Z-отчета".
  /// </summary>
  TFiscalPiritReportZSetting = class(TFiscalPiritCustomSetting)
  strict private
    function GetValuePrintAmountComulativeShift: Boolean;
    function GetValuePrintAmountComulative: Boolean;
    function GetValueNoPrintUnusedPaymentMeans: Boolean;
    function GetValuePrintDateTimeBeginShift: Boolean;
    function GetValuePrintSections: Boolean;

    procedure SetValuePrintAmountComulativeShift(AValue: Boolean);
    procedure SetValuePrintAmountComulative(AValue: Boolean);
    procedure SetValueNoPrintUnusedPaymentMeans(AValue: Boolean);
    procedure SetValuePrintDateTimeBeginShift(AValue: Boolean);
    procedure SetValuePrintSections(AValue: Boolean);

  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Печатать сумму нарастающего итога на начало смены.
    /// </summary>
    property PrintAmountComulativeShift: Boolean read GetValuePrintAmountComulativeShift write SetValuePrintAmountComulativeShift;
    /// <summary>
    ///   Печатать суммы нарастающего итога.
    /// </summary>
    property PrintAmountComulative: Boolean read GetValuePrintAmountComulative write SetValuePrintAmountComulative;
    /// <summary>
    ///   Не печатать информацию по неиспользованным за смену платежным
    ///   средствам.
    /// </summary>
    property NoPrintUnusedPaymentMeans: Boolean read GetValueNoPrintUnusedPaymentMeans write SetValueNoPrintUnusedPaymentMeans;
    /// <summary>
    ///   Печатать дату и время начала смены.
    /// </summary>
    property PrintDateTimeBeginShift: Boolean read GetValuePrintDateTimeBeginShift write SetValuePrintDateTimeBeginShift;
    /// <summary>
    ///   Печатать секции на отчете.
    /// </summary>
    property PrintSections: Boolean read GetValuePrintSections write SetValuePrintSections;

  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Управление внешними
  ///   устройствами".
  /// </summary>
  TFiscalPiritExtDeviceSetting = class(TFiscalPiritCustomSetting)
  strict private
    function GetValueMoneyBoxOpenFiscalDevice: Boolean;

    procedure SetValueMoneyBoxOpenFiscalDevice(AValue: Boolean);

  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Денежный ящийк открывает КСА при работе с наличными.
    /// </summary>
    /// <value>
    ///   False - Денежный ящик открывает внешняя программа.
    /// </value>
    property MoneyBoxOpenFiscalDevice: Boolean read GetValueMoneyBoxOpenFiscalDevice write SetValueMoneyBoxOpenFiscalDevice;
  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Управление расчетами".
  /// </summary>
  TFiscalPiritCalculationSetting = class(TFiscalPiritCustomSetting)
  strict private
    function GetValueCashManagement: boolean;
    function GetValueIgnoreAnnulatedChecks: boolean;
    function GetValueAutomaticCollection: boolean;

    procedure SetValueCashManagement(AValue: boolean);
    procedure SetValueIgnoreAnnulatedChecks(AValue: boolean);
    procedure SetValueAutomaticCollection(AValue: Boolean);

  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Контроль наличных в денежном ящике отключен.
    /// </summary>
    property DisableCashManagement: boolean read GetValueCashManagement write SetValueCashManagement;
    /// <summary>
    ///   Не учитывать чеки, аннулированные при включения питания.
    /// </summary>
    property IgnoreAnnulatedChecks: boolean read GetValueIgnoreAnnulatedChecks write SetValueIgnoreAnnulatedChecks;
    /// <summary>
    ///   Автоматическая инкасация включена.
    /// </summary>
    property AutomaticCollection: boolean read GetValueAutomaticCollection write SetValueAutomaticCollection;


  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Управление расчетами и печатью
  ///   налогов".
  /// </summary>
  TFiscalPiritTaxSetting = class(TFiscalPiritCustomSetting)
  strict private
    function GetValuePrintTaxOnReport: boolean;
    function GetValuePrintTaxOnCheck: boolean;
    function GetValuePrintZeroTaxAmounts: boolean;
    function GetValueRoundAmountTaxAfterAll: boolean;

    procedure SetValuePrintTaxOnReport(AValue: boolean);
    procedure SetValuePrintTaxOnCheck(AValue: boolean);
    procedure SetValuePrintZeroTaxAmounts(AValue: boolean);
    procedure SetValueRoundAmountTaxAfterAll(AValue: boolean);

  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Печатать налоги на отчетах.
    /// </summary>
    property PrintTaxOnReport: boolean read GetValuePrintTaxOnReport write SetValuePrintTaxOnReport;
    /// <summary>
    ///   Печатать налоги на чеках.
    /// </summary>
    property PrintTaxOnCheck: boolean read GetValuePrintTaxOnCheck write SetValuePrintTaxOnCheck;
    /// <summary>
    ///   Печатать нулевые налоговые суммы на отчетах.
    /// </summary>
    property PrintZeroTaxAmounts: boolean read GetValuePrintZeroTaxAmounts write SetValuePrintZeroTaxAmounts;
    /// <summary>
    ///   Округлять сумму налога только после ввода всех позиций и скидок.
    /// </summary>
    property RoundAmountTaxAfterAll: boolean read GetValueRoundAmountTaxAfterAll write SetValueRoundAmountTaxAfterAll;

  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Значение округления".
  /// </summary>
  TFiscalPiritRoundSetting = class(TFiscalPiritCustomSetting)
  strict private
    function GetValueRound: integer;

    procedure SetValueRound(AValue: integer);
  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Значение оклугления.
    /// </summary>
    property RoundValue: integer read GetValueRound write SetValueRound;

  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Логический номер КСА".
  /// </summary>
  TFiscalPiritLogicalNumberSetting = class(TFiscalPiritCustomSetting)
  strict private
    function GetValueLogicalNumber: integer;

    procedure SetValueLogicalNumber(AValue: integer);
  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Логический номер кассы, присвоенный ей системой данного торгового
    ///   предприятия.
    /// </summary>
    property LogicalNumber: integer read GetValueLogicalNumber write SetValueLogicalNumber;

  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Дополнительная ячейка".
  /// </summary>
  TFiscalPiritExtCellSetting = class(TFiscalPiritCustomSetting)
  strict private
    function GetValueExtCell: integer;
    procedure SetValueExtCell(AValue: integer);
  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Ячейка таблицы, которую внешнее ПО может использовать для своих
    ///   целей.
    /// </summary>
    property ExtCell: integer read GetValueExtCell write SetValueExtCell;
  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Настройки ПУ".
  /// </summary>
  TFiscalPiritParamPrintDeviceSetting = class(TFiscalPiritCustomSetting)
  strict private
    FValueBrightness: integer;
    FValueSnip80: integer;
    FValueSnip57: integer;

    procedure GetValueBrightnessDevice;
    procedure GetValueSnip80Device;
    procedure GetValueSnip57Device;

    procedure SetValueBrightnessDevice;
    procedure SetValueSnip80Device;
    procedure SetValueSnip57Device;

    function GetValueBrightness: integer;
    function GetValueSnip80: integer;
    function GetValueSnip57: integer;

    procedure SetValueBrightness(AValue: integer);
    procedure SetValueSnip80(AValue: integer);
    procedure SetValueSnip57(AValue: integer);
  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Яркость печати.
    /// </summary>
    /// <value>
    ///   20..100
    /// </value>
    property Brightness: integer read GetValueBrightness write SetValueBrightness;
    /// <summary>
    ///   Частичная отрезка для бумаги 80мм.
    /// </summary>
    /// <value>
    ///   0..100
    /// </value>
    property Snip80: integer read GetValueSnip80 write SetValueSnip80;
    /// <summary>
    ///   Частичная отрезка для бумаги 57мм.
    /// </summary>
    /// <value>
    ///   0..100
    /// </value>
    property Snip57: integer read GetValueSnip57 write SetValueSnip57;

    constructor Create;
  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Пароль для связи".
  /// </summary>
  TFiscalPiritPassConnectSetting = class(TFiscalPiritCustomSetting)
  strict private
    FPassValue: string;

    function GetValuePass: string;

    procedure SetValuePass(AValue: string);

  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Пароль для связи.
    /// </summary>
    property Pass: string read GetValuePass write SetValuePass;

  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Информация об организации".
  /// </summary>
  TFiscalPiritCompanyInfoSetting = class(TFiscalPiritCustomSetting)
  strict private
    FValueName1: string;
    FValueName2: string;

    FValueAddress1: string;
    FValueAddress2: string;

    procedure GetValueName1Device;
    procedure GetValueName2Device;
    procedure GetValueAddress1Device;
    procedure GetValueAddress2Device;

    procedure SetValueName1Device;
    procedure SetValueName2Device;
    procedure SetValueAddress1Device;
    procedure SetValueAddress2Device;

    function GetValueName1: string;
    function GetValueName2: string;
    function GetValueAddress1: string;
    function GetValueAddress2: string;

    procedure SetValueName1(AValue: string);
    procedure SetValueName2(AValue: string);
    procedure SetValueAddress1(AValue: string);
    procedure SetValueAddress2(AValue: string);


  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Наименование организации (строка 1).
    /// </summary>
    property CompanyNameStr1:    string read GetValueName1    write SetValueName1;
    /// <summary>
    ///   Наименование организации (строка 2).
    /// </summary>
    property CompanyNameStr2:    string read GetValueName2    write SetValueName2;
    /// <summary>
    ///   Адрес организации (строка 1).
    /// </summary>
    property CompanyAddressStr1: string read GetValueAddress1 write SetValueAddress1;
    /// <summary>
    ///   Адрес организации (строка 2).
    /// </summary>
    property CompanyAddressStr2: string read GetValueAddress2 write SetValueAddress2;

  end;

  /// <summary>
  ///   Класс. реализующий доступ к настройкам "Строки окончания чеков".
  /// </summary>
  TFiscalPiritTextEndCheckSetting = class(TFiscalPiritCustomSetting)
  strict private
    FStrArray: TArrayTextEndCheck;

    function CorrectValueString(const AValue: string): string;

    function GetValueStrArray: TArrayTextEndCheck;
    procedure SetValueStrArray(AValue: TArrayTextEndCheck);

  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Строки окончания чеков.
    /// </summary>
    property TextEndCheck: TArrayTextEndCheck read GetValueStrArray write SetValueStrArray;

  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Названия типов платежей".
  /// </summary>
  TFiscalPiritNamesPaymentsTypesSetting = class(TFiscalPiritCustomSetting)
  strict private
    FStrArray: TArrayNamesPaymentsTypes;

    function CorrectValueString(const AValue: string): string;

    function GetValueStrArray: TArrayNamesPaymentsTypes;
    procedure SetValueStrArray(AValue: TArrayNamesPaymentsTypes);

  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Названия типов платежей.
    /// </summary>
    property NamesPaymentsType: TArrayNamesPaymentsTypes read GetValueStrArray write SetValueStrArray;

  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Название и процент ставки
  ///   налога".
  /// </summary>
  TFiscalPiritTaxRateSetting = class(TFiscalPiritCustomSetting)
  strict private
    FArrayTaxRate: TArrayTaxRate;

    function GetValueTaxRate: TArrayTaxRate;
    procedure SetValueTaxRate(AValue: TArrayTaxRate);

  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Название и процент ставок налогов.
    /// </summary>
    property TaxRate: TArrayTaxRate read GetValueTaxRate write SetValueTaxRate;
  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Строка названия налоговой
  ///   группы в чеке".
  /// </summary>
  TFiscalPiritNameGroupTaxSetting = class(TFiscalPiritCustomSetting)
  strict private
    FStrNameGroup: string;

    function GetValueNameGroup: string;
    procedure SetValueNameGroup(AValue: string);
  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Строка названия налоговой группы в чеке.
    /// </summary>
    property NameGroupTax: string read GetValueNameGroup write SetValueNameGroup;
  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Наименование отдела/секции".
  /// </summary>
  TFiscalPiritNamesSectionsSetting = class(TFiscalPiritCustomSetting)
  strict private
    FStrArray: TArrayNamesSections;

    function CorrectValueString(const AValue: string): string;

    function GetValueStrArray: TArrayNamesSections;
    procedure SetValueStrArray(AValue: TArrayNamesSections);

  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Наименования отделов секций.
    /// </summary>
    property NamesSectionsType: TArrayNamesSections read GetValueStrArray write SetValueStrArray;
  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Строка названия группы
  ///   отделов/секции на Z-отчете".
  /// </summary>
  TFiscalPiritNameGroupSectionSetting = class(TFiscalPiritCustomSetting)
  strict private
    FStrNameGroup: string;

    function GetValueNameGroup: string;
    procedure SetValueNameGroup(AValue: string);
  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Строка названия группы отделов/секций на Z-отчете.
    /// </summary>
    property NameGroupSection: string read GetValueNameGroup write SetValueNameGroup;
  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Наименование реквизита".
  /// </summary>
  TFiscalPiritNameRequisiteSetting = class(TFiscalPiritCustomSetting)
  strict private
    FStrArray: TArrayNameRequisite;

    function CorrectValueString(const AValue: string): string;

    function GetValueStrArray: TArrayNameRequisite;
    procedure SetValueStrArray(AValue: TArrayNameRequisite);

  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Наименование реквизита.
    /// </summary>
    property NameRequisite: TArrayNameRequisite read GetValueStrArray write SetValueStrArray;
  end;

  /// <summary>
  ///   Класс, реализующий доступ к настройкам "Реквизиты ЦТО".
  /// </summary>
  TFiscalPiritServiceCenterRequisiteSetting = class(TFiscalPiritCustomSetting)
  strict private
    FStrArray: TArrayServiceCenterRequisite;

    function CorrectValueString(const AValue: string): string;

    function GetValueStrArray: TArrayServiceCenterRequisite;
    procedure SetValueStrArray(AValue: TArrayServiceCenterRequisite);

  public
    procedure GetValue;
    procedure SetValue;

    /// <summary>
    ///   Реквизиты ЦТО.
    /// </summary>
    property ServiceCenterRequisite: TArrayServiceCenterRequisite read GetValueStrArray write SetValueStrArray;
  end;


implementation

uses
  cl_pirit_parser, System.SysUtils, System.Math, Winapi.Windows;

{$REGION 'TFiscalPiritPrintDeviceSetting'}
  
  procedure TFiscalPiritPrintDeviceSetting.GetValue;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Self.FValue := Self.GetValueFromDeviceInt(REQTableSetting.REQ_PARAM_PRINT_DEVICE,
                                              0);
  end;

  function TFiscalPiritPrintDeviceSetting.GetValueEcPrinting: boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingPrintDevice.BM_EC_PRINTING);
  end;
  
  function TFiscalPiritPrintDeviceSetting.GetValueFullSnip: Boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingPrintDevice.BM_FULL_SNIP);
  end;
  
  function TFiscalPiritPrintDeviceSetting.GetValuePrintLogo: Boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingPrintDevice.BM_PRINT_LOGO);
  end;
  
  function TFiscalPiritPrintDeviceSetting.GetValuePrintVertLines: boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingPrintDevice.BM_PRINT_VERT_LINES);
  end;
  
  procedure TFiscalPiritPrintDeviceSetting.SetValue;
  begin
    Self.SetValueToDevice(REQTableSetting.REQ_PARAM_PRINT_DEVICE,
                          0,
                          Self.FValue);
  end;
  
  procedure TFiscalPiritPrintDeviceSetting.SetValueEcPrinting(AValue: boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingPrintDevice.BM_EC_PRINTING,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;
  
  procedure TFiscalPiritPrintDeviceSetting.SetValueFullSnip(AValue: boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingPrintDevice.BM_FULL_SNIP,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;
  
  procedure TFiscalPiritPrintDeviceSetting.SetValuePrintLogo(AValue: boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingPrintDevice.BM_PRINT_LOGO,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;
  
  procedure TFiscalPiritPrintDeviceSetting.SetValuePrintVertLines(
    AValue: boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingPrintDevice.BM_PRINT_VERT_LINES,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;
  
{$ENDREGION}

{$REGION 'TFisicalPiritCheckSetting'}
  function TFiscalPiritCheckSetting.GetNumDesignCheck: integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueInteger(Self.FValue,
                                     TBitMaskSettingCheck.BM_NUM_DESIGN_CHECK,
                                     TBitMaskSettingCheck._SIZE_NUM_DESIGN_CHECK);
  end;
  
  procedure TFiscalPiritCheckSetting.GetValue;
  begin
    Self.FValue := Self.GetValueFromDeviceInt(REQTableSetting.REQ_PARAM_CHECK,
                                             0);
  end;
  
  function TFiscalPiritCheckSetting.GetValueNumberingOfChecksExt: Boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingCheck.BM_NUMBERING_OF_CHECKS_EXT);
  end;
  
  procedure TFiscalPiritCheckSetting.SetNumDesignCheck(ANum: integer);
  var
    FResult: integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueInteger(Self.FValue,
                                       TBitMaskSettingCheck.BM_NUM_DESIGN_CHECK,
                                       TBitMaskSettingCheck._SIZE_NUM_DESIGN_CHECK,
                                       ANum);
  
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;
  
  procedure TFiscalPiritCheckSetting.SetValue;
  begin
    Self.SetValueToDevice(REQTableSetting.REQ_PARAM_CHECK,
                          0,
                          Self.FValue);
  end;
  
  procedure TFiscalPiritCheckSetting.SetValueNumberingOfChecksExt(
    AValue: Boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingCheck.BM_NUMBERING_OF_CHECKS_EXT,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;
{$ENDREGION}

{$REGION 'TFiscalPiritReportZSetting'}
  
  procedure TFiscalPiritReportZSetting.GetValue;
  begin
    Self.FValue := Self.GetValueFromDeviceInt(REQTableSetting.REQ_PARAM_REPORT_Z,
                                              0);
  end;
  
  function TFiscalPiritReportZSetting.GetValueNoPrintUnusedPaymentMeans: Boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingReportZ.BM_NO_PRINT_UNUSED_PAYMENT);
  end;
  
  function TFiscalPiritReportZSetting.GetValuePrintAmountComulative: Boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingReportZ.BM_PRINT_AMOUNT_COMUL);
  end;
  
  function TFiscalPiritReportZSetting.GetValuePrintAmountComulativeShift: Boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingReportZ.BM_PRINT_AMOUNT_COMUL_SHIFT);
  end;
  
  function TFiscalPiritReportZSetting.GetValuePrintDateTimeBeginShift: Boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingReportZ.BM_PRINT_DATETIME_BEGIN_SHIFT);
  end;
  
  function TFiscalPiritReportZSetting.GetValuePrintSections: Boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingReportZ.BM_PRINT_SECTIONS);
  end;
  
  procedure TFiscalPiritReportZSetting.SetValue;
  begin
    Self.SetValueToDevice(REQTableSetting.REQ_PARAM_REPORT_Z,
                          0,
                          Self.FValue);
  end;
  
  procedure TFiscalPiritReportZSetting.SetValueNoPrintUnusedPaymentMeans(
    AValue: Boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingReportZ.BM_NO_PRINT_UNUSED_PAYMENT,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;
  
  procedure TFiscalPiritReportZSetting.SetValuePrintAmountComulative(
    AValue: Boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingReportZ.BM_PRINT_AMOUNT_COMUL,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;
  
  procedure TFiscalPiritReportZSetting.SetValuePrintAmountComulativeShift(
    AValue: Boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingReportZ.BM_PRINT_AMOUNT_COMUL_SHIFT,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;
  
  procedure TFiscalPiritReportZSetting.SetValuePrintDateTimeBeginShift(
    AValue: Boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingReportZ.BM_PRINT_DATETIME_BEGIN_SHIFT,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;
  
  procedure TFiscalPiritReportZSetting.SetValuePrintSections(AValue: Boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingReportZ.BM_PRINT_SECTIONS,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;
  
{$ENDREGION}

{$REGION 'TFiscalPiritExtDeviceSetting'}
  procedure TFiscalPiritExtDeviceSetting.GetValue;
  begin
    Self.FValue := Self.GetValueFromDeviceInt(REQTableSetting.REQ_PARAM_EXT_DEVICE,
                                              0);
  end;
  
  
  function TFiscalPiritExtDeviceSetting.GetValueMoneyBoxOpenFiscalDevice: Boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingExtDevice.BM_MONEYBOX_OPEN_FISCAL_DEVICE);
  end;
  
  procedure TFiscalPiritExtDeviceSetting.SetValue;
  begin
    Self.SetValueToDevice(REQTableSetting.REQ_PARAM_EXT_DEVICE,
                          0,
                          Self.FValue);
  end;
  
  procedure TFiscalPiritExtDeviceSetting.SetValueMoneyBoxOpenFiscalDevice(
    AValue: Boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingExtDevice.BM_MONEYBOX_OPEN_FISCAL_DEVICE,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;
  
{$ENDREGION}

{$REGION 'TFiscalPiritCalculationSetting'}
  procedure TFiscalPiritCalculationSetting.GetValue;
  begin
    Self.FValue := Self.GetValueFromDeviceInt(REQTableSetting.REQ_PARAM_CALCULATION,
                                              0);
  end;

  function TFiscalPiritCalculationSetting.GetValueAutomaticCollection: boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingCalculation.BM_AUTOMATIC_COLLECTION);
  end;

  function TFiscalPiritCalculationSetting.GetValueCashManagement: boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingCalculation.BM_CASH_MANAGEMENT);
  end;

  function TFiscalPiritCalculationSetting.GetValueIgnoreAnnulatedChecks: boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingCalculation.BM_IGNORE_ANNULLATED_CHECKS);
  end;

  procedure TFiscalPiritCalculationSetting.SetValue;
  begin
    Self.SetValueToDevice(REQTableSetting.REQ_PARAM_CALCULATION,
                          0,
                          Self.FValue);
  end;

  procedure TFiscalPiritCalculationSetting.SetValueAutomaticCollection(AValue: boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingCalculation.BM_AUTOMATIC_COLLECTION,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;

  procedure TFiscalPiritCalculationSetting.SetValueCashManagement(
    AValue: boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingCalculation.BM_CASH_MANAGEMENT,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;

  procedure TFiscalPiritCalculationSetting.SetValueIgnoreAnnulatedChecks(
    AValue: boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingCalculation.BM_IGNORE_ANNULLATED_CHECKS,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;

{$ENDREGION}

{$REGION 'TFiscalPiritTaxSetting'}

  procedure TFiscalPiritTaxSetting.GetValue;
  begin
    Self.FValue := Self.GetValueFromDeviceInt(REQTableSetting.REQ_PARAM_PRINT_CALC_TAX,
                                              0);
  end;

  function TFiscalPiritTaxSetting.GetValuePrintTaxOnCheck: boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingTax.BM_PRINT_TAX_CHECK);
  end;

  function TFiscalPiritTaxSetting.GetValuePrintTaxOnReport: boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingTax.BM_PRINT_TAX_REPORT);
  end;

  function TFiscalPiritTaxSetting.GetValuePrintZeroTaxAmounts: boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingTax.BM_PRINT_ZERO_TAX_AMOUNTS);
  end;

  function TFiscalPiritTaxSetting.GetValueRoundAmountTaxAfterAll: boolean;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    Result := BitMaskGetValueBoolean(Self.FValue,
                                     TBitMaskSettingTax.BM_ROUND_AMOUNT_TAX);
  end;

  procedure TFiscalPiritTaxSetting.SetValue;
  begin
    Self.SetValueToDevice(REQTableSetting.REQ_PARAM_PRINT_CALC_TAX,
                          0,
                          Self.FValue);
  end;

  procedure TFiscalPiritTaxSetting.SetValuePrintTaxOnCheck(AValue: boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingTax.BM_PRINT_TAX_CHECK,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;

  procedure TFiscalPiritTaxSetting.SetValuePrintTaxOnReport(AValue: boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingTax.BM_PRINT_TAX_REPORT,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;

  procedure TFiscalPiritTaxSetting.SetValuePrintZeroTaxAmounts(AValue: boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingTax.BM_PRINT_ZERO_TAX_AMOUNTS,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;

  procedure TFiscalPiritTaxSetting.SetValueRoundAmountTaxAfterAll(
    AValue: boolean);
  var
    FResult: Integer;
  begin
    if self.IsInstantСhanges then
      self.GetValue;

    FResult :=  BitMaskSetValueBoolean(Self.FValue,
                                       TBitMaskSettingTax.BM_ROUND_AMOUNT_TAX,
                                       AValue);
    Self.FValue := FResult;

    if self.IsInstantСhanges then
      self.SetValue;
  end;

{$ENDREGION}

{$REGION 'TFiscalPiritCustomSetting'}
  constructor TFiscalPiritCustomSetting.Create;
  begin
    Self.FValue := 0;
    Self.FIsInstantСhanges := false;
  end;
  
  function TFiscalPiritCustomSetting.GetValueFromDeviceInt(ANum, AIndex: Integer): integer;
  var
//    FPiritParam: TPiritParam;
//    FResultCMD: TPiritResultCMD;
    FResult: string;
  begin
    FResult := GetValueFromDevice(ANum, AIndex);
    if not FResult.isEmpty
    then
      Result := FResult.ToInteger
    else
      begin
        Result := -1;
        OutputDebugString(PWideChar(Format('[Error Fiscal Pirit |TFiscalPiritCustomSettings.GetValueFromDeviceInt|]:'+
                                           ' ANum = %d, AIndex = %d, FResult = "%s"', [ANum, AIndex, FResult])));
      end;
{
      FPiritParam := TPiritParam.Create;
      FPiritParam.Add(ANum.ToString);
      FPiritParam.Add(AIndex.ToString);
      FResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_SFR_READ_TABLE_SETTINGS,
                                               FPiritParam);

      if FResultCMD.ErrorNum = 0 then
        begin
          Self.FValue := FResultCMD.PiritParamResult.Items[0].ToInteger;
        end;
      FPiritParam.Free;
      FResultCMD.Free;
}
  end;

  procedure TFiscalPiritCustomSetting.SetValueToDevice(ANum, AIndex, AValue: integer);
//  var
//    FPiritParam: TPiritParam;
//    FResultCMD: TPiritResultCMD;
  begin
    self.SetValueToDevice(ANum, AIndex, AValue.ToString);
{
      FPiritParam := TPiritParam.Create;
      FPiritParam.Add(ANum.ToString);
      FPiritParam.Add(AIndex.ToString);
      FPiritParam.Add(AValue.ToString);

      FResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_SFR_WRITE_TABLE_SETTINGS,
                                               FPiritParam);
      FPiritParam.Free;
      FResultCMD.Free;
}
  end;

  function TFiscalPiritCustomSetting.GetValueFromDevice(ANum,
    AIndex: Integer): string;
  var
    FPiritParam: TPiritParam;
    FResultCMD: TPiritResultCMD;
  begin
    FPiritParam := TPiritParam.Create;
    FPiritParam.Add(ANum.ToString);
    FPiritParam.Add(AIndex.ToString);
    FResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_SFR_READ_TABLE_SETTINGS,
                                             FPiritParam);

    if FResultCMD.ErrorNum = 0 then
      begin
        if FResultCMD.PiritParamResult.Count > 0
        then
          result := FResultCMD.PiritParamResult.Items[0]
        else
          Result := '';
      end;
    FPiritParam.Free;
    FResultCMD.Free;
  end;

  procedure TFiscalPiritCustomSetting.SetValueToDevice(ANum, AIndex: Integer;
    AValue: string);
  var
    FPiritParam: TPiritParam;
    FResultCMD: TPiritResultCMD;
  begin
    FPiritParam := TPiritParam.Create;
    FPiritParam.Add(ANum.ToString);
    FPiritParam.Add(AIndex.ToString);
    FPiritParam.Add(AValue);

    FResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_SFR_WRITE_TABLE_SETTINGS,
                                             FPiritParam);
    FPiritParam.Free;
    FResultCMD.Free;
  end;

{$ENDREGION}

{$REGION 'TFiscalPiritRoundSetting'}
  
  procedure TFiscalPiritRoundSetting.GetValue;
  begin
    Self.FValue := Self.GetValueFromDeviceInt(REQTableSetting.REQ_PARAM_ROUND_VALUE,
                                              0);
  end;
  
  function TFiscalPiritRoundSetting.GetValueRound: integer;
  begin
    if self.IsInstantСhanges then
      Self.GetValue;

    Result := Self.FValue;
  end;

  procedure TFiscalPiritRoundSetting.SetValue;
  begin
    Self.SetValueToDevice(REQTableSetting.REQ_PARAM_ROUND_VALUE,
                          0,
                          Self.FValue);
  end;
  
  procedure TFiscalPiritRoundSetting.SetValueRound(AValue: integer);
  begin
    Self.FValue := AValue;

    if self.IsInstantСhanges then
        Self.SetValue;
  end;
{$ENDREGION}

{$REGION 'TFiscalPiritLogicalNumber'}
  procedure TFiscalPiritLogicalNumberSetting.GetValue;
  begin
    Self.FValue :=  self.GetValueFromDeviceInt(REQTableSetting.REQ_PARAM_LOGICAL_NUMBER,
                                               0);
  end;
  
  function TFiscalPiritLogicalNumberSetting.GetValueLogicalNumber: integer;
  begin
    if self.IsInstantСhanges then
      Self.GetValue;
  
    Result := Self.FValue;
  end;
  
  procedure TFiscalPiritLogicalNumberSetting.SetValue;
  begin
    Self.SetValueToDevice(REQTableSetting.REQ_PARAM_LOGICAL_NUMBER,
                          0,
                          Self.FValue);
  end;
  
  procedure TFiscalPiritLogicalNumberSetting.SetValueLogicalNumber(AValue: integer);
  begin
    if (AValue < 1) or (AValue > 9999) then
      exit;

    Self.FValue := AValue;

    if self.IsInstantСhanges then
      Self.SetValue;
  end;
  
{$ENDREGION}

{$REGION 'TFiscalPiritExtCellSetting'}
  procedure TFiscalPiritExtCellSetting.GetValue;
  begin
    Self.FValue :=  self.GetValueFromDeviceInt(REQTableSetting.REQ_PARAM_EXT_CELL,
                                               0);
  end;
  
  function TFiscalPiritExtCellSetting.GetValueExtCell: integer;
  begin
    if self.IsInstantСhanges then  
      Self.GetValue;
  
    Result := Self.FValue;
  end;
  
  procedure TFiscalPiritExtCellSetting.SetValue;
  begin
    Self.SetValueToDevice(REQTableSetting.REQ_PARAM_EXT_CELL,
                          0,
                          Self.FValue);
  end;
  
  procedure TFiscalPiritExtCellSetting.SetValueExtCell(AValue: integer);
  begin
    if (AValue < 0) or (AValue > 65535) then
      exit;

    Self.FValue := AValue;

    if self.IsInstantСhanges then
      Self.SetValue;
  end;
  
{$ENDREGION}

{$REGION 'TFiscalPiritParamPrintDeviceSetting'}
  constructor TFiscalPiritParamPrintDeviceSetting.Create;
  begin
    inherited;
    Self.FValueBrightness := 0;
    Self.FValueSnip80 := 0;
    Self.FValueSnip57 := 0;
  end;
  
  procedure TFiscalPiritParamPrintDeviceSetting.GetValue;
  begin
    Self.GetValueBrightnessDevice;
    Self.GetValueSnip80Device;
    Self.GetValueSnip57Device;
  end;
  
  function TFiscalPiritParamPrintDeviceSetting.GetValueBrightness: integer;
  begin
    if Self.IsInstantСhanges then
      Self.GetValueBrightnessDevice;
  
    Result := Self.FValueBrightness;
  end;
  
  procedure TFiscalPiritParamPrintDeviceSetting.GetValueBrightnessDevice;
  begin
    Self.FValueBrightness :=  self.GetValueFromDeviceInt(REQTableSetting.REQ_PARAM_PRINT_SETTING,
                                               1);
  end;
  
  function TFiscalPiritParamPrintDeviceSetting.GetValueSnip57: integer;
  begin
    if Self.IsInstantСhanges then
      self.GetValueSnip57Device;
  
    Result := Self.FValueSnip57;
  end;
  
  procedure TFiscalPiritParamPrintDeviceSetting.GetValueSnip57Device;
  begin
    Self.FValueSnip57 :=  self.GetValueFromDeviceInt(REQTableSetting.REQ_PARAM_PRINT_SETTING,
                                               3);
  end;
  
  function TFiscalPiritParamPrintDeviceSetting.GetValueSnip80: integer;
  begin
    if self.IsInstantСhanges then
      self.GetValueSnip80Device;
  
    Result := Self.FValueSnip80;
  end;
  
  procedure TFiscalPiritParamPrintDeviceSetting.GetValueSnip80Device;
  begin
    Self.FValueSnip80 :=  self.GetValueFromDeviceInt(REQTableSetting.REQ_PARAM_PRINT_SETTING,
                                               2);
  end;
  
  procedure TFiscalPiritParamPrintDeviceSetting.SetValue;
  begin
    Self.SetValueBrightnessDevice;
    Self.SetValueSnip80Device;
    Self.SetValueSnip57Device;
  end;
  
  procedure TFiscalPiritParamPrintDeviceSetting.SetValueBrightness(
    AValue: integer);
  begin
    if (AValue < 20) or (AValue > 100) then
      exit;

    Self.FValueBrightness := AValue;
  
    if self.IsInstantСhanges then
      self.SetValueBrightnessDevice;
  end;
  
  procedure TFiscalPiritParamPrintDeviceSetting.SetValueBrightnessDevice;
  begin
    Self.SetValueToDevice(REQTableSetting.REQ_PARAM_PRINT_SETTING,
                          1,
                          Self.FValueBrightness);
  end;
  
  procedure TFiscalPiritParamPrintDeviceSetting.SetValueSnip57(AValue: integer);
  begin
    if (AValue < 0) or (AValue > 100) then
      exit;

    Self.FValueSnip57 := AValue;
  
    if self.IsInstantСhanges then
      self.SetValueSnip57Device;
  end;
  
  procedure TFiscalPiritParamPrintDeviceSetting.SetValueSnip57Device;
  begin
    Self.SetValueToDevice(REQTableSetting.REQ_PARAM_PRINT_SETTING,
                          3,
                          Self.FValueSnip57);
  end;
  
  procedure TFiscalPiritParamPrintDeviceSetting.SetValueSnip80(AValue: integer);
  begin
    if (AValue < 0) or (AValue > 100) then
      exit;

    Self.FValueSnip80 := AValue;
  
    if self.IsInstantСhanges then
      self.SetValueSnip80Device;
  end;
  
  procedure TFiscalPiritParamPrintDeviceSetting.SetValueSnip80Device;
  begin
    Self.SetValueToDevice(REQTableSetting.REQ_PARAM_PRINT_SETTING,
                          2,
                          Self.FValueSnip80);
  end;
  
{$ENDREGION}

{$REGION 'TFiscalPiritPassConnectSetting'}

  procedure TFiscalPiritPassConnectSetting.GetValue;
  begin
    Self.FPassValue := self.GetValueFromDevice(REQTableSetting.REQ_PARAM_PASS,
                                               0);
  end;

  function TFiscalPiritPassConnectSetting.GetValuePass: string;
  begin
    if Self.IsInstantСhanges then
      Self.GetValue;

    Result := Self.FPassValue;
  end;

  procedure TFiscalPiritPassConnectSetting.SetValue;
  begin
    Self.SetValueToDevice(REQTableSetting.REQ_PARAM_PASS,
                          0,
                          Self.FPassValue);
  end;

  procedure TFiscalPiritPassConnectSetting.SetValuePass(AValue: string);
  begin
    if AValue.Length > 4 then
      exit;

    Self.FPassValue := AValue;

    if Self.IsInstantСhanges then
      Self.SetValue;
  end;

{$ENDREGION}


{$REGION 'TFiscalPiritCompanyInfoSetting'}
  procedure TFiscalPiritCompanyInfoSetting.GetValue;
  begin
    Self.GetValueName1Device;
    Self.GetValueName2Device;
    Self.GetValueAddress1Device;
    Self.GetValueAddress2Device;
  end;
  
  function TFiscalPiritCompanyInfoSetting.GetValueAddress1: string;
  begin
    if self.IsInstantСhanges then
      Self.GetValueAddress1Device;
  
    Result := Self.FValueAddress1;
  end;
  
  procedure TFiscalPiritCompanyInfoSetting.GetValueAddress1Device;
  begin
    Self.FValueAddress1 := self.GetValueFromDevice(REQTableSetting.REQ_PARAM_COMPANY_INFO,
                                                   2);
  end;
  
  function TFiscalPiritCompanyInfoSetting.GetValueAddress2: string;
  begin
    if self.IsInstantСhanges then
      self.GetValueAddress2Device;
  
    Result := self.FValueAddress2;
  end;
  
  procedure TFiscalPiritCompanyInfoSetting.GetValueAddress2Device;
  begin
    Self.FValueAddress2 := self.GetValueFromDevice(REQTableSetting.REQ_PARAM_COMPANY_INFO,
                                                   3);
  end;
  
  function TFiscalPiritCompanyInfoSetting.GetValueName1: string;
  begin
    if self.IsInstantСhanges then
      self.GetValueName1Device;
  
    Result := Self.FValueName1;
  end;
  
  procedure TFiscalPiritCompanyInfoSetting.GetValueName1Device;
  begin
    Self.FValueName1 := self.GetValueFromDevice(REQTableSetting.REQ_PARAM_COMPANY_INFO,
                                                0);
  end;
  
  function TFiscalPiritCompanyInfoSetting.GetValueName2: string;
  begin
    if Self.IsInstantСhanges then
      self.GetValueName2Device;
  
    Result := Self.FValueName2;
  end;
  
  procedure TFiscalPiritCompanyInfoSetting.GetValueName2Device;
  begin
    Self.FValueName2 := self.GetValueFromDevice(REQTableSetting.REQ_PARAM_COMPANY_INFO,
                                                1);
  end;
  
  procedure TFiscalPiritCompanyInfoSetting.SetValue;
  begin
    self.SetValueName1Device;
    Self.SetValueName2Device;
    Self.SetValueAddress1Device;
    Self.SetValueAddress2Device;
  end;
  
  procedure TFiscalPiritCompanyInfoSetting.SetValueAddress1(AValue: string);
  begin
    Self.FValueAddress1 := AValue;
  
    if self.IsInstantСhanges then
      self.SetValueAddress1Device;
  end;
  
  procedure TFiscalPiritCompanyInfoSetting.SetValueAddress1Device;
  var
    FStr: string;
  begin
    FStr := Copy(Self.FValueAddress1, 1, 44);
    self.SetValueToDevice(REQTableSetting.REQ_PARAM_COMPANY_INFO,
                          2,
                          FStr);
  end;
  
  procedure TFiscalPiritCompanyInfoSetting.SetValueAddress2(AValue: string);
  begin
    Self.FValueAddress2 := AValue;
  
    if self.IsInstantСhanges then
      Self.SetValueAddress2Device;
  end;
  
  procedure TFiscalPiritCompanyInfoSetting.SetValueAddress2Device;
  var
    FStr: string;
  begin
    FStr := Copy(Self.FValueAddress2, 1, 44);
    self.SetValueToDevice(REQTableSetting.REQ_PARAM_COMPANY_INFO,
                          3,
                          FStr);
  end;
  
  procedure TFiscalPiritCompanyInfoSetting.SetValueName1(AValue: string);
  begin
    Self.FValueName1 := AValue;
  
    if self.IsInstantСhanges then
      Self.SetValueName1Device;
  end;
  
  procedure TFiscalPiritCompanyInfoSetting.SetValueName1Device;
  var
    FStr: string;
  begin
      FStr := Copy(Self.FValueName1, 1, 44);
    self.SetValueToDevice(REQTableSetting.REQ_PARAM_COMPANY_INFO,
                          0,
                          FStr);
  end;
  
  procedure TFiscalPiritCompanyInfoSetting.SetValueName2(AValue: string);
  begin
    Self.FValueName2 := AValue;
  
    if Self.IsInstantСhanges then
      Self.SetValueName2Device;
  end;
  
  procedure TFiscalPiritCompanyInfoSetting.SetValueName2Device;
  var
    FStr: string;
  begin
    FStr := Copy(Self.FValueName2, 1, 44);
    self.SetValueToDevice(REQTableSetting.REQ_PARAM_COMPANY_INFO,
                          1,
                          FStr);
  end;
{$ENDREGION}

{$REGION 'TFiscalPiritTextEndCheck'}
  
function TFiscalPiritTextEndCheckSetting.CorrectValueString(
  const AValue: string): string;
var
  FLen: integer;
begin
  FLen := Length(AValue);
  if FLen > 44
  then
    begin
      Result := AValue.Remove(44);
      OutputDebugString(PWideChar(Format(CS_OUT_DEBUG.CORRECT_TEXT_END_CHECK, [AValue, Result])));
    end
  else
    Result := AValue;
end;

procedure TFiscalPiritTextEndCheckSetting.GetValue;
  var
    I: integer;
    FStr: string;
  begin
    for I :=0 to 4 do
      begin
        FStr := self.GetValueFromDevice(REQTableSetting.REQ_PARAM_TEXT_END_CHECK,
                                        I);
        Self.FStrArray[I] := FStr;
      end;
  end;
  
  function TFiscalPiritTextEndCheckSetting.GetValueStrArray: TArrayTextEndCheck;
  begin
    if self.IsInstantСhanges then
      Self.GetValue;
  
    Result := Self.FStrArray;
  end;
  
  procedure TFiscalPiritTextEndCheckSetting.SetValue;
  var
    I: Integer;
    FCorrectStr: string;
  begin
    for I := 0 to 4 do
      begin
        FCorrectStr := Self.CorrectValueString(self.FStrArray[I]);
        self.SetValueToDevice(REQTableSetting.REQ_PARAM_TEXT_END_CHECK,
                              I,
                              FCorrectStr);
      end;
  
  end;
  
  procedure TFiscalPiritTextEndCheckSetting.SetValueStrArray(
    AValue: TArrayTextEndCheck);
  begin
  
    Self.FStrArray := AValue;
  
    if self.IsInstantСhanges then
      Self.SetValue;
  end;
{$ENDREGION}

{$REGION 'TFiscalPiritNamesPaymentsTypesSetting'}
  
  
function TFiscalPiritNamesPaymentsTypesSetting.CorrectValueString(
  const AValue: string): string;
var
  FLen: integer;
begin
  FLen := Length(AValue);
  if FLen > 18
  then
    begin
      Result := AValue.Remove(18);
      OutputDebugString(PWideChar(Format(CS_OUT_DEBUG.CORRECT_NAME_PAYMENT_TYPE, [AValue, Result])));
    end
  else
    Result := AValue;
end;

procedure TFiscalPiritNamesPaymentsTypesSetting.GetValue;
  var
    I: integer;
    FStr: string;
  begin
    for I :=0 to 15 do
      begin
        FStr := self.GetValueFromDevice(REQTableSetting.REQ_PARAM_NAMES_PAYMENTS_TYPES,
                                        I);
        Self.FStrArray[I] := FStr;
      end;
  end;
  
  function TFiscalPiritNamesPaymentsTypesSetting.GetValueStrArray: TArrayNamesPaymentsTypes;
  begin
    if self.IsInstantСhanges then
      Self.GetValue;
  
    Result := Self.FStrArray;
  end;
  
  procedure TFiscalPiritNamesPaymentsTypesSetting.SetValue;
  var
    I: Integer;
    FCorrectStr: string;
  begin
    for I := 1 to 15 do
      begin
        FCorrectStr := CorrectValueString(self.FStrArray[I]);
        self.SetValueToDevice(REQTableSetting.REQ_PARAM_NAMES_PAYMENTS_TYPES,
                              I,
                              FCorrectStr);
      end;
  end;
  
  procedure TFiscalPiritNamesPaymentsTypesSetting.SetValueStrArray(
    AValue: TArrayNamesPaymentsTypes);
  begin
    Self.FStrArray := AValue;
  
    if self.IsInstantСhanges then
      Self.SetValue;
  end;
{$ENDREGION}

{$REGION 'TFiscalPiritTaxRateSetting'}
  
  procedure TFiscalPiritTaxRateSetting.GetValue;
  var
    I: integer;
    FNameTax: string;
    FStrRateTax: string;
    FRateTax: Double;
    FRecTaxRate: TTaxRateRecord;
  
  begin
    FRateTax := 0.0;
    for I :=0 to 5 do
      begin
        FNameTax := self.GetValueFromDevice(REQTableSetting.REQ_PARAM_NAMES_TAX,
                                            I);
        FStrRateTax := Self.GetValueFromDevice(REQTableSetting.REQ_PARAM_RATE_TAX,
                                            I);
  
        FRateTax := FStrRateTax.ToDouble;
  
        FRecTaxRate.AName := FNameTax;
        FRecTaxRate.APercentage := RoundTo(FRateTax, -4);
        Self.FArrayTaxRate[I] := FRecTaxRate;
      end;
  end;
  
  function TFiscalPiritTaxRateSetting.GetValueTaxRate: TArrayTaxRate;
  begin
    if self.IsInstantСhanges then
      Self.GetValue;
  
    Result := Self.FArrayTaxRate;
  end;
  
  procedure TFiscalPiritTaxRateSetting.SetValue;
  var
    I: Integer;
    FNameTax: string;
    FStrRateTax: string;
    FRateTax: Double;
    FRecTaxRate: TTaxRateRecord;
  
  begin
    for I := 0 to 5 do
      begin
        FRecTaxRate := Self.FArrayTaxRate[I];
  
        FRateTax := RoundTo(FRecTaxRate.APercentage, - 4);
        FStrRateTax := FRateTax.ToString;
  
        self.SetValueToDevice(REQTableSetting.REQ_PARAM_NAMES_TAX,
                              I,
                              FRecTaxRate.AName);
  
        self.SetValueToDevice(REQTableSetting.REQ_PARAM_RATE_TAX,
                              I,
                              FStrRateTax);
      end;
  end;
  
  procedure TFiscalPiritTaxRateSetting.SetValueTaxRate(AValue: TArrayTaxRate);
  begin
    Self.FArrayTaxRate := AValue;
  
    if self.IsInstantСhanges then
      Self.SetValue;
  end;
  
{$ENDREGION}

{$REGION 'TFiscalPiritNameGroupTax'}
  
  procedure TFiscalPiritNameGroupTaxSetting.GetValue;
  begin
    self.FStrNameGroup := self.GetValueFromDevice(REQTableSetting.REQ_PARAM_NAME_GROUP_TAX,
                                                 0);
  end;
  
  function TFiscalPiritNameGroupTaxSetting.GetValueNameGroup: string;
  begin
    if self.IsInstantСhanges then
      Self.GetValue;
  
    Result := Self.FStrNameGroup;
  end;
  
  procedure TFiscalPiritNameGroupTaxSetting.SetValue;
  var
    FStr: string;
  begin
    FStr := Copy(Self.FStrNameGroup, 1, 44);
    self.SetValueToDevice(REQTableSetting.REQ_PARAM_NAME_GROUP_TAX,
                          0,
                          FStr);
  end;
  
  procedure TFiscalPiritNameGroupTaxSetting.SetValueNameGroup(AValue: string);
  begin
    Self.FStrNameGroup := AValue;
  
    if self.IsInstantСhanges then
      Self.SetValue;
  end;
{$ENDREGION}


{$REGION 'TFiscalPiritNamesSectionsSetting'}
  function TFiscalPiritNamesSectionsSetting.CorrectValueString(
  const AValue: string): string;
var
  FLen: integer;
begin
  FLen := Length(AValue);
  if FLen > 44
  then
    begin
      Result := AValue.Remove(44);
      OutputDebugString(PWideChar(Format(CS_OUT_DEBUG.CORRECT_NAME_SECTION, [AValue, Result])));
    end
  else
    Result := AValue;
end;

procedure TFiscalPiritNamesSectionsSetting.GetValue;
  var
    I: integer;
    FStr: string;
  begin
    for I :=1 to 16 do
      begin
        FStr := self.GetValueFromDevice(REQTableSetting.REQ_PARAM_NAMES_SECTIONS,
                                        I);
        Self.FStrArray[I] := FStr;
      end;
  end;
  
  function TFiscalPiritNamesSectionsSetting.GetValueStrArray: TArrayNamesSections;
  begin
    if self.IsInstantСhanges then
      Self.GetValue;
  
    Result := Self.FStrArray;
  end;
  
  procedure TFiscalPiritNamesSectionsSetting.SetValue;
  var
    I: Integer;
    FCorrectStr: string;
  begin
    for I := 1 to 16 do
      begin
        FCorrectStr := Self.CorrectValueString(self.FStrArray[I]);
        self.SetValueToDevice(REQTableSetting.REQ_PARAM_NAMES_SECTIONS,
                              I,
                              FCorrectStr);
      end;
  end;
  
  procedure TFiscalPiritNamesSectionsSetting.SetValueStrArray(
    AValue: TArrayNamesSections);
  begin
    Self.FStrArray := AValue;
  
    if self.IsInstantСhanges then
      Self.SetValue;
  end;
{$ENDREGION}

{$REGION 'TFiscalPiritNameGroupSectionSetting'}
  
  procedure TFiscalPiritNameGroupSectionSetting.GetValue;
  begin
    self.FStrNameGroup := self.GetValueFromDevice(REQTableSetting.REQ_PARAM_NAME_GROUP_SECTION,
                                                 0);
  end;
  
  function TFiscalPiritNameGroupSectionSetting.GetValueNameGroup: string;
  begin
    if self.IsInstantСhanges then
      Self.GetValue;
  
    Result := Self.FStrNameGroup;
  end;
  
  procedure TFiscalPiritNameGroupSectionSetting.SetValue;
  var
    FStr: string;
  begin
    FStr := Copy(Self.FStrNameGroup, 1, 44);
    self.SetValueToDevice(REQTableSetting.REQ_PARAM_NAME_GROUP_SECTION,
                          0,
                          FStr);
  end;
  
  procedure TFiscalPiritNameGroupSectionSetting.SetValueNameGroup(AValue: string);
  begin
    Self.FStrNameGroup := AValue;
  
    if self.IsInstantСhanges then
      Self.SetValue;
  end;
  
{$ENDREGION}


{$REGION 'TFiscalPiritNameRequisiteSetting'}

function TFiscalPiritNameRequisiteSetting.CorrectValueString(
  const AValue: string): string;
var
  FLen: integer;
begin
  FLen := Length(AValue);
  if FLen > 30
  then
    begin
      Result := AValue.Remove(30);
      OutputDebugString(PWideChar(Format(CS_OUT_DEBUG.CORRECT_NAME_SECTION, [AValue, Result])));
    end
  else
    Result := AValue;
end;

procedure TFiscalPiritNameRequisiteSetting.GetValue;
  var
    I: integer;
    FStr: string;
  begin
    for I :=1 to 5 do
      begin
        FStr := self.GetValueFromDevice(REQTableSetting.REQ_PARAM_NAME_REQUISITE,
                                        I);
        Self.FStrArray[I] := FStr;
      end;
  end;

  function TFiscalPiritNameRequisiteSetting.GetValueStrArray: TArrayNameRequisite;
  begin
    if self.IsInstantСhanges then
      Self.GetValue;

    Result := Self.FStrArray;
  end;

  procedure TFiscalPiritNameRequisiteSetting.SetValue;
  var
    I: Integer;
    FCorrectStr: string;
  begin
    for I := 1 to 5 do
      begin
         FCorrectStr := Self.CorrectValueString(self.FStrArray[I]);
         self.SetValueToDevice(REQTableSetting.REQ_PARAM_NAME_REQUISITE,
                               I,
                               FCorrectStr);
      end;
  end;

  procedure TFiscalPiritNameRequisiteSetting.SetValueStrArray(
  AValue: TArrayNameRequisite);
begin
    Self.FStrArray := AValue;

    if self.IsInstantСhanges then
      Self.SetValue;
end;

{$ENDREGION}

{$REGION 'TFiscalPiritServiceCenterRequisiteSetting' }

  function TFiscalPiritServiceCenterRequisiteSetting.CorrectValueString(
  const AValue: string): string;
var
  FLen: integer;
begin
  FLen := Length(AValue);
  if FLen > 44
  then
    begin
      Result := AValue.Remove(44);
      OutputDebugString(PWideChar(Format(CS_OUT_DEBUG.CORRECT_SERVICE_CENTER_REQ, [AValue, Result])));
    end
  else
    Result := AValue;
end;

procedure TFiscalPiritServiceCenterRequisiteSetting.GetValue;
  var
    I: integer;
    FStr: string;
  begin
    for I := 0 to 1 do
      begin
        FStr := self.GetValueFromDevice(REQTableSetting.REQ_PARAM_SERVICE_CENTER_REQUISITE,
                                        I);
        Self.FStrArray[I] := FStr;
      end;
  end;

  function TFiscalPiritServiceCenterRequisiteSetting.GetValueStrArray: TArrayServiceCenterRequisite;
  begin
    if self.IsInstantСhanges then
      Self.GetValue;

    Result := Self.FStrArray;
  end;

  procedure TFiscalPiritServiceCenterRequisiteSetting.SetValue;
  var
    I: Integer;
    FCorrectStr: string;
  begin
    for I := 0 to 1 do
      begin
        FCorrectStr := Self.CorrectValueString(self.FStrArray[I]);
        self.SetValueToDevice(REQTableSetting.REQ_PARAM_SERVICE_CENTER_REQUISITE,
                              I,
                              FCorrectStr);
      end;
  end;

  procedure TFiscalPiritServiceCenterRequisiteSetting.SetValueStrArray(
    AValue: TArrayServiceCenterRequisite);
  begin
    Self.FStrArray := AValue;

    if self.IsInstantСhanges then
      Self.SetValue;
  end;


{$ENDREGION}

{$REGION 'TFiscalSettingsDevice' }

constructor TFiscalSettingsDevice.Create;
begin
  FFiscalPiritPrintDeviceSetting            := TFiscalPiritPrintDeviceSetting.Create;
  FFiscalPiritCheckSetting                  := TFiscalPiritCheckSetting.Create;
  FFiscalPiritReportZSetting                := TFiscalPiritReportZSetting.Create;
  FFiscalPiritExtDeviceSetting              := TFiscalPiritExtDeviceSetting.Create;
  FFiscalPiritCalculationSetting            := TFiscalPiritCalculationSetting.Create;
  FFiscalPiritTaxSetting                    := TFiscalPiritTaxSetting.Create;
  FFiscalPiritRoundSetting                  := TFiscalPiritRoundSetting.Create;
  FFiscalPiritLogicalNumberSetting          := TFiscalPiritLogicalNumberSetting.Create;
  FFiscalPiritExtCellSetting                := TFiscalPiritExtCellSetting.Create;
  FFiscalPiritParamPrintDeviceSetting       := TFiscalPiritParamPrintDeviceSetting.Create;
  FFiscalPiritPassConnectSetting            := TFiscalPiritPassConnectSetting.Create;
  FFiscalPiritCompanyInfoSetting            := TFiscalPiritCompanyInfoSetting.Create;
  FFiscalPiritTextEndCheckSetting           := TFiscalPiritTextEndCheckSetting.Create;
  FFiscalPiritNamesPaymentsTypesSetting     := TFiscalPiritNamesPaymentsTypesSetting.Create;
  FFiscalPiritTaxRateSetting                := TFiscalPiritTaxRateSetting.Create;
  FFiscalPiritNameGroupTaxSetting           := TFiscalPiritNameGroupTaxSetting.Create;
  FFiscalPiritNamesSectionsSetting          := TFiscalPiritNamesSectionsSetting.Create;
  FFiscalPiritNameGroupSectionSetting       := TFiscalPiritNameGroupSectionSetting.Create;
  FFiscalPiritNameRequisiteSetting          := TFiscalPiritNameRequisiteSetting.Create;
  FFiscalPiritServiceCenterRequisiteSetting := TFiscalPiritServiceCenterRequisiteSetting.Create;
end;

destructor TFiscalSettingsDevice.Destroy;
begin
  FFiscalPiritPrintDeviceSetting.Free;
  FFiscalPiritCheckSetting.Free;
  FFiscalPiritReportZSetting.Free;
  FFiscalPiritExtDeviceSetting.Free;
  FFiscalPiritCalculationSetting.Free;
  FFiscalPiritTaxSetting.Free;
  FFiscalPiritRoundSetting.Free;
  FFiscalPiritLogicalNumberSetting.Free;
  FFiscalPiritExtCellSetting.Free;
  FFiscalPiritParamPrintDeviceSetting.Free;
  FFiscalPiritPassConnectSetting.Free;
  FFiscalPiritCompanyInfoSetting.Free;
  FFiscalPiritTextEndCheckSetting.Free;
  FFiscalPiritNamesPaymentsTypesSetting.Free;
  FFiscalPiritTaxRateSetting.Free;
  FFiscalPiritNameGroupTaxSetting.Free;
  FFiscalPiritNamesSectionsSetting.Free;
  FFiscalPiritNameGroupSectionSetting.Free;
  FFiscalPiritNameRequisiteSetting.Free;
  FFiscalPiritServiceCenterRequisiteSetting.Free;

  inherited;
end;

{$ENDREGION}

end.
