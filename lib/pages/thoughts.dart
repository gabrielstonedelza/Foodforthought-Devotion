import 'package:flutter/material.dart';
import 'package:foodforthought/pages/myloading.dart';
import 'package:foodforthought/pages/thought_detail.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'dart:convert';

import 'homeshortcut.dart';
import 'mydrawer.dart';

class Thoughts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ThoughtState();
  }
}

class _ThoughtState extends State<Thoughts>{

  bool isLoading = true;
  var title = "";
  List items = [];
  var thoughts;

  _fetchData() async{
    final url = "https://www.connectdjango.com/api/thoughtlist/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);

    if(response.statusCode == 200){
      final codeUnits = response.body.codeUnits;
      var data = Utf8Decoder().convert(codeUnits);
      items = json.decode(data);
    }

    setState(() {
      isLoading = false;
      this.items = items;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _fetchData();
    });
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
        title: Text("Thoughts"),
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
        ],
      ),

      body: isLoading ? MyLoading() : ListView.builder(
          itemCount: this.items != null ? this.items.length :0,
          itemBuilder: (context,i){
            thoughts = items[i];
            return Container(
              // height: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.lightbulb_outlined,color: Colors.yellow,),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top:8.0,bottom: 10),
                          child: Text(thoughts['title'],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Text(thoughts['author']),
                            ),
                            Text(thoughts['date_posted'].toString().split("T").first)
                          ],
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ThoughtDetail(this.items[i]['title'], this.items[i]['id']);

                          }));
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Divider(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          }
      )
    );
  }
}