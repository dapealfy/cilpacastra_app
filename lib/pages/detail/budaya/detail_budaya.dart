import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class DetailBudaya extends StatefulWidget {
  @override
  _DetailBudayaState createState() => _DetailBudayaState();
}

class _DetailBudayaState extends State<DetailBudaya> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rumah Joglo'),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Image.network(
                'https://i2.wp.com/blog.schneidermans.com/wp-content/uploads/2017/03/brown-and-gray-decorating-in-this-loft-dining-room.jpg?resize=1200%2C1153',
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
                          'Rumah Joglo',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border),
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
                      child: Text(
                          'Lorem ipsum dolor sit amet uwau kamu keren banget Lorem ipsum dolor sit amet uwau kamu keren banget Lorem ipsum dolor sit amet uwau kamu keren banget '),
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
                    decoration: InputDecoration(
                      labelText: 'Tulis Komentar...',
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        //nanti buat ngirim komentar
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
