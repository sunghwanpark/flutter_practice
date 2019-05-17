import 'dart:io';

import 'package:bunyang/Util/Util.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PDFViewer extends StatefulWidget
{
  const PDFViewer(this._pdfFileName, this._pdfSerialNum);
  
  final String _pdfFileName;
  final String _pdfSerialNum;
  @override
  PDFViewerWidget createState() => PDFViewerWidget();
}

class PDFViewerWidget extends State<PDFViewer>
{
  PDFViewerWidget();

  String _filePath;
  bool _isDownloadComplete = false;
  @override
  void initState()
  {
    super.initState();

    _downloadFile(pdfDownloadURL + widget._pdfSerialNum, 'pdf')
    .then((f)
    {
      setState(() {
        _filePath = f.path;
        _isDownloadComplete = true; 
      });
    });
  }

  Future<File> _downloadFile(String url, String filename) async 
  {
    http.Client client = new http.Client();
    var req = await client.get(Uri.parse(url));
    var bytes = req.bodyBytes;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
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
          title: myText(widget._pdfFileName, Colors.white),
          iconTheme: IconThemeData
          (
            color: Colors.white
          ),
          backgroundColor: Colors.black
        )
      ),
      body: Center
      (
        child: _isDownloadComplete ? PDFView(filePath: _filePath) : CircularProgressIndicator(backgroundColor: Colors.white,)
      ),
    );
  }
}