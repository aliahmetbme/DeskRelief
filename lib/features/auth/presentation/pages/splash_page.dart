import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();

    // Video ayarlarını yap
    _controller = VideoPlayerController.asset('assets/videos/splash_video.mp4')
      ..initialize()
          .then((_) {
            setState(() {
              _isVideoInitialized = true;
            });
            _controller.setLooping(true);
            _controller.setVolume(0); // Splash'te genelde ses istenmez
            _controller.play();
          })
          .catchError((error) {
            debugPrint("❌ Splash Video Hatası: $error");
          });

    // Arka planda verileri hazırla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // AuthViewModel zaten kendi _init() sürecini başlattığı için
      // isInitialized durumunu dinlemek yeterli olacaktır.
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black, // Video yüklenene kadar siyah kalsın
      body: Stack(
        children: [
          // 1. TAM EKRAN VİDEO
          if (_isVideoInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          else
            // Video yüklenirken görünecek yer tutucu (veya logo)
            Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            ),

          // 2. OVERLAY: Video üzerine marka logosu (Okunabilirlik için gölge eklendi)
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'DeskRelief',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        blurRadius: 15.0,
                        color: theme.shadowColor.withValues(alpha: 0.5),
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
