import 'package:bunyang/Secret/URL.dart';
import 'package:bunyang/Util/HighlightImageView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatefulWidget
{
  NetworkImageWidget({ @required String serialNum, BuildContext context })
    : _serialNum = serialNum, _context = context;
  
  final String _serialNum;
  final BuildContext _context;

  @override
  NetworkImageWidgetState createState() => NetworkImageWidgetState();
}

class NetworkImageWidgetState extends State<NetworkImageWidget>
{
  CachedNetworkImageProvider _cachedNetworkImageProvider;
  Image _image;
  LoadingState _imageLoadingState = LoadingState.WAITING;

  @override
  void initState()
  {
    super.initState();

    String serialNum = widget._serialNum;
    _cachedNetworkImageProvider = CachedNetworkImageProvider("$imageURL$serialNum", errorListener: ()
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
    
    _cachedNetworkImageProvider.resolve(new ImageConfiguration()).addListener(imgStreamListener);

    double width = MediaQuery.of(widget._context).size.width;
    _image = Image(image: _cachedNetworkImageProvider, width: width);
  }

  @override
  void dispose()
  {
    super.dispose();
    if(_cachedNetworkImageProvider.cacheManager != null)
      _cachedNetworkImageProvider.cacheManager.emptyCache();
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
        MaterialPageRoute(builder: (context) => HighlightImageView(widget._serialNum, _cachedNetworkImageProvider))
      )
    ) : _imageLoadingState == LoadingState.LOADING ? CircularProgressIndicator(backgroundColor: Colors.black)
    : _imageLoadingState == LoadingState.ERROR ? myText('이미지 로드 실패') : SizedBox();
  }
}