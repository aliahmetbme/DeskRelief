import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../viewmodels/pain_intensity_view_model.dart';
import '../widgets/circular_pain_indicator.dart';
import '../widgets/gradient_slider_track.dart';
import '../widgets/focus_regions_dialog.dart';

class PainIntensityPage extends StatelessWidget {
  final List<String> selectedRegions;

  const PainIntensityPage({super.key, required this.selectedRegions});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PainIntensityViewModel(selectedRegions: selectedRegions),
      child: const _PainIntensityView(),
    );
  }
}

class _PainIntensityView extends StatelessWidget {
  const _PainIntensityView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = context.watch<PainIntensityViewModel>();

    if (viewModel.selectedRegions.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Seçili bölge bulunamadı.'),
              TextButton(
                onPressed: () => context.go('/body-map'),
                child: const Text('Geri Dön'),
              ),
            ],
          ),
        ),
      );
    }

    final activeColor = _getPainColor(viewModel.currentPainValue);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Ana İçerik
          SingleChildScrollView(
            child: Column(
              children: [
                // Top Navigation Bar
                _buildAppBar(context, theme, viewModel),

                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16, // 20'den 16'ya düşürülerek daha da kenarlara yaklaştırıldı
                    0,
                    16,
                    140,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 36,
                      ), // Deneyimi ferahlatmak için boşluk artırıldı
                      // Dairesel Gösterge
                      CircularPainIndicator(
                        value: viewModel.currentPainValue,
                        label: viewModel.painLevelDescription,
                        activeColor: activeColor,
                      ),
                      const SizedBox(height: 56),

                      // Slider Bölümü
                      _buildSlider(theme, viewModel, activeColor),
                      const SizedBox(height: 48),

                      // Analiz Kartı
                      _buildAnalysisCard(theme, viewModel, activeColor),
                      const SizedBox(height: 16),

                      // Bilgilendirme (Sticky Info)
                      _buildStickyInfo(theme, activeColor),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Alt Buton Alanı (Glassmorphism)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomAction(context, theme, viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    ThemeData theme,
    PainIntensityViewModel viewModel,
  ) {
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Üst Navigasyon Satırı
          SizedBox(
            height: 56,
            child: Row(
              children: [
                // Sol: Geri Butonu
                SizedBox(
                  width: 56,
                  child: AppBackButton(
                    onTap: () {
                      if (viewModel.currentIndex > 0) {
                        viewModel.previousRegion();
                      } else {
                        context.pop();
                      }
                    },
                  ),
                ),

                // Orta: Ana Başlık (White, Bold, Centered)
                Expanded(
                  child: Text(
                    '${viewModel.currentRegion} Bölgesi',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                      fontSize: 18,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Sağ: Dengeleyici Boşluk
                const SizedBox(width: 56),
              ],
            ),
          ),

          const SizedBox(height: 16),
          // 2. Pill + Dot progress indicator (iOS tarzı)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(viewModel.totalRegions, (i) {
              final isActive = i == viewModel.currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 8,
                width: isActive ? 56 : 8,
                decoration: BoxDecoration(
                  color: isActive
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.35,
                            ),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildStickyInfo(ThemeData theme, Color activeColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.help_outline,
              color: theme.colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Değerlendirme Amacı',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ağrı şiddeti değerlendirmesi, mevcut durumunuzu objektif bir şekilde takip etmemize ve size en uygun egzersiz yoğunluğunu belirlememize yardımcı olur.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(
    ThemeData theme,
    PainIntensityViewModel viewModel,
    Color activeColor,
  ) {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackShape: GradientSliderTrackShape(),
            trackHeight: 15, // Biraz daha belirgin bir bar için artırıldı
            thumbColor: Colors.white,
            overlayColor: activeColor.withValues(alpha: 0.1),
            thumbShape: _CustomSliderThumb(
              thumbRadius: 18,
              borderColor: activeColor,
            ),
          ),
          child: Slider(
            value: viewModel.currentPainValue,
            min: 0,
            max: 10,
            onChanged: (val) => viewModel.setPainValue(val),
          ),
        ),
        const SizedBox(height: 12),
        // Sayıları bar ile tam hizalamak için Slider'ın thumb radius'u olan 18px kadar padding verildi
        // Artık track full-width olduğu için sayılar doğrudan thumb merkezleriyle hizalıdır.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(11, (i) {
              final isCurrent = i == viewModel.currentPainValue.round();
              return Text(
                '$i',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: isCurrent
                      ? activeColor
                      : theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.6,
                        ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalysisCard(
    ThemeData theme,
    PainIntensityViewModel viewModel,
    Color activeColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: activeColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.info_outline, color: activeColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ağrı Analizi',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  viewModel.painLevelAnalysis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(
    BuildContext context,
    ThemeData theme,
    PainIntensityViewModel viewModel,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              viewModel.nextRegion((List<String> focusRegions) {
                // Son bölge tamamlandı — Odak Bölge Dialog'unu göster
                showGeneralDialog(
                  context: context,
                  barrierDismissible: false,
                  barrierColor: Colors.transparent,
                  transitionDuration: const Duration(milliseconds: 320),
                  transitionBuilder: (ctx, anim, _, child) {
                    return FadeTransition(
                      opacity: anim,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.92, end: 1.0).animate(
                          CurvedAnimation(
                            parent: anim,
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                        child: child,
                      ),
                    );
                  },
                  pageBuilder: (ctx, _, __) => FocusRegionsDialog(
                    topRegions: focusRegions,
                    onConfirm: () {
                      Navigator.of(ctx).pop(); // dialog'u kapat
                      context.push('/scheduling');
                    },
                  ),
                );
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              elevation: 4,
              shadowColor: theme.colorScheme.primary.withValues(alpha: 0.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  viewModel.isLastRegion
                      ? 'DEĞERLENDİRMEYİ BİTİR'
                      : 'SONRAKİ BÖLGE',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getPainColor(double val) {
    if (val <= 3) return const Color(0xFF006E28); // Yeşil
    if (val <= 6) return const Color(0xFFFBC02D); // Sarı
    return const Color(0xFFBA1A1A); // Kırmızı
  }
}

class _CustomSliderThumb extends SliderComponentShape {
  final double thumbRadius;
  final Color borderColor;

  const _CustomSliderThumb({
    required this.thumbRadius,
    required this.borderColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(thumbRadius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, paint);
    canvas.drawCircle(center, thumbRadius, borderPaint);

    // Küçük iç daire
    canvas.drawCircle(
      center,
      thumbRadius * 0.4,
      borderPaint..style = PaintingStyle.fill,
    );
  }
}
