import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:SoundTrek/utilities/appcolors.dart' as AppColors;
import '../utilities/audiofile.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer advancedPlayer;

  @override
  void initState(){
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: [
        Positioned(
            left: 0,
            right: 0,
            top: screenHeight*0.2,
            height: screenHeight*0.36,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              color: Colors.white,
              ),
              child: Column(
                children: [
                  AudioFile(advancedPlayer: advancedPlayer, audioPath: "C:\Users\Kalob\Documents\AndroidStudioProjects\Sound_Trek\assets\musicsample\acoustic.mp3",)
                ],
              ),
            )),
        Positioned(
            top: screenHeight*0.12,
            left: (screenWidth-150)/2,
            right: (screenWidth-150)/2,
            height: screenHeight*0.16,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color:Colors.white, width: 2),
                color: AppColors.audioBackground2,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5),
                    // image: DecorationImage(
                    //   image: AssetImage(widget.musicData[widget.index]["img"]),
                    //   fit: BoxFit.cover
                    )
                  ),
                ),
              ),
            )
      ],),
    );
  }
}
