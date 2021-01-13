import 'package:cilpacastra/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class DetailBudaya extends StatefulWidget {
  final id;
  final data;
  DetailBudaya(this.id, this.data);
  @override
  _DetailBudayaState createState() => _DetailBudayaState();
}

class _DetailBudayaState extends State<DetailBudaya> {
  SharedPref sharedPref = SharedPref();
  var liked = 0;
  List isi_komentar = [];
  TextEditingController komentarController = TextEditingController();

  var getKomentar;
  Future getAllKomentar() async {
    getKomentar = await sharedPref.read('komentar' + widget.id);
    setState(() {
      isi_komentar = getKomentar;
    });
  }

  void initState() {
    getAllKomentar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['nama_budaya']),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Image.network(
                widget.data['thumbnail'],
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.data['nama_budaya'] +
                              '\n' +
                              widget.data['nama_daerah'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (liked == 0) {
                                    liked = 1;
                                  } else {
                                    liked = 0;
                                  }
                                });
                              },
                              icon: liked == 1
                                  ? Icon(Icons.favorite, color: Colors.red)
                                  : Icon(Icons.favorite_border),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.comment_outlined),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: Text(widget.data['deskripsi']),
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    Text('Komentar'),
                    SizedBox(height: 10),
                    Container(
                      transform: Matrix4.translationValues(-10, 0, 0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: isi_komentar.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(Feather.user),
                              ),
                            ),
                            title: Text('Daffa Alvi'),
                            subtitle: Text(isi_komentar[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                //Comment Section
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: Colors.white,
              child: Stack(
                children: [
                  TextFormField(
                    controller: komentarController,
                    decoration: InputDecoration(
                      labelText: 'Tulis Komentar...',
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isi_komentar.add(komentarController.text);
                          komentarController.clear();
                          sharedPref.save('komentar' + widget.id, isi_komentar);
                        });
                      },
                      icon: Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
