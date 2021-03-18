import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'dart:convert';

import 'homeshortcut.dart';
import 'mydrawer.dart';
import 'myloading.dart';

class Answers extends StatefulWidget {
  @override
  _AnswersState createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {

  bool isLoading = true;
  List answers = [];
  var answeredItems;
  var id= 0;


  _fetchAnswers() async{
    final url = "https://www.connectdjango.com/api/answers/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);
    if(response.statusCode == 200){
      final codeUnits = response.body.codeUnits;
      var data = Utf8Decoder().convert(codeUnits);
      answers = json.decode(data);
    }

    setState(() {
      isLoading = false;
      this.answers = answers;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _fetchAnswers();
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: (){
            Navigator.pushAndRemoveUntil(context, PageTransition(child:HomeShortCut(),type:  PageTransitionType.topToBottom), (route) => false);
          },
        ),
        title: Text("Answers"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              _fetchAnswers();
            },
          )
        ],
      ),
      body: isLoading ? MyLoading() : ListView.builder(
          itemCount: this.answers != null ? this.answers.length : 0,
          itemBuilder: (context,i){
            answeredItems = answers[i];
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            child: Row(
                              children: [
                                Text("Question by",style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 30,),
                                Text(answeredItems["question_owner"],style: TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:18.0,bottom: 10),
                      child: Text(answeredItems["question_question"]),
                    ),

                    Divider(),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left:18.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top:10,bottom: 10),
                              child: CircleAvatar(
                                child: Icon(Icons.person_outline_outlined,color: Colors.yellow,),
                              ),
                            ),
                            flex: 1,
                          ),

                          Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Text("Answered by",style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(width: 30,),
                                  Text("Admin",style: TextStyle(fontWeight: FontWeight.bold))
                                ],
                              ),
                              // child: Text("Admin",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:40.0,bottom: 10),
                      child: Text(answeredItems['answer']),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:40.0,bottom: 10),
                      child: Text(answeredItems['date_posted'].toString().split("T").first),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
