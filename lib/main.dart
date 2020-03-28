
import 'dart:async';

import 'package:cross_app_communications_ihealth/home_page.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  StreamSubscription _sub;

  @override
  Widget build(BuildContext context) {
    
    
    
    Future<String> initUniLinks() async {
print('--------------- we ARE in initUniLinks!!()');

          try {
      String initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
      print('!!! initialLink was');
      print(initialLink);
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
      print('PLATFORM EXCEPTION !!!');
    }

     _sub = getUriLinksStream().listen((Uri uri) {
       print('I JUST GOT CALLED WITH THIS URI : $uri ');
       return uri;
     }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
      print('I JUST GOT THIS ERROR ! : $err ');
      return 'error';
     });
      // NOTE: Don't forget to call _sub.cancel() in dispose()
      return "blech - I don't think this is needed";
    }

    return FutureBuilder(
      future: initUniLinks(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        
        debugPrint('*****');
        print(snapshot);
        
        if (snapshot.hasData) {
          // app is ready and running
          return MaterialApp(
            title: 'URL Launcher',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            home: HomePage(),
          );
        } else if (snapshot.hasError) {
          // an error 
          return Text("Unable to open the stream, man");
        } else {
          // spinner until the stream that listens for URL paths is ready
          return SizedBox(
              child: CircularProgressIndicator(),
              width: 160,
              height: 160,
            );
        }
      }
    );

  }

  @override
  dispose() {
    _sub.cancel();
    super.dispose();
  }
}