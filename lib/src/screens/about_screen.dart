import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final Set<Marker> _markers = {};

  final LatLng _currentPosition = LatLng(-6.222546, 106.821381);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.add(
      Marker(
        markerId: MarkerId("-6.222546, 106.821381"),
        position: _currentPosition,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Colors.black, Colors.white30],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return ListView(
      children: <Widget>[
        Container(
          color: Colors.black54,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  ClipOval(
                      child: InkWell(
                    onTap: () {},
                    child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.black,
                        child: Image.asset("images/bravasspngputih.png")),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Bravass Creative Space',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Contact Details',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Card(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 8, bottom: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 8.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Email',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  'info@bravass.space',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: Text(
                                  'Phone Number',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  '(+62) 81919567567',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: Text(
                                  'Address',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  'Lotte Shopping Avenue Level 5 05B, Jl. Prof. Dr. Satrio Kav 3 – 5 Jakarta Selatan 12940',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                height: 200,
                                width: 200,
                                child: GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                      target: _currentPosition, zoom: 14.0),
                                  markers: _markers,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Copyright © 2019 - Bravass Creative Space. All rights reserved.\n App Version: 1.0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
