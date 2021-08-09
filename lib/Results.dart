import 'package:class_proj/apicalls/SongCall.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Results extends StatefulWidget {
  final int id;
  Results({required this.id});

  @override
  _ResultsState createState() => _ResultsState(id: this.id);
}

class _ResultsState extends State<Results> {
  final int id;
  _ResultsState({required this.id});
  var data;
  bool loading = true;

  getLyrics() async {
    var res = await songApiCall(id);
    print(res);
    setState(() {
      data = res;
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLyrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lyrics"),
        ),
        body: loading
            ? Center(
                child: Text("loading..."),
              )
            : WebView(
                initialUrl: data['url'],
              ));
  }
}
