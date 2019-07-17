import 'package:flutter/material.dart';

abstract class AbstractContentsView extends StatelessWidget
{
  @protected
  List<Widget> getContents(BuildContext context);

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
          children: getContents(context)
        ),
      )
    );
  }
}