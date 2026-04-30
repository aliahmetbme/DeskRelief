import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../viewmodels/body_map_view_model.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import 'package:deskrelief/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:deskrelief/features/auth/domain/models/user_model.dart';

// Senin Kusursuz Oturan Koordinatların
final Map<String, List<Offset>> backOffsets = {
  'region_neck': [const Offset(0.50, 0.12)],
  'region_shoulder_left': [const Offset(0.41, 0.23)],
  'region_shoulder_right': [const Offset(0.59, 0.23)],
  'region_lower_back': [const Offset(0.50, 0.36)],
  'region_hip_pelvis': [const Offset(0.42, 0.52), const Offset(0.58, 0.52)],
  'region_arm_right': [const Offset(0.68, 0.44)],
  'region_arm_left': [const Offset(0.32, 0.44)],
  'region_knee_right': [const Offset(0.56, 0.72)],
  'region_knee_left': [const Offset(0.44, 0.72)],
  'region_ankle_right': [const Offset(0.55, 0.93)],
  'region_ankle_left': [const Offset(0.45, 0.93)],
};

final Map<String, List<Offset>> frontOffsets = {
  'region_arm_right': [const Offset(0.31, 0.44)],
  'region_arm_left': [const Offset(0.69, 0.44)],
  'region_knee_right': [const Offset(0.44, 0.72)],
  'region_knee_left': [const Offset(0.56, 0.72)],
  'region_ankle_right': [const Offset(0.45, 0.93)],
  'region_ankle_left': [const Offset(0.55, 0.93)],
};

