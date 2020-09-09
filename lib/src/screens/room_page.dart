import 'dart:convert';
import 'package:bravass_development/src/blocs/bloc_room.dart';
import 'package:bravass_development/src/models/room_model.dart';
import 'package:bravass_development/src/screens/room_detail.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    roomBloc.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roomBloc.fetchAllRoom();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder<RoomModel>(
        stream: roomBloc.allRoom,
        builder: (context, AsyncSnapshot<RoomModel> snapshot) {
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

  Widget buildList(AsyncSnapshot<RoomModel> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.result.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomDetailPage(
                    result: snapshot.data.result[index],
                  ),
                ),
              );
            },
            child: new Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: new Stack(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 55.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  snapshot.data.result[index].room,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[],
                          ),
                          Container(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                  snapshot.data.result[index].description,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  maxLines: 3,
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    height: 124,
                    margin: EdgeInsets.only(left: 46),
                    decoration: new BoxDecoration(
                        color: Colors.black12,
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.circular(8),
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: new Offset(0.0, 10),
                          )
                        ]),
                  ),
                  new Container(
                    margin: new EdgeInsets.symmetric(vertical: 16),
                    alignment: FractionalOffset.centerLeft,
                    child: ClipOval(
                        child: snapshot.data.result[index].foto == null
                            ? Image.asset(
                                "images/bravasslogo.jpeg",
                                width: 92,
                                height: 92,
                                fit: BoxFit.cover,
                              )
                            : Image.memory(
                                base64Decode(snapshot.data.result[index].foto),
                                width: 92,
                                height: 92,
                                fit: BoxFit.cover,
                              )),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget planetThumbnail = new Container(
    margin: new EdgeInsets.symmetric(vertical: 16),
    alignment: FractionalOffset.centerLeft,
    child: new Image(
      image: new AssetImage('images/mars.png'),
      height: 92,
      width: 92,
    ),
  );

  final planetCard = new Container(
    height: 124,
    margin: EdgeInsets.only(left: 46),
    decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10))
        ]),
  );
}
