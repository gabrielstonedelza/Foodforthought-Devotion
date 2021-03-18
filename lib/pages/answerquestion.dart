import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodforthought/pages/answers.dart';
import 'package:foodforthought/pages/questions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class AnswerQuestion extends StatefulWidget {
  int questionId;
  String question;
  String questionOwner;
  AnswerQuestion(this.questionId,this.question,this.questionOwner);
  @override
  _AnswerQuestionState createState() => _AnswerQuestionState(this.questionId,this.question,this.questionOwner);
}

class _AnswerQuestionState extends State<AnswerQuestion> {
  int questionId;
  String question;
  String questionOwner;
  _AnswerQuestionState(this.questionId,this.question,this.questionOwner);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _answerController = TextEditingController();


  _addAnswer() async{
    final url = "https://www.connectdjango.com/api/answers/";
    var myLink = Uri.parse(url);
    await http.post(myLink,
        body: {"question":questionId.toString(),"answer": _answerController.text},
        headers: {"Content-Type": "application/x-www-form-urlencoded"}
    );
    showToast("Adding your answer",duration: Toast.LENGTH_LONG);
    Timer(Duration(seconds: 1),()=> Navigator.pushAndRemoveUntil(context, PageTransition(child:Answers(),type:  PageTransitionType.leftToRightWithFade), (route) => false) );
  }
  void showToast(String msg, {duration,gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              // title: Text("Thought Today"),
              pinned: true,
              expandedHeight: 100.0,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Padding(
                  padding: const EdgeInsets.only(top:8.0,left: 10.0),
                  child: Text("Answer $questionOwner",style: TextStyle(fontSize: 15.0),),
                ),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("Question",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(question,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                ),
              ),
              SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _answerController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            labelText: "answer",
                            prefixIcon: Icon(Icons.comment_outlined),

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            )
                        ),
                        // ignore: missing_return
                        validator: (value){
                          if(value == null){
                            // ignore: missing_return, missing_return
                            return "you must answer this question";
                          }
                        },
                      ),

                      SizedBox(height: 30,),
                      Row(
                        children: [
                          Expanded(
                            child: RawMaterialButton(
                              child: Text("Save"),
                              onPressed: (){
                                if(!_formKey.currentState.validate()){
                                  return;
                                }else{
                                  _addAnswer();
                                }
                              },
                              fillColor: kPrimaryColor,
                              splashColor: kBackgroundColor,
                              // textColor: Colors.white,
                              shape: StadiumBorder(),
                            ),
                          ),
                          SizedBox(width: 30,),
                          Expanded(
                            child: RawMaterialButton(
                              child: Text("Cancel"),
                              onPressed: (){
                                Navigator.pushAndRemoveUntil(context, PageTransition(child:Questions(),type:  PageTransitionType.rotate), (route) => false);
                              },
                              fillColor: kPrimaryColor,
                              splashColor: kBackgroundColor,
                              // textColor: Colors.white,
                              shape: StadiumBorder(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]))
          ],
        )
    );
  }
}
