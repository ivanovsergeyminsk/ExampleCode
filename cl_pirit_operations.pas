/// <summary>
///   Модуль команд основных операций КСА.
///   <list type="table">
///     <listheader>
///       <term>Код команды (HEX)</term>
///       <description>Название команды</description>
///     </listheader>
///     <item>
///       <term>20</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.PrintReportX(string)">
///         Распечатать отчет без гашения (X-отчет).</see></description>
///     </item>
///     <item>
///       <term>21</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.PrintReportZ(string)">
///         Распечатать отчет с гашением (Z-отчет).</see></description>
///     </item>
///     <item>
///       <term>22</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.PrintBuferControlTape">
///         Распечатать буфер контрольной ленты.</see></description>
///     </item>
///     <item>
///       <term>23</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.OpenShift">
///         Открыть смену.</see></description>
///     </item>
///     <item>
///       <term>30</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.OpenDocument(TOpenDocument)">
///         Открыть документ.</see></description>
///     </item>
///     <item>
///       <term>31</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.CompleteDocument(Boolean)">
///         Завершить документ.</see></description>
///     </item>
///     <item>
///       <term>32</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.CancelDocument">
///         Отменить документ.</see></description>
///     </item>
///     <item>
///       <term>35</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.AnnulateDocument(Integer,TList,string)">
///         Аннулировать документ.</see></description>
///     </item>
///     <item>
///       <term>40</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.PrintText(string,TAttributeText)">
///         Печать текста.</see></description>
///     </item>
///     <item>
///       <term>41</term>
///       <description><b>(TODO)</b> Печатать штрих-код.</description>
///     </item>
///     <item>
///       <term>42</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.ProductPositionAdd(string,string,Double,Double,Integer,string,Integer,string)">
///         Добавить товарную позицию.</see></description>
///     </item>
///     <item>
///       <term>43</term>
///       <description><b>(TODO)</b> Коррекция товарной позиции.</description>
///     </item>
///     <item>
///       <term>44</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.SubTotal">
///         Подитог.</see></description>
///     </item>
///     <item>
///       <term>45</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.Discount(TPiritTypeDisMark,string,Double)">
///         Скидка на чек.</see></description>
///     </item>
///     <item>
///       <term>46</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.Markup(TPiritTypeDisMark,string,Double)">
///         Наценка на чек.</see></description>
///     </item>
///     <item>
///       <term>47</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.Payment(Integer,Double,string)">
///         Оплата.</see></description>
///     </item>
///     <item>
///       <term>48</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.DepIssMoney(string,Double)">
///         Внесение/изъятие суммы.</see></description>
///     </item>
///     <item>
///       <term>49</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.PrintRequisite(TPiritRequisite,Boolean)">
///         Печать реквизита.</see></description>
///     </item>
///     <item>
///       <term>52</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.CompareAmountCheck(Double)">
///         Сравнить сумму по чеку.</see></description>
///     </item>
///     <item>
///       <term>54</term>
///       <description><see cref="cl_pirit_operations|TFiscalPiritMainOperation.SetZeroCounterMoneyBox">
///         Обнулить наличные в денежном ящике.</see></description>
///     </item>
///   </list>
/// </summary>
unit cl_pirit_operations;

interface

uses
  intrf_pirit, cs_pirit, System.Generics.Collections, cl_pirit_base;

