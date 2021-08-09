import 'package:class_proj/apicalls/SongCall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    super.initState();
    getLyrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lyrics"),
          centerTitle: true,
        ),
        body: loading
            ? Center(
                child: SpinKitFadingGrid(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : WebView(
                initialUrl: data['url'],
              ));
  }
}
