import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import '../viewmodels/exercise_video_view_model.dart';
import '../../../../l10n/app_localizations.dart';

class ExerciseVideoPage extends StatelessWidget {
  final String videoUrl;

  const ExerciseVideoPage({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExerciseVideoViewModel(videoUrl: videoUrl),
      child: const _ExerciseVideoView(),
    );
  }
}

class _ExerciseVideoView extends StatefulWidget {
  const _ExerciseVideoView();

  @override
  State<_ExerciseVideoView> createState() => _ExerciseVideoViewState();
}

class _ExerciseVideoViewState extends State<_ExerciseVideoView> {
  late FlickManager flickManager;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    if (mounted) {
      setState(() {
        _hasError = false;
      });
    }

    final viewModel = context.read<ExerciseVideoViewModel>();
    final proxyUrl = viewModel.cachedVideoUrl;
    
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(proxyUrl),
      ),
      onVideoEnd: () {
        // Video bittiğinde yapılacak işlemler buraya eklenebilir
      },
    );

    flickManager.flickVideoManager?.addListener(_videoListener);
  }

  void _videoListener() {
    if (flickManager.flickVideoManager?.errorInVideo ?? false) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    flickManager.flickVideoManager?.removeListener(_videoListener);
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _hasError
                ? _buildErrorWidget(loc)
                : FlickVideoPlayer(
                    flickManager: flickManager,
                    flickVideoWithControls: const FlickVideoWithControls(
                      controls: FlickPortraitControls(),
                      playerLoadingFallback: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
          ),
          
          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(AppLocalizations loc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 60),
        const SizedBox(height: 16),
        Text(
          loc.videoError,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            flickManager.dispose();
            if (mounted) {
              _initializePlayer();
            }
          },
          child: Text(loc.videoRetry),
        ),
      ],
    );
  }
}
