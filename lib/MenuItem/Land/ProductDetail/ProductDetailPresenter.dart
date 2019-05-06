import 'package:bunyang/MenuItem/Land/LandPageModel.dart';
import 'package:bunyang/MenuItem/Land/ProductDetail/ProductDetailModel.dart';
import 'package:bunyang/MenuItem/Land/ProductDetail/ProductDetailView.dart';

class ProductDetailPresenter
{
  ProductDetailModel _model;
  ProductDetailView _view;

  ProductDetailPresenter(this._view)
  {
    _model = new ProductDetailModel();
  }

  void onRequestDetailinfo(DetailPageData requestDetailData)
  {
    _model
      .fetchDetailInfo(requestDetailData.ccrCnntSysDsCd, requestDetailData.aisInfSn, requestDetailData.bzdtCd, requestDetailData.loldNo, requestDetailData.panId)
      .then((res) => _view.onComplete(res))
      .catchError((err) => _view.onError());
  }
}