import 'package:bunyang/MenuItem/Store/Bid/BidSupplyDetail/StoreBidSupplyDetailModel.dart';
import 'package:bunyang/MenuItem/Store/Bid/BidSupplyDetail/StoreBidSupplyDetailView.dart';

class StoreBidSupplyDetailPresenter
{
  StoreBidSupplyDetailModel _model;
  StoreBidSupplyDetailWidget _view;

  StoreBidSupplyDetailPresenter(this._view)
  {
    _model = StoreBidSupplyDetailModel();
  }

  void onRequestData(Map<String, String> params)
  {
    _model
      .fetchData(params)
      .then((res) => _view.onComplete(res))
      .catchError((err) => _view.onError(err));
  }
}