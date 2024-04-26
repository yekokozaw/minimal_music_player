import 'package:flutter/material.dart';
import 'package:minimal_music_player/components/new_box.dart';
import 'package:minimal_music_player/provider/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String formatTime(Duration duration){
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context,value,child) {
      //get playlist
      final playlist = value.playlist;

      //get current song index
      final currentSong = playlist[value.currentSongIndex ?? 0];

      return Scaffold(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //app bar style
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back)
                    ),
                    const Text('P L A Y L I S T'),
                    IconButton(
                        onPressed: () {

                        },
                        icon: const Icon(Icons.menu)
                    ),
                  ],
                ),
                const SizedBox(height: 25,),
                NewBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                              currentSong.albumArtImagePath),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(currentSong.songName, style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                )),
                                Text(currentSong.artistName)
                              ],
                            ),
                            Icon(Icons.favorite, color: Colors.red)
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                //song duration progress
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //start time
                      Text(formatTime(value.currentDuration)),

                      //shuffle icon
                      Icon(Icons.shuffle),

                      //repeat icon
                      Icon(Icons.repeat),

                      Text(formatTime(value.totalDuration))
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 0)
                  ),
                  child: Slider(
                      min: 0,
                      max: value.totalDuration.inSeconds.toDouble(),
                      value: value.currentDuration.inSeconds.toDouble(),
                      activeColor: Colors.green,
                      onChanged: (double double) {

                      },
                      onChangeEnd: (double double){
                        value.seek(Duration(seconds: double.toInt()));
                      },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    //skip previous
                    Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: const NewBox(
                              child: Icon(Icons.skip_previous)),
                        )
                    ),
                    SizedBox(width: 25),
                    Expanded(
                      flex: 2,
                        child: GestureDetector(
                          onTap: value.pauseOrResume,
                          child: NewBox(
                              child: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
                        )
                      ),
                    ),
                      SizedBox(width: 25),
                    Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: const NewBox(
                              child: Icon(Icons.skip_next)),
                        )
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
