import 'package:bunyang/Data/Address.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class ChargeSupplyInfoDetailView extends StatelessWidget
{
  ChargeSupplyInfoDetailView(this._datas);

  final Map<String, String> _datas;

  Widget _getContentSection(BuildContext context)
  {
    return SliverList
    (
      delegate: SliverChildListDelegate
      (
        <Widget>
        [
          Row
          (
            children : <Widget>
            [
              Icon(Icons.check_circle, color: Colors.black),
              SizedBox(width: 10),
              Text('주택형 안내', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
            ]
          ),
          Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 주택형 : %s', [_datas['HTY_NNA']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ),
          Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 전용면적(㎡) : %s', [_datas['DDO_AR']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ),
          Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 공급면적(㎡) : %s', [_datas['SPL_AR']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ),
          Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 주거공용면적(㎡): %s', [_datas['RSDN_CMUS_AR']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ),
          Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 기타공용면적(㎡) : %s', [_datas['ETC_CMUS_AR']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ),
          Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 지하주차장면적(㎡) : %s', [_datas['PKPL_AR']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ),
          Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 계약면적(㎡) : %s', [_datas['CTRT_AR']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ),
          Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 세대수: %s', [_datas['HSH_CNT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ),
          Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 금회분양 세대수 : %s', [_datas['NOW_HSH_CNT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ),
          Align
          (
            alignment: Alignment.centerLeft,
            child: Text('· 평균분양가격(원) : 공고문 확인', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ),
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.white,
      body: CustomScrollView
      (
        primary: false,
        slivers: <Widget>
        [
          SliverAppBar
          (
            expandedHeight: 200,
            iconTheme: IconThemeData
            (
              color: Colors.black
            ),
            flexibleSpace: FlexibleSpaceBar
            (
              titlePadding: EdgeInsets.only(bottom: 20, left: 80, right: 80),
              centerTitle: true,
              title: Text
              (
                "공급정보 상세보기",
                style: TextStyle
                (
                  color: Colors.white,
                  fontFamily: "TmonTium",
                  fontSize: 25,
                  fontWeight: FontWeight.w800
                )
              ),
              background: Stack
              (
                fit: StackFit.expand,
                children: <Widget>
                [
                  Hero
                  (
                    tag: constNoticeCodeMap[Notice_Code.installment_house].code,
                    child: FadeInImage
                    (
                      fit: BoxFit.cover,
                      placeholder: AssetImage("assets/image/placeholder.jpg"),
                      image: constNoticeCodeMap[Notice_Code.installment_house].image
                    )
                  )
                ]
              )
            ),
          ),
          _getContentSection(context)
        ], 
      ),
    );
  }
}