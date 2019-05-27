import 'package:bunyang/MenuItem/IntallmentHouse/SupplyInfoView.dart';
import 'package:flutter/material.dart';

class SupplyInfos extends StatefulWidget
{
  SupplyInfos(this._uppAisTpCd, this._defaultData, this._publicInstallment, this._publicLease, this._publicInstallmentLease, this._imageData);

  final String _uppAisTpCd;
  final Iterable<Map<String, String>> _defaultData;
  final Iterable<List<Map<String, String>>> _publicInstallment;
  final Iterable<List<Map<String, String>>> _publicLease;
  final Iterable<List<Map<String, String>>> _publicInstallmentLease;
  final Iterable<List<Map<String, String>>> _imageData;

  @override
  SupplyInfosView createState() => SupplyInfosView();
}

class SupplyInfosView extends State<SupplyInfos> with SingleTickerProviderStateMixin 
{
  List<String> _tabNames;
  List<Widget> contents = new List<Widget>();

  TabController _tabController;

  @override
  void initState() 
  {
    super.initState();

    _tabNames = widget._defaultData.map((k) => k['BZDT_NM']).toList();
    for(int i = 0; i < widget._defaultData.length; i++)
    {
      contents.add(SupplyInfo
      (
        widget._uppAisTpCd, 
        widget._defaultData.elementAt(i),
        widget._publicInstallment.elementAt(i), 
        widget._publicLease.elementAt(i), 
        widget._publicInstallmentLease.elementAt(i), 
        widget._imageData.elementAt(i))
      );
    }

    _tabController = TabController(length: _tabNames.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose()
  {
    _tabController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      width: MediaQuery.of(context).size.width,
      child: ListView
      (
        children: <Widget>
        [
          Container
          (
            decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
            child: new TabBar
            (
              controller: _tabController,
              tabs: _tabNames.map((str)
              {
                return Tab
                (
                  icon: Text(str, style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'TmonTium', decoration: TextDecoration.underline))
                );
              }).toList()
            ),
          ),
          TabBarView
          (
            controller: _tabController,
            children: contents
          )
        ],
      )
    );
  }
}