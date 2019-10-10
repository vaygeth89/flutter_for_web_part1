import 'package:flutter/material.dart';
import 'package:flutter_for_web_part1/routes.dart' as RouterFile;

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
      initialRoute: RouterFile.homePageRoute,
      // We register our Router Class
      onGenerateRoute: RouterFile.Router.generateRoute,
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
                Navigator.pushNamed(context, RouterFile.internalRoute);
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
                Navigator.pushNamed(context, RouterFile.externalRoute,
                    arguments: RouterFile.ExternalRouteArguments(externalUrl,
                        showAlertMessage: true));
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
    );
  }
}

class MyInternalScreen extends StatelessWidget {
  const MyInternalScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Internal Route"),
      ),
      body: Container(
          child: Center(
        child: Text(
          "Internal Route Screen",
          style: TextStyle(fontSize: 25),
        ),
      )),
    );
  }
}
