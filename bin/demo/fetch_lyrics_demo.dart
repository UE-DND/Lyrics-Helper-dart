import 'dart:convert';
import 'package:lyricify_lyrics_helper/lyrics_helper.dart';
import 'package:lyricify_lyrics_helper/models/track_metadata.dart';

void main() async {
  final track = TrackMetadata()..title = '百花繚乱';

  print('Searching lyrics for: ${track.title}');

  final result = await LyricsHelper.fetchLyricsFull(track);

  print('Status: ${result.status}');
  if (result.status == FetchStatus.success) {
    final jsonPretty =
        const JsonEncoder.withIndent('  ').convert(result.lyricsData);
    print('Lyrics parsed ->');
    print(jsonPretty);
  } else {
    print('Message: ${result.message}');
    if (result.rawLyrics != null) {
      print('--- Raw Lyrics ---');
      print(result.rawLyrics);
    }
  }
}
