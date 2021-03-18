import 'package:flutter/material.dart';

class HomeGestures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                ),
                SizedBox(width: 20,),
                Expanded(
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
            Divider()
          ],
        ),
      ),
    );
  }
}
