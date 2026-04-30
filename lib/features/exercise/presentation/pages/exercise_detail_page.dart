import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/exercise_model.dart';
import '../viewmodels/exercise_detail_view_model.dart';
import '../../data/services/video_cache_service.dart';

class ExerciseDetailPage extends StatelessWidget {
  final ExerciseItem exercise;

  const ExerciseDetailPage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExerciseDetailViewModel(exercise: exercise),
      child: const _ExerciseDetailView(),
    );
  }
}

class _ExerciseDetailView extends StatefulWidget {
  const _ExerciseDetailView();

  @override
  State<_ExerciseDetailView> createState() => _ExerciseDetailViewState();
}

class _ExerciseDetailViewState extends State<_ExerciseDetailView> {
  FlickManager? _flickManager;
  final VideoCacheService _cacheService = VideoCacheService();

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    final exercise = context.read<ExerciseDetailViewModel>().exercise;
    if (exercise.videoUrl.isNotEmpty) {
      final proxyUrl = _cacheService.getCachedUrl(exercise.videoUrl);
      _flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(proxyUrl),
        ),
        autoPlay: false,
        // Kontrollerin (ve ortadaki ikonun) daha hızlı kaybolması için süreyi kısaltıyoruz
        getPlayerControlsTimeout: ({errorInVideo, isPlaying, isVideoEnded, isVideoInitialized}) => 
            const Duration(milliseconds: 500),
      );
    }
  }

  @override
  void dispose() {
    _flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ExerciseDetailViewModel>();
    final exercise = viewModel.exercise;
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Main Content
          Positioned.fill(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(height: MediaQuery.of(context).padding.top + 80),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverToBoxAdapter(
                    child: _buildHeaderInfo(exercise, theme, loc),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16), // Wider than the rest
                  sliver: SliverToBoxAdapter(
                    child: _buildVideoCard(context, exercise, theme, loc),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      if (exercise.warnings.isNotEmpty)
                        _buildWarningCard(exercise, theme, loc, isDark),
                      const SizedBox(height: 32),
                      _buildInstructions(exercise, theme, loc, isDark),
                      const SizedBox(height: 32),
                      _buildBentoSection(exercise, theme, loc, isDark),
                      const SizedBox(height: 48),
                      
                      // Action Button
                      CustomPrimaryButton(
                        text: loc.markAsCompleted.toUpperCase(),
                        icon: Icons.check_circle_rounded,
                        onPressed: () => viewModel.markAsCompleted(context),
                      ),
                      
                      const SizedBox(height: 64),
                    ]),
                  ),
                ),
              ],
            ),
          ),

          // Sticky Top Navigation
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _CustomAppBar(title: exercise.title),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderInfo(ExerciseItem exercise, ThemeData theme, AppLocalizations loc) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            exercise.tags.isNotEmpty ? exercise.tags.first.toUpperCase() : 'ROM',
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
              fontFamily: 'Manrope',
            ),
          ),
        ),
        const SizedBox(width: 16),
        Row(
          children: [
            Icon(Icons.timer_outlined, size: 18, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 6),
            Text(
              exercise.duration ?? '5 Dakika',
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVideoCard(BuildContext context, ExerciseItem exercise, ThemeData theme, AppLocalizations loc) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: theme.brightness == Brightness.dark ? 0.3 : 0.08),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: _flickManager != null
              ? FlickVideoPlayer(
                  flickManager: _flickManager!,
                  flickVideoWithControls: FlickVideoWithControls(
                    videoFit: BoxFit.contain,
                    controls: const FlickPortraitControls(),
                    playerLoadingFallback: Image.network(
                      exercise.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: const Icon(Icons.play_circle_outline, color: Colors.white54, size: 50),
                      ),
                    ),
                  ),
                )
              : Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.video_library_outlined),
                ),
        ),
      ),
    );
  }

  Widget _buildWarningCard(ExerciseItem exercise, ThemeData theme, AppLocalizations loc, bool isDark) {
    final bgColor = isDark ? const Color(0xFF2C1414) : const Color(0xFFFEF2F2);
    final borderColor = isDark ? const Color(0xFF4C1D1D) : const Color(0xFFFECACA).withValues(alpha: 0.5);
    final iconColor = isDark ? const Color(0xFFEF4444) : const Color(0xFFB91C1C);
    final textColor = isDark ? const Color(0xFFFECACA) : const Color(0xFF7F1D1D);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_rounded, color: iconColor, size: 24),
              const SizedBox(width: 10),
              Text(
                loc.importantWarnings,
                style: TextStyle(
                  color: iconColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Manrope',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...exercise.warnings.map((warning) => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        warning,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildInstructions(ExerciseItem exercise, ThemeData theme, AppLocalizations loc, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.howToDo,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : const Color(0xFF1E293B),
            fontFamily: 'Manrope',
          ),
        ),
        const SizedBox(height: 20),
        ...List.generate(exercise.instructions.length, (index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? theme.colorScheme.surface : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: isDark ? Border.all(color: Colors.white.withValues(alpha: 0.1)) : null,
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    exercise.instructions[index],
                    style: TextStyle(
                      color: isDark ? Colors.white70 : const Color(0xFF475569),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildBentoSection(ExerciseItem exercise, ThemeData theme, AppLocalizations loc, bool isDark) {
    // Green (Tips)
    final tipsBg = isDark ? const Color(0xFF062016) : const Color(0xFFF0FDF4);
    final tipsBorder = isDark ? const Color(0xFF064E3B).withValues(alpha: 0.5) : const Color(0xFFBBF7D0).withValues(alpha: 0.5);
    final tipsIcon = isDark ? const Color(0xFF34D399) : const Color(0xFF15803D);
    final tipsTitle = isDark ? const Color(0xFF34D399) : const Color(0xFF15803D);
    final tipsText = isDark ? const Color(0xFFA7F3D0) : const Color(0xFF166534);

    // Blue (Focus)
    final focusBg = isDark ? const Color(0xFF172554) : const Color(0xFFEFF6FF);
    final focusBorder = isDark ? const Color(0xFF1E40AF).withValues(alpha: 0.5) : const Color(0xFFBFDBFE).withValues(alpha: 0.5);
    final focusIcon = isDark ? const Color(0xFF60A5FA) : const Color(0xFF1D4ED8);
    final focusTitle = isDark ? const Color(0xFF60A5FA) : const Color(0xFF1D4ED8);
    final focusText = isDark ? Colors.white : const Color(0xFF1E293B);
    final focusSubtext = isDark ? Colors.white70 : const Color(0xFF475569);

    return Column(
      children: [
        // Tips Card
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: tipsBg,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: tipsBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb_outline_rounded, color: tipsIcon, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    'Genel İpuçları',
                    style: TextStyle(
                      color: tipsTitle,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Manrope',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...exercise.tips.map((tip) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(color: tipsIcon, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            tip,
                            style: TextStyle(
                              color: tipsText,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Focus Card
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: focusBg,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: focusBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Odak Bölgesi',
                    style: TextStyle(
                      color: focusTitle,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Manrope',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    exercise.focusArea,
                    style: TextStyle(
                      color: focusText,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Manrope',
                    ),
                  ),
                  Text(
                    exercise.focusDescription,
                    style: TextStyle(
                      color: focusSubtext,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              Icon(Icons.accessibility_new_rounded, color: focusIcon, size: 40),
            ],
          ),
        ),
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String title;

  const _CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, bottom: 12, left: 12, right: 12),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor.withValues(alpha: 0.8),
          ),
          child: Row(
            children: [
              const AppBackButton(),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
