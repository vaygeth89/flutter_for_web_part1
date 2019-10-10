import 'package:flutter/material.dart';
import 'package:flutter_for_web_part1/main.dart';
import 'dart:html' as html;
import 'dart:js' as js;

const String homePageRoute = '/';
const String internalRoute = '/internal';
const String externalRoute = '/external';

class ExternalRouteArguments {
  //You have as many arguments as you want
  final String url;
  final bool showAlertMessage;

  ExternalRouteArguments(this.url, {this.showAlertMessage = false});
}

//Our Router class that handles routes coordination
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    //Handles different application routes
    switch (settings.name) {
      case homePageRoute:
        return MaterialPageRoute(
            builder: (_) => MyHomePage(title: MyHomePage.homeTitle));

      case internalRoute:
        {
          //Stores username=123 into the cookie
          html.window.document.cookie = "username=123";

          //Stores the cookie into the browsers local storage
          html.window.localStorage
              .addEntries([MapEntry("cookie", html.window.document.cookie)]);

          //Dart to Javascript Proxying
          //Creates json object from javascript library
          js.JsObject jsonObject = js.JsObject(js.context['Object']);

          //Create object {"route":"/internal"}
          jsonObject["route"] = internalRoute;

          //Executes javascripts console.log("https://github.com/vaygeth89/flutter_for_web_part1");
          js.context["console"].callMethod("log", [internalRoute]);

          return MaterialPageRoute(
              builder: (_) => MyInternalScreen(
                    //Pass our jsonObject data to internal/native screen
                    myData: jsonObject["route"],
                  ));
        }
      case externalRoute:
        {
          return MaterialPageRoute(builder: (context) {

            //Fetching the passed data from the main.dart containning both url & showAlerMessage parameters
            final ExternalRouteArguments arguments =
                settings.arguments as ExternalRouteArguments;

            if (arguments != null) {
              //Dart to HTML Proxying
              if (arguments.showAlertMessage)
                //Show browser's dialog that user is being redirected
                html.window
                    .alert("You're being redirected to \n ${arguments.url}");

              //Dart to Javascript Proxying
              //Executes javascripts window.open(https://github.com/vaygeth89/flutter_for_web_part1, '');
              js.context.callMethod("open", [arguments.url]);
            }
            //For simplicity we will go bk to home page again, you can decide how you handle it
            return MyHomePage(
              title: MyHomePage.homeTitle,
            );
          });
        }

      default:
        {
          return MaterialPageRoute(
              builder: (_) => MyHomePage(title: MyHomePage.homeTitle));
        }
    }
  }
}