type
  /// <summary>
  ///   Класс, реализующий команды основных операций КСА.
  /// </summary>
  TFiscalPiritMainOperation = class(TPiritCustomBase)
  strict private
    function _CorrectNameProduct(AValue: string): string;
    function _CorrectBarcodePosition(AValue: string): string;
    function _CorrectNameOperator(AValue: string): string;

    function _CorrectWidth_PrintBarCode(AValue: Integer): integer;
    function _CorrectHeight_PrintBarCode(AValue: integer): Integer;
  public
    /// <summary>
    ///   Распечатать отчет без гашения (X-отчет).
    /// </summary>
    /// <param name="ANameOperator">
    ///   Код и/или имя оператора.
    /// </param>
    procedure PrintReportX(ANameOperator: string);
    /// <summary>
    ///   Распечатать отчет с гашением (Z-отчет).
    /// </summary>
    /// <param name="ANameOperator">
    ///   Код и/или имя оператора.
    /// </param>
    procedure PrintReportZ(ANameOperator: string);
    /// <summary>
    ///   Распечатать буфер контрольной ленты.
    /// </summary>
    procedure PrintBuferControlTape;

    /// <summary>
    ///   Открыть смену.
    /// </summary>
    procedure OpenShift;
    /// <summary>
    ///   Открыть смену.
    /// </summary>
    /// <param name="ANameOperator">
    ///   Код и/или имя оператора.
    /// </param>
    /// <param name="ATypeDevice">
    ///   Тип оборудования.
    /// </param>
    /// <remarks>
    ///   Данная команда предназначена только для использования сервисным
    ///   инженером через сервисную утилиту, в случае возникновения нештатной
    ///   ситуации.
    /// </remarks>
    procedure OpenShift_Service(ANameOperator: string; ATypeDevice: TTypeDevice);

    /// <summary>
    ///   Открыть документ.
    /// </summary>
    /// <remarks>
    ///   <para>
    ///     Эта команда открывает новый документ и переводит КСА в режим
    ///     ввода документа.
    ///   </para>
    ///   <para>
    ///     После успешного выполнения этой команды во внутренней переменной
    ///     "статуса документа" устанавливается соответствующий тип текущего
    ///     документа. Этот статус можно получить по команде "Запрос флагов
    ///     статуса КСА".
    ///   </para>
    /// </remarks>
    procedure OpenDocument(AOpenDocument: TOpenDocument);
    /// <summary>
    ///   Завершить документ.
    /// </summary>
    /// <param name="AClip">
    ///   Флаг отрезки.
    /// </param>
    /// <remarks>
    ///   Если параметр "Флаг отрезки" = TRUE, отрезка документа по завершению
    ///   не выполняется (выполняется только для сервисных документов).
    /// </remarks>
    function CompleteDocument(AClip: boolean): TResultCompleteDocument;
    /// <summary>
    ///   Отменить документ.
    /// </summary>
    /// <remarks>
    ///   Эта команда прерывает формирование текущего документа, данные
    ///   удалаются из оперативной памяти КСА и печатается сообщение об отмене.
    /// </remarks>
    procedure CancelDocument;
    /// <summary>
    ///   Аннулировать документ.
    /// </summary>
    /// <param name="ANumDocument">
    ///   Номер аннулируемого документа.
    /// </param>
    /// <param name="AAmountList">
    ///   Список сумм по типам оплаты. ( <b>максимальное кол-во 16</b>)
    /// </param>
    /// <param name="ANameOperator">
    ///   Код и/или имя оператора.
    /// </param>
    /// <remarks>
    ///   <para>
    ///     AAmountList - максимальное количество сумм по типам оплаты 16.
    ///   </para>
    ///   <para>
    ///     Выше данного количества игнорируется. <br />
    ///   </para>
    /// </remarks>
    procedure AnnulateDocument(ANumDocument: integer; AAmountList: TList<Double>;
                               ANameOperator: string);

    /// <summary>
    ///   Печать текста.
    /// </summary>
    /// <param name="AText">
    ///   Текст.
    /// </param>
    /// <param name="AAttributeText">
    ///   Атрибуты текста.
    /// </param>
    /// <remarks>
    ///   С помощью данной команды печатается текст внутри открытого сервисного
    ///   документа.
    /// </remarks>
    procedure PrintText(AText: string; AAttributeText: TAttributeText);


    /// <summary>
    ///   Печатать штрих-код.
    /// </summary>
    /// <param name="AOutOption">
    ///   Опции вывода.
    /// </param>
    /// <param name="AWidth">
    ///   Ширина штрих-кода. Значение задается в точках и может быть от 2 до 8.
    /// </param>
    /// <param name="AHeight">
    ///   Высота штрих-кода. Значение задается в точках и может принимать
    ///   значения от 1 до 255 (игнорируется для штрих-кодов: QR_CODE,
    ///   CODE_128).
    /// </param>
    /// <param name="ABarCodeType">
    ///   Тип штрих-кода.
    /// </param>
    /// <param name="ABarCode">
    ///   Штрих-код. Строка содержащая штрих-код, причем контрольная сумма
    ///   может и не указываться. <br />
    /// </param>
    /// <remarks>
    ///   <para>
    ///     С помощью данной команды можно распечатать штрих-код товара
    ///     внутри открытого документа.
    ///   </para>
    ///   <para>
    ///     Для печати штрих-кода PDF417 используйте метод
    ///     PrintBarCode_PDF417.
    ///   </para>
    /// </remarks>
    procedure PrintBarCode(AOutOption: TBarCodeOutOption;
                           AWidth: integer; AHeight: integer;
                           ABarCodeType: TBarCodeType; ABarCode: string);

    /// <summary>
    ///   Печатать штрих-код (PDF417).
    /// </summary>
    /// <param name="AProportions">
    ///   Пропорции высоты/ширины штрих-кода в процентах (по умолчанию 50%).
    /// </param>
    /// <param name="AWidth">
    ///   Ширина штрих-кода. Значение задается в точках и может быть от 2 до 8.
    /// </param>
    /// <param name="AHeight">
    ///   Высота штрих-кода. Значение задается в точках и может принимать
    ///   значения от 1 до 255.
    /// </param>
    /// <param name="ABarCode">
    ///   Штрих-код. Строка содержащая штрих-код, причем контрольная сумма
    ///   может и не указываться.
    /// </param>
    procedure PrintBarCode_PDF417(AProportions: Integer;
                                  AWidth: integer; AHeight: integer;
                                  ABarCode: string);


    /// <summary>
    ///   Добавить товарную позицию.
    /// </summary>
    /// <param name="ANameProduct">
    ///   Название товара.
    /// </param>
    /// <param name="ABarcodePosition">
    ///   Признак и сам штриховой код позиции.
    /// </param>
    /// <param name="ACountProduct">
    ///   Количество товара в товарной позиции.
    /// </param>
    /// <param name="APriceProduct">
    ///   Цена товара по данному артиклу.
    /// </param>
    /// <param name="ANumTax">
    ///   Номер ставки налога.
    /// </param>
    /// <param name="ANumProductPosition">
    ///   Номер товарной позиции.
    /// </param>
    /// <param name="ANumSection">
    ///   Номер секции.
    /// </param>
    /// <param name="ADelimiter">
    ///   Разделитель параметра "Номер товарной позиции" (по умолчанию ":") .
    /// </param>
    /// <remarks>
    ///   <para>
    ///     Эта команда может быть вызвана сразу после открытия чека и может
    ///     повторяться любое количество раз внутри текущего документа для
    ///     отражения всего списка товаров.
    ///   </para>
    ///   <para>
    ///     "Признак и сам штриховой код позиции" (A - не GTIN; B - GTIN; С -
    ///     услуга) - если товар с GTIN, то передавать необходимо: Bxxx, где
    ///     xxx - штриховой код GTIN.
    ///   </para>
    ///   <para>
    ///     Параметры "Номер ставки налога", "Номер секции" и "Номер товарной
    ///     позиции" не являются обязательными и могут отсутствовать.
    ///   </para>
    /// </remarks>
    procedure ProductPositionAdd(ANameProduct: string; ABarcodePosition: string;
                                 ACountProduct: double; APriceProduct: double;
                                 ANumTax: integer; ANumProductPosition: string;
                                 ANumSection: integer; ADelimiter: string = ':'); overload;
    /// <summary>
    ///   Добавить товарную позицию.
    /// </summary>
    /// <param name="ANameProduct">
    ///   Название товара.
    /// </param>
    /// <param name="ABarcodePosition">
    ///   Признак и сам штриховой код позиции.
    /// </param>
    /// <param name="ACountProduct">
    ///   Количество товара в товарной позиции.
    /// </param>
    /// <param name="APriceProduct">
    ///   Цена товара по данному артиклу.
    /// </param>
    /// <param name="ANumTax">
    ///   Номер ставки налога.
    /// </param>
    /// <param name="ANumProductPosition">
    ///   Номер товарной позиции.
    /// </param>
    /// <param name="ADelimiter">
    ///   Разделитель параметра "Номер товарной позиции" (по умолчанию ":") .
    /// </param>
    /// <remarks>
    ///   <para>
    ///     Эта команда может быть вызвана сразу после открытия чека и может
    ///     повторяться любое количество раз внутри текущего документа для
    ///     отражения всего списка товаров.
    ///   </para>
    ///   <para>
    ///     "Признак и сам штриховой код позиции" (A - не GTIN; B - GTIN; С -
    ///     услуга) - если товар с GTIN, то передавать необходимо: Bxxx, где
    ///     xxx - штриховой код GTIN.
    ///   </para>
    ///   <para>
    ///     Параметры "Номер ставки налога", "Номер секции" и "Номер товарной
    ///     позиции" не являются обязательными и могут отсутствовать.
    ///   </para>
    /// </remarks>
    procedure ProductPositionAdd(ANameProduct: string; ABarcodePosition: string;
                                 ACountProduct: double; APriceProduct: double;
                                 ANumTax: integer; ANumProductPosition: string; ADelimiter: string = ':'); overload;
    /// <summary>
    ///   Добавить товарную позицию.
    /// </summary>
    /// <param name="ANameProduct">
    ///   Название товара.
    /// </param>
    /// <param name="ABarcodePosition">
    ///   Признак и сам штриховой код позиции.
    /// </param>
    /// <param name="ACountProduct">
    ///   Количество товара в товарной позиции.
    /// </param>
    /// <param name="APriceProduct">
    ///   Цена товара по данному артиклу.
    /// </param>
    /// <param name="ANumTax">
    ///   Номер ставки налога.
    /// </param>
    /// <remarks>
    ///   <para>
    ///     Эта команда может быть вызвана сразу после открытия чека и может
    ///     повторяться любое количество раз внутри текущего документа для
    ///     отражения всего списка товаров.
    ///   </para>
    ///   <para>
    ///     "Признак и сам штриховой код позиции" (A - не GTIN; B - GTIN; С -
    ///     услуга) - если товар с GTIN, то передавать необходимо: Bxxx, где
    ///     xxx - штриховой код GTIN.
    ///   </para>
    ///   <para>
    ///     Параметры "Номер ставки налога", "Номер секции" и "Номер товарной
    ///     позиции" не являются обязательными и могут отсутствовать.
    ///   </para>
    /// </remarks>
    procedure ProductPositionAdd(ANameProduct: string; ABarcodePosition: string;
                                 ACountProduct: double; APriceProduct: double;
                                 ANumTax: integer); overload;
    /// <summary>
    ///   Добавить товарную позицию.
    /// </summary>
    /// <param name="ANameProduct">
    ///   Название товара.
    /// </param>
    /// <param name="ABarcodePosition">
    ///   Признак и сам штриховой код позиции.
    /// </param>
    /// <param name="ACountProduct">
    ///   Количество товара в товарной позиции.
    /// </param>
    /// <param name="APriceProduct">
    ///   Цена товара по данному артиклу.
    /// </param>
    /// <remarks>
    ///   <para>
    ///     Эта команда может быть вызвана сразу после открытия чека и может
    ///     повторяться любое количество раз внутри текущего документа для
    ///     отражения всего списка товаров.
    ///   </para>
    ///   <para>
    ///     "Признак и сам штриховой код позиции" (A - не GTIN; B - GTIN; С -
    ///     услуга) - если товар с GTIN, то передавать необходимо: Bxxx, где
    ///     xxx - штриховой код GTIN.
    ///   </para>
    ///   <para>
    ///     Параметры "Номер ставки налога", "Номер секции" и "Номер товарной
    ///     позиции" не являются обязательными и могут отсутствовать.
    ///   </para>
    /// </remarks>
    procedure ProductPositionAdd(ANameProduct: string; ABarcodePosition: string;
                                 ACountProduct: double; APriceProduct: double); overload;


    procedure ProductPositionCorrect(ANameProduct: string; ABarcodePosition: string;
                                     ACountProduct: Double; APriceProduct: integer;
                                     ANumTax: Integer; ANumProductPosition: string;
                                     ANumSection: integer; ADelimiter: string = ':'); overload;

    procedure ProductPositionCorrect(ANameProduct: string; ABarcodePosition: string;
                                     ACountProduct: Double; APriceProduct: integer;
                                     ANumTax: Integer; ANumProductPosition: string; ADelimiter: string = ':'); overload;

    procedure ProductPositionCorrect(ANameProduct: string; ABarcodePosition: string;
                                     ACountProduct: Double; APriceProduct: integer;
                                     ANumTax: Integer); overload;

    procedure ProductPositionCorrect(ANameProduct: string; ABarcodePosition: string;
                                     ACountProduct: Double; APriceProduct: integer); overload;


    /// <summary>
    ///   Подитог.
    /// </summary>
    /// <remarks>
    ///   <para>
    ///     Эта команда заканчивает ввод товаров в чеке. Команда "Подитог"
    ///     может даваться дважды.
    ///   </para>
    ///   <para>
    ///     После первой команды "Подитог" становится невозможно добавлять
    ///     новые позиции в чек. Далее можно установить скидки/наценки на
    ///     весьчек, зарегистрировать суммы налогов, распечатать произвольный
    ///     текст, прервать оформление чека командами "Отложить чек" и
    ///     "Аннулировать чек" или продолжить оформление с использованием
    ///     повторной команды "Подитог" или команды "Оплата".
    ///   </para>
    /// </remarks>
    procedure SubTotal;
    /// <summary>
    ///   Скидка на чек.
    /// </summary>
    /// <param name="AType">
    ///   Тип скидки.
    /// </param>
    /// <param name="AName">
    ///   Название скидки.
    /// </param>
    /// <param name="AValue">
    ///   Процент или сумма скидки.
    /// </param>
    /// <remarks>
    ///   <para>
    ///     Данная команда позволяет устанавливать процентные или абсолютные
    ///     скидки на весь чек. Команда может быть вызвана несколько раз, при
    ///     этом необходимо помнить, что итоговая сумма после применения
    ///     скидки не должна быть отрицательной.
    ///   </para>
    ///   <para>
    ///     Сумма скидки, вычисляемая при процентной скидке, округляется к
    ///     ближайшему целому.
    ///   </para>
    /// </remarks>
    procedure Discount(AType: TPiritTypeDisMark; AName: string; AValue: double);
    /// <summary>
    ///   Наценка на чек.
    /// </summary>
    /// <param name="AType">
    ///   Тип наценки.
    /// </param>
    /// <param name="AName">
    ///   Название наценки.
    /// </param>
    /// <param name="AValue">
    ///   Процент или сумма наценки.
    /// </param>
    /// <remarks>
    ///   Данная команда позволяет устанавливать процентные или абсолютные
    ///   наценки на весь чек. Команда может быть вызвана несколько раз, при
    ///   этом необходимо помнить, что итоговая сумма после отмены наценки не
    ///   должна быть отрицательной.
    /// </remarks>
    procedure Markup(AType: TPiritTypeDisMark; AName: string; AValue: double);
    /// <summary>
    ///   Оплата.
    /// </summary>
    /// <param name="ATypePayment">
    ///   Код типа платежа.
    /// </param>
    /// <param name="AAmount">
    ///   Сумма, принятая от покупателя по данному платежу.
    /// </param>
    /// <param name="AText">
    ///   Дополнительный текст.
    /// </param>
    /// <remarks>
    ///   <para>
    ///     С помощью этой команды производится фиксирование всех
    ///     взаиморасчетов с клиентом с указанием сумм и типов оплаты. При
    ///     первом использовании этой команды в чеке печатается "Итоговая
    ///     сумма", что является окончательной суммой чека. После этого
    ///     производить скидки на чек нельзя.
    ///   </para>
    ///   <para>
    ///     При передаче суммы наличными, больше требуемой, КСА
    ///     самостоятельно рассчитывает сдачу. Сумма по безналичным типам
    ///     платежа (с кодами от 1 до 15), не должна превышать итоговой суммы
    ///     по чеку.
    ///   </para>
    ///   <para>
    ///     Код типа платежа должен соответствовать одному из
    ///     запрограммированных средств оплаты в "Таблице настроек КСА" .
    ///   </para>
    /// </remarks>
    procedure Payment(ATypePayment: integer; AAmount: double; AText: string);
    /// <summary>
    ///   Внесение/выдача денег.
    /// </summary>
    /// <param name="AName">
    ///   Название или тип купюры.
    /// </param>
    /// <param name="AAmount">
    ///   Сумма.
    /// </param>
    /// <remarks>
    ///   <para>
    ///     Команда регистрирует внесение или выдача суммы денег из денежного
    ///     ящика.
    ///   </para>
    ///   <para>
    ///     Команда выполняется после команды "Открыть документ". Если
    ///     производится внесение денег, тип документа должен быть 4, если
    ///     выдача - 5.
    ///   </para>
    ///   <para>
    ///     При этом может быть напечатана информация о купюрах, которые были
    ///     использованы при выполнении данной операции.
    ///   </para>
    /// </remarks>
    procedure DepIssMoney(AName: string; AAmount: double);
    /// <summary>
    ///   Печать реквизита.
    /// </summary>
    /// <param name="ARequisite">
    ///   Запись реквизита.
    /// </param>
    /// <param name="ADontSave">
    ///   Не сохранять реквизит в КЛ.
    /// </param>
    /// <remarks>
    ///   <para>
    ///     С помощью данной команды могут печататься дополнительные
    ///     реквизиты чека, при открытом чеке на продажу, возврат, внесение
    ///     или выдачи.
    ///   </para>
    ///   <para>
    ///     Код реквизиа должен соответствовать одному из запрограммированных
    ///     наименований реквизита в "Таблице настроек КСА". Если значение
    ///     реквизита обесечивает однозначное его толкование, его можно
    ///     распечатать без предварительно запрограммированного наименования,
    ///     с кодомреквизита равным нулю.
    ///   </para>
    ///   <para>
    ///     Значение реквизита может состоять из 4-х строк, при этом 1-я
    ///     строка значения реквизита печатается непосредственно за
    ///     наименованием реквизита в одну строку. Общая длина наименования и
    ///     значения реквизита составляет не более 4-х строк.
    ///   </para>
    ///   <para>
    ///     Если значение реквизита состоит из одной строки и первым символом
    ///     является символ '&amp;', то перевод строки после печати данного
    ///     реквизита не выполняется, можно на следующей строке начать печать
    ///     следующего реквизита.
    ///   </para>
    ///   <para>
    ///     Если реквизит не нужно сохранять в электронной контрольной ленте
    ///     (КЛ), параметр ADontSave должен быть TRUE. <br />
    ///   </para>
    /// </remarks>
    procedure PrintRequisite(ARequisite: TPiritRequisite; ADontSave: boolean);

    /// <summary>
    ///   Сравнить сумму по чеку.
    /// </summary>
    /// <param name="Amount">
    ///   Сумма для сравнения.
    /// </param>
    /// <remarks>
    ///   Команда сравнивает текущую сумму по чеку с переданной в параметре и
    ///   возвращает ошибку "Некорректный формат или параметр команды", если
    ///   суммы не совпадают. Эта команда может быть вызвана после любой
    ///   команды, если документ открыт.
    /// </remarks>
    procedure CompareAmountCheck(Amount: Double);
    /// <summary>
    ///   Обнулить наличные в денежном ящике.
    /// </summary>
    /// <remarks>
    ///   Команда обнуляет счетчик наличных в денежном ящике.
    /// </remarks>
    procedure SetZeroCounterMoneyBox;
  end;



