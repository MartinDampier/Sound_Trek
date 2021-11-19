import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons(this._audioPlayer, {Key? key}) : super(key: key);

  final AudioPlayer _audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StreamBuilder <bool> (
          stream: _audioPlayer.shuffleModeEnabledStream,
          builder: (context, snapshot) {
            return _shuffleButton(context, snapshot.data ?? false);
          },
        ),
        StreamBuilder <SequenceState?> (
          stream: _audioPlayer.sequenceStateStream,
          builder: (_, __) {
            return _previousButton();
          },
        ),
        StreamBuilder <PlayerState> (
          stream: _audioPlayer.playerStateStream,
          builder: (_, snapshot) {
            final playerState = snapshot.data;
            return _playPauseButton(playerState!);
          },
        ),
        StreamBuilder <SequenceState?> (
          stream: _audioPlayer.sequenceStateStream,
          builder: (_, __) {
            return _nextButton();
          },
        ),
        StreamBuilder <LoopMode> (
          stream: _audioPlayer.loopModeStream,
          builder: (context, snapshot) {
            return _repeatButton(context, snapshot.data ?? LoopMode.off);
          },
        )
      ],
    );
  }

  Widget _playPauseButton(PlayerState playerState) {
    final processingState = playerState.processingState;

    if(processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
      return Container(
        margin: EdgeInsets.all(8.0),
        width: 64.0,
        height: 64.0,
        child: CircularProgressIndicator(),
      );
    }
    else if (_audioPlayer.playing != true) {
      return IconButton(onPressed: _audioPlayer.play, icon: Icon(Icons.play_arrow_rounded), iconSize: 64.0,);
    }
    else if (processingState != ProcessingState.completed) {
      return IconButton(onPressed: _audioPlayer.pause, icon: Icon(Icons.pause_rounded), iconSize: 64.0,);
    }
    else {
      return IconButton(onPressed: () => _audioPlayer.seek(Duration.zero, index: _audioPlayer.effectiveIndices!.first), icon: Icon(Icons.replay), iconSize: 64.0,);
    }
  }

  Widget _shuffleButton(BuildContext context, bool isEnabled) {
    return IconButton(
      icon: isEnabled
          ? Icon(Icons.shuffle_rounded, color: Theme.of(context).accentColor)
          : Icon(Icons.shuffle_rounded),
      onPressed: () async {
        final enable = !isEnabled;
        if (enable) {
          await _audioPlayer.shuffle();
        }
        await _audioPlayer.setShuffleModeEnabled(enable);
      },
    );
  }

  Widget _previousButton() {
    return IconButton(
      icon: Icon(Icons.skip_previous_rounded),
      onPressed: _audioPlayer.hasPrevious ? _audioPlayer.seekToPrevious : null,
    );
  }

  Widget _nextButton() {
    return IconButton(
      icon: Icon(Icons.skip_next_rounded),
      onPressed: _audioPlayer.hasNext ? _audioPlayer.seekToNext : null,
    );
  }

  Widget _repeatButton(BuildContext context, LoopMode loopMode) {
    final icons = [
      Icon(Icons.repeat_rounded),
      Icon(Icons.repeat_rounded, color: Theme.of(context).accentColor),
      Icon(Icons.repeat_one_rounded, color: Theme.of(context).accentColor),
    ];
    const cycleModes = [
      LoopMode.off,
      LoopMode.all,
      LoopMode.one,
    ];
    final index = cycleModes.indexOf(loopMode);
    return IconButton(
      icon: icons[index],
      onPressed: () {
        _audioPlayer.setLoopMode(
            cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
      },
    );
  }
}
