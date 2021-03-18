import 'package:flutter/material.dart';
import 'package:foodforthought/pages/mydrawer.dart';
import 'package:foodforthought/pages/myloading.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'addfeedback.dart';
import 'homeshortcut.dart';


class FeedBacks extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FeedBacksState();
  }
}

class _FeedBacksState extends State<FeedBacks>{

  var userWithFeedBack;
  bool isLoading = true;
  List feedbacks = [];
  var feedbackItem;

  _fetchData() async{
    final url = "https://www.connectdjango.com/api/feedbacks/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);
    if(response.statusCode ==200){
      final codeUnits = response.body.codeUnits;
      var data = Utf8Decoder().convert(codeUnits);
      feedbacks = json.decode(data);
    }

    setState(() {
      isLoading = false;
      this.feedbacks = feedbacks;
    });
  }

  @override
  void initState(){
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
        title: Text("Feedbacks"),
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
          itemCount: this.feedbacks != null ? this.feedbacks.length : 0,
          itemBuilder: (context,i){
            feedbackItem = feedbacks[i];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: CircleAvatar(
                                  child: Icon(Icons.person_outline_outlined),
                                ),
                              ),
                              flex: 1,
                            ),

                            Expanded(
                              flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:8.0),
                                  child: Text(
                                    feedbackItem['name'],
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.justify,
                                  ),
                                )
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left:18.0,bottom:8),
                          child: Text(feedbackItem['message']),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(left:18.0,bottom: 10),
                          child: Text(feedbackItem['date_of_feedback'].toString().split("T").first),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  // Divider(
                  //   color: Colors.white,
                  // ),
                ],
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Color(0xff303030),
        backgroundColor: Color(0xff030303),
        child: Icon(Icons.add_comment,color: Colors.white,),
        elevation: 10.0,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return FeedBackNew();
          }));
        },
      ),
    );
  }
}