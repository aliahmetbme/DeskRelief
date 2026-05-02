import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../viewmodels/body_map_view_model.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import 'package:deskrelief/features/auth/presentation/viewmodels/auth_view_model.dart';

class BodyMapPage extends StatelessWidget {
  const BodyMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authVM = context.watch<AuthViewModel>();
    final bool isFemale = authVM.currentUser?.sex == 'female';

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
                      // Başlık Alanı
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
                      const SizedBox(height: 32),

                      // Ön/Arka Switcher
                      _buildSwitcher(context, viewModel, theme),

                      const SizedBox(height: 24),

                      // Vücut Haritası Kartı
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
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
                                  bool isHidden =
                                      (!isChangingToThis &&
                                          animation.value <= 0.5) ||
                                      (isChangingToThis &&
                                          animation.value < 0.5);
                                  return Opacity(
                                    opacity: isHidden ? 0.0 : 1.0,
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
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
                              color: theme.cardTheme.color,
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.shadowColor.withValues(alpha: 0.04),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                              border: Border.all(
                                color: theme.dividerColor.withValues(
                                  alpha: 0.1,
                                ),
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                // Cinsiyete göre görsel yolu seçimi
                                final String imagePath =
                                    viewModel.currentStep == 1
                                    ? (isFemale
                                          ? 'assets/images/bodyImageBackWoman.png'
                                          : 'assets/images/bodyImageBackMan.png')
                                    : (isFemale
                                          ? 'assets/images/bodyImageFrontWoman.png'
                                          : 'assets/images/bodyImageFrontMan.png');

                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.asset(
                                      imagePath,
                                      fit: BoxFit.cover,
                                    ),

                                    // Akıllı Dokunma Bölgeleri (Sol/Sağ %25 Çevirir, Orta %50 Güvenli Alan)
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              HapticFeedback.mediumImpact();
                                              viewModel.toggleStep();
                                            },
                                            child: const SizedBox.expand(),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 2,
                                          child: SizedBox.expand(),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              HapticFeedback.mediumImpact();
                                              viewModel.toggleStep();
                                            },
                                            child: const SizedBox.expand(),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Noktalar
                                    // Only render zones that belong to the current view
                                    ... (viewModel.currentStep == 1
                                            ? viewModel.backRegions
                                            : viewModel.frontRegions)
                                        .expand((region) {
                                      // Cinsiyete göre koordinat seti seçimi
                                      final Map<String, List<Offset>>
                                      currentMap = viewModel.currentStep == 1
                                          ? (isFemale
                                                ? viewModel.backOffsetsFemale
                                                : viewModel.backOffsetsMale)
                                          : (isFemale
                                                ? viewModel.frontOffsetsFemale
                                                : viewModel.frontOffsetsMale);

                                      final offsets =
                                          currentMap[region] ?? <Offset>[];
                                      final isSelected = viewModel
                                          .selectedRegions
                                          .contains(region);

                                      // Noktalar (Draggable Version)
                                      return List.generate(offsets.length, (
                                        index,
                                      ) {
                                        final offset = offsets[index];
                                        const double touchSize = 48.0;
                                        const double visualSize = 18.0;

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
                                            onPanUpdate: (details) {
                                              // Sürükleme Mantığı (Koordinatları Normalize Et)
                                              final double newX =
                                                  (constraints.maxWidth *
                                                          offset.dx +
                                                      details.delta.dx) /
                                                  constraints.maxWidth;
                                              final double newY =
                                                  (constraints.maxHeight *
                                                          offset.dy +
                                                      details.delta.dy) /
                                                  constraints.maxHeight;
                                              viewModel.updateOffset(
                                                region,
                                                index,
                                                Offset(newX, newY),
                                                isFemale,
                                              );
                                            },
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

                      // Seçili Bölgeler Chip Listesi
                      _buildSelectedRegions(
                        context,
                        viewModel,
                        theme,
                        hasSelection,
                      ),
                    ],
                  ),
                ),

                // Sabit Alt Buton
                _buildSubmitButton(context, viewModel, theme, hasSelection),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSwitcher(
    BuildContext context,
    BodyMapViewModel viewModel,
    ThemeData theme,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            final double delta = details.primaryDelta! / constraints.maxWidth;
            viewModel.updateDragPosition(viewModel.dragPosition + delta);
          },
          onHorizontalDragEnd: (details) {
            HapticFeedback.mediumImpact();
            viewModel.finalizeDrag();
          },
          child: Container(
            width: double.infinity,
            height: 54,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: viewModel.isDragging
                      ? Duration.zero
                      : const Duration(milliseconds: 250),
                  curve: Curves.easeInOutSine,
                  alignment: Alignment(viewModel.dragPosition * 2 - 1, 0),
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
                              color: theme.shadowColor.withValues(alpha: 0.08),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
                            AppLocalizations.of(context)!.bodyFront,
                            style: TextStyle(
                              fontWeight: viewModel.currentStep == 2
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: viewModel.currentStep == 2
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurfaceVariant.withValues(
                                      alpha: 0.7,
                                    ),
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
                            AppLocalizations.of(context)!.bodyBack,
                            style: TextStyle(
                              fontWeight: viewModel.currentStep == 1
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: viewModel.currentStep == 1
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurfaceVariant.withValues(
                                      alpha: 0.7,
                                    ),
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
        );
      },
    );
  }

  Widget _buildSelectedRegions(
    BuildContext context,
    BodyMapViewModel viewModel,
    ThemeData theme,
    bool hasSelection,
  ) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: hasSelection
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.selectedRegionsTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: viewModel.selectedRegions.map((region) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer.withValues(
                          alpha: 0.3,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _getTranslatedRegion(context, viewModel.getRegionLocalizationKey(region)),
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              viewModel.toggleRegion(region);
                            },
                            child: Icon(
                              CupertinoIcons.clear_circled_solid,
                              size: 18,
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.6,
                              ),
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
    );
  }

  Widget _buildSubmitButton(
    BuildContext context,
    BodyMapViewModel viewModel,
    ThemeData theme,
    bool hasSelection,
  ) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.scaffoldBackgroundColor.withValues(alpha: 0.0),
              theme.scaffoldBackgroundColor.withValues(alpha: 0.98),
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: CustomPrimaryButton(
          text: AppLocalizations.of(context)!.determinePainIntensity,
          icon: Icons.chevron_right,
          onPressed: hasSelection
              ? () => viewModel.submitSelection(context, context.read<AuthViewModel>())
              : null,
        ),
      ),
    );
  }

  String _getTranslatedRegion(BuildContext context, String key) {
    final loc = AppLocalizations.of(context)!;
    switch (key) {
      case 'regionNeck': return loc.regionNeck;
      case 'leftShoulder': return loc.leftShoulder;
      case 'rightShoulder': return loc.rightShoulder;
      case 'regionHipPelvis': return loc.regionHipPelvis;
      case 'regionUpperBack': return loc.regionUpperBack;
      case 'regionLowerBack': return loc.regionLowerBack;
      case 'leftArm': return loc.leftArm;
      case 'rightArm': return loc.rightArm;
      case 'leftKnee': return loc.leftKnee;
      case 'rightKnee': return loc.rightKnee;
      case 'leftAnkle': return loc.leftAnkle;
      case 'rightAnkle': return loc.rightAnkle;
      default: return key;
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
    if (widget.isSelected) _controller.repeat(reverse: true);
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
                  : theme.colorScheme.onSurface.withValues(alpha: 0.25),
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
                        color: theme.shadowColor.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
              border: !widget.isSelected
                  ? Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.45),
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
