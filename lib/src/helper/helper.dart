import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class HelperFunction {
  static String numberCurrency(double nomor) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: nomor,
        settings: MoneyFormatterSettings(
            symbol: 'Rp.',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 0,
            compactFormatType: CompactFormatType.short));
    return fmf.output.symbolOnLeft.toString();
  }
}
