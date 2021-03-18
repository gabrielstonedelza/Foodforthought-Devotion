import 'package:flutter/material.dart';
import 'package:foodforthought/pages/about.dart';
import 'package:foodforthought/pages/feedbacks.dart';
import 'package:foodforthought/pages/homeshortcut.dart';
import 'package:foodforthought/pages/members.dart';
import 'package:foodforthought/pages/testimonies.dart';
import 'package:foodforthought/pages/thoughttoday.dart';
import 'package:foodforthought/pages/thoughts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:page_transition/page_transition.dart';


class MyDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("FoodForThought",style: TextStyle(fontWeight: FontWeight.bold),),
            accountEmail: Text("dailymotivational@gmail.com",style: TextStyle(fontWeight: FontWeight.bold),),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/bible.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home",style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("Go to main"),
            onTap: (){

              Navigator.pushAndRemoveUntil(context, PageTransition(child:HomeShortCut(),type:  PageTransitionType.topToBottom), (route) => false);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lightbulb_outlined,color: Colors.yellow,),
            title: Text("Today",style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("Thought for today"),
            onTap: (){

              Navigator.pushAndRemoveUntil(context, PageTransition(child:ThoughtToday(),type:  PageTransitionType.topToBottom), (route) => false);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lightbulb_outline_rounded),
            title: Text("Thoughts",style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("All thoughts"),
              onTap: (){

                Navigator.pushAndRemoveUntil(context, PageTransition(child:Thoughts(),type:  PageTransitionType.fade), (route) => false);
              }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people_outline_outlined),
            title: Text("Members",style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("Our Members"),
              onTap: (){

                Navigator.pushAndRemoveUntil(context, PageTransition(child:Members(),type:  PageTransitionType.fade), (route) => false);
              }
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.comment),
              title: Text("Feedbacks",style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text("Want to hear your thoughts"),
              onTap: (){

                Navigator.pushAndRemoveUntil(context, PageTransition(child:FeedBacks(),type:  PageTransitionType.fade), (route) => false);
              }
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.insert_comment_sharp),
              title: Text("Testimonies",style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text("Feedbacks"),
              onTap: (){

                Navigator.pushAndRemoveUntil(context, PageTransition(child:Testimonies(),type:  PageTransitionType.fade), (route) => false);
              }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text("About",style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("About us"),
              onTap: (){

                Navigator.pushAndRemoveUntil(context, PageTransition(child:AboutUs(),type:  PageTransitionType.fade), (route) => false);
              }
          ),
          Divider(),
          ListTile(
              leading: Image(
                color: Colors.white,
                width: 40,
                height: 40,
                image: Svg("assets/images/broadcast.svg"),
              ),
              title: Text("Listen Live",style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text("Listen live to all our programs"),
              onTap: () async{
                  // ignore: unnecessary_statements, unnecessary_statements
                  String url = "https://kessbenfm.com/?fbclid=IwAR1qmBWsHc8w5l0d59xKhbBN-E7zUM81gul1KKcYwk6nMVnXDL1jiGZ_bmY";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }
          ),
        ],
      ),
    );
  }
}