implementation

uses
  cl_pirit_parser, System.SysUtils, Winapi.Windows;

{$REGION 'TFiscalPiritMainOperation'}

procedure TFiscalPiritMainOperation.AnnulateDocument(ANumDocument: integer;
  AAmountList: TList<Double>; ANameOperator: string);
var
  FPiritParam: TPiritParam;
  FResultCMD: TPiritResultCMD;
  I, FCount: integer;
  FCorrectedNameOperator: string;

begin
  FCorrectedNameOperator := Self._CorrectNameOperator(ANameOperator);

  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(ANumDocument.ToString);

  FCount := 16 - AAmountList.Count;
  if FCount < 0 then
    for I := 0 to 15 do
      FPiritParam.Add(AAmountList[i].ToString)
  else
  if FCount = 16 then
    for I := 0 to 15 do
      FPiritParam.Add('0.00')
  else
    begin
      for I := 0 to AAmountList.Count - 1 do
        FPiritParam.Add(AAmountList[i].ToString);

      for I := AAmountList.Count to AAmountList.Count + FCount-1 do
        FPiritParam.Add('0.00');
    end;

  FPiritParam.Add(FCorrectedNameOperator);


  FResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_ANNULATE_DOCUMENT,
                                            FPiritParam);

  FPiritParam.Free;
  FResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.CancelDocument;
