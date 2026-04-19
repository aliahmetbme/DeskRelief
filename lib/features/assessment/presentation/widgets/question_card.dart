import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class QuestionCard extends StatelessWidget {
  final String number;
  final String questionText;
  final bool? selectedAnswer;
  final Function(bool) onAnswered;

  const QuestionCard({
    super.key,
    required this.number,
    required this.questionText,
    required this.selectedAnswer,
    required this.onAnswered,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? theme.colorScheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: TextStyle(
                  color: theme.colorScheme.primary.withOpacity(0.15),
                  fontSize: 44,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    questionText,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildAnswerButton(
                  context: context,
                  text: 'Hayır',
                  isTargetValue: false,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildAnswerButton(
                  context: context,
                  text: 'Evet',
                  isTargetValue: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerButton({
    required BuildContext context,
    required String text,
    required bool isTargetValue,
  }) {
    final isSelected = selectedAnswer == isTargetValue;
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => onAnswered(isTargetValue),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 48,
        decoration: BoxDecoration(
          color: isSelected 
              ? primary 
              : (isDark ? theme.colorScheme.onSurface.withOpacity(0.05) : theme.colorScheme.onSurface.withOpacity(0.05)),
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : theme.colorScheme.onSurface.withOpacity(0.7),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
