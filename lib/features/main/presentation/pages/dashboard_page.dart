import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../viewmodels/dashboard_view_model.dart';
import 'package:deskrelief/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deskrelief/features/content/domain/models/content_models.dart';
import 'package:deskrelief/features/content/presentation/pages/content_detail_page.dart';

import 'dart:async';
import 'package:deskrelief/core/theme/app_colors.dart';
import 'package:deskrelief/core/widgets/custom_toast.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Timer? _toastTimer;

  @override
  void initState() {
    super.initState();
    // Schedule a push command toast after 5 seconds on dashboard
    _toastTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        final viewModel = context.read<DashboardViewModel>();
        final pushCommand = viewModel.currentPushCommand;
        final localeCode = Localizations.localeOf(context).languageCode;

        if (pushCommand != null) {
          CustomToast.show(
            context,
            pushCommand.getLocalizedText(localeCode),
            isError: false,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _toastTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.top + 16),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            sliver: Consumer<DashboardViewModel>(
              builder: (context, viewModel, child) {
                final isRestDay = viewModel.isRestDay;

                return SliverList(
                  delegate: SliverChildListDelegate([
                    const _WelcomeSection(),
                    const SizedBox(height: 20),
                    _ProgressSection(isRestDay: isRestDay),
                    const SizedBox(height: 10),
                    const _MotivationMottoBox(),
                    const SizedBox(height: 24),

                    if (isRestDay) ...[
                      const _SpinalHealthTipsHeader(),
                      const SizedBox(height: 16),
                      const _BentoContentGrid(),
                    ] else ...[
                      const _ClinicalWarningSection(),
                      const SizedBox(height: 24),
                      const _DailyProgramHero(),
                    ],

                    const SizedBox(height: 32),
                    const SizedBox(height: 120),
                  ]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;
    final isRestDay = context.watch<DashboardViewModel>().isRestDay;

    final String today = DateFormat(
      'EEEE, d MMMM',
      Localizations.localeOf(context).toString(),
    ).format(DateTime.now()).toUpperCase();

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              today,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white60 : Colors.grey,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isRestDay
                  ? loc.restDayTitle
                  : loc.welcome_user(
                      context
                              .watch<AuthViewModel>()
                              .currentUser
                              ?.name
                              .split(' ')
                              .first ??
                          'User',
                    ),
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.0,
                color: isDark ? Colors.white : Colors.black,
                height: 1.1,
              ),
            ),
          ],
        ),
        if (!isRestDay)
          Positioned(right: -8, top: -20, child: _FlareUpButton()),
      ],
    );
  }
}

class _MotivationMottoBox extends StatelessWidget {
  const _MotivationMottoBox();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = context.watch<DashboardViewModel>();
    final motivation = viewModel.currentMotivation;
    final localeCode = Localizations.localeOf(context).languageCode;

    if (motivation == null) return const SizedBox.shrink();

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '"${motivation.getLocalizedText(localeCode)}"',
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.primary,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}

class _FlareUpButton extends StatefulWidget {
  @override
  State<_FlareUpButton> createState() => _FlareUpButtonState();
}

