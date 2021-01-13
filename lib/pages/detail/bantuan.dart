import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class BantuanPage extends StatefulWidget {
  @override
  _BantuanPageState createState() => _BantuanPageState();
}

class _BantuanPageState extends State<BantuanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Bantuan'),
        // backgroundColor: Colors.white,
      ),
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: Image.asset(
                'assets/helpsupport.png',
                height: 220,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Butuh bantuan?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: Text(
                "Klik tombol dibawah untuk menghubungi pihak Cilpacastra!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                var whatsappUrl = "whatsapp://send?phone=+628987654321";
                await canLaunch(whatsappUrl)
                    ? launch(whatsappUrl)
                    : print(
                        "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(LineAwesomeIcons.whatsapp,
                        color: Colors.white, size: 30),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Whatsapp kami',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                await canLaunch('cs@cilpacastra.com')
                    ? launch('cs@cilpacastra.com')
                    : print("open whatsap");
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: 180,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.email, color: Colors.white, size: 30),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Email kami',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
