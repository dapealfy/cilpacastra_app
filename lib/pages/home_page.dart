import 'dart:convert';

import 'package:cilpacastra/pages/detail/bantuan.dart';
import 'package:cilpacastra/pages/detail/budaya/detail_budaya.dart';
import 'package:cilpacastra/pages/detail/cari_lokasi.dart';
import 'package:cilpacastra/pages/detail/list_budaya.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Berita
  List berita = [];
  var kategoriBerita = 'health';
  Future<List> _dataBerita(kategori) async {
    var url = "http://newsapi.org/v2/top-headlines?country=id&category=" +
        kategori +
        "&apiKey=1fc3dfc3a41a44e998e1aaf39ff8ad52";
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
    });
    Map<String, dynamic> _berita;

    _berita = json.decode(response.body);
    setState(() {
      berita = _berita['articles'];
    });
  }

  List listDataBudaya = [];
  Future<List> _dataBudaya() async {
    var url = "http://cilpacastra.snip-id.com/api/data-budaya";
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
    });
    Map<String, dynamic> _listBudaya;

    _listBudaya = json.decode(response.body);
    setState(() {
      listDataBudaya = _listBudaya['data_budaya'];
    });
  }

  void initState() {
    _dataBerita(kategoriBerita);
    _dataBudaya();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Cilpacastra'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 9.0,
                                spreadRadius: 0.0,
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Icon(Feather.user),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Daffa Alvi',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.brown.withOpacity(0.2),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Level 3',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LokasiPage()));
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Feather.trending_up),
                                            SizedBox(height: 5),
                                            Text(
                                              'Tingkatkan',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      //BERITA SECTION
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yuk Eksplore!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 30,
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        kategoriBerita = 'health';
                                        berita.clear();
                                      });
                                      _dataBerita(kategoriBerita);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 7),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: kategoriBerita == 'health'
                                              ? Colors.brown
                                              : Colors.black.withOpacity(0.5),
                                        ),
                                        color: kategoriBerita == 'health'
                                            ? Colors.brown
                                            : Colors.white,
                                      ),
                                      child: Text(
                                        'Kesehatan',
                                        style: TextStyle(
                                            color: kategoriBerita == 'health'
                                                ? Colors.white
                                                : Colors.black
                                                    .withOpacity(0.5)),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        kategoriBerita = 'entertainment';
                                        berita.clear();
                                      });
                                      _dataBerita(kategoriBerita);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 7),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: kategoriBerita ==
                                                  'entertainment'
                                              ? Colors.brown
                                              : Colors.black.withOpacity(0.5),
                                        ),
                                        color: kategoriBerita == 'entertainment'
                                            ? Colors.brown
                                            : Colors.white,
                                      ),
                                      child: Text(
                                        'Hiburan',
                                        style: TextStyle(
                                            color: kategoriBerita ==
                                                    'entertainment'
                                                ? Colors.white
                                                : Colors.black
                                                    .withOpacity(0.5)),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        kategoriBerita = 'technology';
                                        berita.clear();
                                      });
                                      _dataBerita(kategoriBerita);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 7),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: kategoriBerita == 'technology'
                                              ? Colors.brown
                                              : Colors.black.withOpacity(0.5),
                                        ),
                                        color: kategoriBerita == 'technology'
                                            ? Colors.brown
                                            : Colors.white,
                                      ),
                                      child: Text(
                                        'Teknologi',
                                        style: TextStyle(
                                            color:
                                                kategoriBerita == 'technology'
                                                    ? Colors.white
                                                    : Colors.black
                                                        .withOpacity(0.5)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 270,
                              child: berita.toString() == '[]'
                                  ? Center(
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount:
                                          berita.toString() == '[]' ? 0 : 4,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Container(
                                              height: 250,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    blurRadius: 5.0,
                                                    spreadRadius: 0.0,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 200,
                                                    height: 140,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                      ),
                                                      child: Image.network(
                                                        berita[index]
                                                            ['urlToImage'],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 180,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Text(
                                                            berita[index]
                                                                ['title'],
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          width: 200,
                                                          child: Text(
                                                            berita[index][
                                                                    'description'] +
                                                                '...',
                                                            maxLines: 4,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 9.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LokasiPage()));
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            margin: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              color: Colors.brown.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Feather.map, color: Colors.brown),
                                SizedBox(height: 5),
                                Text(
                                  'Cari Lokasi',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.brown),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListBudaya()));
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            margin: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              color: Colors.brown.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Feather.camera, color: Colors.brown),
                                SizedBox(height: 5),
                                Text(
                                  'Budaya',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.brown),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailBudaya(
                                        listDataBudaya[0]['id'].toString(),
                                        listDataBudaya[0])));
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            margin: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              color: Colors.brown.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Feather.feather, color: Colors.brown),
                                SizedBox(height: 5),
                                Text(
                                  'Random',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.brown),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BantuanPage()));
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            margin: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              color: Colors.brown.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Feather.help_circle, color: Colors.brown),
                                SizedBox(height: 5),
                                Text(
                                  'Bantuan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.brown),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
