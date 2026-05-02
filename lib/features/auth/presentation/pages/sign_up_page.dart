import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../l10n/app_localizations.dart';
import '../viewmodels/auth_view_model.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../../../../core/widgets/custom_toast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  bool _obscurePassword = true;
  bool _termsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  Future<void> _onSignUp() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final loc = AppLocalizations.of(context)!;
      final authVM = context.read<AuthViewModel>();

      final success = await authVM.signUp(name, email, password, loc);

      if (mounted) {
        if (success) {
          authVM.checkClinicalStatus(context, authVM.currentUser!);
        } else {
          CustomToast.show(context, authVM.errorMessage ?? loc.errorUnknown);
        }
      }
    }
  }

  void _handleSocialSignIn(VoidCallback signAction) {
    if (!_termsAccepted) {
      CustomToast.show(context, AppLocalizations.of(context)!.acceptTermsError);
      return;
    }
    signAction();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient Configuration matching mockup
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.secondary.withValues(alpha: 0.15),
                    theme.scaffoldBackgroundColor,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              AppLocalizations.of(context)!.welcomeTo,
                              style: theme.textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              'DeskRelief',
                              style: theme.textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              AppLocalizations.of(context)!.signInTagline,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Content Card
                            Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.shadowColor.withValues(
                                      alpha: 0.05,
                                    ),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(24.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    _buildFieldLabel(
                                      AppLocalizations.of(
                                        context,
                                      )!.fullNameLabel,
                                      theme,
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _nameController,
                                      focusNode: _nameFocus,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      autofillHints: const [AutofillHints.name],
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(
                                          context,
                                        )!.fullNameHint,
                                        errorText:
                                            authViewModel.errorMessage
                                                    ?.toLowerCase()
                                                    .contains('name') ==
                                                true
                                            ? authViewModel.errorMessage
                                            : null,
                                        prefixIcon: const Icon(
                                          Icons.badge_outlined,
                                        ),
                                        filled: true,
                                        fillColor: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.04),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      onFieldSubmitted: (_) => FocusScope.of(
                                        context,
                                      ).requestFocus(_emailFocus),
                                      validator: (value) =>
                                          value != null &&
                                              value.trim().isNotEmpty
                                          ? null
                                          : AppLocalizations.of(
                                              context,
                                            )!.enterNameError,
                                    ),
                                    const SizedBox(height: 16),

                                    _buildFieldLabel(
                                      AppLocalizations.of(context)!.emailLabel,
                                      theme,
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _emailController,
                                      focusNode: _emailFocus,
                                      keyboardType: TextInputType.emailAddress,
                                      autofillHints: const [
                                        AutofillHints.email,
                                      ],
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: 'john.doe@company.com',
                                        errorText:
                                            authViewModel.errorMessage
                                                        ?.toLowerCase()
                                                        .contains('email') ==
                                                    true ||
                                                authViewModel.errorMessage
                                                        ?.toLowerCase()
                                                        .contains('user') ==
                                                    true
                                            ? authViewModel.errorMessage
                                            : null,
                                        prefixIcon: const Icon(
                                          Icons.person_outline,
                                        ),
                                        filled: true,
                                        fillColor: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.04),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      onFieldSubmitted: (_) => FocusScope.of(
                                        context,
                                      ).requestFocus(_passwordFocus),
                                      validator: (value) =>
                                          value != null && value.contains('@')
                                          ? null
                                          : AppLocalizations.of(
                                              context,
                                            )!.invalidEmailError,
                                    ),
                                    const SizedBox(height: 16),

                                    _buildFieldLabel(
                                      AppLocalizations.of(
                                        context,
                                      )!.passwordLabel,
                                      theme,
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _passwordController,
                                      focusNode: _passwordFocus,
                                      obscureText: _obscurePassword,
                                      autofillHints: const [
                                        AutofillHints.newPassword,
                                      ],
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: '••••••••',
                                        errorText:
                                            authViewModel.errorMessage
                                                    ?.toLowerCase()
                                                    .contains('password') ==
                                                true
                                            ? authViewModel.errorMessage
                                            : null,
                                        prefixIcon: const Icon(
                                          Icons.lock_outline,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                          onPressed: () => setState(
                                            () => _obscurePassword =
                                                !_obscurePassword,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.04),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      onFieldSubmitted: (_) => FocusScope.of(
                                        context,
                                      ).requestFocus(_confirmPasswordFocus),
                                      validator: (value) =>
                                          value != null && value.length >= 6
                                          ? null
                                          : AppLocalizations.of(
                                              context,
                                            )!.invalidPasswordError,
                                    ),
                                    const SizedBox(height: 16),

                                    _buildFieldLabel(
                                      AppLocalizations.of(
                                        context,
                                      )!.confirmPasswordLabel,
                                      theme,
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _confirmPasswordController,
                                      focusNode: _confirmPasswordFocus,
                                      obscureText: _obscurePassword,
                                      textInputAction: TextInputAction.done,
                                      onFieldSubmitted: (_) => _onSignUp(),
                                      decoration: InputDecoration(
                                        hintText: '••••••••',
                                        prefixIcon: const Icon(
                                          Icons.lock_outline,
                                        ),
                                        filled: true,
                                        fillColor: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.04),

                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value != _passwordController.text) {
                                          return AppLocalizations.of(
                                            context,
                                          )!.passwordsDoNotMatchError;
                                        }
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 16),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Checkbox(
                                            value: _termsAccepted,
                                            onChanged: (val) => setState(
                                              () =>
                                                  _termsAccepted = val ?? false,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            activeColor:
                                                theme.colorScheme.primary,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text.rich(
                                            TextSpan(
                                              text: AppLocalizations.of(
                                                context,
                                              )!.agreeTermsP1,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                    color: theme
                                                        .colorScheme
                                                        .onSurface
                                                        .withValues(alpha: 0.8),
                                                    fontSize: 14,
                                                  ),
                                              children: [
                                                TextSpan(
                                                  text: AppLocalizations.of(
                                                    context,
                                                  )!.termsOfService,
                                                  style: TextStyle(
                                                    color: theme
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: AppLocalizations.of(
                                                    context,
                                                  )!.agreeTermsP2,
                                                ),
                                                TextSpan(
                                                  text: AppLocalizations.of(
                                                    context,
                                                  )!.eula,
                                                  style: TextStyle(
                                                    color: theme
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: AppLocalizations.of(
                                                    context,
                                                  )!.agreeTermsP3,
                                                ),
                                                TextSpan(
                                                  text: AppLocalizations.of(
                                                    context,
                                                  )!.privacyPolicy,
                                                  style: TextStyle(
                                                    color: theme
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: AppLocalizations.of(
                                                    context,
                                                  )!.agreeTermsP4,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 24),

                                    CustomPrimaryButton(
                                      text: AppLocalizations.of(
                                        context,
                                      )!.signUpButton,
                                      icon: Icons.arrow_forward,
                                      isLoading: authViewModel.isLoading,
                                      onPressed: () {
                                        if (!_termsAccepted) {
                                          CustomToast.show(
                                            context,
                                            AppLocalizations.of(
                                              context,
                                            )!.acceptTermsError,
                                          );
                                          return;
                                        }
                                        _onSignUp();
                                      },
                                    ),

                                    const SizedBox(height: 24),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            color: theme.colorScheme.onSurface
                                                .withValues(alpha: 0.1),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.orContinueWith,
                                            style: theme.textTheme.labelSmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: theme
                                                      .colorScheme
                                                      .onSurface
                                                      .withValues(alpha: 0.5),
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Divider(
                                            color: theme.colorScheme.onSurface
                                                .withValues(alpha: 0.1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: _SocialButton(
                                            text: AppLocalizations.of(
                                              context,
                                            )!.google,
                                            svgAsset: 'assets/Icons/google.svg',
                                            onPressed: () =>
                                                _handleSocialSignIn(() async {
                                                  if (authViewModel.isLoading) {
                                                    return;
                                                  }
                                                  final loc =
                                                      AppLocalizations.of(
                                                        context,
                                                      )!;
                                                  final success =
                                                      await authViewModel
                                                          .signInWithGoogle(
                                                            loc,
                                                            isSignUp: true,
                                                          );
                                                  if (!context.mounted) return;

                                                  if (success) {
                                                    authViewModel
                                                        .checkClinicalStatus(
                                                          context,
                                                          authViewModel
                                                              .currentUser!,
                                                        );
                                                  } else if (authViewModel
                                                          .errorMessage !=
                                                      null) {
                                                    CustomToast.show(
                                                      context,
                                                      authViewModel
                                                          .errorMessage!,
                                                    );
                                                  }
                                                }),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: _SocialButton(
                                            text: AppLocalizations.of(
                                              context,
                                            )!.apple,
                                            iconData: Icons.apple,
                                            onPressed: () =>
                                                _handleSocialSignIn(() async {
                                                  if (authViewModel.isLoading) {
                                                    return;
                                                  }
                                                  final loc =
                                                      AppLocalizations.of(
                                                        context,
                                                      )!;
                                                  final success =
                                                      await authViewModel
                                                          .signInWithApple(
                                                            loc,
                                                            isSignUp: true,
                                                          );
                                                  if (!context.mounted) return;

                                                  if (success) {
                                                    authViewModel
                                                        .checkClinicalStatus(
                                                          context,
                                                          authViewModel
                                                              .currentUser!,
                                                        );
                                                  } else if (authViewModel
                                                          .errorMessage !=
                                                      null) {
                                                    CustomToast.show(
                                                      context,
                                                      authViewModel
                                                          .errorMessage!,
                                                    );
                                                  }
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: GestureDetector(
                                onTap: () {
                                  if (context.canPop()) {
                                    context.pop();
                                  } else {
                                    context.go('/sign-in');
                                  }
                                },
                                child: Text.rich(
                                  TextSpan(
                                    text: AppLocalizations.of(
                                      context,
                                    )!.haveAccount,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.8),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(
                                          context,
                                        )!.signInLink,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                              color: theme.colorScheme.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String text, ThemeData theme) {
    return Text(
      text,
      style: theme.textTheme.labelMedium?.copyWith(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
        fontWeight: FontWeight.w700,
        letterSpacing: 1.0,
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final String? svgAsset;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.text,
    this.iconData,
    this.svgAsset,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: theme.colorScheme.onSurface,
        backgroundColor: isDark
            ? theme.colorScheme.onSurface.withValues(alpha: 0.08)
            : theme.colorScheme.surface,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: isDark
              ? BorderSide.none
              : BorderSide(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (svgAsset != null)
            SvgPicture.asset(svgAsset!, width: 20, height: 20)
          else if (iconData != null)
            Icon(iconData, size: 24),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}
