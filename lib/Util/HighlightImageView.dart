import 'package:flutter/material.dart';

class HighlightImageView extends StatelessWidget 
{
  HighlightImageView(this._heroTag, this._heroImage);

  final String _heroTag;
  final Image _heroImage;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.black,
      appBar: PreferredSize
      (
        preferredSize: Size.fromHeight(50),
        child: AppBar
        (
          iconTheme: IconThemeData
          (
            color: Colors.white
          ),
          backgroundColor: Colors.black
        )
      ),
      body: Center
      (
        child: Hero
        (
          tag: _heroTag,
          child: _heroImage
        )
      ),
    );
  }
}