import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:deskrelief/features/auth/domain/models/user_model.dart';
import '../viewmodels/personal_info_view_model.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _jobController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  
  String? _selectedGender;
  bool _isSedentary = true;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _jobController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
  }

  void _initializeData(UserModel user) {
    _jobController.text = user.job ?? '';
    _heightController.text = user.height?.toString() ?? '';
    _weightController.text = user.weight?.toString() ?? '';
    _selectedGender = user.gender;
    _isSedentary = user.isSedentary;
    _isInitialized = true;
  }

  @override
  void dispose() {
    _jobController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final drColors = theme.extension<DeskReliefColors>();
    final isTrueDark = theme.brightness == Brightness.dark && 
                      drColors?.cardShadowColor == Colors.black;

    return Consumer<PersonalInfoViewModel>(
      builder: (context, viewModel, _) {
        final user = viewModel.currentUser;

        if (user == null) {
          return const Scaffold(
            body: Center(child: CupertinoActivityIndicator()),
          );
        }

        if (!_isInitialized) {
          _initializeData(user);
        }

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      const AppBackButton(),
                      const SizedBox(width: 16),
                      Text(
                        loc.personalInfo,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Job Input
                          _buildSectionTitle(loc.job),
                          _buildTextField(
                            controller: _jobController,
                            hint: loc.job,
                            icon: Icons.work_outline_rounded,
                            isTrueDark: isTrueDark,
                          ),
                          const SizedBox(height: 24),

                          // Gender Selection
                          _buildSectionTitle(loc.gender),
                          _buildGenderSelector(isTrueDark),
                          const SizedBox(height: 24),

                          // Height & Weight
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildSectionTitle(loc.height),
                                    _buildTextField(
                                      controller: _heightController,
                                      hint: 'cm',
                                      icon: Icons.height_rounded,
                                      keyboardType: TextInputType.number,
                                      isTrueDark: isTrueDark,
                                      suffix: 'cm',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildSectionTitle(loc.weight),
                                    _buildTextField(
                                      controller: _weightController,
                                      hint: 'kg',
                                      icon: Icons.monitor_weight_outlined,
                                      keyboardType: TextInputType.number,
                                      isTrueDark: isTrueDark,
                                      suffix: 'kg',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Sedentary Switch
                          _buildSedentaryCard(isTrueDark),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: CustomPrimaryButton(
              text: loc.saveChanges,
              isLoading: viewModel.isLoading,
              onPressed: _handleSave,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isTrueDark = false,
    TextInputType keyboardType = TextInputType.text,
    String? suffix,
  }) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: isTrueDark ? Colors.black : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: isTrueDark ? Border.all(color: Colors.white12) : null,
        boxShadow: isTrueDark ? null : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, size: 20, color: theme.colorScheme.primary),
          suffixText: suffix,
          suffixStyle: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            fontWeight: FontWeight.w600,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildGenderSelector(bool isTrueDark) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isTrueDark ? Colors.black : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: isTrueDark ? Border.all(color: Colors.white12) : null,
        boxShadow: isTrueDark ? null : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildGenderOption('male', Icons.male_rounded, loc.male),
          _buildGenderOption('female', Icons.female_rounded, loc.female),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String value, IconData icon, String label) {
    final isSelected = _selectedGender == value;
    final theme = Theme.of(context);
    
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedGender = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSedentaryCard(bool isTrueDark) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isTrueDark ? Colors.black : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: isTrueDark ? Border.all(color: Colors.white12) : null,
        boxShadow: isTrueDark ? null : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.sedentaryStatus,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoSwitch(
                value: _isSedentary,
                activeTrackColor: theme.colorScheme.primary,
                onChanged: (val) => setState(() => _isSedentary = val),
              ),
            ],
          ),
          if (_isSedentary) ...[
            const SizedBox(height: 12),
            Text(
              loc.sedentaryInfo,
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      context.read<PersonalInfoViewModel>().updatePersonalInfo(
        context: context,
        job: _jobController.text,
        gender: _selectedGender,
        height: double.tryParse(_heightController.text),
        weight: double.tryParse(_weightController.text),
        isSedentary: _isSedentary,
      );
    }
  }
}
