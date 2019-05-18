import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/ChargeSupplyInfoView.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class ChargeSupplyInfoTab extends StatefulWidget
{
  ChargeSupplyInfoTab(this._tabContents);

  final List<Tuple3<Map<String, String>, Map<String, String>, Map<String, String>>> _tabContents;

  @override
  ChargeSupplyInfoTabView createState() => ChargeSupplyInfoTabView();
}

class ChargeSupplyInfoTabView extends State<ChargeSupplyInfoTab> with SingleTickerProviderStateMixin
{
  TabController _tabController;

  @override
  void initState()
  {
    super.initState();
    _tabController = TabController(length: widget._tabContents.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose()
  {
    super.dispose();
    _tabController.dispose();
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
        child: ListView
        (
          children: <Widget>
          [
            TabBar
            (
              controller: _tabController,
              tabs: widget._tabContents.map((tuple)
              {
                return Tab
                (
                  icon: Text
                  (
                    tuple.item1['LCC_NT_NM'],
                    overflow: TextOverflow.fade,
                    style: TextStyle
                    (
                      fontSize: 18,
                      inherit: true,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: 
                      [
                        Shadow( // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: Colors.black
                        ),
                        Shadow( // bottomRight
                          offset: Offset(1.5, -1.5),
                          color: Colors.black
                        ),
                        Shadow( // topRight
                          offset: Offset(1.5, 1.5),
                          color: Colors.black
                        ),
                        Shadow( // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: Colors.black
                        ),
                      ]
                    )
                  )
                );
              }).toList(),
            ),
            TabBarView
            (
              children: widget._tabContents.map((tuple)
              {
                ChargeSupplyInfo(tuple.item1, tuple.item2, tuple.item3);
              }).toList()
            )
          ]
        )
      )
    );
  }
}