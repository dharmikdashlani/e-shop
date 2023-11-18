import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/DB/productdb.dart';
import 'package:untitled/view/auth.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String email = "";

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email').toString();
    });
  }

  Future logOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Auth(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            TextButton.icon(
              onPressed: () {
                logOut(context);
              },
              icon: Icon(
                Icons.logout,
                size: 30,
              ),
              label: Text(
                "LogOut",
                style: TextStyle(fontSize: 25),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 90,
                  width: double.infinity,
                  color: Color(0xff457B9D),
                  child: Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 4),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 36,
                          width: 283,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextFormField(
                            onTap: () {},
                            decoration: InputDecoration(
                                icon: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.search,
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                ),
                                // enabled: false,
                                focusColor: Colors.black,
                                hintText: "Search Hear...",
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                            // enabled: ,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.message,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.notifications_active,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                FutureBuilder(future: ProductDb().GetData()
                ,builder: (context, snapshot) {
                  if(snapshot.hasError)
                    {
                      return Center(child: Text(snapshot.error.toString()),);
                    }
                  if(snapshot.hasData)
                    {
                      List? data = snapshot.data;
                       return Center(child: Text("${data![0]['product_id']}"),);
                    }

                  return Center(child: CircularProgressIndicator(),);
                },),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
