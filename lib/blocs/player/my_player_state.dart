part of 'player_bloc.dart';

enum PlayerStatus {
  initial, // When PlayerBloc is first created or after the player has been reset.
  loading, // When a new track or playlist is loaded into the player.
  loaded, // When the player successfully finishes loading a track or playlist.
  playPressed, // When the user presses the play button but the audio playback has not started yet.
  playing, // When the audio playback is in progress.
  // paused, // When the audio playback is paused.
  // stopped, // When the audio playback is stopped.
  // completed, // When the audio playback completes all tracks in the queue.
  error, // When an error occurs within the player (e.g., loading or playback fails).
}

class MyPlayerState extends Equatable {
  final PlayerStatus status;
  final Failure failure;
  final AudioPlayer player;
  // Background color, extracted from the track's cover image
  // We use HSLColor so operations to adjust lightness are more efficient (avoids unecessary conversions)
  final HSLColor backgroundColor;
  List<Track> queue;

  /// Source of the current track being played (where is the track playing from?)
  /// Examples: PLAYLIST, SEARCH or BUNDLE
  final String source;

  MyPlayerState({
    required this.status,
    required this.failure,
    required this.player,
    required this.backgroundColor,
    required this.queue,
    required this.source,
  });

  factory MyPlayerState.initial(
      {required AudioPlayer player, ConcatenatingAudioSource? audioSource}) {
    // logger.f('MyPlayerState.initial: player.hashCode = ${player.hashCode}');
    return MyPlayerState(
      status: PlayerStatus.initial,
      failure: const Failure(),
      player: player,
      backgroundColor: HSLColor.fromColor(Core.appColor.primary),
      queue: [],
      source: 'INITIAL',
    );
  }

  @override
  List<Object?> get props => [
        status,
        failure,
        player,
        backgroundColor,
        queue,
        source,
      ];

  MyPlayerState copyWith({
    PlayerStatus? status,
    Failure? failure,
    AudioPlayer? player,
    ConcatenatingAudioSource? audioSource,
    HSLColor? backgroundColor,
    List<Track>? queue,
    String? source,
  }) {
    return MyPlayerState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      player: player ?? this.player,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      queue: queue ?? this.queue,
      source: source ?? this.source,
    );
  }
}