var
  FResultCMD: TPiritResultCMD;
begin
  FResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_CANCEL_DOCUMENT,
                                            nil);

  FResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.CompareAmountCheck(Amount: Double);
var
  FPiritParam: TPiritParam;
  FResultCMD: TPiritResultCMD;
begin
  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(Amount.ToString);

  FResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_COMPARE_AMOUNT_CHECK,
                                            FPiritParam);

  FPiritParam.Free;
  FResultCMD.Free;
end;

function TFiscalPiritMainOperation.CompleteDocument(
  AClip: boolean): TResultCompleteDocument;
var
  FPiritParam: TPiritParam;
  FResultCMD: TPiritResultCMD;
begin
  Result.ANumDocument := 0;
  Result.ACounterOperating := '';
  FPiritParam := TPiritParam.Create;
  if AClip then
    FPiritParam.Add('0')
  else
    FPiritParam.Add('1');

  FResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_FINALLY_DOCUMENT,
                                            FPiritParam);

  if FResultCMD.ErrorNum = 0 then
    begin
      Result.ANumDocument := FResultCMD.PiritParamResult.Items[0].ToInteger;
      Result.ACounterOperating := FResultCMD.PiritParamResult.Items[1];
    end;

  FPiritParam.Free;
  FResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.DepIssMoney(AName: string; AAmount: double);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
