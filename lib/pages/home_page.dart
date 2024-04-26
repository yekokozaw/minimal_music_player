import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_music_player/components/my_drawer.dart';
import 'package:minimal_music_player/pages/song_page.dart';
import 'package:minimal_music_player/provider/playlist_provider.dart';
import 'package:provider/provider.dart';

import '../models/song.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final dynamic playlistProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    playlistProvider.currentSongIndex = songIndex;

    //navigate to song page
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SongPage()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('P L A Y L I S T'),
        ),
        drawer: const MyDrawer(),
        body: Consumer<PlaylistProvider>(
          builder: (context, value, child) {
            final List<Song> playlist = value.playlist;
            //return list view UI
            return ListView.builder(
                itemCount: playlist.length,
                itemBuilder: (context, index) {
                  final Song song = playlist[index];

                  return ListTile(
                    title: Text(song.songName),
                    subtitle: Text(song.artistName),
                    leading: Image.asset(
                      song.albumArtImagePath, width: 80, fit: BoxFit.fill,),
                    onTap: () => goToSong(index),
                  );
                }
            );
          },
        )
    );
  }
}
