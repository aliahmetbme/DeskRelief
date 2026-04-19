import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_primary_button.dart';

class WelcomeProfilePage extends StatefulWidget {
  const WelcomeProfilePage({super.key});

  @override
  State<WelcomeProfilePage> createState() => _WelcomeProfilePageState();
}

class _WelcomeProfilePageState extends State<WelcomeProfilePage> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  
  bool _isSedentary = false;
  bool _privacyConsent = false;
  bool _medicalDisclaimer = false;

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _onGetStarted() {
    FocusScope.of(context).unfocus();
    
    if (_heightController.text.isEmpty || _weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your height and weight.')));
      return;
    }
    if (!_privacyConsent || !_medicalDisclaimer) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please accept all agreements to continue.')));
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
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header
                        Text(
                          'Kinetic',
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onBackground,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          'Equilibrium',
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Let's begin your journey toward perfect alignment and effortless movement.",
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onBackground.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Form Fields (Height & Weight)
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFieldLabel('HEIGHT (CM)', theme),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _heightController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: '180',
                                      hintStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.35)),
                                      filled: true,
                                      fillColor: theme.colorScheme.onSurface.withOpacity(0.04),
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
                                  _buildFieldLabel('WEIGHT (KG)', theme),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _weightController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      hintText: '75',
                                      hintStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.35)),
                                      filled: true,
                                      fillColor: theme.colorScheme.onSurface.withOpacity(0.04),
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
                          onTap: () => setState(() => _isSedentary = !_isSedentary),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: _isSedentary 
                                  ? theme.colorScheme.primary.withOpacity(0.08) 
                                  : theme.colorScheme.onSurface.withOpacity(0.03),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _isSedentary 
                                    ? theme.colorScheme.primary.withOpacity(0.2) 
                                    : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sedentary Worker',
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Do you spend more than 6 hours sitting daily?',
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          color: theme.colorScheme.onBackground.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CupertinoSwitch(
                                  value: _isSedentary,
                                  onChanged: (val) => setState(() => _isSedentary = val),
                                  activeColor: theme.colorScheme.secondary,
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
                            color: theme.colorScheme.tertiary.withOpacity(isDark ? 0.15 : 0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: theme.colorScheme.tertiary.withOpacity(isDark ? 0.2 : 0.15),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.report_problem_outlined, color: theme.colorScheme.tertiary, size: 28),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Medical Disclaimer',
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.tertiary,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'This app provides postural guidance and is not a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician.',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onBackground.withOpacity(0.8),
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
                          onChanged: (val) => setState(() => _privacyConsent = val),
                          textSpan: TextSpan(
                            text: 'I agree to the ',
                            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onBackground.withOpacity(0.8), fontSize: 13),
                            children: [
                              TextSpan(text: 'Privacy Policy', style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                              const TextSpan(text: ' and consent to data processing for my health profile.'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildCheckboxRow(
                          context,
                          value: _medicalDisclaimer,
                          onChanged: (val) => setState(() => _medicalDisclaimer = val),
                          textSpan: TextSpan(
                            text: 'I confirm that I have read and understood the Medical Disclaimer provided above.',
                            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onBackground.withOpacity(0.8), fontSize: 13),
                          ),
                        ),
                        const SizedBox(height: 48),

                        // Get Started Button
                        CustomPrimaryButton(
                          text: 'Get Started',
                          icon: Icons.arrow_forward,
                          onPressed: _onGetStarted,
                        ),
                        
                        const SizedBox(height: 24),
                        Center(
                          child: Text(
                            'YOUR DATA IS SECURE • GDPR COMPLIANT',
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              color: theme.colorScheme.onBackground.withOpacity(0.5),
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
        color: theme.colorScheme.onBackground.withOpacity(0.8),
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildCheckboxRow(BuildContext context, {required bool value, required ValueChanged<bool> onChanged, required TextSpan textSpan}) {
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
