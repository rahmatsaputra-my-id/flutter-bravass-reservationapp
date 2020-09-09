import 'dart:math';

import 'package:bravass_development/src/blocs/bloc_invoice.dart';
import 'package:bravass_development/src/helper/helper.dart';
import 'package:bravass_development/src/models/invoice_model.dart';
import 'package:bravass_development/src/screens/detail_screen_invoice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    invoiceBloc.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getidMember().then((idMember) {
      invoiceBloc.fetchAllInvoice(idMember);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<InvoiceModel>(
        stream: invoiceBloc.allInvoice,
        builder: (context, AsyncSnapshot<InvoiceModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  static Color randomColor() {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
  }

  Widget buildList(AsyncSnapshot<InvoiceModel> snapshot) {
    if (snapshot.data.result == null) {
      return Center(
        child: Text('Upss, Belum ada Invoice untuk Anda'),
      );
    } else {
      return ListView.builder(
          itemCount: snapshot.data.result.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailScreenInvoice(
                              result: snapshot.data.result[index],
                            )));
              },
              child: Card(
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            keteranganWidget("Invoice Id"),
                            titikWidget(),
                            dataWidget(
                                'INV-' + snapshot.data.result[index].idInvoice),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            keteranganWidget("Room"),
                            titikWidget(),
                            dataWidget(snapshot.data.result[index].room),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            keteranganWidget("Transaction Date"),
                            titikWidget(),
//                      dd-MM-yyyy').format(DateTime.parse(snapshot.data.result[index].transactionDate
                            dataWidget(DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(snapshot
                                    .data.result[index].transactionDate))),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            keteranganWidget("Payment Status"),
                            titikWidget(),
//                      dd-MM-yyyy').format(DateTime.parse(snapshot.data.result[index].transactionDate
                            dataWidget(snapshot.data.result[index].statusBayar),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            keteranganWidget("Total"),
                            titikWidget(),
//                      dd-MM-yyyy').format(DateTime.parse(snapshot.data.result[index].transactionDate
                            dataWidget(HelperFunction.numberCurrency(
                                double.parse(
                                    snapshot.data.result[index].jumlah))),
                          ],
                        ),
                      ],
                    ),
                  )),
            );
          });
    }
  }

  Widget keteranganWidget(String keterangan) {
    return Expanded(
      child: Container(
        child: Text(keterangan),
      ),
      flex: 4,
    );
  }

  Widget titikWidget() {
    return Expanded(
      child: Container(
        child: Text(':'),
      ),
      flex: 1,
    );
  }

  Widget dataWidget(String data) {
    return Expanded(
      child: Container(
        child: Text(data),
      ),
      flex: 5,
    );
  }

  Future<String> getidMember() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String idMember = sharedPreferences.getString("id_member");
    return idMember;
  }

//  static String numberCurrency(double nomor){
//    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
//        amount: nomor,
//        settings: MoneyFormatterSettings(
//            symbol: 'Rp.',
//            thousandSeparator: '.',
//            decimalSeparator: ',',
//            symbolAndNumberSeparator: ' ',
//            fractionDigits: 2,
//            compactFormatType: CompactFormatType.short
//        )
//    );
//
//    return fmf.output.symbolOnLeft.toString();
//  }
}
