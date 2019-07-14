import 'package:bunyang/MenuItem/MenuItemPresenter.dart';
import 'package:bunyang/MenuItem/Store/Bid/StoreBidModel.dart';
import 'package:bunyang/MenuItem/Store/Bid/StoreBidView.dart';

class StoreBidPresenter extends MenuItemPresenter<StoreBidModel>
{
  StoreBidPresenter(StoreBidViewWidget view) : super(StoreBidModel(), view);
  
  void onRequestDefaultData(Map<String, String> params)
  {
    model
      .fetchData(params)
      .then((res) => (view as StoreBidViewWidget).onResponseDefaultData(res))
      .catchError((err) => view.onError(err));
  }

  void onRequestAttachmentData(Map<String, String> params)
  {
    model
      .fetchAttachmentData(params)
      .then((res) => (view as StoreBidViewWidget).onResponseAttachmentData(res))
      .catchError((err) => view.onError(err));
  }

  void onRequestStoreData(Map<String, String> params)
  {
    model
      .fetchStoreData(params)
      .then((res) => (view as StoreBidViewWidget).onResponseStoreData(params['BZDT_CD'], res))
      .catchError((err) => view.onError(err));
  }

  void onRequestStoreElemData(Map<String, String> params)
  {
    model
      .fetchStoreElemData(params)
      .then((res) => (view as StoreBidViewWidget).onResponseStoreElemData(params['BZDT_CD'], res))
      .catchError((err) => view.onError(err));
  }

  void onRequestStoreImageData(Map<String, String> params)
  {
    model
      .fetchStoreImageData(params)
      .then((res) => (view as StoreBidViewWidget).onResponseStoreImageData(params['BZDT_CD'], params['DNG_SN'], params['SBD_NO'], res))
      .catchError((err) => view.onError(err));
  }
}