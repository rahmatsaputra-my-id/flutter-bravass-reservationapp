import 'package:flutter/material.dart';

class PlanetRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: new Stack(
        children: <Widget>[
          planetCard,
          planetThumbnail,
        ],
      ),
    );
  }

  final planetThumbnail = new Container(
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
