import 'package:flutter/material.dart';
import 'package:foodforthought/pages/mydrawer.dart';
import 'package:foodforthought/pages/myloading.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'homeshortcut.dart';
import 'newmember.dart';


class Members extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MembersState();
  }
}

class _MembersState extends State<Members>{

  var memberName;
  bool isLoading = true;
  List members = [];
  var items;

  _fetchData() async{
    final url = "https://www.connectdjango.com/api/members/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);
    if(response.statusCode ==200){
      final codeUnits = response.body.codeUnits;
      var data = Utf8Decoder().convert(codeUnits);
      members = json.decode(data);
    }

    setState(() {
      isLoading = false;
      this.members = members;
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
        title: Text("Members"),
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
          itemCount: this.members != null ? this.members.length : 0,
          itemBuilder: (context,i){
            items = members[i];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ListTile(
                        leading: Icon(Icons.person,color:Colors.white),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom:8.0),
                          child: Text(items['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        subtitle: Row(
                          children: [
                            Expanded(child: Text("Date Joined: ")),
                            Expanded(child: Text(items['date_joined'].toString().split("T").first)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Color(0xff303030),
        backgroundColor: Color(0xff030303),
        child: Icon(Icons.person_add_alt_1_outlined,color: Colors.white,),
        elevation: 10.0,
        tooltip: "Become a member",
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return NewMemberPage();
          }));
        },
      ),
    );
  }
}