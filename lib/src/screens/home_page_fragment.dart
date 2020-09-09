import 'dart:convert';

import 'package:bravass_development/src/blocs/bloc_room.dart';
import 'package:bravass_development/src/models/room_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageFragment extends StatefulWidget {
  @override
  _HomePageFragmentState createState() => _HomePageFragmentState();
}

class _HomePageFragmentState extends State<HomePageFragment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roomBloc.fetchAllRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          whatsAppOpen();
        },
        label: Text('Call Us'),
        icon: Icon(Icons.phone),
      ),
      body: StreamBuilder<RoomModel>(
          stream: roomBloc.allRoom,
          builder: (context, AsyncSnapshot<RoomModel> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      CarouselSlider(
                          autoPlay: true,
                          aspectRatio: 16 / 16,
                          height: 200,
                          viewportFraction: 1.0,
                          items: <Widget>[
                            for (var i = 0;
                                i < snapshot.data.result.length;
                                i++)
                              Container(
                                decoration: BoxDecoration(color: Colors.black),
                                child: snapshot.data.result[i].foto == null
                                    ? Container(
                                        color: Colors.black,
                                      )
                                    : new Image.memory(
                                        base64Decode(
                                            snapshot.data.result[i].foto),
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                      ),
                              )
                          ]),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 10, left: 16),
                        child: Text(
                          'About Bravass',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Text(
                          'Bravass menyediakan tempat yang nyaman untuk pertemuan, tempat kerja, dan hiburan. Kantor kami yang berdedikasi menawarkan tempat kerja yang nyaman dan ruang bersama kami melayani komunitas kreatif untuk mengeksplorasi peluang bisnis dan kolaborasi mereka. Bravass berusaha untuk memberikan suasana kerja yang baru dan kreatif. Bravass menyediakan berbagai ruang kerja seperti kantor yang dilayani, meja khusus, dan meja fleksibel untuk tim beranggotakan 1 - 50. Revolusi Kreatif adalah inti dari Bravass yang memungkinkan kolaborasi dari berbagai komunitas dan media untuk menyediakan ruang produktif terbaik untuk pekerjaan kreatif Anda.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  void whatsAppOpen() async {
    String phone = "6281919567567";
    var whatsappUrl =
        "whatsapp://send?phone=$phone&text=Hi, can you tell me the detail about bravass ?";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : Fluttertoast.showToast(
            msg: "Aplikasi Whatsapp Belum Terinstall ",
            timeInSecForIos: 2,
          );
  }
}
