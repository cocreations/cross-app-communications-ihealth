import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("URL Launcher"),
      ),
      body: Column(
        children: <Widget>[

          ListTile(
            title: Text("Launch Web Page"),
            onTap: () async {
              const url = 'https://google.com';

              if (await canLaunch(url)) {
                await launch(url, forceSafariVC: false);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),

          ListTile(
            title: Text("Telephone"),
            onTap: () async {

              final String telephoneNumber = "01817658822";
              
              String telephoneUrl = "tel:$telephoneNumber";

              if (await canLaunch(telephoneUrl)) {
                await launch(telephoneUrl);
              } else {
                throw "Can't phone that number.";
              }
            },
          ),



        ],
      ),
    );
  }
}