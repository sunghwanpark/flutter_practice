import 'package:bunyang/Secret/URL.dart';
import 'package:bunyang/Util/HighlightImageView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatefulWidget
{
  NetworkImageWidget({ @required String serialNum })
    : _serialNum = serialNum;
  
  final String _serialNum;

  @override
  NetworkImageWidgetState createState() => NetworkImageWidgetState();
}

class NetworkImageWidgetState extends State<NetworkImageWidget>
{
  Image _image;
  LoadingState _imageLoadingState = LoadingState.WAITING;

  @override
  void initState()
  {
    super.initState();

    String serialNum = widget._serialNum;
    var cachedImageProvider = CachedNetworkImageProvider("$imageURL$serialNum", errorListener: ()
    {
      setState(() {
        _imageLoadingState = LoadingState.ERROR; 
      });
    });

    cachedImageProvider.resolve(new ImageConfiguration()).addListener((_, __) 
    {
      if (mounted) 
      {
        setState(() {
          _imageLoadingState = LoadingState.DONE;
        });
      }
    });

    _image = Image(image: cachedImageProvider);
  }

  @override
  Widget build(BuildContext context) 
  {
    return _imageLoadingState == LoadingState.DONE ? InkWell
    (
      child: Hero
      (
        tag: widget._serialNum,
        child: _image
      ),
      onTap: () => Navigator.push
      (
        context,
        MaterialPageRoute(builder: (context) => HighlightImageView(widget._serialNum, _image))
      )
    ) : _imageLoadingState == LoadingState.LOADING ? CircularProgressIndicator(backgroundColor: Colors.black)
    : _imageLoadingState == LoadingState.ERROR ? myText('이미지 로드 실패') : SizedBox();
  }
}