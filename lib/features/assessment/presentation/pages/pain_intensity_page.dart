import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../viewmodels/pain_intensity_view_model.dart';
import '../widgets/circular_pain_indicator.dart';
import 'package:deskrelief/features/auth/presentation/viewmodels/auth_view_model.dart';
import '../widgets/gradient_slider_track.dart';
import '../widgets/focus_regions_dialog.dart';
import '../widgets/medical_consultation_dialog.dart';
import 'package:deskrelief/l10n/app_localizations.dart';

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
              Text(AppLocalizations.of(context)!.noRegionSelected),
              TextButton(
                onPressed: () => context.go('/body-map'),
                child: Text(AppLocalizations.of(context)!.goBack),
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
          SingleChildScrollView(
            child: Column(
              children: [
                _buildAppBar(context, theme, viewModel),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 140),
                  child: Column(
                    children: [
                      const SizedBox(height: 36),
                      CircularPainIndicator(
                        value: viewModel.currentPainValue,
                        label: viewModel.getPainLevelDescription(AppLocalizations.of(context)!),
                        activeColor: activeColor,
                      ),
                      const SizedBox(height: 56),
                      _buildSlider(theme, viewModel, activeColor),
                      const SizedBox(height: 48),
                      _buildAnalysisCard(context, theme, viewModel, activeColor),
                      const SizedBox(height: 16),
                      _buildStickyInfo(context, theme, activeColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
          SizedBox(
            height: 56,
            child: Row(
              children: [
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
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.regionLabel(_getRegionDisplayName(context, viewModel.currentRegion)),
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
                const SizedBox(width: 56),
              ],
            ),
          ),
          const SizedBox(height: 16),
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
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildStickyInfo(BuildContext context, ThemeData theme, Color activeColor) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.help_outline, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(loc.assessmentPurposeTitle, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(loc.assessmentPurposeDesc, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(ThemeData theme, PainIntensityViewModel viewModel, Color activeColor) {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackShape: GradientSliderTrackShape(),
            trackHeight: 15,
            thumbColor: Colors.white,
          ),
          child: Slider(
            value: viewModel.currentPainValue,
            min: 0,
            max: 10,
            onChanged: (val) => viewModel.setPainValue(val),
          ),
        ),
        const SizedBox(height: 12),
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
                  color: isCurrent ? activeColor : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalysisCard(BuildContext context, ThemeData theme, PainIntensityViewModel viewModel, Color activeColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: activeColor, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.painAnalysisTitle, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(viewModel.getPainLevelAnalysis(AppLocalizations.of(context)!), style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context, ThemeData theme, PainIntensityViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
      child: ElevatedButton(
        onPressed: () {
          viewModel.nextRegion((List<String> focusRegions) async {
            if (viewModel.hasRedFlag) {
              _showMedicalDialog(context);
            } else {
              _showFocusDialog(context, focusRegions);
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              viewModel.isLastRegion ? AppLocalizations.of(context)!.finishAssessment : AppLocalizations.of(context)!.nextRegion,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.5),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    );
  }

  void _showFocusDialog(BuildContext context, List<String> focusRegions) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (ctx, _, __) => FocusRegionsDialog(
        topRegions: focusRegions,
        onConfirm: () async {
          final authVM = context.read<AuthViewModel>();
          await authVM.updateProgress(hasCompletedPainScore: true);
          if (ctx.mounted) Navigator.of(ctx).pop();
          if (context.mounted) context.push('/scheduling', extra: focusRegions);
        },
      ),
    );
  }

  void _showMedicalDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (ctx, _, __) => MedicalConsultationDialog(
        onConfirm: () async {
          Navigator.of(ctx).pop();
          await context.read<AuthViewModel>().updateProgress(isClearedForExercise: false);
          if (context.mounted) context.go('/');
        },
      ),
    );
  }

  Color _getPainColor(double val) {
    if (val <= 3) return const Color(0xFF006E28);
    if (val <= 6) return const Color(0xFFFBC02D);
    return const Color(0xFFBA1A1A);
  }

  String _getRegionDisplayName(BuildContext context, String id) {
    final loc = AppLocalizations.of(context)!;
    switch (id) {
      case 'neck': return loc.regionNeck;
      case 'leftShoulder': return loc.regionShoulderLeft;
      case 'rightShoulder': return loc.regionShoulderRight;
      case 'upperBack': return loc.regionUpperBack;
      case 'lowerBack': return loc.regionLowerBack;
      case 'hip': return loc.regionHipPelvis;
      case 'leftArm': return loc.regionArmLeft;
      case 'rightArm': return loc.regionArmRight;
      case 'leftKnee': return loc.regionKneeLeft;
      case 'rightKnee': return loc.regionKneeRight;
      case 'leftAnkle': return loc.regionAnkleLeft;
      case 'rightAnkle': return loc.regionAnkleRight;
      default: return id.replaceAll('_', ' ').toUpperCase();
    }
  }
}
