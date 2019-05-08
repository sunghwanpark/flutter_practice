import 'dart:async';
import 'package:bunyang/Map/MyGoogleMapPresenter.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MyGoogleMap extends StatefulWidget
{
  MyGoogleMap(this.title, this.address);

  final String title;
  final String address;

  @override
  State<StatefulWidget> createState() => MyGoogleMapView(this.title, this.address);
}

class MyGoogleMapView extends State<MyGoogleMap>
{
  MyGoogleMapView(this.title, this.address);

  final String title;
  final String address;
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  MyGoogleMapPresenter _presenter;
  LatLng _center;
  LoadingState loadingState = LoadingState.LOADING;

  @override
  void initState() 
  {
    _presenter = new MyGoogleMapPresenter(this);

    super.initState();
    _presenter.onRequestLatLng(address);
  }

  void onLatLngComplete(Tuple2<double, double> res)
  {
    _center = LatLng(res.item1, res.item2);
    _markers.add(Marker
    (
      markerId: MarkerId(_center.toString()),
      position: _center,
      icon: BitmapDescriptor.defaultMarker
    ));
    setState(() => loadingState = LoadingState.DONE);
  }

  void onError()
  {
    setState(() => loadingState = LoadingState.ERROR);
  }

  void _onMapCreated(GoogleMapController controller) 
  {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) 
  {
    switch(loadingState)
    {
      case LoadingState.DONE:
        return Container
        (
          width: MediaQuery.of(context).size.width,
          child: Padding
          (
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column
            (
              children : <Widget>
              [
                Row
                (
                  children : <Widget>
                  [
                    Icon(Icons.location_on, color: Colors.black),
                    SizedBox(width: 10),
                    Text(title, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium'))
                  ]
                ),
                this.address.isNotEmpty ? AutoSizeText
                (
                  this.address,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium')
                ) : SizedBox(),
                Container
                (
                  height: 300,
                  child: GoogleMap
                  (
                    onMapCreated: _onMapCreated,
                    markers: _markers,
                    initialCameraPosition: CameraPosition
                    (
                      target: _center,
                      zoom: 16.0,
                    )
                  )
                )
              ]
            )
          )
        );
      case LoadingState.ERROR:
        return myText("맵을 불러오지 못했습니다");
      case LoadingState.LOADING:
        return Container
        (
          alignment: Alignment.center,
          child: CircularProgressIndicator(backgroundColor: Colors.black)
        );
      default:
        return Container();
    }
  }
}