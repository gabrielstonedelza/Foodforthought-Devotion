import 'package:flutter/material.dart';
import 'package:foodforthought/pages/addnewtestimony.dart';
import 'package:foodforthought/pages/mydrawer.dart';
import 'package:foodforthought/pages/myloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:page_transition/page_transition.dart';

import 'homeshortcut.dart';


class Testimonies extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestimoniesState();
  }
}

class _TestimoniesState extends State<Testimonies>{
  bool isLoading = true;
  List testimonies = [];
  var items;

  _fetchData() async{
    final url = "https://www.connectdjango.com/api/testimonies/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);
    if(response.statusCode ==200){
      final codeUnits = response.body.codeUnits;
      var data = Utf8Decoder().convert(codeUnits);
      testimonies = json.decode(data);
    }

    setState(() {
      isLoading = false;
      this.testimonies = testimonies;
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: (){
              Navigator.pushAndRemoveUntil(context, PageTransition(child:HomeShortCut(),type:  PageTransitionType.topToBottom), (route) => false);
            },
          ),
        title: Text("Testimonies"),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                _fetchData();
              },
            )
          ]
      ),

      body: isLoading ? MyLoading() : ListView.builder(
          itemCount: this.testimonies != null ? this.testimonies.length : 0,
          itemBuilder: (context,i){
            items = testimonies[i];
            return Padding(
              padding: const EdgeInsets.only(top:12.0,left: 10,right: 10,bottom: 10),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top:10,bottom: 10),
                            child: CircleAvatar(
                              child: Icon(Icons.person_outline_outlined),
                            ),
                          ),
                          flex: 1,
                        ),

                        Expanded(
                          flex: 4,
                            child: Text(items['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:18.0,bottom: 10),
                      child: Text(items['testimony']),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left:18.0,bottom: 10),
                      child: Text(items['date_of_testimony'].toString().split("T").first),
                    )
                  ],
                ),
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_comment),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return NewTestimony();
          }));
        },
      ),
    );
  }
}