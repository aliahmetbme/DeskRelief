import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

class AssessmentResultDialog extends StatelessWidget {
  final bool hasRedFlags;
  final VoidCallback onActionPressed;

  const AssessmentResultDialog({
    super.key,
    required this.hasRedFlags,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final drColors = theme.extension<DeskReliefColors>()!;

    final iconData = hasRedFlags
        ? Icons.warning_amber_rounded
        : Icons.check_circle_outline_rounded;
        
    final iconColor = hasRedFlags
        ? (drColors.warning ?? Colors.orange)
        : (drColors.success ?? Colors.green);
        
    final iconBgColor = iconColor.withValues(alpha: 0.1);

    final loc = AppLocalizations.of(context)!;
    final title = hasRedFlags
        ? loc.medicalWarningTitle
        : loc.screeningCompletedTitle;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: BoxConstraints(
            maxWidth: 400,
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withValues(alpha: theme.brightness == Brightness.dark ? 0.3 : 0.08),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
                child: Column(
                  children: [
                    // Icon Container
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(iconData, color: iconColor, size: 40),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Body Text
                    hasRedFlags
                        ? RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                                height: 1.6,
                              ),
                              children: [
                                TextSpan(text: loc.medicalWarningDescP1),
                                TextSpan(
                                  text: loc.deskRelief,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                TextSpan(text: loc.medicalWarningDescP2),
                              ],
                            ),
                          )
                        : Text(
                            loc.screeningSuccessDesc,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                              height: 1.6,
                            ),
                          ),
                    const SizedBox(height: 32),

                    // Action Button
                    CustomPrimaryButton(
                      text: hasRedFlags ? loc.understood : loc.continueBtn,
                      onPressed: onActionPressed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
