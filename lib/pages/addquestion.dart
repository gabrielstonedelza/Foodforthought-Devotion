import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodforthought/constants.dart';
import 'package:foodforthought/pages/questions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class QuestionNew extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _QuestionNewState();
  }
}

class _QuestionNewState extends State<QuestionNew>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _questionController = TextEditingController();


  _addToQuestion() async{
    final url = "https://www.connectdjango.com/api/questions/";
    var myLink = Uri.parse(url);
    await http.post(myLink,
        body: {"name": _nameController.text,"email": _emailController.text,"question": _questionController.text},
        headers: {"Content-Type": "application/x-www-form-urlencoded"}
    );
    showToast("Adding your question",duration: Toast.LENGTH_LONG);

    Timer(Duration(seconds: 1),()=> Navigator.pushAndRemoveUntil(context, PageTransition(child:Questions(),type:  PageTransitionType.leftToRightWithFade), (route) => false) );
  }

  void showToast(String msg, {duration,gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                  child: Text("Got any question?",style: TextStyle(fontSize: 20.0),),
                ),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([

              SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            labelText: "enter name",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            )
                        ),
                        // ignore: missing_return
                        validator: (value){
                          if(value == null){
                            // ignore: missing_return, missing_return
                            return "name can't be empty";
                          }
                        },
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "enter email",
                            hintText: "get notified when answered",
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            )
                        ),
                        // ignore: missing_return
                        validator: (value){
                          if(value == null){
                            // ignore: missing_return, missing_return
                            return "email can't be empty";
                          }
                        },
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        controller: _questionController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "enter question",
                            prefixIcon: Icon(Icons.comment),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            )
                        ),
                        // ignore: missing_return
                        validator: (value){
                          if(value == null){
                            // ignore: missing_return, missing_return
                            return "question can't be empty";
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
                                  _addToQuestion();
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
                                Navigator.pop(context);
                              },
                              fillColor: kPrimaryColor,
                              splashColor: kBackgroundColor,
                              // textColor: Colors.white,
                              shape: StadiumBorder(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
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