begin
  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(AName);
  FPiritParam.Add(AAmount.ToString);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_IN_OUT_AMOUNT,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.Discount(AType: TPiritTypeDisMark;
  AName: string; AValue: double);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
begin
  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(ord(AType).ToString);
  FPiritParam.Add(AName);
  FPiritParam.Add(AValue.ToString);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_DISCOUNT_ON_CHECK,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.Markup(AType: TPiritTypeDisMark;
  AName: string; AValue: double);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
begin
  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(ord(AType).ToString);
  FPiritParam.Add(AName);
  FPiritParam.Add(AValue.ToString);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_MARKUP_ON_CHECK,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.OpenDocument(AOpenDocument: TOpenDocument);
var
  FPiritParam: TPiritParam;
  FResultCMD: TPiritResultCMD;
  FModeTypeDocument: integer;
begin
  FModeTypeDocument := GenerateTypeModeDocumentValue(AOpenDocument.ATypeDocument,
                                                     AOpenDocument.AModeGenerateDocument,
                                                     AOpenDocument.AModePrintRequsite);
  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(FModeTypeDocument.ToString);
  FPiritParam.Add(AOpenDocument.ANumDepartment.ToString);
  FPiritParam.Add(AOpenDocument.ANameOperator);
  FPiritParam.Add(AOpenDocument.ANumDocument.ToString);

  FResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_OPEN_DOCUMENT,
                                            FPiritParam);

  FPiritParam.Free;
  FResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.OpenShift;
