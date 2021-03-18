import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodforthought/pages/feedbacks.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class FeedBackNew extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FeedBackNewState();
  }
}

class _FeedBackNewState extends State<FeedBackNew> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  var name;
  var message;

  _addToComment() async {
    final url = "https://www.connectdjango.com/api/feedbacks/";
    var myLink = Uri.parse(url);
    await http.post(myLink, body: {
      "name": _nameController.text,
      "message": _messageController.text,
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    });
    showToast("Adding your feedback", duration: Toast.LENGTH_LONG);
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: FeedBacks(),
                type: PageTransitionType.leftToRightWithFade),
            (route) => false));
  }

  void showToast(String msg, {duration, gravity}) {
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
              padding: const EdgeInsets.only(top: 8.0, left: 10.0),
              child: Text(
                "What do you think?",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text("Was this thought helpful?"),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: "enter name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    // ignore: missing_return
                    validator: (value) {

                      if (value == null) {
                        // ignore: missing_return, missing_return
                        return "name can't be empty";
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _messageController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "enter feedback",
                        prefixIcon: Icon(Icons.comment),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    // ignore: missing_return
                    validator: (value) {
                      if (value == null) {
                        // ignore: missing_return, missing_return
                        return "feedback can't be empty";
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RawMaterialButton(
                          child: Text("Save",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            } else {
                              _addToComment();
                            }
                          },
                          fillColor: Color(0xFF292929),
                          splashColor: Color(0xFF3d3d3d),
                          shape: StadiumBorder(),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: RawMaterialButton(
                          child: Text("Cancel",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          fillColor: Color(0xFF292929),
                          splashColor: Color(0xFF3d3d3d),
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
    ));
  }
}
