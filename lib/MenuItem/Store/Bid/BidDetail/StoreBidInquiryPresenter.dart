import 'package:bunyang/MenuItem/Store/Bid/BidDetail/StoreBidInquiryModel.dart';
import 'package:bunyang/MenuItem/Store/Bid/BidDetail/StoreBidInquiryView.dart';

class StoreBidInquiryPresenter
{
  StoreBidInquiryPresenter(this._view)
  {
    _model = new StoreBidInquiryModel();
  }

  StoreBidInquiryModel _model;
  StoreBidInquiryView _view;

  void onRequestData(Map<String, String> params)
  {
    _model
      .fetchData(params)
      .then((res) => _view.onResponseData(res))
      .catchError((err) => _view.onError(err));
  }
}