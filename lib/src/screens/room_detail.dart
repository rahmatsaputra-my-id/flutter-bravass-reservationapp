import 'dart:convert';

import 'package:bravass_development/src/models/room_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomDetailPage extends StatelessWidget {
  final Result result;

  const RoomDetailPage({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text(result.room),
      ),
      body: ListView(children: <Widget>[
        SizedBox(
            height: isPortrait
                ? MediaQuery.of(context).size.height * 0.35
                : MediaQuery.of(context).size.height * 0.9,
            child: result.foto == null
                ? Image.asset(
                    "images/bravasslogo.jpeg",
                    fit: BoxFit.fill,
                  )
                : Image.memory(base64Decode(result.foto), fit: BoxFit.fill)),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Card(
            margin: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8.0,
            child: Padding(
              padding: EdgeInsets.all(25),
              child: ListView(
                children: <Widget>[
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        result.room,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          result.description,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
