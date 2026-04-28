import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/custom_primary_button.dart';

class WelcomeProfilePage extends StatefulWidget {
  const WelcomeProfilePage({super.key});

  @override
  State<WelcomeProfilePage> createState() => _WelcomeProfilePageState();
}

class _WelcomeProfilePageState extends State<WelcomeProfilePage> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _professionController = TextEditingController();

  int? _selectedGender = 0; // 0: Male, 1: Female

  bool _isSedentary = false;
  bool _privacyConsent = false;
  bool _medicalDisclaimer = false;

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _professionController.dispose();
    super.dispose();
  }

  void _onGetStarted() {
    FocusScope.of(context).unfocus();

    if (_heightController.text.isEmpty ||
        _weightController.text.isEmpty ||
        _professionController.text.isEmpty ||
        _selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.fillAllFieldsError,
          ),
        ),
      );
      return;
    }
    if (!_privacyConsent || !_medicalDisclaimer) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.acceptAgreementsError),
        ),
      );
      return;
    }

    // Profil kaydedildi, Tıbbi Tarama modülüne geç
    context.go('/red-flags');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 24.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header
                        Text(
                          AppLocalizations.of(context)!.profileWelcomeTitle1,
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.profileWelcomeTitle2,
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.profileWelcomeSubtitle,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Gender Selection (iOS Style)
                        _buildFieldLabel(
                            AppLocalizations.of(context)!.genderLabel, theme),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          height: 54,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1C1C1E)
                                : theme.colorScheme.onSurface.withValues(
                                    alpha: 0.04,
                                  ),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: theme.dividerColor.withValues(alpha: 0.05),
                              width: 1,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Animated Thumb
                              AnimatedOpacity(
                                opacity: _selectedGender == null ? 0.0 : 1.0,
                                duration: const Duration(milliseconds: 200),
                                child: AnimatedAlign(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOutSine,
                                  alignment: _selectedGender == 1
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: FractionallySizedBox(
                                    widthFactor: 0.5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? const Color.fromARGB(
                                                  255,
                                                  47,
                                                  47,
                                                  49,
                                                )
                                              : theme.colorScheme.surface,
                                          borderRadius: BorderRadius.circular(
                                            26,
                                          ),
                                          boxShadow: isDark
                                              ? []
                                              : [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withValues(
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
                              ),
                              // Texts
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        HapticFeedback.lightImpact();
                                        setState(() => _selectedGender = 0);
                                      },
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .genderMale,
                                          style: TextStyle(
                                            fontWeight: _selectedGender == 0
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                            fontSize: 15,
                                            color: _selectedGender == 0
                                                ? theme.colorScheme.primary
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
                                        HapticFeedback.lightImpact();
                                        setState(() => _selectedGender = 1);
                                      },
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .genderFemale,
                                          style: TextStyle(
                                            fontWeight: _selectedGender == 1
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                            fontSize: 15,
                                            color: _selectedGender == 1
                                                ? theme.colorScheme.primary
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

                        // Profession Field
                        _buildFieldLabel(
                            AppLocalizations.of(context)!.professionLabel,
                            theme),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _professionController,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                            fontSize: 15,
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.professionHint,
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.35,
                              ),
                              fontWeight: FontWeight.w400,
                            ),
                            filled: true,
                            fillColor: theme.colorScheme.onSurface.withValues(
                              alpha: 0.04,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Form Fields (Height & Weight)
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFieldLabel(
                                      AppLocalizations.of(context)!.heightLabel,
                                      theme),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _heightController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!
                                          .heightHint,
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.35),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      filled: true,
                                      fillColor: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.04),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFieldLabel(
                                      AppLocalizations.of(context)!.weightLabel,
                                      theme),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _weightController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!
                                          .weightHint,
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.35),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      filled: true,
                                      fillColor: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.04),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Sedentary Worker Card
                        GestureDetector(
                          onTap: () =>
                              setState(() => _isSedentary = !_isSedentary),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: _isSedentary
                                  ? theme.colorScheme.primary.withValues(
                                      alpha: isDark ? 0.25 : 0.15,
                                    )
                                  : theme.colorScheme.onSurface.withValues(
                                      alpha: 0.03,
                                    ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _isSedentary
                                    ? theme.colorScheme.primary.withValues(
                                        alpha: isDark ? 0.4 : 0.3,
                                      )
                                    : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .sedentaryWorker,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .sedentaryWorkerDesc,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: theme
                                                  .colorScheme
                                                  .onSurface
                                                  .withValues(alpha: 0.7),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                CupertinoSwitch(
                                  value: _isSedentary,
                                  onChanged: (val) =>
                                      setState(() => _isSedentary = val),
                                  activeTrackColor: theme.colorScheme.secondary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Medical Disclaimer Card
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.tertiary.withValues(
                              alpha: isDark ? 0.15 : 0.08,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: theme.colorScheme.tertiary.withValues(
                                alpha: isDark ? 0.2 : 0.15,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.report_problem_outlined,
                                color: theme.colorScheme.tertiary,
                                size: 28,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .medicalDisclaimerTitle,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.tertiary,
                                          ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .medicalDisclaimerDesc,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: theme
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.8),
                                            height: 1.4,
                                            fontSize: 13,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Checkboxes
                        _buildCheckboxRow(
                          context,
                          value: _privacyConsent,
                          onChanged: (val) =>
                              setState(() => _privacyConsent = val),
                          textSpan: TextSpan(
                            text: AppLocalizations.of(context)!
                                .agreePrivacyPolicyP1,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.8,
                              ),
                              fontSize: 13,
                            ),
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .privacyPolicy,
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .agreePrivacyPolicyP2,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildCheckboxRow(
                          context,
                          value: _medicalDisclaimer,
                          onChanged: (val) =>
                              setState(() => _medicalDisclaimer = val),
                          textSpan: TextSpan(
                            text: AppLocalizations.of(context)!
                                .confirmMedicalDisclaimer,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.8,
                              ),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),

                        // Get Started Button
                        CustomPrimaryButton(
                          text: AppLocalizations.of(context)!.getStarted,
                          icon: Icons.arrow_forward,
                          onPressed: _onGetStarted,
                        ),

                        const SizedBox(height: 24),
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.dataSecurityLabel,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String text, ThemeData theme) {
    return Text(
      text,
      style: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildCheckboxRow(
    BuildContext context, {
    required bool value,
    required ValueChanged<bool> onChanged,
    required TextSpan textSpan,
  }) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: (val) => onChanged(val ?? false),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            activeColor: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!value),
            child: Text.rich(textSpan),
          ),
        ),
      ],
    );
  }
}
