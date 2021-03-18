import 'package:flutter/material.dart';
import 'package:foodforthought/pages/homeshortcut.dart';
import 'package:foodforthought/pages/myloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:page_transition/page_transition.dart';

class ThoughtToday extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ThoughtTodayState();
  }
}

class _ThoughtTodayState extends State<ThoughtToday>{

  bool isLoading = true;
  bool isPlaying = false;
  var title = "";
  var author = "";
  var audioFile;
  var audioUrl = "";
  var quotation = "";
  String audioStatus = "";
  AudioPlayer audioPlayer = AudioPlayer();
  IconData playBtn = Icons.play_circle_outline_rounded;

  Duration totalDuration = new Duration();
  Duration position = new Duration();

  _initAudio() async{
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      setState(() {
        totalDuration = updatedDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      setState(() {
        position = updatedPosition;
      });
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        playBtn = Icons.play_circle_outline_outlined;
        isPlaying = false;
        _stopAudio();
      });
    });

    audioPlayer.onPlayerStateChanged.listen((updatedStatus) {
      if(updatedStatus == AudioPlayerState.PLAYING){
        setState(() {

        audioStatus = "Playing";
        });
      }
      if(updatedStatus == AudioPlayerState.PAUSED){
        setState(() {

        audioStatus = "Paused";
        });
      }
    });
  }



  _fetchDataToday() async {
    final url = "https://www.connectdjango.com/api/thoughtlist/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var thought2day = jsonData[0];
      title = thought2day['title'];
      author = thought2day['author'];
      quotation = thought2day['bible_quotations'];
      audioFile = thought2day['audio_content'];
    }

    setState(() {
      isLoading = false;
    });
  }

  _playAudio() async{
    await audioPlayer.play(audioFile, isLocal: true);
  }

  _pauseAudio() async{
    await audioPlayer.pause();
  }

  _stopAudio() async{
    await audioPlayer.stop();
  }

  @override
  void initState() {
    _initAudio();
    setState(() {
      _fetchDataToday();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:  CustomScrollView(
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
                child: Text("Thought Today",style: TextStyle(fontSize: 20.0),),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  _fetchDataToday();
                },
              )
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 30,),
                isLoading ? MyLoading() : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    ),
                    Text(quotation,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    SizedBox(height: 10,),
                    Text(author,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    SizedBox(height: 30,),
                    Text("Listen to audio content below",),
                    SizedBox(height: 20,),
                    // slider(),

                    Padding(
                      padding: const EdgeInsets.only(left:10.0,right:10),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          children: [
                          Padding(
                            padding: const EdgeInsets.only(top:12.0,bottom: 12),
                            child: Text(audioStatus,style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(playBtn,size: 50.0,),
                                  onPressed: () {
                                    if(!isPlaying){
                                      setState(() {
                                        playBtn = Icons.pause_circle_outline_rounded;
                                        isPlaying = true;
                                        _playAudio();
                                      });
                                    }
                                    else{
                                      setState(() {
                                        playBtn = Icons.play_circle_outline_rounded;
                                        isPlaying = false;
                                        _pauseAudio();
                                      });
                                    }
                                  },
                                ),
                                SizedBox(width: 40,),
                                IconButton(
                                    icon: Icon(Icons.stop,size: 50,),
                                    onPressed: (){
                                      setState(() {
                                        _stopAudio();
                                        isPlaying = false;
                                        playBtn = Icons.play_circle_outline_outlined;
                                      });
                                    }
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.only(top:12.0,bottom:12),
                              child: Text(position.toString().split(".").first),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ])
          )
        ],
      ),
    );
  }
}