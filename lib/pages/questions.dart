import 'package:flutter/material.dart';
import 'package:foodforthought/pages/addquestion.dart';
import 'package:foodforthought/pages/mydrawer.dart';
import 'package:foodforthought/pages/verifyandadd.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'dart:convert';

import 'homeshortcut.dart';
import 'myloading.dart';

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  bool isLoading = true;
  List questions = [];
  var questionItems;

  _fetchQuestions() async{
    final url = "https://www.connectdjango.com/api/questions/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);
    if(response.statusCode == 200){
      final codeUnits = response.body.codeUnits;
      var data = Utf8Decoder().convert(codeUnits);
      questions = json.decode(data);
    }

    setState(() {
      isLoading = false;
      this.questions = questions;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _fetchQuestions();
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
        title: Text("Questions"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              _fetchQuestions();
            },
          )
        ],
      ),
      body: isLoading ? MyLoading() : ListView.builder(
          itemCount: this.questions != null ? this.questions.length : 0,
          itemBuilder: (context,i){
            questionItems = questions[i];
            return Padding(
              padding: const EdgeInsets.only(top:12.0,left: 10,right: 10,bottom: 10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return VerifyAndAnswer(this.questions[i]['id'],this.questions[i]['question'],this.questions[i]['name']);
                  }));
                },
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
                              child: Text(questionItems['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                          ),
                          // Expanded(
                          //     child: Text(questionItems['answered'] ? "Answered": "Not answered")
                          // )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:18.0,bottom: 10),
                        child: Text(questionItems['question']),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_comment),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return QuestionNew();
          }));
        },
      ),
    );
  }
}
