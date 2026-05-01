import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../viewmodels/red_flags_view_model.dart';
import '../widgets/question_card.dart';
import '../widgets/assessment_result_dialog.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import 'package:deskrelief/features/auth/presentation/viewmodels/auth_view_model.dart';

class RedFlagsPage extends StatefulWidget {
  const RedFlagsPage({super.key});

  @override
  State<RedFlagsPage> createState() => _RedFlagsPageState();
}

class _RedFlagsPageState extends State<RedFlagsPage> {
  @override
  void initState() {
    super.initState();
    // Sayfa her açıldığında mevcut kullanıcı hafızasındaki verileri yükle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<RedFlagsViewModel>().loadInitialAnswers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? theme.scaffoldBackgroundColor
          : AppColors.backgroundLight,
      body: Stack(
        children: [
          // Scrollable Body
          Consumer<RedFlagsViewModel>(
            builder: (context, viewModel, child) {
              final questions = viewModel.currentStepQuestions;

              return ListView(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 130,
                  bottom: 140,
                ),
                children: [
                  if (viewModel.currentStep == 1)
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error.withValues(
                          alpha: isDark ? 0.2 : 0.1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: theme.colorScheme.error.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: theme.colorScheme.error,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!.medicalScreeningExclusionCriteria,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isDark
                                    ? Colors.white
                                    : theme.colorScheme.onSurface,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ...List.generate(questions.length, (index) {
                    final question = questions[index];
                    return QuestionCard(
                      number: '${question.id}',
                      questionText: question.getQuestionText(AppLocalizations.of(context)!),
                      selectedAnswer: viewModel.answers[question.id],
                      onAnswered: (value) {
                        viewModel.setAnswer(question.id, value);
                      },
                    );
                  }),
                ],
              );
            },
          ),

          // Fixed Header (Glassmorphism)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
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
                    color:
                        (isDark ? theme.scaffoldBackgroundColor : Colors.white)
                            .withValues(alpha: 0.7),
                    border: Border(
                      bottom: BorderSide(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                      ),
                    ),
                  ),
                  child: Consumer<RedFlagsViewModel>(
                    builder: (context, viewModel, child) {
                      final progress = viewModel.currentStep / 3;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppBackButton(
                                onTap: () {
                                  if (viewModel.currentStep > 1) {
                                    viewModel.previousStep();
                                  } else {
                                    if (context.canPop()) {
                                      context.pop();
                                    } else {
                                      context.go('/welcome-profile');
                                    }
                                  }
                                },
                              ),
                              Text(
                                AppLocalizations.of(context)!.medicalScreeningTitle,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 36,
                              ), // To balance the close button
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.stepTracker(viewModel.currentStep),
                                style: theme.textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.1),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                              minHeight: 6,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // Fixed Footer (Glassmorphism)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).padding.bottom + 20,
                  ),
                  decoration: BoxDecoration(
                    color: (isDark ? theme.colorScheme.surface : Colors.white)
                        .withValues(alpha: 0.8),
                    border: Border(
                      top: BorderSide(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                      ),
                    ),
                  ),
                  child: Consumer<RedFlagsViewModel>(
                    builder: (context, viewModel, child) {
                      final isLastStep = viewModel.currentStep == 3;

                      return Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!.progressSaved),
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.saveProgress,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.6,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomPrimaryButton(
                              text: isLastStep ? AppLocalizations.of(context)!.completeBtn : AppLocalizations.of(context)!.continueBtn,
                              icon: isLastStep
                                  ? Icons.check
                                  : Icons.arrow_forward,
                              onPressed: () {
                                // Check if all questions in current step are answered
                                final questions =
                                    viewModel.currentStepQuestions;
                                bool allAnswered = true;
                                for (var q in questions) {
                                  if (viewModel.answers[q.id] == null) {
                                    allAnswered = false;
                                    break;
                                  }
                                }

                                if (!allAnswered) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        AppLocalizations.of(context)!.pleaseAnswerAllQuestions,
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                viewModel.nextStep(() {
                                  showGeneralDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    barrierColor: Colors.black.withValues(alpha: 0.3),
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) {
                                          return BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 8,
                                              sigmaY: 8,
                                            ),
                                            child: AssessmentResultDialog(
                                              hasRedFlags:
                                                  viewModel.hasRedFlags,
                                              onActionPressed: () async {
                                                if (viewModel.hasRedFlags) {
                                                  context.pop();
                                                  // Force sign out/back if red flags are present
                                                  context.go('/signin');
                                                } else {
                                                  context.pop();
                                                  
                                                  // Progress'i güncelle ve bekle
                                                  await context.read<AuthViewModel>().updateProgress(hasCompletedRedFlags: true);
                                                  
                                                  // Proceed to Body Map assessment
                                                  if (context.mounted) {
                                                    context.go('/body-map');
                                                  }
                                                }
                                              },
                                            ),
                                          );
                                        },
                                  );
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