var
  FPiritResultCMD: TPiritResultCMD;
begin
  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_OPEN_SHIFT,
                                                 nil);
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.OpenShift_Service(ANameOperator: string;
  ATypeDevice: TTypeDevice);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
  FCorrectedNameOperator: string;
begin
  FCorrectedNameOperator := Self._CorrectNameOperator(ANameOperator);

  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(FCorrectedNameOperator);
  FPiritParam.Add(Ord(ATypeDevice).ToString);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_OPEN_SHIFT_SERVICE,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.Payment(ATypePayment: integer;
  AAmount: double; AText: string);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
begin
  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(ATypePayment.ToString);
  FPiritParam.Add(AAmount.ToString);
  FPiritPAram.Add(AText);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_PAYMENT,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.PrintBarCode(AOutOption: TBarCodeOutOption;
  AWidth, AHeight: integer; ABarCodeType: TBarCodeType; ABarCode: string);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
  FCorrectedWidth, FCorrectedHeight: integer;

begin
  FCorrectedWidth   := Self._CorrectWidth_PrintBarCode(AWidth);
  FCorrectedHeight  := Self._CorrectHeight_PrintBarCode(AHeight);

  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(ord(AOutOption).ToString);
  FPiritParam.Add(FCorrectedWidth.ToString);


  if ABarCodeType in [UPC_A, UPC_E, EAN_13, EAN_8, CODE_39, INTERLEAVED_2of5, CODEBAR]
  then
    FPiritParam.Add(FCorrectedHeight.ToString)
  else
    FPiritParam.Add('');


  FPiritParam.Add(Ord(ABarCodeType).ToString);
  FPiritParam.Add(ABarCode);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_PRINT_BARCODE,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.PrintBarCode_PDF417(AProportions, AWidth,
  AHeight: integer; ABarCode: string);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
begin
  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(AProportions.ToString);
  FPiritParam.Add(AWidth.ToString);
  FPiritParam.Add(AHeight.ToString);
  FPiritParam.Add(IntToStr(PDF_417));
  FPiritParam.Add(ABarCode);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_PRINT_BARCODE,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.PrintBuferControlTape;
var
  FPiritResultCMD: TPiritResultCMD;
begin

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_PRINT_BUFFER_CONTROL_TAPE,
                                                 nil);
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.PrintReportX(ANameOperator: string);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
  FCorrectedNameOperator: string;
begin
  FCorrectedNameOperator := Self._CorrectNameOperator(ANameOperator);

  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(FCorrectedNameOperator);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_PRINT_REPORT_X,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.PrintReportZ(ANameOperator: string);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
  FCorrectedNameOperator: string;
begin
  FCorrectedNameOperator := Self._CorrectNameOperator(ANameOperator);

  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(FCorrectedNameOperator);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_PRINT_REPORT_Z,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.PrintRequisite(ARequisite: TPiritRequisite;
  ADontSave: boolean);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
  FAttributeText, FCodeRequsite: integer;
