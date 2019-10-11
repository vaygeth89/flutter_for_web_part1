import 'package:flutter/material.dart';
import 'dart:html' as html; // importing the HTML proxying library and named it as html
import 'dart:js' as js; // importing the Javascript proxying library and named it as js

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter for Web Demo - Part 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Give it a route that load when app is running
      home: MyHomePage(
        title: MyHomePage.homeTitle,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static String homeTitle = 'Home Page';
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.greenAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // InkWell is widget used to add taps & gestures events to child
            InkWell(
              onTap: () {
                //Dart to HTML Proxying
                //Stores the cookie into the browsers local storage
                html.window.localStorage.addEntries([
                  MapEntry(
                      "data", "this data is stored on browser local storage")
                ]);

                //Dart to Javascript Proxying
                //Creates json object from javascript library
                js.JsObject jsonObject = js.JsObject(js.context['Object']);

                //Create object {"route":"/internal"}
                jsonObject["message"] = 'Flutter Web';

                //Executes javascripts console.log();
                js.context["console"].callMethod(
                    "log", ['internalRoute', '\n', jsonObject["message"]]);
              },
              child: Image.network(
                "https://flutter.dev/assets/flutter-lockup-4cb0ee072ab312e59784d9fbf4fb7ad42688a7fdaea1270ccf6bbf4f34b7e03f.svg",
                width: 200,
                height: 200,
              ),
            ),
            InkWell(
              onTap: () {
                String externalUrl =
                    'https://github.com/vaygeth89/flutter_for_web_part1';
                html.window.alert("You're being redirected to \n $externalUrl");

                //Dart to Javascript Proxying
                //Executes javascripts window.open(https://github.com/vaygeth89/flutter_for_web_part1, '');
                js.context.callMethod("open", [externalUrl]);
              },
              child: Image.network(
                "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png",
                width: 100,
                height: 100,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: (){
          // Refresh & reloads your page
          html.window.location.reload();
        },
      ),
    );
  }
}
