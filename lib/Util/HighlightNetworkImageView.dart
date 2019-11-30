import 'package:bunyang/Secret/URL.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class HighlightNetworkImageView extends StatefulWidget
{
  HighlightNetworkImageView({ @required String name, @required String serialNum, double width })
    : _imageName = name, _serialNum = serialNum, _width = width;
  
  final String _imageName;
  final String _serialNum;
  final double _width;

  @override
  HighlightNetworkImageViewWidget createState() => HighlightNetworkImageViewWidget();
}

class HighlightNetworkImageViewWidget extends State<HighlightNetworkImageView> 
{
  LoadingState _imageLoadingState = LoadingState.WAITING;

  CachedNetworkImageProvider _cachedImageProvider;

  @override
  void initState()
  {
    super.initState();

    String serialNum = widget._serialNum;
    _cachedImageProvider = CachedNetworkImageProvider("$pdfDownloadURL$serialNum", errorListener: ()
    {
      setState(() {
        _imageLoadingState = LoadingState.ERROR; 
      });
    });

    var imgStreamListener = ImageStreamListener((_, __)
    {
      if (mounted) 
        {
          setState(() {
            _imageLoadingState = LoadingState.DONE;
          });
        }
    });

    _cachedImageProvider.resolve(new ImageConfiguration()).addListener(imgStreamListener);
  }

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
          title: myText(widget._imageName),
          iconTheme: IconThemeData
          (
            color: Colors.white
          ),
          backgroundColor: Colors.black
        )
      ),
      body: Center
      (
        child: _imageLoadingState == LoadingState.DONE ?
          PhotoView(imageProvider: _cachedImageProvider)
          : _imageLoadingState == LoadingState.WAITING ?
          CircularProgressIndicator(backgroundColor: Colors.black)
          : _imageLoadingState == LoadingState.ERROR ?
          myText('이미지 로드 실패') : SizedBox()
      ),
    );
  }
}