begin
  if ADontSave then
    FCodeRequsite := SetDontSaveBit(ARequisite.ACode)
  else
    FCodeRequsite := ARequisite.ACode;

  FAttributeText := GenerateAttributeTextValue(ARequisite.AAttributeText);

  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(FCodeRequsite.ToString);
  FPiritParam.Add(FAttributeText.ToString);
  FPiritParam.Add(ARequisite.AText1);
  FPiritParam.Add(ARequisite.AText2);
  FPiritParam.Add(ARequisite.AText3);
  FPiritParam.Add(ARequisite.AText4);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_PRINT_REQUISITE,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.PrintText(AText: string;
  AAttributeText: TAttributeText);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
  FText: string;
  FAttributeText: integer;
begin
  FText := AText;
  Delete(FText, 72, Length(FText));
  FAttributeText := GenerateAttributeTextValue(AAttributeText);

  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(FText);
  FPiritParam.Add(FAttributeText.ToString);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_PRINT_TEXT,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.ProductPositionAdd(ANameProduct,
  ABarcodePosition: string; ACountProduct, APriceProduct: double;
  ANumTax: integer; ANumProductPosition: string; ADelimiter: string = ':');
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
  FDelimiter: string;
  FCorrectedNameProduct: string;
  FCorrectedBarcodePosition: string;
begin
  if ADelimiter.IsEmpty then
    FDelimiter := ':'
  else
    FDelimiter := ADelimiter;

  FCorrectedNameProduct := Self._CorrectNameProduct(ANameProduct);
  FCorrectedBarcodePosition := Self._CorrectBarcodePosition(ABarcodePosition);

  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(FCorrectedNameProduct);
  FPiritParam.Add(FCorrectedBarcodePosition);
  FPiritParam.Add(ACountProduct.ToString);
  FPiritParam.Add(APriceProduct.ToString);
  FPiritParam.Add(ANumTax.ToString);
  FPiritParam.Add(ANumProductPosition+FDelimiter);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_ADD_PRODUCT_POSITION,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.ProductPositionAdd(ANameProduct,
  ABarcodePosition: string; ACountProduct, APriceProduct: double;
  ANumTax: integer; ANumProductPosition: string; ANumSection: integer;
  ADelimiter: string = ':');
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
  FDelimiter: string;

  FCorrectedNameProduct, FCorrectedBarcodePosition: string;
begin
  if ADelimiter.IsEmpty then
    FDelimiter := ':'
  else
    FDelimiter := ADelimiter;

  FCorrectedNameProduct := Self._CorrectNameProduct(ANameProduct);
  FCorrectedBarcodePosition := Self._CorrectBarcodePosition(ABarcodePosition);

  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(FCorrectedNameProduct);
  FPiritParam.Add(FCorrectedBarcodePosition);
  FPiritParam.Add(ACountProduct.ToString);
  FPiritParam.Add(APriceProduct.ToString);
  FPiritParam.Add(ANumTax.ToString);
  FPiritParam.Add(ANumProductPosition+FDelimiter);
  FPiritParam.Add(ANumSection.ToString);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_ADD_PRODUCT_POSITION,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.ProductPositionAdd(ANameProduct,
  ABarcodePosition: string; ACountProduct, APriceProduct: double);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
  FCorrectedNameProduct: string;
  FCorrectedBarcodePosition: string;
begin
  FCorrectedNameProduct := Self._CorrectNameProduct(ANameProduct);
  FCorrectedBarcodePosition := Self._CorrectBarcodePosition(ABarcodePosition);

  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(FCorrectedNameProduct);
  FPiritParam.Add(FCorrectedBarcodePosition);
  FPiritParam.Add(ACountProduct.ToString);
  FPiritParam.Add(APriceProduct.ToString);
  FPiritParam.Add('');
  FPiritParam.Add('');
  FPiritParam.Add('');

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_ADD_PRODUCT_POSITION,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.ProductPositionCorrect(ANameProduct,
  ABarcodePosition: string; ACountProduct: Double; APriceProduct,
  ANumTax: Integer; ANumProductPosition, ADelimiter: string);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
  FDelimiter: string;
begin
  if ADelimiter.IsEmpty then
    FDelimiter := ':'
  else
    FDelimiter := ADelimiter;

  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(ANameProduct);
  FPiritParam.Add(ABarcodePosition);
  FPiritParam.Add(ACountProduct.ToString);
  FPiritParam.Add(APriceProduct.ToString);
  FPiritParam.Add(ANumTax.ToString);
  FPiritParam.Add(ANumProductPosition+FDelimiter);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_CORRECT_PRODUCT_POSITION,
                                                FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.ProductPositionCorrect(ANameProduct,
  ABarcodePosition: string; ACountProduct: Double; APriceProduct,
  ANumTax: Integer; ANumProductPosition: string; ANumSection: integer;
  ADelimiter: string);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
  FDelimiter: string;
begin
  if ADelimiter.IsEmpty then
    FDelimiter := ':'
  else
    FDelimiter := ADelimiter;

  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(ANameProduct);
  FPiritParam.Add(ABarcodePosition);
  FPiritParam.Add(ACountProduct.ToString);
  FPiritParam.Add(APriceProduct.ToString);
  FPiritParam.Add(ANumTax.ToString);
  FPiritParam.Add(ANumProductPosition+FDelimiter);
  FPiritParam.Add(ANumSection.ToString);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_CORRECT_PRODUCT_POSITION,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.ProductPositionCorrect(ANameProduct,
  ABarcodePosition: string; ACountProduct: Double; APriceProduct: integer);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
