import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_primary_button.dart';

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

    // "Boyun ve Alt Sırt" gibi virgülle / "ve" ile birleştir
    final regionText = topRegions.length == 1
        ? topRegions.first
        : '${topRegions.sublist(0, topRegions.length - 1).join(', ')} ve ${topRegions.last}';

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
                      'Odak Bölgeler\nBelirlendi',
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
                          const TextSpan(
                            text:
                                'Algoritmamız en yüksek ağrı skoruna sahip bölgelere öncelik vermiştir: ',
                          ),
                          TextSpan(
                            text: regionText,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const TextSpan(
                            text:
                                '.\n\nDiğer bölgeleriniz için, mevcut programı tamamladıktan sonra yeni bir değerlendirme yapabilirsiniz.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── Tamam butonu ──────────────────────────────────────
                    CustomPrimaryButton(
                      text: 'Tamam, Devam Et',
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
