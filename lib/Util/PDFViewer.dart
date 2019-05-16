import 'dart:convert';
import 'dart:io';

import 'package:bunyang/Secret/URL.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PDFViewer extends StatefulWidget
{
  const PDFViewer(this._serialNum);

  final String _serialNum;
  
  @override
  PDFViewerWidget createState() => PDFViewerWidget(_serialNum);
}

class PDFViewerWidget extends State<PDFViewer>
{
  PDFViewerWidget(this._serialNum);

  final String _serialNum;
  bool _isDownloadComplete = false;
  double _downloadProgress = 0;

  @override
  void initState()
  {
    super.initState();

    int fileSize;
    new HttpClient().getUrl(Uri.parse(pdfDownloadURL + _serialNum))
     .then((HttpClientRequest request) => request.close())
     .then((HttpClientResponse response)
     {
       fileSize ??= response.contentLength;
       response.transform(utf8.decoder).listen((contents)
       {
         _downloadProgress += contents.length;
       });
     });
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.black,
      appBar: AppBar
      (
        iconTheme: IconThemeData
        (
          color: Colors.white
        ),
        backgroundColor: Colors.black
      ),
      body: Center
      (
        child: _isDownloadComplete ? CircularProgressIndicator(value: _downloadProgress, backgroundColor: Colors.white,) : Container()

      ),
    );
  }
}