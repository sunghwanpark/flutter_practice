import 'dart:async';
import 'package:bunyang/Abstract/IErrorCallBack.dart';
import 'package:bunyang/Map/MyGoogleMapPresenter.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MyGoogleMap extends StatefulWidget
{
  MyGoogleMap(
    this.title,
    this.address,
    {
      double titleSize = 25
    })
  : mapTitleSize = titleSize;

  final String title;
  final String address;
  final double mapTitleSize;

  @override
  State<StatefulWidget> createState() => MyGoogleMapView(this.title, this.address);
}

class MyGoogleMapView extends State<MyGoogleMap> implements IErrorCallBack
{
  MyGoogleMapView(this.title, this.address);

  final String title;
  final String address;
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _googleMapController;
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
      icon: BitmapDescriptor.defaultMarker,
      consumeTapEvents: true
    ));
    setState(() => loadingState = LoadingState.DONE);
  }

  void onError(dynamic err)
  {
    assert(() 
    {
      print(err);
      print(StackTrace.current);
      return true;
    }());
    
    setState(() => loadingState = LoadingState.ERROR);
  }

  void _onMapCreated(GoogleMapController controller) 
  {
    _controller.complete(controller);
    _googleMapController = controller;
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
          child: Column
          (
            children: <Widget>
            [
              Row
              (
                children : <Widget>
                [
                  Icon(Icons.location_on, color: Colors.black),
                  SizedBox(width: 10),
                  Text(title, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: widget.mapTitleSize, fontFamily: 'TmonTium'))
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
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 300,
                child: GoogleMap
                (
                  onMapCreated: _onMapCreated,
                  markers: _markers,
                  initialCameraPosition: CameraPosition
                  (
                    target: _center,
                    zoom: 16.0,
                  ),
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>
                  [
                    new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
                  ].toSet(),
                  mapToolbarEnabled: false,
                  scrollGesturesEnabled: true,
                  myLocationButtonEnabled: false
                )
              ),
              Align
              (
                alignment: Alignment.topCenter,
                child: IconButton
                (
                  icon: Icon(Icons.location_on, color: Colors.red, semanticLabel: "원래위치로"),
                  alignment: Alignment.topRight,
                  onPressed: ()
                  {
                    if(_controller.isCompleted)
                    {
                      _googleMapController.animateCamera
                      (
                        CameraUpdate.newCameraPosition
                        (
                          CameraPosition
                          (
                            target: _center,
                            zoom: 16.0
                          ),
                        )
                      );
                    }
                  },
                ),
              )
            ],
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

class MyGoogleMapViewLatLtd extends StatelessWidget
{
  MyGoogleMapViewLatLtd(
    this._title, 
    this._address, 
    this._latLng,
    {
      double titleSize = 25
    }) : _mapTitleSize = titleSize
  {
    _markers.add(Marker
    (
      markerId: MarkerId(_latLng.toString()),
      position: _latLng,
      icon: BitmapDescriptor.defaultMarker,
      consumeTapEvents: true
    ));
  }

  final String _title;
  final String _address;
  final LatLng _latLng;
  final double _mapTitleSize;
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _googleMapController;
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) 
  {
    _controller.complete(controller);
    _googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) 
  {
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
                Text(_title, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: _mapTitleSize, fontFamily: 'TmonTium'))
              ]
            ),
            this._address.isNotEmpty ? AutoSizeText
            (
              this._address,
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
                  target: _latLng,
                  zoom: 10.0,
                ),
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>
                [
                  new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
                ].toSet(),
                mapToolbarEnabled: false,
                scrollGesturesEnabled: true,
                myLocationButtonEnabled: false
              )
            ),
            Align
            (
              alignment: Alignment.topCenter,
              child: IconButton
              (
                icon: Icon(Icons.location_on, color: Colors.red, semanticLabel: "원래위치로"),
                alignment: Alignment.topRight,
                onPressed: ()
                {
                  if(_controller.isCompleted)
                  {
                    _googleMapController.animateCamera
                    (
                      CameraUpdate.newCameraPosition
                      (
                        CameraPosition
                        (
                          target: _latLng,
                          zoom: 10.0
                        ),
                      )
                    );
                  }
                },
              ),
            )
          ]
        )
      )
    );
  }
}

class MyGoogleMapWidget extends StatelessWidget
{
  MyGoogleMapWidget(this._latLng)
  {
    _markers.add(Marker
    (
      markerId: MarkerId(_latLng.toString()),
      position: _latLng,
      icon: BitmapDescriptor.defaultMarker,
      consumeTapEvents: true
    ));
  }

  final LatLng _latLng;
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _googleMapController;
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) 
  {
    _controller.complete(controller);
    _googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      width: MediaQuery.of(context).size.width,
      child: Padding
      (
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row
        (
          children : <Widget>
          [
            Container
            (
              height: 500,
              child: GoogleMap
              (
                onMapCreated: _onMapCreated,
                markers: _markers,
                initialCameraPosition: CameraPosition
                (
                  target: _latLng,
                  zoom: 15.0,
                ),
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>
                [
                  new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
                ].toSet(),
                mapToolbarEnabled: false,
                scrollGesturesEnabled: true,
                myLocationButtonEnabled: false
              )
            ),
            Align
            (
              alignment: Alignment.topCenter,
              child: IconButton
              (
                icon: Icon(Icons.location_on, color: Colors.red, semanticLabel: "원래위치로"),
                alignment: Alignment.topRight,
                onPressed: ()
                {
                  if(_controller.isCompleted)
                  {
                    _googleMapController.animateCamera
                    (
                      CameraUpdate.newCameraPosition
                      (
                        CameraPosition
                        (
                          target: _latLng,
                          zoom: 15.0
                        ),
                      )
                    );
                  }
                },
              ),
            )
          ]
        )
      )
    );
  }
}