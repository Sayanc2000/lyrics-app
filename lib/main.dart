import 'package:class_proj/Results.dart';
import 'package:class_proj/apicalls/SearchCall.dart';
import 'package:class_proj/apicalls/SongCall.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lyrics Search"),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: LyricsSearch());
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: Center(
          child: Text("Click on the search button to start"),
        ));
  }
}

class LyricsSearch extends SearchDelegate {
  var data;
  bool loading = false;
  getCall() async {
    loading = true;
    final res = await searchApiCall(query);
    data = res;
    loading = false;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: getCall(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (loading) {
            return Center(
              child: Text("Loading..."),
            );
          } else {
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  Results(id: data[index]['result']['id'])));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              data[index]['result']['full_title'],
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        color: Colors.black.withOpacity(0.6),
                        width: double.infinity,
                      ),
                    ],
                  );
                });
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
