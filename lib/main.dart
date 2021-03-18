import 'package:flutter/material.dart';
import 'package:foodforthought/constants.dart';
import 'package:foodforthought/pages/about.dart';
import 'package:foodforthought/pages/addnewtestimony.dart';
import 'package:foodforthought/pages/addquestion.dart';
import 'package:foodforthought/pages/answers.dart';
import 'package:foodforthought/pages/feedbacks.dart';
import 'package:foodforthought/pages/addfeedback.dart';
import 'package:foodforthought/pages/homeshortcut.dart';
import 'package:foodforthought/pages/members.dart';
import 'package:foodforthought/pages/newmember.dart';
import 'package:foodforthought/pages/questions.dart';
import 'package:foodforthought/pages/testimonies.dart';
import 'package:foodforthought/pages/thoughttoday.dart';
import 'package:foodforthought/pages/thoughts.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyWelcomeTransition(),
      routes: <String, WidgetBuilder>{
        '/today': (BuildContext context) => ThoughtToday(),
        '/thoughts': (BuildContext context) => Thoughts(),
        '/members': (BuildContext context) => Members(),
        '/becomeMember': (BuildContext context) => NewMemberPage(),
        '/aboutus': (BuildContext context) => AboutUs(),
        '/comments': (BuildContext context) => FeedBacks(),
        '/commentsadd': (BuildContext context) => FeedBackNew(),
        '/testimonies': (BuildContext context) => Testimonies(),
        '/newtestimony': (BuildContext context) => NewTestimony(),
        '/questions': (BuildContext context) => Questions(),
        '/addquestion': (BuildContext context) => QuestionNew(),
        '/answers': (BuildContext context) => Answers(),
      },
    );
  }
}


class MyWelcomeTransition extends StatefulWidget {
  @override
  _MyWelcomeTransitionState createState() => _MyWelcomeTransitionState();
}

class _MyWelcomeTransitionState extends State<MyWelcomeTransition> with TickerProviderStateMixin{

  PageController pageController;
  AnimationController rippleController;
  AnimationController scaleController;

  Animation<double> rippleAnimation;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(
        initialPage: 0
    );

    rippleController = AnimationController(vsync: this,duration:Duration(seconds: 1));
    scaleController = AnimationController(
        vsync: this,
        duration:Duration(seconds: 2))
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed){
          Navigator.pushAndRemoveUntil(context, PageTransition(child:HomeShortCut(),type:  PageTransitionType.topToBottom), (route) => false);
        }
      });

    rippleAnimation = Tween<double>(
        begin: 80.0,
        end: 90.0
    ).animate(rippleController)..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        rippleController.reverse();
      }else if(status == AnimationStatus.dismissed){
        rippleController.forward();
      }
    });

    scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 30.0
    ).animate(scaleController);

    rippleController.forward();
  }

  @override
  void dispose() {
    rippleController.dispose();
    scaleController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          makePage(image: "assets/images/joyful-1.jpg"),
        ],
      ),
    );
  }

  Widget makePage({image}){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(image))),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.3),
                ]
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Welcome to FoodForThought",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right:12,top: 10),
              child: Text("with Omanhene Yaw Adu Boakye",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            SizedBox(height: 12,),
            Text("Your Daily Bible Devotion",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedBuilder(
                animation: rippleAnimation,
                builder: (context,child){
                  return Container(
                    width: rippleAnimation.value,
                    height: rippleAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.withOpacity(.4)
                      ),
                      child: InkWell(
                        onTap: (){
                          scaleController.forward();
                        },
                        child: AnimatedBuilder(
                          animation: scaleAnimation,
                          builder: (context, child) => Transform.scale(
                            scale: scaleAnimation.value,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kPrimaryColor
                              ),
                              child: Center(child: Text("Hi")),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

