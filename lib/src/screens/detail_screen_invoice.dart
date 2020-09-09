import 'package:bravass_development/src/helper/helper.dart';
import 'package:bravass_development/src/models/invoice_model.dart';
import 'package:flutter/material.dart';

class DetailScreenInvoice extends StatelessWidget {
  final Result result;

  DetailScreenInvoice({Key key, @required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("id Member " + result.idMember);
    print("Member Name " + result.namaMember);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Detail Invoice'),
      ),
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            margin: EdgeInsets.only(top: 10),
            child: Card(
                margin: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 8.0,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          alignment: Alignment.center,
                          color: Colors.black,
                          child: Image.asset('images/bravasspngputih.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
//                              isi('INV-'+result.idInvoice),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Invoice ID',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'INV-' + result.idInvoice,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Container(
                                          height: 1.0,
                                          width: 1.0,
                                          color: Colors.white30,
                                          margin: const EdgeInsets.only(
                                              right: 10.0, top: 10),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Transaction Date',
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                        ),
                                        Text(
                                          result.transactionDate,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Container(
                                          height: 1.0,
                                          width: 1.0,
                                          color: Colors.white30,
                                          margin: const EdgeInsets.only(
                                              right: 10.0, top: 10),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              viewMarginRightTop10(),
                              judulDeskripsi("Member Name"),
                              isi(result.namaMember),
                              viewMarginRightTop10(),
                              judulDeskripsi("Room"),
                              isi(result.room),
                              viewMarginRightTop10(),
                              judulDeskripsi("Tenant Name"),
                              isi(result.namaTenant),
                              viewMarginRightTop10(),
                              judulDeskripsi("Tenant Address"),
                              isi(result.alamatUnit),
                              viewMarginRightTop10(),
                              judulDeskripsi("Period"),
                              isi(result.periode),
                              viewMarginRightTop10(),

                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Unit Price',
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                        ),
                                        Text(
                                          HelperFunction.numberCurrency(
                                              double.parse(result.price)),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Container(
                                          height: 1.0,
                                          width: 1.0,
                                          color: Colors.white30,
                                          margin: const EdgeInsets.only(
                                              right: 10.0, top: 10),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Duration',
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                        ),
                                        Text(
                                          result.quantity,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Container(
                                          height: 1.0,
                                          width: 1.0,
                                          color: Colors.white30,
                                          margin: const EdgeInsets.only(
                                              right: 10.0, top: 10),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Extra Charge',
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                        ),
                                        Text(
                                          result.charge.isEmpty
                                              ? "0"
                                              : HelperFunction.numberCurrency(
                                                  double.parse(result.charge)),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Container(
                                          height: 1.0,
                                          width: 1.0,
                                          color: Colors.white30,
                                          margin: const EdgeInsets.only(
                                              right: 10.0, top: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              viewMarginRightTop10(),
                              judulDeskripsi("Extra Charge Description"),
                              isi(result.description),
                              viewMarginRightTop10(),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Before VAT',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        Text(
                                          HelperFunction.numberCurrency(
                                              double.parse(result.total)),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Container(
                                          height: 1.0,
                                          width: 1.0,
                                          color: Colors.white30,
                                          margin: const EdgeInsets.only(
                                              right: 10.0, top: 10),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'VAT 10%',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        Text(
                                          HelperFunction.numberCurrency(
                                              double.parse(result.ppn)),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Container(
                                          height: 1.0,
                                          width: 1.0,
                                          color: Colors.white30,
                                          margin: const EdgeInsets.only(
                                              right: 10.0, top: 10),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'After VAT',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        Text(
                                          HelperFunction.numberCurrency(
                                              double.parse(result.jumlah)),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Container(
                                          height: 1.0,
                                          width: 1.0,
                                          color: Colors.white30,
                                          margin: const EdgeInsets.only(
                                              right: 10.0, top: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              viewMarginRightTop10(),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Due Date',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        Text(
                                          result.tglTempoByr,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Container(
                                          height: 1.0,
                                          width: 1.0,
                                          color: Colors.white30,
                                          margin: const EdgeInsets.only(
                                              right: 10.0, top: 10),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Payment Total',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        Text(
                                          HelperFunction.numberCurrency(
                                              double.parse(result.jumlahBayar)),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Container(
                                          height: 1.0,
                                          width: 1.0,
                                          color: Colors.white30,
                                          margin: const EdgeInsets.only(
                                              right: 10.0, top: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              viewMarginRightTop10(),
                              judulDeskripsi("Payment Status"),
                              isi(result.statusBayar),
                              viewMarginRightTop10(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Payer',
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                        ),
                                        Text(
                                          result.pembayar,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Container(
                                          height: 1.0,
                                          width: 1.0,
                                          color: Colors.white30,
                                          margin: const EdgeInsets.only(
                                              right: 10.0, top: 10),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Employee',
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                        ),
                                        Text(
                                          result.petugas,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        new Container(
                                          height: 1.0,
                                          width: 1.0,
                                          color: Colors.white30,
                                          margin: const EdgeInsets.only(
                                              right: 10.0, top: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ]),
      ),
    );
  }

  Widget viewMarginRightTop10() {
    return Container(
      height: 1.0,
      width: 1.0,
      color: Colors.white30,
      margin: const EdgeInsets.only(right: 10.0, top: 10),
    );
  }

  Widget judulDeskripsi(String judul) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Text(
          judul,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ));
  }

  Widget marginTop8() {
    return Container(
        margin: EdgeInsets.only(
      top: 8,
    ));
  }

  Widget isi(String isi) {
    return Text(
      isi,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
