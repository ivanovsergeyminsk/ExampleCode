unit cs_pirit;

interface

const
  DelimiterPirit = AnsiChar(#$1B);

  PingResponse = AnsiChar(#$06);

  CS_PIRIT_INI_FILENAME = 'fiscal_pirit.ini';
  CS_PIRIT_INI_SECTION  = 'connection_pirit';
    CS_PIRIT_INI_com_port = 'com_port';
    CS_PIRIT_INI_baud     = 'baud';
    CS_PIRIT_INI_pass     = 'pass';
    CS_PIRIT_INI_isPrintXReportCloseShift = 'isPrintXReportCloseShift';
    CS_PIRIT_INI_isRequestPrintBufferControlTape = 'isRequestPrintBufferControlTape';

type


  TTaxRateRecord = record
    AName: string[18];
    APercentage: Double;
  end;

  TArrayTextEndCheck            = array[0..4] of string;
  TArrayNamesPaymentsTypes      = array[0..15] of string;
  TArrayNamesSections           = array[1..16] of string;
  TArrayNameRequisite           = array[1..5] of string;
  TArrayServiceCenterRequisite  = array[0..1] of string;

  TArrayTaxRate = array[0..5] of TTaxRateRecord;

  TTypeDevice = (
                 tdFiscal = 1,
                 tdSCNO = 2
                );

{$REGION 'Структуры для команды "Запрос состояния печатующего устройства"'}
  TStatePrintingDevice = (spdNotReady = 0,
                          spdNoPaper = 1,
                          spdLidIsOpen = 2,
                          spdErrorCutter = 3,
                          spdNoConnection = 7);
{$ENDREGION}


  /// <summary>
  ///   Фатальные состояния КСА.
  /// </summary>
  TFlagsFatalStateDevice = (
                             /// <summary>
                             ///   Неверная контрольная сумма NVR.
                             /// </summary>
                             sfsInvalidChecksumNVR = 0,
                             /// <summary>
                             ///   Неверная контрольная сумма в конфигурации.
                             /// </summary>
                             sfsInvalidChecksumConfig = 1,
                             /// <summary>
                             ///   Ошибка интерфейса с БЭП.
                             /// </summary>
                             sfsErrorInterfaceBEP = 2,
                             /// <summary>
                             ///   Неверная контрольная сумма БЭП.
                             /// </summary>
                             sfsInvalidChecksumBEP = 3,
                             /// <summary>
                             ///   Ошибка записи в БЭП.
                             /// </summary>
                             sfsErrorWriteBEP = 4,
                             /// <summary>
                             ///   БЭП не авторизован.
                             /// </summary>
                             sfsNotAuthorizeBEP = 5,
                             /// <summary>
                             ///   Фатальная ошибка памяти контрольной ленты.
                             /// </summary>
                             sfsErrorFatalMemoryControlTape = 6
                            );

  /// <summary>
  ///   Текущие флаги КСА.
  /// </summary>
  TCurrentFlagsDevice = (
                         /// <summary>
                         ///   Не была вызвана функция "Начало работы".
                         /// </summary>
                         scfNotCallStartWork = 0,
                         /// <summary>
                         ///   Учебный режим.
                         /// </summary>
                         scfTrainingMode = 1,
                         /// <summary>
                         ///   Смена открыта.
                         /// </summary>
                         scfShiftOpened = 2,
                         /// <summary>
                         ///   Смена больше 24 часов.
                         /// </summary>
                         scfShift24 = 3,
                         /// <summary>
                         ///   Присутствуют данные в буфере контрольной ленты
                         ///   (буфер не пустой).
                         /// </summary>
                         scfBufferNotEmpty = 4,
                         /// <summary>
                         ///   Зарезервировано.
                         /// </summary>
                         scfReserved1 = 5,
                         /// <summary>
                         ///   Нет памяти для закрытия смены в БЭП.
                         /// </summary>
                         scfNoMemory = 6,
                         /// <summary>
                         ///   Зарезервировано.
                         /// </summary>
                         scfReserverd2 = 7,
                         /// <summary>
                         ///   Не было завершено закрытие смены, необходимо
                         ///   повторить операцию.
                         /// </summary>
                         scfShiftDontClose = 8
                        );

  /// <summary>
  ///   Тип текущего открытого документа.
  /// </summary>
  TTypeDocumentDevice = (
                         /// <summary>
                         ///   Документ закрыт.
                         /// </summary>
                         tddClosed          = Byte(0),
                         /// <summary>
                         ///   Сервисный документ.
                         /// </summary>
                         tddService         = Byte(1),
                         /// <summary>
                         ///   Чек на продажу.
                         /// </summary>
                         tddPayment         = Byte(2),
                         /// <summary>
                         ///   Чек на возврат.
                         /// </summary>
                         tddRefund          = Byte(3),
                         /// <summary>
                         ///   Внесение денег.
                         /// </summary>
                         tddDeposit         = Byte(4),
                         /// <summary>
                         ///   Выдача денег.
                         /// </summary>
                         tddIssuance        = Byte(5),
                         /// <summary>
                         ///   Чек оформления заказа.
                         /// </summary>
                         tddOrdering        = Byte(6),
                         /// <summary>
                         ///   Чек закрытия заказа.
                         /// </summary>
                         tddCloseOrder      = Byte(7),
                         /// <summary>
                         ///   Чек отмены заказа.
                         /// </summary>
                         tddCancelOrder     = Byte(8),
                         /// <summary>
                         ///   Чек добавления заказа.
                         /// </summary>
                         tddAppendOrder     = Byte(9),
                         /// <summary>
                         ///   Чек коррекции заказа.
                         /// </summary>
                         tddCorrectOrder    = Byte(10),
                         /// <summary>
                         ///   Счет на оплату.
                         /// </summary>
                         tddInvoicePayment  = Byte(11)
                        );

  /// <summary>
  ///   Состояние документа.
  /// </summary>
  TStateDocumentDevice = (
                          /// <summary>
                          ///   Документ закрыт.
                          /// </summary>
                          sddClosed = 0,
                          /// <summary>
                          ///   Устанавливается после команды "открыть
                          ///   документ". (Для типов документа 2, 3, 6, 7, 8,
                          ///   9, 10 - можно вводить товарные позиции).
                          /// </summary>
                          sddOpen = 1,
                          /// <summary>
                          ///   Устанавливается после первой команды "Подитог".
                          ///   Можно делать скидки/наценки на чек.
                          /// </summary>
                          sddSubTotal1 = 2,
                          /// <summary>
                          ///   Устанавливается после второй команды "Подитог"
                          ///   или поле начала команды "Оплата". Можно только
                          ///   производить оплату различными типами платежных
                          ///   средств.
                          /// </summary>
                          sddPayment = 3,
                          /// <summary>
                          ///   Расчет завершен - требуется закрыть документ.
                          /// </summary>
                          sddCalcCompleted = 4
                         );


  TStatePrinting = set of TStatePrintingDevice;

  /// <summary>
  ///   Статус фатального состояния КСА.
  /// </summary>
  /// <remarks>
  ///   При установке любого бита статуса фатального состояния блокируются все
  ///   функции СКА.
  /// </remarks>
  TStatusFatalState = set of TFlagsFatalStateDevice;

  /// <summary>
  ///   Статус текущих флагов КСА.
  /// </summary>
  TStatusCurrentFlags = set of TCurrentFlagsDevice;

//  TTypeDocument = set of TTypeDocumentDevice;
//  TStateDocument = set of TStateDocumentDevice;

  /// <summary>
  ///   Статус документа.
  /// </summary>
  TStatusDocument = record
    /// <summary>
    ///   Тип текущего открытого документа.
    /// </summary>
    ATypeDocument: TTypeDocumentDevice;
    /// <summary>
    ///   Состояние текущего документа.
    /// </summary>
    AStateDocument: TStateDocumentDevice;
  end;


  /// <summary>
  ///   Флаги статуса КСА.
  /// </summary>
  TStatusFlagsDevice = record
    /// <summary>
    ///   Статус фатального состояния КСА.
    /// </summary>
    AStatusFatalState: TStatusFatalState;
    /// <summary>
    ///   Статус текущих флагов.
    /// </summary>
    AStatusCurrentFlags: TStatusCurrentFlags;
    /// <summary>
    ///   Статус документа.
    /// </summary>
    AStatusDocument: TStatusDocument;
  end;


{$REGION 'Структуры для команды "Открыть документ"'}
  /// <summary>
  ///   Режим формирования документа
  /// </summary>
  TModeGenerateDocument = (
                           /// <summary>
                           ///   Обычный режим формирования документа.
                           /// </summary>
                           mgdSimple = 0,
                           /// <summary>
                           ///   Пакетный режим формирования документа.
                           /// </summary>
                           mgdPackage = 1
                          );

  /// <summary>
  ///   Режим печати реквизитов.
  /// </summary>
  TModePrintRequsite = (
                        /// <summary>
                        ///   Обычный режим печати реквизитов.
                        /// </summary>
                        mprSimple = 0,
                        /// <summary>
                        ///   Режим отложенной печати реквизитов.
                        /// </summary>
                        mprDelay = 1
                       );

  TOpenDocument = record
    /// <summary>
    ///   Тип документа.
    /// </summary>
    ATypeDocument: TTypeDocumentDevice;
    /// <summary>
    ///   Режим формирования документа.
    /// </summary>
    AModeGenerateDocument: TModeGenerateDocument;
    /// <summary>
    ///   Режим печати реквезитов.
    /// </summary>
    AModePrintRequsite: TModePrintRequsite;
    ANumDepartment: Integer;
    ANameOperator: string;
    ANumDocument: integer;
  end;
{$ENDREGION}

{$REGION 'Структуры для команды "Завершить документ"'}
  TResultCompleteDocument = record
    ANumDocument: Integer;
    ACounterOperating: string;
  end;
{$ENDREGION}

{$REGION 'Структуры для команды "Печать текста"'}

  /// <summary>
  ///   Шрифты
  /// </summary>
  TPiritFont = (
                /// <summary>
                ///   Шрифт 13х24.
                /// </summary>
                pf13_24 = 0,
                /// <summary>
                ///   Шрифт 10х24.
                /// </summary>
                pf10_24 = 1,
                /// <summary>
                ///   Шрифт 13х24 Pirit жирный.
                /// </summary>
                pf13_24_pirit_bold = 2,
                /// <summary>
                ///   Шрифт 10х20 Pirit жирный.
                /// </summary>
                pf10_20_pirit_bold = 3,
                /// <summary>
                ///   Шрифт 8х14.
                /// </summary>
                pf8_14 = 4,
                /// <summary>
                ///   Шрифт 24х45.
                /// </summary>
                pf24_45 = 5,
                /// <summary>
                ///   Шрифт 24х45 жирный.
                /// </summary>
                pf24_45_bold = 6,
                /// <summary>
                ///   Шрифт 13х24 Pirit.
                /// </summary>
                pf13_24_pirit = 7,
                /// <summary>
                ///   Шрифт 10х20 Pirit.
                /// </summary>
                pf10_20_pirit = 8
               );

  /// <summary>
  ///   Размеры печати текста.
  /// </summary>
  TPiritTextSize = (
                    /// <summary>
                    ///   Печать двойной высоты текста.
                    /// </summary>
                    pfsDoubleHeight = 4,
                    /// <summary>
                    ///   Печать двойной ширины текста.
                    /// </summary>
                    pfsDoubleWight = 5
                   );

  TPiritTextSizeSet = set of TPiritTextSize;

  /// <summary>
  ///   Аттрибуты печати текста.
  /// </summary>
  TAttributeText = record
    /// <summary>
    ///   Шрифт.
    /// </summary>
    AFont: TPiritFont;
    /// <summary>
    ///   Размер текста.
    /// </summary>
    ATextSize: TPiritTextSizeSet;

  end;

{$ENDREGION}

{$REGION 'Структуры для команды "Добавить товарную позицию"'}
  TProductPosition = record
    ANameProduct: string[56];
    ABarcodePosition: string[18];
    ACountProduct: double;
    APriceProduct: double;
    ANumTax: integer;
    ANumProductPosition: string[4];
    ANumSection: integer;
  end;
{$ENDREGION}

{$REGION 'Стуктуры для команды "Скидка на чек"'}
  TPiritTypeDisMark = (
                        tdmPercentage = 0,
                        tdmAmount = 1
                       );
{$ENDREGION}

{$REGION 'Стуктуры для команды "Печать реквизита"'}
  TPiritRequisite = record
    ACode: integer;
    AAttributeText: TAttributeText;
    AText1: string[56];
    AText2: string[56];
    AText3: string[56];
    AText4: string[56];
  end;

{$ENDREGION}

{$REGION 'Структуры для команды "Запрос сменных счетчиков и регистров"'}
  TResultCountChecksByTransactionType = record
    ASales: integer;
    ARefund: integer;
    AAnnulate: integer;
    ADeferred: integer;
    ADeposite: integer;
    AIssuance: integer;
  end;

  TResultDataLastReport = record
    ACounterOperation: string;
    ANumDocument: integer;
    AAmountCassa: double;
    ACountSales: integer;
    AAmountSales: double;
    ACountRefund: integer;
    AAmountRefund: double;
    ACountAnnulate: integer;
    AAmountAnnulate: double;
    ACountDeposite: integer;
    AAmountDeposite: double;
    ACountIssuance: integer;
    AAmountIssuance: double;
  end;

  TResultDataOrders = record
    ACounterIssued: integer;
    ACounterCancelled: integer;
    ACounterClosed: integer;
    ACounterCorrected: integer;
    AAmountIssued: double;
    AAmountCancelled: double;
    AAmountClosed: double;
    AAmountCorrected: double;
  end;
{$ENDREGION}

{$REGION 'Структуры для команд "чтение/запись таблицы настроек"'}

  TBitMaskSettingPrintDevice = class
  const
    BM_EC_PRINTING = 0;
    BM_FULL_SNIP = 1;
    BM_PRINT_LOGO = 2;
    BM_PRINT_VERT_LINES = 3;
  end;

  TBitMaskSettingCheck = class
  const
    _SIZE_NUM_DESIGN_CHECK = 5;
  const
    BM_NUM_DESIGN_CHECK = 0;
    BM_NUMBERING_OF_CHECKS_EXT = 7;
  end;

  TBitMaskSettingReportZ = class
  const
    BM_PRINT_AMOUNT_COMUL_SHIFT = 0;
    BM_PRINT_AMOUNT_COMUL = 1;
    BM_NO_PRINT_UNUSED_PAYMENT = 5;
    BM_PRINT_DATETIME_BEGIN_SHIFT = 6;
    BM_PRINT_SECTIONS = 7;
  end;

  TBitMaskSettingExtDevice = class
  const
    BM_MONEYBOX_OPEN_FISCAL_DEVICE = 0;
  end;

  TBitMaskSettingCalculation = class
  const
    BM_AUTOMATIC_COLLECTION = 0;
    BM_CASH_MANAGEMENT = 1;
    BM_IGNORE_ANNULLATED_CHECKS = 2;
  end;

  TBitMaskSettingTax = class
  const
    BM_PRINT_TAX_REPORT = 0;
    BM_PRINT_TAX_CHECK = 1;
    BM_PRINT_ZERO_TAX_AMOUNTS = 2;
    BM_ROUND_AMOUNT_TAX = 3;
  end;

{$ENDREGION}

{$REGION 'Структуры для команды "Запрос данных по чеку"'}

  /// <summary>
  ///   Счетчики текущего документа.
  /// </summary>
  TCountersCurrentDocument = record
    /// <summary>
    ///   Сумма чека.
    /// </summary>
    AmountCheck: double;
    /// <summary>
    ///   Сумма скидки по чеку.
    /// </summary>
    AmountDiscount: double;
    /// <summary>
    ///   Сумма наценки по чеку.
    /// </summary>
    AmountMarkUp: double;
  end;

  /// <summary>
  ///   Данные по последнему закрытому чеку.
  /// </summary>
  TDataLastClosedCheck = record
    /// <summary>
    ///   Тип чека.
    /// </summary>
    /// <remarks>
    ///   Для отмененных = 0.
    /// </remarks>
    TypeDocument: TTypeDocumentDevice;
    /// <summary>
    ///   Текущий операционный счетчик.
    /// </summary>
    CounterCurrentOperation: string;
    /// <summary>
    ///   Номер чека.
    /// </summary>
    NumberCheck: integer;
    /// <summary>
    ///   Номер документа.
    /// </summary>
    NumberDocument: integer;
    /// <summary>
    ///   Сумма чека.
    /// </summary>
    AmountCheck: double;
    /// <summary>
    ///   Сумма скидки по чеку.
    /// </summary>
    AmountDiscount: double;
    /// <summary>
    ///   Сумма наценки по чеку.
    /// </summary>
    AmountMarkUp: double;
  end;


{$ENDREGION}

{$REGION 'Структуры для команды "Печатать штрих-код"'}

  /// <summary>
  ///   Опции вывода (для линейных кодов).
  /// </summary>
  TBarCodeOutOption = (
                       /// <summary>
                       ///   Не выводить.
                       /// </summary>
                       bcoNotOutput       = 0,
                       /// <summary>
                       ///   Вывести наверху штрих-кода.
                       /// </summary>
                       bcoAtTop           = 1,
                       /// <summary>
                       ///   Вывести внизу штрих-кода.
                       /// </summary>
                       bcoAtButtom        = 2,
                       /// <summary>
                       ///   Вывести наверху и внизу штрих-кода.
                       /// </summary>
                       bcoAtTopAndButtom  = 3
                      );

  TBarCodeType = (
                  UPC_A = 0,
                  UPC_E = 1,
                  EAN_13 = 2,
                  EAN_8 = 3,
                  CODE_39 = 4,
                  INTERLEAVED_2of5 = 5,
                  CODEBAR = 6,
                  QR_CODE = 8,
                  CODE_128 = 9
                 );

const
   PDF_417 = 7;

{$ENDREGION}


{$REGION 'Структуры для команды "Запрос сведений по КЛ"'}
type
  /// <summary>
  ///   Номера первого и последнего документа смены.
  /// </summary>
  TFirstLastNumDoc = record
    /// <summary>
    ///   Номер первого документа в смене.
    /// </summary>
    AFirstNumDoc: Integer;
    /// <summary>
    ///   Номер последнего документа в смене.
    /// </summary>
    ALastNumDoc: Integer;
  end;


  {$REGION 'Структуры данных'}
    const
      CS_START_STRUCTURE = AnsiChar(#$01);
    type
      ArrayOfAnsiChar = array of AnsiChar;
      TDocStructureType = (
                           stOpenDoc            = UInt8(1),  //Open
                           stCloseDoc           = UInt8(2),  //Close
                           stCloseRequsitesDoc  = UInt8(3),  //Close
                           stCancelDoc          = UInt8(4),  //Close
                           stAddPosition        = UInt8(5),  //Item
                           stDiscount           = UInt8(6),  //Discount
                           stMarkup             = UInt8(7),  //Discount
                           stPayment            = UInt8(8),  //Payment
                           stSubTotal           = UInt8(9),  //Total
                           stTotal              = UInt8(10), //Total
                           stDelivery           = UInt8(11), //Total
                           stCashInOut          = UInt8(12), //CashinOut
                           stCashInMoneyBox     = UInt8(13), //Total
                           stExtRequsites       = UInt8(14), //Recv
                           stTotalDiscount      = UInt8(15), //Total
                           stTotalMarkup        = UInt8(16), //Total
                           stNameTaxSection     = UInt8(17), //Recv
                           stTax                = UInt8(18)  //Tax
                          );


      TSignCorrection = (
                          scNotCorrection = UInt8(0),
                          scCorrection    = UInt8(1)
                        );
      TSignPosition  = (
                          sposCheck     = UInt8(0),
                          sposPosition  = UInt8(1)
                       );
      TSignPercentage = (
                          sperPercentage = UInt8(0),
                          sperAbsolute   = UInt8(1)
                        );

      TDocStructDate = packed record // размер 7 байт.
        ADay    : UInt8;                   // 1 байт
        AMonth  : UInt8;                   // 1 байт
        AYear   : UInt16;                  // 2 байта
        AHour   : UInt8;                   // 1 байт
        AMin    : UInt8;                   // 1 байт
        ASec    : UInt8;                   // 1 байт
      end;

      TDocStructOpen = packed record // размер 48 байт. CRC = 83
        ADocStructType  : TDocStructureType;         // 1 байт
        ADocType        : TTypeDocumentDevice;       // 1 байт
        ANumOperator    : UInt16;                    // 2 байта
        ANumDepartment  : UInt16;                    // 2 байта
        ANumCheck       : UInt32;                    // 4 байта
        ANumShift       : UInt16;                    // 2 байта
        ANumDoc         : UInt32;                    // 4 байта
        ADate           : TDocStructDate;            // 7 байт
        ANameOperator   : array[0..23] of AnsiChar;  // 24 байта
        ACRC            : UInt8;                     // 1 байт //Сумма всех предыдущих байт структуры + 0x35
      end;

      TDocStructClose = packed record // размер 29 байт. CRC = 64
        ADocStructType  : TDocStructureType;     // 1 байт
        ASumma          : UInt64;                 // 8 байт //8-ми байтовое число с фиксированной на четвертом знаке десятичной точкой (10000 = 1 рубль)
        ADate           : TDocStructDate;        // 7 байт
        AID             : array[0..11] of UInt8;     // 12 байт
        ACRC            : UInt8;                  // 1 байт
      end;

      TDocStructItem = packed record // размер 112 байт. CRC = 147
        ADocStructType  : TDocStructureType;     // 1 байт
        ASignCorrection : UInt8;                  // 1 байт //Коррекция, если поле не равно "0"
        AAmount         : UInt64;                 // 8 байт
        ACount          : UInt64;                 // 8 байт
        ASumma          : UInt64;                 // 8 байт
        ANumPosition    : array[0..4] of AnsiChar;  // 5 байт
        AArticle        : array[0..18] of AnsiChar; // 19 байт
        AName           : array[0..56] of AnsiChar; // 57 байт
        ANumSection    : UInt16;                  // 2 байта
        ANumTax         : UInt16;                  // 2 байта
        ACRC            : UInt8;                  // 1 байт
      end;

      TDocStructTotal = packed record // размер 11 байт. CRC = 46
        ADocStructType  : TDocStructureType;      // 1 байт
        ADocType        : TTypeDocumentDevice;    // 1 байт    //TTypeDocumentDevice ???
        ASumma          : UInt64;                 // 8 байт
        ACRC            : UInt8;                  // 1 байт
      end;

      TDocStructDiscount = packed record // размер 60 байт. CRC = 95
        ADocStructType  : TDocStructureType;        // 1 байт
        ASignPosition   : UInt8;                     // 1 байт  //Если поле равно "0" - на чек, иначе - скидка/наценка на позицию.
        ASignPecentage  : UInt8;                     // 1 байт  //Если поле равно "0" - процентная, иначе - абсолютная.
        ASignCorrection : UInt8;                     // 1 байт  //Коррекция скидки, если поле не равно "0".
        AName           : array[0..38] of AnsiChar; // 39 байт
        APercentage     : UInt64;                    // 8 байт  //для абсолютных скидок/наценок поле не используется
        ASumma          : UInt64;                    // 8 байт
        ACRC            : UInt8;                     // 1 байт
      end;

      TDocStructPayment = packed record // размер 74 байта. CRC = 109
        ADocStructType  : TDocStructureType;        // 1 байт
        ANamePayment    : array[0..44] of AnsiChar; // 45 байт
        ATypePayment    : array[0..18] of AnsiChar; // 19 байт
        ASumma          : UInt64;                    // 8 байт
        ACRC            : UInt8;                     // 1 байт
      end;

      TDocStructCashInOut = packed record // размер 55 байт. CRC = 90
        ADocStructType  : TDocStructureType;        // 1 байт
        AName           : array[0..44] of AnsiChar; // 45 байт
        ASumm           : UInt64;                    // 8 байт
        ACRC            : UInt8;                     // 1 байт
      end;

      TDocStructRecv = packed record // размер 78 байт. CRC = 113
        ADocStructType  : TDocStructureType;        // 1 байт
        AAttributePrint : UInt8;                     // 1 байт
        ASignLineFeed   : UInt8;                     // 1 байт
        AText           : array[0..73] of AnsiChar; // 74 байта
        ACRC            : UInt8;                     // 1 байт
      end;

      TDocStructTax = packed record // размер 39 байт. CRC = 74
        ADocStructType  : TDocStructureType;        // 1 байт
        ANumTax         : UInt16;                     // 2 байта
        AName           : array[0..18] of AnsiChar; // 19 байт
        APercentage     : UInt64;                    // 8 байт
        ASumma          : UInt64;                    // 8 байт
        ACRC            : UInt8;                     // 1 байт
      end;


      PDocStructDate      = ^TDocStructDate;
      PDocStructOpen      = ^TDocStructOpen;
      PDocStructClose     = ^TDocStructClose;
      PDocStructItem      = ^TDocStructItem;
      PDocStructTotal     = ^TDocStructTotal;
      PDocStructDiscount  = ^TDocStructDiscount;
      PDocStructPayment   = ^TDocStructPayment;
      PDocStructCashInOut = ^TDocStructCashInOut;
      PDocStructRecv      = ^TDocStructRecv;
      PDocStructTax       = ^TDocStructTax;
  {$ENDREGION}


{$ENDREGION}


{$REGION 'Структуры для команд управлением внешних устройств'}
  TStateMoneyBox = (
                    smmClosed = 0,
                    smmOpened = 1
                   );
{$ENDREGION}

{$REGION 'Стурктуры для системных команд'}
  TDataExchangeRate = (
                      der_4800   = 0,
                      der_9600   = 1,
                      der_19200  = 2,
                      der_38400  = 3,
                      der_57600  = 4,
                      der_115200 = 5
                      );
{$ENDREGION}

{$REGION 'Команды'}
type
  /// <summary>
  ///   Команды КСА.
  /// </summary>
  CMDPirit = class

  {$REGION 'Команды получения данных о КСА'}
  const
    /// <summary>
    ///   Запрос флагов статуса КСА.
    /// </summary>
    CMD_GET_STATUS_FLAGS = '00';
  const
    /// <summary>
    ///   Запрос сменных счетчиков и регистров.
    /// </summary>
    CMD_GET_INTERCHANGEABLE_COUNTERS_AND_REGISTERS = '01';
  const
    /// <summary>
    ///   Запрос сведений о КСА.
    /// </summary>
    CMD_GET_INFO_FISCAL_REGISTER = '02';
  const
    /// <summary>
    ///   Запрос данных по чеку.
    /// </summary>
    CMD_GET_DATA_BY_CHECK = '03';
  const
    /// <summary>
    ///   Запрос состояния печатающего устройства.
    /// </summary>
    CMD_GET_STATE_PRINTING_DEVICE = '04';
  const
    /// <summary>
    ///   Запрос сервисной информации.
    /// </summary>
    CMD_GET_SERVICE_INFO = '05';
  const
    /// <summary>
    ///   Запрос дополнительной информации о ошибках.
    /// </summary>
    CMD_GET_INFO_EXT_ERRORS = '06';
  {$ENDREGION}

  {$REGION 'Команды настройки параметров КСА'}
  const
    /// <summary>
    ///   Начало работы с КСА.
    /// </summary>
    CMD_SFR_BEGIN_WORK = '10';
  const
    /// <summary>
    ///   Чтение таблицы настроек.
    /// </summary>
    CMD_SFR_READ_TABLE_SETTINGS = '11';
  const
    /// <summary>
    ///   Запись таблицы настроек.
    /// </summary>
    CMD_SFR_WRITE_TABLE_SETTINGS = '12';
  const
    /// <summary>
    ///   Чтение даты/времени КСА.
    /// </summary>
    CMD_SFR_READ_DATETIME = '13';
  const
    /// <summary>
    ///   Запись даты/времени КСА.
    /// </summary>
    CMD_SFR_WRITE_DATETIME = '14';
  const
    /// <summary>
    ///   Программировать логотип.
    /// </summary>
    CMD_SFR_PROGRAMMING_LOGOTYPE = '15';
  const
    /// <summary>
    ///   Удалить логотип.
    /// </summary>
    CMD_SFR_DELETE_LOGOTYPE = '16';
  const
    /// <summary>
    ///   Загрузить дизайн чека.
    /// </summary>
    CMD_SFR_LOAD_DESIGN_CHECK = '17';
  {$ENDREGION}

  {$REGION 'Команды основных операций'}
  const
    /// <summary>
    ///   Распечатать отчет без гашения (X-отчет).
    /// </summary>
    CMD_MOP_PRINT_REPORT_X = '20';
  const
    /// <summary>
    ///   Распечатать отчет с гашением (Z-отчет).
    /// </summary>
    CMD_MOP_PRINT_REPORT_Z = '21';
  const
    /// <summary>
    ///   Распечатать буфер контрольной ленты.
    /// </summary>
    CMD_MOP_PRINT_BUFFER_CONTROL_TAPE = '22';
  const
    /// <summary>
    ///   Открыть смену.
    /// </summary>
    CMD_MOP_OPEN_SHIFT = '23';
  const
    /// <summary>
    ///   Открыть смену.
    /// </summary>
    /// <remarks>
    ///   Только для использования сервисным инженером.
    /// </remarks>
    CMD_MOP_OPEN_SHIFT_SERVICE = '24';
  const
    /// <summary>
    ///   Открыть документ.
    /// </summary>
    CMD_MOP_OPEN_DOCUMENT = '30';
  const
    /// <summary>
    ///   Завершить документ.
    /// </summary>
    CMD_MOP_FINALLY_DOCUMENT = '31';
  const
    /// <summary>
    ///   Отменить документ.
    /// </summary>
    CMD_MOP_CANCEL_DOCUMENT = '32';
  const
    /// <summary>
    ///   Аннулировать документ.
    /// </summary>
    CMD_MOP_ANNULATE_DOCUMENT = '35';
  const
    /// <summary>
    ///   Печать текста.
    /// </summary>
    CMD_MOP_PRINT_TEXT = '40';
  const
    /// <summary>
    ///   Печатать штрих-код.
    /// </summary>
    CMD_MOP_PRINT_BARCODE = '41';
  const
    /// <summary>
    ///   Добавить товарную позицию.
    /// </summary>
    CMD_MOP_ADD_PRODUCT_POSITION = '42';
  const
    /// <summary>
    ///   Коррекция товарной позиции.
    /// </summary>
    CMD_MOP_CORRECT_PRODUCT_POSITION = '43';
  const
    /// <summary>
    ///   Подитог.
    /// </summary>
    CMD_MOP_SUBTOTAL = '44';
  const
    /// <summary>
    ///   Скидка на чек.
    /// </summary>
    CMD_MOP_DISCOUNT_ON_CHECK = '45';
  const
    /// <summary>
    ///   Наценка на чек.
    /// </summary>
    CMD_MOP_MARKUP_ON_CHECK = '46';
  const
    /// <summary>
    ///   Оплата.
    /// </summary>
    CMD_MOP_PAYMENT = '47';
  const
    /// <summary>
    ///   Внесение/выдача суммы.
    /// </summary>
    CMD_MOP_IN_OUT_AMOUNT = '48';
  const
    /// <summary>
    ///   Печать реквизита.
    /// </summary>
    CMD_MOP_PRINT_REQUISITE = '49';
  const
    /// <summary>
    ///   Сравнить сумму по чеку.
    /// </summary>
    CMD_MOP_COMPARE_AMOUNT_CHECK = '52';
  const
    /// <summary>
    ///   Обнулить наличные в денежном ящике.
    /// </summary>
    CMD_MOP_SET_ZERO_MONEY_BOX = '54';
  {$ENDREGION}

  {$REGION 'Команды для работы с БЭП'}
  const
    /// <summary>
    ///   Регистрация/Перерегистрация.
    /// </summary>
    CMD_BEP_REGISTRATION_BEP = '60';
  const
    /// <summary>
    ///   Распечатать отчет по данным из БЭП.
    /// </summary>
    CMD_BEP_PRINT_REPORT_BEP = '62';
  {$ENDREGION}

  {$REGION 'Команды для работы с КЛ'}
  const
    /// <summary>
    ///   Распечатать документ из КЛ.
    /// </summary>
    CMD_KL_PRINT_DOCUMENTS_KL = '70';
  const
    /// <summary>
    ///   Получить на ПК документы из КЛ.
    /// </summary>
    CMD_KL_GET_DOCUMENTS_KL = '71';
  const
    /// <summary>
    ///   Запрос сведений по КЛ.
    /// </summary>
    CMD_KL_GET_INFO_KL = '72';
  {$ENDREGION}

  {$REGION 'Команды управления внешними устройствами'}
  const
    /// <summary>
    ///   Открыть денежный ящик.
    /// </summary>
    CMD_EXD_OPEN_MONEY_BOX = '80';
  const
    /// <summary>
    ///   Получить статус денежного ящика.
    /// </summary>
    CMD_EXD_GET_STATUS_MONEY_BOX = '81';
  const
    /// <summary>
    ///   Подача звукового сигнала.
    /// </summary>
    CMD_EXD_SEND_SOUND_SIGNAL = '82';
  {$ENDREGION}

  {$REGION 'Системные команды'}
  const
    /// <summary>
    ///   Авторизация КСА.
    /// </summary>
    CMD_SYS_AUTORIZATION_FISCAL_REGISTER = '90';
  const
    /// <summary>
    ///   Чтение блока памяти КСА.
    /// </summary>
    CMD_SYS_READ_BLOCK_MEMORY = '91';
  const
    /// <summary>
    ///   Чтение ПО БЭП.
    /// </summary>
    CMD_SYS_READ_PO_BEP = '92';
  const
    /// <summary>
    ///   Установить скорость обмена.
    /// </summary>
    CMD_SYS_SET_EXCHANGE_SPEED = '93';
  const
    /// <summary>
    ///   Распечатать сервисные данные.
    /// </summary>
    CMD_SYS_PRINT_SERVICE_DATA = '94';
  const
    /// <summary>
    ///   Распечатать данные о состоянии СКНО.
    /// </summary>
    CMD_SYS_PRINT_STATE_SKNO = '96';
  const
    /// <summary>
    ///   Аварийное закрытие смены.
    /// </summary>
    CMD_SYS_CLOSE_SHIFT_EMERGENCY = 'A0';
  const
    /// <summary>
    ///   Печать копии последнего Z-отчета.
    /// </summary>
    CMD_SYS_PRINT_LAST_REPORT_Z = 'A1';
  {$ENDREGION}

  {$REGION 'Специальные команды'}
  const
    /// <summary>
    ///   Прервать выполнение отчета.
    /// </summary>
    CMD_SPC_ABORT_REPORT = AnsiChar(#$18); //CAN
  const
    /// <summary>
    ///   Проверка связи.
    /// </summary>
    CMD_SPC_CONNECTIONCHECK = AnsiString('ENQ'); //ENQ
  const
    /// <summary>
    ///   Промотка бумаги.
    /// </summary>
    CMD_SPC_PROMOTION_PAPER = AnsiChar(#$0A); //LF
  {$ENDREGION}

  end;
{$ENDREGION}

{$REGION 'Запросы'}
    /// <summary>
    ///   Запросы сменных счетчиков и регистров.
    /// </summary>
    REQCountersAndRegisters = class
    const
      REQ_NUM_CURRENT_SHIFT = '1';
    const
      REQ_NUM_NEXT_CHECK = '2';
    const
      REQ_AMOUNT_SALES_BY_PAYMENTS = '3';
    const
      REQ_COUNT_PAYMNET_BY_SALES = '4';
    const
      REQ_AMOUNT_REFUNDS_BY_PAYMENTS = '5';
    const
      REQ_COUNT_PAYMENTS_BY_REFUNDS = '6';
    const
      REQ_COUNT_ISSUED_CHECKS_BY_TRANSACTION_TYPE = '7';
    const
      REQ_AMOUNT_ISSUED_CHECKS = '8';
    const
      REQ_AMOUNT_DISCOUNTS_MARKUP = '9';
    const
      REQ_AMOUNT_TAX_BY_SALES = '10';
    const
      REQ_AMOUNT_TAX_BY_REFUNDS = '11';
    const
      REQ_DATA_LAST_REPORT_XZ = '12';
    const
      REQ_AMOUNT_SECTIONS_BY_SALES = '13';
    const
      REQ_AMOUNT_SECTIONS_BY_REFUNDS = '14';
    const
      REQ_DATA_ORDERS = '15';
    end;

    /// <summary>
    ///   Запросы сведений о КСА.
    /// </summary>
    REQInfoDevice = class
    const
      /// <summary>
      ///   Вернуть заводской номер КСА.
      /// </summary>
      REQ_NUM_FACTORY = '1';
    const
      /// <summary>
      ///   Вернуть идентификатор прошивки.
      /// </summary>
      REQ_ID_FIRMWARE = '2';
    const
      /// <summary>
      ///   Вернуть УНП.
      /// </summary>
      /// <remarks>
      ///   УНП (Учетный Номер Плательщика) - единый уникальный номер,
      ///   присваиваемый каждому плательщику при потановке на учет в налоговом
      ///   органе РБ.
      /// </remarks>
      REQ_NUM_PAYER_ACCOUNT = '3';
    const
      /// <summary>
      ///   Регистрационный номер КСА.
      /// </summary>
      REQ_NUM_REGISTRATION = '4';
    const
      /// <summary>
      ///   Вернуть дату и время последней операции в БЭП.
      /// </summary>
      REQ_DATETIME_LAST_OPERATION_BEP = '5';
    const
      /// <summary>
      ///   Вернуть дату регистрации/перерегистрации.
      /// </summary>
      REQ_DATE_REGISTRATION = '6';
    const
      /// <summary>
      ///   Вернуть сумму наличных в денежном ящике.
      /// </summary>
      REQ_AMOUNT_CASH_MONEY_BOX = '7';
    const
      /// <summary>
      ///   Вернуть номер следующего документа.
      /// </summary>
      REQ_NUM_NEXT_DCOUMENT = '8';
    const
      /// <summary>
      ///   Вернуть номер смены регистрации/перерегистрации.
      /// </summary>
      REQ_NUM_SHIFT_REGISTRATION = '9';
    const
      /// <summary>
      ///   Вернуть номер следующего X-отчета.
      /// </summary>
      REQ_NUM_NEXT_REPORT_X = '10';
    const
      /// <summary>
      ///   Вернуть текущий операционный счетчик.
      /// </summary>
      REQ_СOUNTER_CURRENT_OPERATING = '11';
    const
      /// <summary>
      ///   Вернуть нарастающий итог.
      /// </summary>
      REQ_TOTAL_CUMULATIVE = '12';
    const
      /// <summary>
      ///   Вернуть количество свободных смен в БЭП.
      /// </summary>
      REQ_COUNT_FREE_SHIFTS_BEP = '13';
    end;

    /// <summary>
    ///   Запросы данных по чеку.
    /// </summary>
    REQDataCheck = class
    const
      /// <summary>
      ///   Вернуть счетчики текущего документа.
      /// </summary>
      REQ_COUNTER_CURRENT_DOCUMENT = '1';
    const
      /// <summary>
      ///   Вернуть данные по последнему закрытому чеку.
      /// </summary>
      REQ_DATA_LAST_CLOSED_CHECK = '2';
    end;

    /// <summary>
    ///   Запросы сервисной информации.
    /// </summary>
    REQServiceInfo = class
    const
      /// <summary>
      ///   Вернуть напряжение питания (мВ).
      /// </summary>
      REQ_VOLTAGE_POWER = '1';
    const
      /// <summary>
      ///   Вернуть температуру термологовки.
      /// </summary>
      REQ_TEMPERATURE_TERMALHEAD = '2';
    const
      /// <summary>
      ///   Вернуть количество отрезов резчика.
      /// </summary>
      REQ_COUNT_SNIP = '3';
    const
      /// <summary>
      ///   Вернуть ресурс термоголовки.
      /// </summary>
      REQ_RESOURCE_TERMALHEAD = '4';
    const
      /// <summary>
      ///   Обнулить количество отрезов резчика.
      /// </summary>
      REQ_SET_ZERO_COUNT_SNIP = '5';
    const
      /// <summary>
      ///   Обнулить ресурс термоголовки.
      /// </summary>
      REQ_SET_ZERO_RESOURCE_TERMALHEAD = '6';
    const
      /// <summary>
      ///   Вернуть напряжение на батарейке (мВ).
      /// </summary>
      REQ_VOLTAGE_BATTERY = '7';
    const
      /// <summary>
      ///   Вернуть количество отрезов резчика (необнуляемое).
      /// </summary>
      REQ_COUNT_SNIP_NN = '8';
    const
      /// <summary>
      ///   Вернуть ресурс термоголовки (необнуляемое).
      /// </summary>
      REQ_RESOURCE_TERMALHEAD_NN = '9';
    end;

    REQTableSetting = class
    const
      REQ_PARAM_PRINT_DEVICE = 1;
      REQ_PARAM_CHECK = 2;
      REQ_PARAM_REPORT_Z = 3;
      REQ_PARAM_EXT_DEVICE = 4;
      REQ_PARAM_CALCULATION = 5;
      REQ_PARAM_PRINT_CALC_TAX = 6;
      REQ_PARAM_ROUND_VALUE = 7;
      REQ_PARAM_LOGICAL_NUMBER = 10;
      REQ_PARAM_EXT_CELL = 11;
      REQ_PARAM_PRINT_SETTING = 12;
      REQ_PARAM_PASS = 20;
      REQ_PARAM_COMPANY_INFO = 30;
      REQ_PARAM_TEXT_END_CHECK = 31;
      REQ_PARAM_NAMES_PAYMENTS_TYPES = 32;
      REQ_PARAM_NAMES_TAX = 40;
      REQ_PARAM_RATE_TAX = 41;
      REQ_PARAM_NAME_GROUP_TAX = 42;
      REQ_PARAM_NAMES_SECTIONS = 50;
      REQ_PARAM_NAME_GROUP_SECTION = 51;
      REQ_PARAM_NAME_REQUISITE = 52;
      REQ_PARAM_SERVICE_CENTER_REQUISITE = 54;
    end;

{$ENDREGION}


{$REGION 'Константы отладчика'}

type
  CS_OUT_DEBUG = class
  const
    CORRECT_FACTORY_NUM_DEVICE      = '[Warning Fiscal Pirit |CMD: AuthorizationDevice|]: The line size with the factory number device is greater than 12. Corrected from "%s" to "%s"';
    CORRECT_COUNT_BYTES_GREATER     = '[Warning Fiscal Pirit |CMD: ReadMemory...|]: The count bytes is greater than 64. Corrected from "%d" to "%d"';
    CORRECT_COUNT_BYTES_LESS        = '[Warning Fiscal Pirit |CMD: ReadMemory...|]: The count bytes is less than 1. Corrected from "%d" to "%d"';
    CORRECT_TEXT_END_CHECK          = '[Warning Fiscal Pirit |CMD: TextEndCheck|]: The line size with the text is greater than 44. Corrected from "%s" to "%s"';
    CORRECT_NAME_PAYMENT_TYPE       = '[Warning Fiscal Pirit |CMD: NamePaymentType|]: The line size with the text is greater than 18. Corrected from "%s" to "%s"';
    CORRECT_NAME_SECTION            = '[Warning Fiscal Pirit |CMD: NameSection|]: The line size with the text is greater than 44. Corrected from "%s" to "%s"';
    CORRECT_NAME_REQUISITE          = '[Warning Fiscal Pirit |CMD: NameRequisite|]: The line size with the text is greater than 30. Corrected from "%s" to "%s"';
    CORRECT_SERVICE_CENTER_REQ      = '[Warning Fiscal Pirit |CMD: ServiceCenterRequisite|]: The line size with the text is greater than 44. Corrected from "%s" to "%s"';
  end;

{$ENDREGION}



implementation

end.