begin
  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(ANameProduct);
  FPiritParam.Add(ABarcodePosition);
  FPiritParam.Add(ACountProduct.ToString);
  FPiritParam.Add(APriceProduct.ToString);
  FPiritParam.Add('');
  FPiritParam.Add('');
  FPiritParam.Add('');

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_CORRECT_PRODUCT_POSITION,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.ProductPositionCorrect(ANameProduct,
  ABarcodePosition: string; ACountProduct: Double; APriceProduct,
  ANumTax: Integer);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
begin
  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(ANameProduct);
  FPiritParam.Add(ABarcodePosition);
  FPiritParam.Add(ACountProduct.ToString);
  FPiritParam.Add(APriceProduct.ToString);
  FPiritParam.Add(ANumTax.ToString);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_CORRECT_PRODUCT_POSITION,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.ProductPositionAdd(ANameProduct,
  ABarcodePosition: string; ACountProduct, APriceProduct: double;
  ANumTax: integer);
var
  FPiritParam: TPiritParam;
  FPiritResultCMD: TPiritResultCMD;
  FCorrectedNameProduct: string;
  FCorrectedBarcodePosition: string;
begin
  FCorrectedNameProduct := Self._CorrectNameProduct(ANameProduct);
  FCorrectedBarcodePosition := Self._CorrectBarcodePosition(ABarcodePosition);

  FPiritParam := TPiritParam.Create;
  FPiritParam.Add(FCorrectedNameProduct);
  FPiritParam.Add(FCorrectedBarcodePosition);
  FPiritParam.Add(ACountProduct.ToString);
  FPiritParam.Add(APriceProduct.ToString);
  FPiritParam.Add(ANumTax.ToString);

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_ADD_PRODUCT_POSITION,
                                                 FPiritParam);
  FPiritParam.Free;
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.SetZeroCounterMoneyBox;
var
  FPiritResultCMD: TPiritResultCMD;
begin

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_SET_ZERO_MONEY_BOX,
                                                 nil);
  FPiritResultCMD.Free;
end;

procedure TFiscalPiritMainOperation.SubTotal;
var
  FPiritResultCMD: TPiritResultCMD;
begin

  FPiritResultCMD := Self.Owner.PiritExecuteCMD(CMDPirit.CMD_MOP_SUBTOTAL,
                                                 nil);
  FPiritResultCMD.Free;
end;

function TFiscalPiritMainOperation._CorrectBarcodePosition(
  AValue: string): string;
var
  FLen: integer;
begin
  FLen := Length(AValue);
  if FLen > 18
  then
    begin
      Result := AValue.Remove(18);
      OutputDebugString(PWideChar(Format('[Warning Fiscal Pirit |CMD: ProductPosition...|]: The line size with the barcode is greater than 18. Corrected from "%s" to "%s"', [AValue, Result])));
    end
  else
    Result := AValue;
end;

function TFiscalPiritMainOperation._CorrectHeight_PrintBarCode(
  AValue: integer): Integer;

begin
  if AValue < 1
  then
    begin
      Result := 1;
      OutputDebugString(PWideChar(Format('[Warning Fiscal Pirit |CMD: PrintBarCode|]: The height is less than 1. Corrected from %d to 1', [AValue])));
    end
  else
    if AValue > 255
    then
      begin
        Result := 255;
        OutputDebugString(PWideChar(Format('[Warning Fiscal Pirit |CMD: PrintBarCode|]: The height value is greater than 255. Corrected from %d to 255', [AValue])));
      end
    else
      Result := AValue;
end;

function TFiscalPiritMainOperation._CorrectNameOperator(AValue: string): string;
begin
  if Length(AValue) > 25
  then
    begin
      Result := AValue.Remove(25);
      OutputDebugString(PWideChar(Format('[Warning Fiscal Pirit |CMD: ...|]: The operator name "%s" contains more than 25 characters (the string is truncated).', [AValue])));
    end
  else
    Result := AValue
end;

function TFiscalPiritMainOperation._CorrectNameProduct(AValue: string): string;
var
  FLen: integer;
begin
  FLen := Length(AValue);
  if FLen > 56
  then
    begin
      Result := AValue.Remove(56);
      OutputDebugString(PWideChar(Format('[Warning Fiscal Pirit |CMD: ProductPosition...|]: The line size with the product name is greater than 56. Corrected from "%s" to "%s"', [AValue, Result])));
    end
  else
    Result := AValue;
end;

function TFiscalPiritMainOperation._CorrectWidth_PrintBarCode(
  AValue: Integer): integer;

begin
  if AValue < 2
  then
    begin
      Result := 2;
      OutputDebugString(PWideChar(Format('[Warning Fiscal Pirit |CMD: PrintBarCode|]: The width is less than 2. Corrected from %d to 2', [AValue])));
    end
  else
    if AValue > 8
    then
      begin
        Result := 8;
        OutputDebugString(PWideChar(Format('[Warning Fiscal Pirit |CMD: PrintBarCode|]: The width value is greater than 8. Corrected from %d to 8', [AValue])));
      end
    else
      Result := AValue;
end;

{$ENDREGION}

end.
