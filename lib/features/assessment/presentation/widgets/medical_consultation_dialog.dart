import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

class MedicalConsultationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const MedicalConsultationDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final drColors = theme.extension<DeskReliefColors>()!;

    return Stack(
      children: [
        // Blur arka plan
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(color: Colors.black.withValues(alpha: 0.45)),
        ),

        // Dialog kutusu
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.fromLTRB(28, 36, 28, 28),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withValues(alpha: 0.18),
                      blurRadius: 48,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // İkon alanı
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: (drColors.warning ?? Colors.orange).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.warning_amber_rounded,
                          color: drColors.warning ?? Colors.orange,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Başlık
                    Text(
                      AppLocalizations.of(context)!.medicalConsultationTitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.onSurface,
                        letterSpacing: -0.6,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Açıklama metni
                    Text(
                      AppLocalizations.of(context)!.medicalConsultationDesc,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Tamam butonu
                    CustomPrimaryButton(
                      text: AppLocalizations.of(context)!.medicalConsultationBtn,
                      onPressed: onConfirm,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
