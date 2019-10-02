import 'package:flutter/material.dart';
import 'package:flutter_for_web_part1/main.dart';
import 'dart:html' as html;

class ExternalRouteArguments {
  //You have as many arguments as you want
  final String url;

  ExternalRouteArguments(this.url);
}

const String homePageRoute = '/';
const String internalRoute = '/internal';
const String externalRoute = '/external';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePageRoute:
        return MaterialPageRoute(builder: (_) => MyHomePage());

      case internalRoute:
        return MaterialPageRoute(builder: (_) => MyInternalScreen());
      case externalRoute:
        {
          return MaterialPageRoute(builder: (context) {
            final ExternalRouteArguments arguments =
                settings.arguments as ExternalRouteArguments;

            if (arguments != null) {
              //dart to html proxy
              html.window.location.href = arguments.url;
              return Container();
            }
            //For simplicity we will the home page again, how you handle it is your preference
            return MyHomePage();
          });
        }

      default:
        {
          return MaterialPageRoute(builder: (_) => MyHomePage());
        }
    }
  }
}
