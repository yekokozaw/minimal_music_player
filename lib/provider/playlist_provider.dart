import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:minimal_music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  //playlist of songs
  final List<Song> _playlist = [
    Song(
        songName: "So Sick",
        artistName: "Neyo",
        albumArtImagePath: "assets/images/album_artwork_1.jpeg",
        audioPath: "audio/chill.mp3"),
    Song(
        songName: "Acid Rap",
        artistName: "Chance the Rapper",
        albumArtImagePath: "assets/images/album_artwork_2.jpg",
        audioPath: "audio/chill.mp3"),
    Song(
        songName: "Lucid Dream",
        artistName: "Juice World",
        albumArtImagePath: "assets/images/album_artwork_3.jpg",
        audioPath: "audio/chill.mp3"),
  ];

  //current song playing index
  int? _currentSongIndex;

  /*
    A U D I O P L A Y E R
   */

  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlaylistProvider(){
    listenToDuration();
  }

  //initially not playing
  bool _isPlaying = false;

  //play the song
  void play() async{
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  //pause current song
  void pause() async{
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async{
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async{
    if(_isPlaying){
      pause();
    }else {
      resume();
    }
    notifyListeners();
  }
  //seek to a specific position in the current song
  void seek(Duration position) async{
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong(){
    if(_currentSongIndex != null){
      if(_currentSongIndex! < _playlist.length -1){
        //go to the next song if it's not the last song
        currentSongIndex = currentSongIndex! + 1;
      }else{
        currentSongIndex = 0;
      }
    }
  }

  //play previous song
  void playPreviousSong() async{
    //if more than 2 seonds have passed,restart the current song
    if(_currentDuration.inSeconds > 2){
      seek(Duration.zero);
    }
    else{
      if(_currentSongIndex! > 0){
        currentSongIndex = _currentSongIndex! - 1;
      }else{
        currentSongIndex = _playlist.length - 1;
      }
    }
  }
  //listen to duration
  void listenToDuration(){
    _audioPlayer.onDurationChanged.listen((newDuration){
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition){
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event){
      playNextSong();
    });
  }

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentSongIndex(int? newIndex){

    _currentSongIndex = newIndex;
    if(newIndex != null){
      play();
    }
    //update UI
    notifyListeners();
  }
}