import 'package:bunyang/Map/MyGoogleMapModel.dart';
import 'package:bunyang/Map/MyGoogleMapView.dart';

class MyGoogleMapPresenter
{
  MyGoogleMapModel _model;
  final MyGoogleMapView _view;

  MyGoogleMapPresenter(this._view)
  {
    _model = new MyGoogleMapModel();
  }

  void onRequestLatLng(String address)
  {
    _model
      .fetchGeocode(address)
      .then((res) => _view.onLatLngComplete(res))
      .catchError((onError) => _view.onError(onError));
  }
}