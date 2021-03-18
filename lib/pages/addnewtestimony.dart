import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodforthought/pages/testimonies.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class NewTestimony extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewTestimonyState();
  }
}

class _NewTestimonyState extends State<NewTestimony> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _testimonyController = TextEditingController();

  _addToTestimony() async {
    final url = "https://www.connectdjango.com/api/testimonies/";
    var myLink = Uri.parse(url);
    await http.post(myLink, body: {
      "name": _nameController.text,
      "testimony": _testimonyController.text,
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    });
    showToast("Adding your testimony", duration: Toast.LENGTH_LONG);
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: Testimonies(),
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
                  "Add your testimony",
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
                    Text("Let's hear what food for thought has done for."),
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
                          return "name cannot be empty";
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _testimonyController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "enter testimony",
                          prefixIcon: Icon(Icons.comment),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      // ignore: missing_return
                      validator: (value) {
                        if (value == null) {
                          // ignore: missing_return, missing_return
                          return "testimony can't be empty";
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
                            child: Text("Save"),
                            onPressed: () {
                              if (!_formKey.currentState.validate()) {
                                return;
                              } else {
                                _addToTestimony();
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
                            child: Text("Cancel"),
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
      ),
    );
  }
}
