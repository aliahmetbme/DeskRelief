import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../viewmodels/daily_routine_view_model.dart';
import '../../domain/models/exercise_model.dart';

class DailyRoutinePage extends StatelessWidget {
  const DailyRoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DailyRoutineViewModel>();
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top + 80),
                  
                  // Hero Section
                  Text(
                    loc.routineTitle,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontFamily: 'Manrope',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
              
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoChip(
                    icon: Icons.schedule_rounded,
                    label: loc.duration15Min,
                    color: theme.colorScheme.primary,
                  ),
                  _InfoChip(
                    icon: Icons.rebase_edit,
                    label: loc.exercises10,
                    color: theme.colorScheme.primary,
                  ),
                  _InfoChip(
                    icon: Icons.bolt_rounded,
                    label: loc.intensityMedium,
                    color: Colors.orange,
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Motivation Card
              _MotivationCard(
                tagline: loc.motivationTagline,
                quote: loc.motivationQuote,
              ),
              
              const SizedBox(height: 32),
              
              // Exercise List Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.workoutFlow,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    loc.remainingExercises(viewModel.remainingExercisesCount),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Phases and Exercises
              ..._buildExerciseList(context, viewModel),
              
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
      
      // Floating Back Button
      Positioned(
        top: MediaQuery.of(context).padding.top + 12,
        left: 20,
        child: const AppBackButton(),
      ),
    ],
  ),
);
  }

  List<Widget> _buildExerciseList(BuildContext context, DailyRoutineViewModel viewModel) {
    final loc = AppLocalizations.of(context)!;
    final List<Widget> widgets = [];

    final phases = [
      LegacyExercisePhase.mobilization,
      LegacyExercisePhase.strengthening,
      LegacyExercisePhase.stretching,
      LegacyExercisePhase.coolDown,
    ];

    for (var phase in phases) {
      final phaseExercises = viewModel.exercises.where((e) => e.phase == phase).toList();
      if (phaseExercises.isEmpty) continue;

      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _getPhaseTitle(loc, phase).toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            if (phase == LegacyExercisePhase.mobilization)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  loc.priority.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
          ],
        ),
      ));

      for (var exercise in phaseExercises) {
        widgets.add(_ExerciseCard(exercise: exercise));
        widgets.add(const SizedBox(height: 12));
      }
    }

    return widgets;
  }

  String _getPhaseTitle(AppLocalizations loc, LegacyExercisePhase phase) {
    switch (phase) {
      case LegacyExercisePhase.mobilization:
        return loc.phase1;
      case LegacyExercisePhase.strengthening:
        return loc.phase2;
      case LegacyExercisePhase.stretching:
        return loc.phase3;
      case LegacyExercisePhase.coolDown:
        return loc.phase4;
    }
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _MotivationCard extends StatelessWidget {
  final String tagline;
  final String quote;

  const _MotivationCard({
    required this.tagline,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final primaryContainer = theme.colorScheme.primaryContainer;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.format_quote_rounded,
                size: 120,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tagline,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  quote,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
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

class _ExerciseCard extends StatelessWidget {
  final ExerciseItem exercise;

  const _ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        if (!exercise.isLocked) {
          context.push('/exercise/detail', extra: exercise);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: exercise.isLocked
                ? Colors.transparent
                : theme.colorScheme.primary.withValues(alpha: 0.1),
            width: exercise.isLocked ? 1 : 1.5,
          ),
          boxShadow: [
            if (!exercise.isLocked)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Opacity(
          opacity: exercise.isLocked ? 0.6 : 1.0,
          child: ColorFiltered(
            colorFilter: exercise.isLocked
                ? const ColorFilter.matrix([
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0.2126, 0.7152, 0.0722, 0, 0,
                    0,      0,      0,      1, 0,
                  ])
                : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // Image
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 96,
                        height: 80,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: exercise.imageUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  exercise.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                _getPhaseIcon(exercise.phase),
                                size: 32,
                                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                              ),
                      ),
                      if (exercise.isLocked)
                        Container(
                          width: 96,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.lock_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        )
                      else if (exercise.imageUrl.isNotEmpty)
                        Container(
                          width: 96,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.play_circle_filled_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: exercise.tags.map((tag) => Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: _Tag(label: tag),
                          )).toList(),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          exercise.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          exercise.isLocked
                              ? (exercise.phase == LegacyExercisePhase.mobilization ? loc.locked : loc.waitingWarmup)
                              : (exercise.reps != null ? '${exercise.reps} Tekrar' : (exercise.duration ?? '')),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  if (!exercise.isLocked)
                    Icon(
                      Icons.play_arrow_rounded,
                      color: theme.colorScheme.primary,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getPhaseIcon(LegacyExercisePhase phase) {
    switch (phase) {
      case LegacyExercisePhase.mobilization:
        return Icons.rebase_edit;
      case LegacyExercisePhase.strengthening:
        return Icons.fitness_center_rounded;
      case LegacyExercisePhase.stretching:
        return Icons.accessibility_new_rounded;
      case LegacyExercisePhase.coolDown:
        return Icons.self_improvement_rounded;
    }
  }
}

class _Tag extends StatelessWidget {
  final String label;

  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color bgColor = theme.colorScheme.surfaceContainerHigh;
    Color textColor = theme.colorScheme.onSurfaceVariant;

    if (label == 'Mobilite' || label == 'Mobility') {
      bgColor = Colors.blue.withValues(alpha: 0.1);
      textColor = isDark ? Colors.blue.shade300 : Colors.blue.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w900,
          color: textColor,
        ),
      ),
    );
  }
}
