import 'dart:convert';

import 'package:cilpacastra/pages/detail/budaya/detail_budaya.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListBudaya extends StatefulWidget {
  @override
  _ListBudayaState createState() => _ListBudayaState();
}

class _ListBudayaState extends State<ListBudaya> {
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
    _dataBudaya();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Budaya'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listDataBudaya.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailBudaya(
                                listDataBudaya[index]['id'].toString(),
                                listDataBudaya[index])));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                child: Image.network(
                                  listDataBudaya[index]['thumbnail'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(
                                    listDataBudaya[index]['nama_budaya'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    listDataBudaya[index]['deskripsi'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailBudaya(
                                        listDataBudaya[index]['id'].toString(),
                                        listDataBudaya[index])));
                          },
                          child: Text('Lihat'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
