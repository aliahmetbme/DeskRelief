import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../viewmodels/red_flags_view_model.dart';
import '../widgets/question_card.dart';
import '../widgets/assessment_result_dialog.dart';

class ExclusionCriteriaSettingsPage extends StatelessWidget {
  const ExclusionCriteriaSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: isDark ? theme.scaffoldBackgroundColor : AppColors.backgroundLight,
      body: Stack(
        children: [
          // Scrollable List
          Consumer<RedFlagsViewModel>(
            builder: (context, viewModel, child) {
              final allQuestions = viewModel.allQuestions;
              
              // Group by category
              final systemic = allQuestions.where((q) => q.step == 1).toList();
              final musculoskeletal = allQuestions.where((q) => q.step == 2).toList();
              final redFlags = allQuestions.where((q) => q.step == 3).toList();

              return ListView(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 100,
                  bottom: 140,
                  left: 24,
                  right: 24,
                ),
                children: [
                  // Professional Header Message
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.15)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.shield_rounded, color: theme.colorScheme.primary, size: 24),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            loc.exclusionCriteriaHeader,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  _CategorySection(title: loc.qCat1, questions: systemic, viewModel: viewModel),
                  const SizedBox(height: 32),
                  _CategorySection(title: loc.qCat2, questions: musculoskeletal, viewModel: viewModel),
                  const SizedBox(height: 32),
                  _CategorySection(title: loc.qCat3, questions: redFlags, viewModel: viewModel),
                ],
              );
            },
          ),

          // Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _Header(isDark: isDark),
          ),

          // Footer
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _Footer(isDark: isDark),
          ),
        ],
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  final String title;
  final List<dynamic> questions;
  final RedFlagsViewModel viewModel;

  const _CategorySection({
    required this.title,
    required this.questions,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        ...questions.map((q) => QuestionCard(
          number: '${q.id}',
          questionText: q.getQuestionText(loc),
          selectedAnswer: viewModel.answers[q.id],
          onAnswered: (value) => viewModel.setAnswer(q.id, value),
        )),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final bool isDark;
  const _Header({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 10,
            bottom: 16,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            color: (isDark ? theme.scaffoldBackgroundColor : Colors.white).withValues(alpha: 0.7),
            border: Border(bottom: BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.05))),
          ),
          child: Row(
            children: [
              const AppBackButton(),
              const SizedBox(width: 16),
              Text(
                loc.exclusionCriteria,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final bool isDark;
  const _Footer({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          decoration: BoxDecoration(
            color: (isDark ? theme.colorScheme.surface : Colors.white).withValues(alpha: 0.8),
            border: Border(top: BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.05))),
          ),
          child: Consumer<RedFlagsViewModel>(
            builder: (context, viewModel, child) {
              return CustomPrimaryButton(
                text: loc.done,
                icon: Icons.check_circle_rounded,
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: false,
                    barrierColor: Colors.black.withValues(alpha: 0.3),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: AssessmentResultDialog(
                          hasRedFlags: viewModel.hasRedFlags,
                          onActionPressed: () {
                            if (viewModel.hasRedFlags) {
                              context.pop(); // Pop Dialog
                              context.go('/signin'); // Logout
                            } else {
                              context.pop(); // Pop Dialog
                              context.pop(); // Pop Page back to Profile
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
