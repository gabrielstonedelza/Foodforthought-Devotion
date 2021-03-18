import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodforthought/pages/about.dart';
import 'package:foodforthought/pages/answers.dart';
import 'package:foodforthought/pages/feedbacks.dart';
import 'package:foodforthought/pages/members.dart';
import 'package:foodforthought/pages/questions.dart';
import 'package:foodforthought/pages/testimonies.dart';
import 'package:foodforthought/pages/thoughts.dart';
import 'package:foodforthought/pages/thoughttoday.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeShortCut extends StatefulWidget {
  @override
  _HomeShortCutState createState() => _HomeShortCutState();
}

class _HomeShortCutState extends State<HomeShortCut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: null,
            pinned: true,
            expandedHeight: 100.0,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(top:8.0,left: 10.0),
                child: Text("Welcome",style: TextStyle(fontSize: 20.0),),
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
          SafeArea(
          child: Padding(
          padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/thought.jpg"),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black26,
                                    Colors.black38
                                  ]
                              )
                          ),
                        ),
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context, PageTransition(child:ThoughtToday(),type:  PageTransitionType.topToBottom), (route) => false);
                        },
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/ideas.jpg"),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black26,
                                    Colors.black38
                                  ]
                              )
                          ),
                        ),
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context, PageTransition(child:Thoughts(),type:  PageTransitionType.bottomToTop), (route) => false);
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(top:12.0,bottom: 12),
                      child: Text("Thought Today",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                    )),

                    Expanded(child: Text("All Thoughts",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/members.jpg"),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black26,
                                    Colors.black38
                                  ]
                              )
                          ),
                        ),
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context, PageTransition(child:Members(),type:  PageTransitionType.leftToRight), (route) => false);
                        },
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/feedback.jpg"),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black26,
                                    Colors.black38
                                  ]
                              )
                          ),
                        ),
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context, PageTransition(child:FeedBacks(),type:  PageTransitionType.rightToLeft), (route) => false);
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(top:12.0,bottom: 12),
                      child: Text("Members",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                    )),

                    Expanded(child: Text("Feedbacks",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))
                  ],
                ),
                Divider(
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/testimony.png"),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black26,
                                    Colors.black38
                                  ]
                              )
                          ),
                        ),
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context, PageTransition(child:Testimonies(),type:  PageTransitionType.leftToRight, duration: Duration(seconds: 2)), (route) => false);
                        },
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/aboutus.jpg"),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black26,
                                    Colors.black38
                                  ]
                              )
                          ),
                        ),
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context, PageTransition(child:AboutUs(),type:  PageTransitionType.rotate), (route) => false);
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(top:12.0,bottom: 12),
                      child: Text("Testimony",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                    )),

                    Expanded(child: Text("About",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/kessben.jpg"),
                                  fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black26,
                                    Colors.black38
                                  ]
                              )
                          ),

                        ),
                        onTap: () async{
                          // ignore: unnecessary_statements, unnecessary_statements
                          String url = "https://kessbenfm.com/?fbclid=IwAR1qmBWsHc8w5l0d59xKhbBN-E7zUM81gul1KKcYwk6nMVnXDL1jiGZ_bmY";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/question.jpg"),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black26,
                                    Colors.black38
                                  ]
                              )
                          ),
                        ),
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context, PageTransition(child:Questions(),type:  PageTransitionType.rightToLeftWithFade), (route) => false);
                        },
                      ),
                    ),
                    // Expanded(child: Container())
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(top:12.0,bottom: 12),
                      child: Text("Listen Live",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                    )),

                    Expanded(child: Text("Questions",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/answers.jpg"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black26,
                                    Colors.black38
                                  ]
                              )
                          ),

                        ),
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context, PageTransition(child:Answers(),type:  PageTransitionType.rotate), (route) => false);
                        },
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Container(

                      ),
                    ),
                    // Expanded(child: Container())
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(top:12.0,bottom: 12),
                      child: Text("Answers",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                    )),

                    Expanded(child: Text("",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))
                  ],
                ),
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
