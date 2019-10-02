import 'package:flutter/material.dart';
import 'package:flutter_for_web_part1/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //We register our Router Class
      onGenerateRoute: Router.generateRoute,
      home: MyHomePage(title: 'Flutter for Web Part 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
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
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InputChip(
              label: Text("External Route to Github"),
              avatar: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Font_Awesome_5_brands_github.svg/54px-Font_Awesome_5_brands_github.svg.png"),
              onPressed: () {
                Navigator.pushNamed(context, externalRoute,
                    arguments:
                        ExternalRouteArguments('https://github.com/vaygeth89'));
              },
            ),
            InputChip(
              label: Text("Internal Route"),
              avatar: Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, internalRoute);
              },
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
        child: Text("Internal Route Screen"),
      )),
    );
  }
}
