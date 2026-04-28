import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import 'package:deskrelief/l10n/app_localizations.dart';

class FocusRegionsDialog extends StatelessWidget {
  final List<String> topRegions;
  final VoidCallback onConfirm;

  const FocusRegionsDialog({
    super.key,
    required this.topRegions,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    final translatedRegions = topRegions.map((id) => _getRegionDisplayName(context, id)).toList();
    final regionText = translatedRegions.length == 1
        ? translatedRegions.first
        : '${translatedRegions.sublist(0, translatedRegions.length - 1).join(', ')} ${loc.localeName == 'tr' ? 've' : 'and'} ${translatedRegions.last}';

    return Stack(
      children: [
        // ── Blur arka plan ────────────────────────────────────────────────
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(color: Colors.black.withValues(alpha: 0.45)),
        ),

        // ── Dialog kutusu ─────────────────────────────────────────────────
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.fromLTRB(28, 36, 28, 28),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 48,
                      spreadRadius: 0,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── İkon alanı ─────────────────────────────────────────
                    Transform.rotate(
                      angle: 0.21, // ~12 derece
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.10,
                          ),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Transform.rotate(
                          angle: -0.21,
                          child: Icon(
                            Icons.track_changes_rounded,
                            color: theme.colorScheme.primary,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Başlık ─────────────────────────────────────────────
                    Text(
                      loc.focusRegionsTitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.onSurface,
                        letterSpacing: -0.6,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Açıklama metni ────────────────────────────────────
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.6,
                        ),
                        children: [
                          TextSpan(
                            text: loc.focusRegionsDescP1,
                          ),
                          TextSpan(
                            text: regionText,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          TextSpan(
                            text: loc.focusRegionsDescP2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── Tamam butonu ──────────────────────────────────────
                    CustomPrimaryButton(
                      text: loc.focusRegionsBtn,
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

  String _getRegionDisplayName(BuildContext context, String id) {
    final loc = AppLocalizations.of(context)!;
    switch (id) {
      case 'region_neck':
        return loc.regionNeck;
      case 'region_shoulder_right':
        return loc.regionShoulderRight;
      case 'region_shoulder_left':
        return loc.regionShoulderLeft;
      case 'region_lower_back':
        return loc.regionLowerBack;
      case 'region_hip_pelvis':
        return loc.regionHipPelvis;
      case 'region_arm_right':
        return loc.regionArmRight;
      case 'region_arm_left':
        return loc.regionArmLeft;
      case 'region_knee_right':
        return loc.regionKneeRight;
      case 'region_knee_left':
        return loc.regionKneeLeft;
      case 'region_ankle_right':
        return loc.regionAnkleRight;
      case 'region_ankle_left':
        return loc.regionAnkleLeft;
      default:
        return id;
    }
  }
}
