import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'postsmodel.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  var responseBody;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black38,
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text(
            'Bost Screen',
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: gets(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide.none),
                          color: Colors.lightGreen,
                          child: Container(
                              padding: EdgeInsets.all(15),
                              color: Colors.white,
                              margin: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('userId: ${snapshot.data[i].userId}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                  Text('id: ${snapshot.data[i].id}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                  Text('title: ${snapshot.data[i].title}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                  Text(
                                    'body: ${snapshot.data[i].body}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ],
                              ))),
                    );
                  },
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red)));
              }
            }),
      ),
    );
  }

  Future<List<postsModel>> gets() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    List<postsModel> postlist = [];
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      for (var i in responseBody) {
        postsModel x = postsModel(
            body: i["body"],
            id: i["id"],
            title: i["title"],
            userId: i["userId"]);
        postlist.add(x);
      }
      return postlist;
    }
    return postlist;
  }
}
