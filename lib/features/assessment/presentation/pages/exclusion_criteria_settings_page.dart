import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../viewmodels/red_flags_view_model.dart';
import '../widgets/question_card.dart';

class ExclusionCriteriaSettingsPage extends StatelessWidget {
  const ExclusionCriteriaSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Scrollable List
          Consumer<RedFlagsViewModel>(
            builder: (context, viewModel, child) {
              final grouped = viewModel.questionsByCategory;
              
              final systemic = grouped[1] ?? [];
              final musculoskeletal = grouped[2] ?? [];
              final redFlags = grouped[3] ?? [];

              return ListView(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 100,
                  bottom: 40,
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

                  _CategorySection(title: _getTranslatedCategory(context, 'qCat1'), questions: systemic, viewModel: viewModel),
                  const SizedBox(height: 32),
                  _CategorySection(title: _getTranslatedCategory(context, 'qCat2'), questions: musculoskeletal, viewModel: viewModel),
                  const SizedBox(height: 32),
                  _CategorySection(title: _getTranslatedCategory(context, 'qCat3'), questions: redFlags, viewModel: viewModel),
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
        ],
      ),
    );
  }

  String _getTranslatedCategory(BuildContext context, String key) {
    final loc = AppLocalizations.of(context)!;
    switch (key) {
      case 'qCat1': return loc.qCat1;
      case 'qCat2': return loc.qCat2;
      case 'qCat3': return loc.qCat3;
      default: return key;
    }
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
          questionText: _getTranslatedText(context, q.getQuestionTextKey()),
          selectedAnswer: viewModel.answers[q.id],
          onAnswered: (value) => viewModel.setAnswer(q.id, value),
        )),
      ],
    );
  }

  String _getTranslatedText(BuildContext context, String key) {
    final loc = AppLocalizations.of(context)!;
    switch (key) {
      case 'q1': return loc.q1;
      case 'q2': return loc.q2;
      case 'q3': return loc.q3;
      case 'q4': return loc.q4;
      case 'q5': return loc.q5;
      case 'q6': return loc.q6;
      case 'q7': return loc.q7;
      case 'q8': return loc.q8;
      case 'q9': return loc.q9;
      case 'q10': return loc.q10;
      case 'q11': return loc.q11;
      case 'q12': return loc.q12;
      case 'q13': return loc.q13;
      case 'q14': return loc.q14;
      case 'q15': return loc.q15;
      case 'q16': return loc.q16;
      case 'q17': return loc.q17;
      case 'q18': return loc.q18;
      default: return key;
    }
  }
}

class _Header extends StatelessWidget {
  final bool isDark;
  const _Header({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 16,
        left: 20,
        right: 20,
      ),
      color: theme.scaffoldBackgroundColor,
      child: Row(
        children: [
          const AppBackButton(),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              loc.exclusionCriteria,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Consumer<RedFlagsViewModel>(
            builder: (context, viewModel, child) {
              return TextButton(
                onPressed: () => viewModel.submitExclusionCriteria(context),
                child: Text(
                  loc.done,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


