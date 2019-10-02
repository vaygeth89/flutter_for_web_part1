import 'package:flutter/material.dart';
import 'package:flutter_for_web_part1/main.dart';
import 'dart:html' as html;

const String homePageRoute = '/';
const String internalRoute = '/internal';
const String externalRoute = '/external';

class ExternalRouteArguments {
  //You have as many arguments as you want
  final String url;
  final bool showAlertMessage;

  ExternalRouteArguments(this.url, {this.showAlertMessage = false});
}

//Our Router class that handles routes redirection
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
              if (arguments.showAlertMessage)
              //this is where dart to html proxying happens
                html.window.alert("You're being redirected to external website");
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
