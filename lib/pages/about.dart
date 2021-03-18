import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodforthought/gestures/mygestures.dart';
import 'package:foodforthought/pages/aboutustext.dart';
import 'package:foodforthought/pages/mydrawer.dart';
import 'package:page_transition/page_transition.dart';

import 'homeshortcut.dart';

class AboutUs extends StatefulWidget{

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // title: Text("Thought Today"),
            leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: (){
                Navigator.pushAndRemoveUntil(context, PageTransition(child:HomeShortCut(),type:  PageTransitionType.topToBottom), (route) => false);
              },
            ),
            pinned: true,
            expandedHeight: 100.0,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(top:8.0,left: 10.0),
                child: Text("About Us",style: TextStyle(fontSize: 20.0),),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 30,),
                Center(child: Text("Welcome to FoodForThought Group",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                // SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          aboutUs(),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 10,),
                                Text("Connect with us on Facebook"),
                                SizedBox(height: 10,),
                                MyGestures("https://web.facebook.com/groups/142903436398","assets/images/facebook.svg")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                SizedBox(height: 30,),
                Center(
                    child: Text("Host",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                ),
                SizedBox(height: 30,),

                Padding(
                  padding: const EdgeInsets.only(left:10.0,right:10),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)
                    ),
                    child:
                      Column(
                        children: [
                          SizedBox(width: 10,),
                          Padding(
                            padding: const EdgeInsets.only(top:10.0),
                            child: Text("Omannhene Yaw Adu-Boakye",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(bottom:12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyGestures("https://web.facebook.com/omannhene.yawaduboakye", "assets/images/facebook.svg"),
                                SizedBox(width: 30,),
                                MyGestures("https://www.instagram.com/onanhene5/", 'assets/images/instagram.svg')
                              ],
                            ),
                          )
                        ],
                      )
                  ),
                ),
                Divider(),
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Developer",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    SizedBox(height: 18,),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,right:10),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("Gabriel Akwasi Asare",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                            ),
                            Text("Havens Software Development",style: TextStyle(fontSize: 10),),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.only(top:10.0,bottom:10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: MyGestures("https://web.facebook.com/connect.django/","assets/images/facebook.svg"),
                                  ),
                                  // SizedBox(width: 30,),
                                  Expanded(
                                    child: MyGestures("https://www.instagram.com/gabriel_stonedelza/","assets/images/instagram.svg"),
                                  ),
                                  Expanded(
                                    child: MyGestures("https://github.com/gabrielstonedelza","assets/images/github.svg"),
                                  ),
                                  Expanded(
                                    child: MyGestures("https://medium.com/@gabrielstonedelza/about","assets/images/medium.svg"),
                                  ),
                                  Expanded(
                                    child: MyGestures("https://www.linkedin.com/in/gabriel-akwasi-asare-2367021a6/","assets/images/linkedin.svg"),
                                  ),

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: Text("Email: gabrielstonedelza@gmail.com\n"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom:10.0),
                              child: Text("joygem2002@yahoo.com"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100,)
              ])
          )
        ],
      ),
    );
  }
}