import 'package:cross_app_communications_ihealth/ihealth_param_types.dart';
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


          ListTile(
            title: Text("iHealth CONNECT"),
            onTap: () async {

              final String iHealthUrl = "ihealth-layer://" +
                                        "?action=$IHEALTH_CMD_ADD_MEASURE" +
                                        "&cmd=$IHEALTH_CMD_ADD_MEASURE" +
                                        "&addtype=$IHEALTH_ADDTYPE_BTSCAN" +
                                        "&deviceModel=$IHEALTH_DEVICEMODEL_BP5" +
                                        "&orientation=$IHEALTH_ORIENTATION_AUTO" +
                                        "&unit=$IHEALTH_UNIT_BloodPressureUnitMMHG" +
                                        "&scheme=crossappdemo" +
                                        "&appId=cross_app_comms_demo_app" +
                                        "&ver=100";        

              if (await canLaunch(iHealthUrl)) {
                await launch(iHealthUrl);
              } else {
                throw "Can't launch iHealth CONNECT (ihealth-layer://).";
              }
            },
          ),



        ],
      ),
    );
  }
}