class _FlareUpButtonState extends State<_FlareUpButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: _isPressed
              ? Colors.red.withValues(alpha: 0.35)
              : Colors.red.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: _isPressed
                ? Colors.red.withValues(alpha: 0.6)
                : Colors.red.withValues(alpha: 0.2),
          ),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.red.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_fire_department_rounded,
              color: _isPressed ? const Color(0xFFB71C1C) : Colors.redAccent,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              loc.flareUp,
              style: TextStyle(
                color: _isPressed ? const Color(0xFFB71C1C) : Colors.redAccent,
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressSection extends StatelessWidget {
  final bool isRestDay;
  const _ProgressSection({required this.isRestDay});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;
    final viewModel = context.watch<DashboardViewModel>();

    final progressValue = viewModel.progressValue;
    final remainingSessions = viewModel.remainingSessions;

    final drColors = theme.extension<DeskReliefColors>()!;

    final cobaltBlue = theme.colorScheme.primary;
    final softGreen =
        drColors.successBackground ?? Colors.green.withValues(alpha: 0.1);
    final darkGreen = drColors.successText ?? Colors.green;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: cobaltBlue.withValues(alpha: 0.08),
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 16,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.grey.withValues(alpha: 0.1),
              ),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: progressValue,
                strokeWidth: 16,
                color: cobaltBlue,
                strokeCap: StrokeCap.round,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${(progressValue * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w800,
                    color: cobaltBlue,
                    letterSpacing: -2,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  loc.planCompleted,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (!isRestDay)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: softGreen,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: darkGreen.withValues(alpha: isDark ? 0.3 : 0.1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: darkGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    remainingSessions == 0 ? Icons.celebration : Icons.check,
                    color: isDark ? Colors.black : Colors.white,
                    size: 14,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    remainingSessions == 0
                        ? _getTranslatedFeedback(
                            context,
                            viewModel.getFeedbackMessageKey(),
                          )
                        : loc.feedbackRemainingSessions(
                            _getTranslatedFeedback(
                              context,
                              viewModel.getFeedbackMessageKey(),
                            ),
                            remainingSessions,
                          ),
                    style: TextStyle(
                      color: darkGreen,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  String _getTranslatedFeedback(BuildContext context, String key) {
    final loc = AppLocalizations.of(context)!;
    switch (key) {
      case 'feedbackStart':
        return loc.feedbackStart;
      case 'feedbackStep':
        return loc.feedbackStep;
      case 'feedbackHalfway':
        return loc.feedbackHalfway;
      case 'feedbackAlmostDone':
        return loc.feedbackAlmostDone;
      case 'feedbackDone':
        return loc.feedbackDone;
      default:
        return key;
    }
  }
}

class _ClinicalWarningSection extends StatelessWidget {
  const _ClinicalWarningSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final viewModel = context.watch<DashboardViewModel>();
    final regionalTip = viewModel.getRegionalTip();
    final localeCode = Localizations.localeOf(context).languageCode;

    final drColors = theme.extension<DeskReliefColors>()!;

    final warningColor = drColors.warningText ?? Colors.orange;
    final warningBg =
        drColors.warningBackground ?? Colors.orange.withValues(alpha: 0.1);
    final warningBorder = (drColors.warningText ?? Colors.orange).withValues(
      alpha: 0.2,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: warningBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: warningBorder, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: warningColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.warning_rounded, color: warningColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  regionalTip?.rationale ?? loc.clinicalWarningTitle,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: warningColor,
                    fontSize: 11,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  regionalTip?.getLocalizedContent(localeCode) ??
                      loc.clinicalWarningDesc,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: warningColor.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    height: 1.4,
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

class _SpinalHealthTipsHeader extends StatelessWidget {
  const _SpinalHealthTipsHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        loc.spinalHealthTipsTitle,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}

class _DailyProgramHero extends StatelessWidget {
  const _DailyProgramHero();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.dailyProgramTitle,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      loc.dailyProgramDesc,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    loc.statusActive,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Expanded(
                child: _AnatomicalCard(
                  title: 'Boyun',
                  subtitle: 'BÖLGE 1',
                  imageUrl:
                      'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=400&auto=format&fit=crop',
                ),
              ),
              const Expanded(
                child: _AnatomicalCard(
                  title: 'Alt Sırt',
                  subtitle: 'BÖLGE 2',
                  imageUrl:
                      'https://images.unsplash.com/photo-1512023241041-3c9987a8ad34?q=80&w=400&auto=format&fit=crop',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: _StartWorkoutButton(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _AnatomicalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const _AnatomicalCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StartWorkoutButton extends StatefulWidget {
  const _StartWorkoutButton();

  @override
  State<_StartWorkoutButton> createState() => _StartWorkoutButtonState();
}

class _StartWorkoutButtonState extends State<_StartWorkoutButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final loc = AppLocalizations.of(context)!;

    final baseColor = primary;
    final darkerColor = Color.lerp(primary, Colors.black, 0.2) ?? primary;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () => context.push('/exercise/daily-routine'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 64,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isPressed
                ? [darkerColor, darkerColor.withValues(alpha: 0.9)]
                : [baseColor, baseColor.withValues(alpha: 0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loc.startWorkout,
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.play_circle_fill_rounded,
              color: Colors.white,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}

class _BentoContentGrid extends StatelessWidget {
  const _BentoContentGrid();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = context.watch<DashboardViewModel>();
    final localeCode = Localizations.localeOf(context).languageCode;
    final blog = viewModel.randomFeaturedBlog;
    final loc = AppLocalizations.of(context)!;

    return Column(
      children: [
        if (blog != null)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContentDetailPage(blog: blog),
                ),
              );
            },
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  image: DecorationImage(
                    image: NetworkImage(blog.imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          blog.getLocalizedCategory(localeCode).toUpperCase(),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        blog.getLocalizedTitle(localeCode),
                        style: GoogleFonts.manrope(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _SmallBentoCard(
                  icon: Icons.lightbulb_outline_rounded,
                  title:
                      viewModel.currentErgoTip?.getLocalizedRationale(
                        localeCode,
                      ) ??
                      loc.dailyTip,
                  subtitle:
                      viewModel.currentErgoTip?.getLocalizedContent(
                        localeCode,
                      ) ??
                      loc.tipErgonomicsDesc,
                  iconColor: Colors.amber,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SmallBentoCard(
                  icon: Icons.auto_graph_rounded,
                  title:
                      viewModel.currentBct?.getLocalizedFocus(localeCode) ??
                      'BCT',
                  subtitle:
                      viewModel.currentBct?.getLocalizedText(localeCode) ??
                      loc.tipMobilityDesc,
                  iconColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SmallBentoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;

  const _SmallBentoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Color.lerp(theme.colorScheme.surface, iconColor, 0.05)
            : Color.lerp(Colors.white, iconColor, 0.04),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: iconColor.withValues(alpha: isDark ? 0.15 : 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: iconColor.withValues(alpha: isDark ? 0.02 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  maxLines: 2,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: theme.colorScheme.onSurface,
                    letterSpacing: -0.2,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
