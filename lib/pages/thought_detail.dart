import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:foodforthought/pages/myloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:page_transition/page_transition.dart';
import 'homeshortcut.dart';

class ThoughtDetail extends StatefulWidget{
  String detailTitle;
  var detailId;
  ThoughtDetail(this.detailTitle,this.detailId);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ThoughtDetailState(this.detailTitle,this.detailId);
  }
}

class _ThoughtDetailState extends State<ThoughtDetail>{
  String detailTitle;
  var detailId;
  _ThoughtDetailState(this.detailTitle,this.detailId);

  bool isLoading = true;
  bool isPlaying = false;
  var title = "";
  var author = "";
  var audioFile;
  var quotation = "";
  String audioStatus = "";
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache cache;
  Duration totalDuration = new Duration();
  Duration position = new Duration();
  List items = [];
  IconData playBtn = Icons.play_circle_outline_rounded;
  List comments = [];
  int likesCount = 0;

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
      if(updatedStatus == AudioPlayerState.STOPPED){
        setState(() {
          audioStatus = "Not Playing";
        });
      }
      if(updatedStatus == AudioPlayerState.COMPLETED){
        setState(() {
          audioStatus = "Not Playing";
          isPlaying = false;
          _stopAudio();
        });
      }
    });

    audioPlayer.positionHandler = (p){
      setState((){
        position = p;
      });
    };

    audioPlayer.durationHandler = (d){
      setState(() {
        totalDuration = d;
      });
    };
    cache.load(audioFile);
  }

  _stopAudio() async{
    await audioPlayer.stop();
  }

  _fetchData() async{
    final url = "https://www.connectdjango.com/api/thoughtlist/$detailId";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);
    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      var thought2day = jsonData;
      title = thought2day['title'];
      author = thought2day['author'];
      quotation = thought2day['bible_quotations'];
      audioFile = thought2day['audio_content'];

    }

    setState(() {
      isLoading = false;
    });
  }

  Widget slider(){
    return Slider(
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
        value: this.position.inSeconds.toDouble(),
        max: this.totalDuration.inSeconds.toDouble(),

        onChanged: (value){
          seekToSec(value.toInt());
        }
    );
  }

  void seekToSec(int sec){
    Duration newPos = new Duration(seconds: sec);
    audioPlayer.seek(newPos);
  }

  _playAudio() async{
    await audioPlayer.play(audioFile);
  }

  _pauseAudio() async{
    await audioPlayer.pause();
  }

  @override
  void initState() {
    _initAudio();
    setState(() {
      _fetchData();
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
                padding: const EdgeInsets.only(top:10.0,left: 10.0),
                child: Text(detailTitle,style: TextStyle(fontSize: 10.0),),
              ),
            ),
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
          SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 30,),
                isLoading ? MyLoading() : Column(
                  children: [
                Padding(
                  padding: const EdgeInsets.only(left:12,right: 12),
                  child: Text(detailTitle,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(quotation,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      SizedBox(height: 10,),
                      Text(author,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Listen to audio content below"),
                    SizedBox(height: 20,),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left:10.0,right:10),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Column(
                      children: [
                        slider(),
                        Padding(
                          padding: const EdgeInsets.only(top:12,bottom:12),
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
                        SizedBox(height: 35,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(position.toString().split(".").first),
                            SizedBox(height: 35,),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                  ],
                ),
                SizedBox(height: 35,),
              ])
          )
        ],
      ),

    );
  }

  Widget loading(){
    return Center(
      child: Column(
        children: [
          CircularProgressIndicator(),
          Text("loading please wait")
        ],
      ),
    );
  }

}