class BodyMapPage extends StatelessWidget {
  const BodyMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Consumer<BodyMapViewModel>(
          builder: (context, viewModel, child) {
            final bool hasSelection = viewModel.selectedRegions.isNotEmpty;

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 160),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Üst Bar ve Geri Butonu
                      // Modernize Edilmiş Başlık Alanı (m-Health Standartlarına Uygun)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.bodyMapTitle,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: theme.colorScheme.onSurface,
                              letterSpacing: -0.8,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppLocalizations.of(context)!.bodyMapDesc,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant
                                  .withValues(alpha: 0.8),
                              height: 1.4,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ), // Harita ile aradaki nefes alma boşluğu
                      // Özel Tasarım Capsule Switcher (Arka/Ön)
                      Container(
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: theme.dividerColor.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Hareketli Arka Plan (Thumb)
                            AnimatedAlign(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOutSine,
                              alignment: viewModel.currentStep == 1
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: 0.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surface,
                                      borderRadius: BorderRadius.circular(26),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.08,
                                          ),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Yazılar
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      if (viewModel.currentStep != 2) {
                                        HapticFeedback.lightImpact();
                                        viewModel.toggleStep();
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.front,
                                        style: TextStyle(
                                          fontWeight: viewModel.currentStep == 2
                                              ? FontWeight.bold
                                              : FontWeight.w500,
                                          fontSize: 15,
                                          color: viewModel.currentStep == 2
                                              ? theme.primaryColor
                                              : theme
                                                    .colorScheme
                                                    .onSurfaceVariant
                                                    .withValues(alpha: 0.7),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      if (viewModel.currentStep != 1) {
                                        HapticFeedback.lightImpact();
                                        viewModel.toggleStep();
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.back,
                                        style: TextStyle(
                                          fontWeight: viewModel.currentStep == 1
                                              ? FontWeight.bold
                                              : FontWeight.w500,
                                          fontSize: 15,
                                          color: viewModel.currentStep == 1
                                              ? theme.primaryColor
                                              : theme
                                                    .colorScheme
                                                    .onSurfaceVariant
                                                    .withValues(alpha: 0.7),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Gelişmiş Kart Dönüş Animasyonu ve Kusursuz Düzen
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        layoutBuilder:
                            (
                              Widget? currentChild,
                              List<Widget> previousChildren,
                            ) {
                              return Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  ...previousChildren,
                                  if (currentChild != null) currentChild,
                                ],
                              );
                            },
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                              final rotate = Tween(
                                begin: 3.14159,
                                end: 0.0,
                              ).animate(animation);
                              return AnimatedBuilder(
                                animation: rotate,
                                child: child,
                                builder: (context, widget) {
                                  final isChangingToThis =
                                      (child.key ==
                                      ValueKey<int>(viewModel.currentStep));
                                  double angle = isChangingToThis
                                      ? rotate.value
                                      : -rotate.value;

                                  // Görünmez kısımları SizedBox.shrink yerine Opacity ile gizleyip, layout boyutunu bozmasını engelliyoruz
                                  bool isHidden =
                                      (!isChangingToThis &&
                                          animation.value <= 0.5) ||
                                      (isChangingToThis &&
                                          animation.value < 0.5);

                                  return Opacity(
                                    opacity: isHidden ? 0.0 : 1.0,
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..setEntry(
                                          3,
                                          2,
                                          0.001,
                                        ) // Daha yumuşak perspektif
                                        ..rotateY(angle),
                                      alignment: Alignment.center,
                                      child: widget,
                                    ),
                                  );
                                },
                              );
                            },
                        child: AspectRatio(
                          key: ValueKey<int>(viewModel.currentStep),
                          aspectRatio: 0.8,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                              border: Border.all(
                                color: theme.dividerColor.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    // BoxFit.cover ile resim çerçeveye sıfıra sıfır oturur
                                    Image.asset(
                                      viewModel.currentStep == 1
                                          ? 'assets/images/bodyImageBackMan.png'
                                          : 'assets/images/bodyImageFrontMan.png',
                                      fit: BoxFit.cover,
                                    ),

                                    // TÜM BÖLGELER İÇİN TIKLANABİLİR NOKTALAR (YENİ UX)
                                    ...viewModel.allRegions.expand((region) {
                                      final currentMap =
                                          viewModel.currentStep == 1
                                          ? backOffsets
                                          : frontOffsets;
                                      final offsets =
                                          currentMap[region] ?? <Offset>[];
                                      final isSelected = viewModel
                                          .selectedRegions
                                          .contains(region);

                                      return offsets.map((offset) {
                                        const double touchSize =
                                            48.0; // Tıklama alanı büyük
                                        const double visualSize =
                                            18.0; // Görsel nokta boyutu

                                        return Positioned(
                                          left:
                                              constraints.maxWidth * offset.dx -
                                              (touchSize / 2),
                                          top:
                                              constraints.maxHeight *
                                                  offset.dy -
                                              (touchSize / 2),
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              HapticFeedback.lightImpact();
                                              viewModel.toggleRegion(region);
                                            },
                                            child: SizedBox(
                                              width: touchSize,
                                              height: touchSize,
                                              child: Center(
                                                child: _PulseMarker(
                                                  isSelected: isSelected,
                                                  visualSize: visualSize,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    }),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ALT KISIM: YENİ CHIP LİSTESİ (Grid yerine)
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: hasSelection
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.selectedRegionsTitle,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: viewModel.selectedRegions.map((
                                      region,
                                    ) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: theme
                                              .colorScheme
                                              .primaryContainer
                                              .withValues(alpha: 0.3),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: theme.colorScheme.primary
                                                .withValues(alpha: 0.3),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              _getRegionDisplayName(context, region),
                                              style: TextStyle(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    theme.colorScheme.primary,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            GestureDetector(
                                              onTap: () {
                                                HapticFeedback.lightImpact();
                                                viewModel.toggleRegion(region);
                                              },
                                              child: Icon(
                                                CupertinoIcons
                                                    .clear_circled_solid,
                                                size: 18,
                                                color: theme.colorScheme.primary
                                                    .withValues(alpha: 0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )
                            : Center(
                                child: Text(
                                  AppLocalizations.of(context)!.bodyMapEmptyState,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: theme.colorScheme.onSurfaceVariant,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),

                // SABİT ALT BUTON - Alt bara çok yakın, zarif yüzer konumlandırma
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(
                      24,
                      8,
                      24,
                      12,
                    ), // Alt boşluk 24'ten 12'ye indirilerek barın hemen üstüne çekildi
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.scaffoldBackgroundColor.withValues(alpha: 0.0),
                          theme.scaffoldBackgroundColor.withValues(alpha: 0.98),
                          theme.scaffoldBackgroundColor,
                        ],
                        stops: const [
                          0.0,
                          0.5,
                          1.0,
                        ], // Gradyan daha aşağıda başlıyor
                      ),
                    ),
                    child: CustomPrimaryButton(
                      text: AppLocalizations.of(context)!.determinePainIntensity,
                      icon: Icons.chevron_right,
                      onPressed: hasSelection
                            ? () async {
                              final authVM = context.read<AuthViewModel>();
                              viewModel.nextStep(viewModel.selectedRegions);
                              
                              // Seçili bölgeleri RegionDetail formatına çevir
                              final List<RegionDetail> painRegions = viewModel.selectedRegions.map((id) {
                                return RegionDetail(regionId: id);
                              }).toList();

                              // Progress'i ve bölgeleri güncelle ve bekle
                              await authVM.updateProgress(
                                hasCompletedBodyMap: true,
                                painRegions: painRegions,
                              );
                              
                              if (context.mounted) {
                                context.push(
                                  '/assessment/pain-intensity',
                                  extra: viewModel.selectedRegions,
                                );
                              }
                            }
                          : null,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
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

class _PulseMarker extends StatefulWidget {
  final bool isSelected;
  final double visualSize;

  const _PulseMarker({required this.isSelected, required this.visualSize});

  @override
  State<_PulseMarker> createState() => _PulseMarkerState();
}

class _PulseMarkerState extends State<_PulseMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.isSelected) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(_PulseMarker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.reset();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        final scale = widget.isSelected ? _scaleAnimation.value : 1.0;

        return Transform.scale(
          scale: scale,
          child: Container(
            width: widget.visualSize,
            height: widget.visualSize,
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(
                      alpha: 0.25,
                    ), // 0.1'den 0.25'e çıkarıldı
              shape: BoxShape.circle,
              boxShadow: widget.isSelected
                  ? [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.4),
                        blurRadius: 18 * scale,
                        spreadRadius: 6 * scale,
                      ),
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.2),
                        blurRadius: 30 * scale,
                        spreadRadius: 2 * scale,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
              border: !widget.isSelected
                  ? Border.all(
                      color: theme.colorScheme.primary.withValues(
                        alpha: 0.45,
                      ), // 0.2'den 0.45'e çıkarıldı
                      width: 1.5,
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}
