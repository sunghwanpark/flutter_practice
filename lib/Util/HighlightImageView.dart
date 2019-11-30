import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class HighlightImageView extends StatelessWidget 
{
  HighlightImageView(this._heroTag, this._imageProvider);

  final ImageProvider _imageProvider;
  final String _heroTag;

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
        child: PhotoView
        (
          imageProvider: _imageProvider,
          heroAttributes: PhotoViewHeroAttributes(tag: _heroTag)
        )
      ),
    );
  }
}