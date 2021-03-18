import 'package:flutter/material.dart';
import 'package:foodforthought/pages/answerquestion.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

import '../constants.dart';

// ignore: must_be_immutable
class VerifyAndAnswer extends StatefulWidget {
  int questionId;
  String question;
  String questionOwner;
  VerifyAndAnswer(this.questionId,this.question,this.questionOwner);
  @override
  _VerifyAndAnswerState createState() => _VerifyAndAnswerState(this.questionId,this.question,this.questionOwner);
}

class _VerifyAndAnswerState extends State<VerifyAndAnswer> {
  int questionId;
  String question;
  String questionOwner;
  _VerifyAndAnswerState(this.questionId,this.question,this.questionOwner);

  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  _proceedToAnswer(){
    var username = "food4thoughtdaily";
    var password = "foodforthoughtisgood10?";

    if(_usernameController.text == username && _passwordController.text == password){
      showToast("Validation was successful",duration: Toast.LENGTH_LONG);
      Navigator.pushAndRemoveUntil(context, PageTransition(child:AnswerQuestion(this.questionId,this.question,this.questionOwner),type:  PageTransitionType.rotate), (route) => false);
    }
    else{
      showToast("The information is wrong",duration: Toast.LENGTH_LONG);
    }
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
                  child: Text("Enter administrator details",style: TextStyle(fontSize: 14.0),),
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
                        controller: _usernameController,
                        decoration: InputDecoration(
                            labelText: "username",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            )
                        ),
                        // ignore: missing_return
                        validator: (value){
                          if(value == null){
                            // ignore: missing_return, missing_return
                            return "enter username please";
                          }
                        },
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            labelText: "password",
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            )
                        ),
                        // ignore: missing_return
                        validator: (value){
                          if(value == null){
                            return "enter password please";
                          }
                        },
                obscureText: true,
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
                                  _proceedToAnswer();
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
                      SizedBox(height: 40,),
                      Text("You must be admin to answer a question")
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
