import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../l10n/app_localizations.dart';
import '../viewmodels/auth_view_model.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../../../../core/widgets/custom_toast.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _onSignIn() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final loc = AppLocalizations.of(context)!;
      final authVM = context.read<AuthViewModel>();

      final success = await authVM.signIn(email, password, loc);

      if (mounted) {
        if (success) {
          CustomToast.show(context, loc.signInSuccess, isError: false);
          authVM.checkClinicalStatus(context, authVM.currentUser!);
        } else {
          CustomToast.show(context, authVM.errorMessage ?? loc.errorUnknown);
        }
      }
    }
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
                                    color: theme.shadowColor.withValues(alpha: 0.05),
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
                                      AppLocalizations.of(context)!.emailLabel,
                                      theme,
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _emailController,
                                      focusNode: _emailFocus,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: 'jondoe@mail.com',
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
                                    const SizedBox(height: 20),

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
                                      textInputAction: TextInputAction.done,
                                      onFieldSubmitted: (_) => _onSignIn(),
                                      decoration: InputDecoration(
                                        hintText: '••••••••',
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
                                      validator: (value) =>
                                          value != null && value.length >= 6
                                          ? null
                                          : AppLocalizations.of(
                                              context,
                                            )!.invalidPasswordError,
                                    ),

                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () => context.push('/forgot-password'),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.forgotPassword,
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 8),

                                    CustomPrimaryButton(
                                      text: AppLocalizations.of(
                                        context,
                                      )!.signInButton,
                                      icon: Icons.login,
                                      isLoading: authViewModel.isLoading,
                                      onPressed: _onSignIn,
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
                                            onPressed: () async {
                                              if (authViewModel.isLoading) {
                                                return;
                                              }
                                              final loc = AppLocalizations.of(
                                                context,
                                              )!;
                                              final success =
                                                  await authViewModel
                                                      .signInWithGoogle(loc);
                                              if (!context.mounted) return;
                                              
                                              if (success) {
                                                CustomToast.show(
                                                  context,
                                                  loc.signInSuccess,
                                                  isError: false,
                                                );
                                                authViewModel.checkClinicalStatus(context, authViewModel.currentUser!);
                                              } else if (authViewModel.errorMessage !=
                                                      null) {
                                                CustomToast.show(
                                                  context,
                                                  authViewModel.errorMessage!,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: _SocialButton(
                                            text: AppLocalizations.of(
                                              context,
                                            )!.apple,
                                            iconData: Icons.apple,
                                            onPressed: () async {
                                              if (authViewModel.isLoading) {
                                                return;
                                              }
                                              final loc = AppLocalizations.of(
                                                context,
                                              )!;
                                              final success =
                                                  await authViewModel
                                                      .signInWithApple(loc);
                                              if (!context.mounted) return;

                                              if (success) {
                                                CustomToast.show(
                                                  context,
                                                  loc.signInSuccess,
                                                  isError: false,
                                                );
                                                authViewModel.checkClinicalStatus(context, authViewModel.currentUser!);
                                              } else if (authViewModel.errorMessage !=
                                                      null) {
                                                CustomToast.show(
                                                  context,
                                                  authViewModel.errorMessage!,
                                                );
                                              }
                                            },
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
                                onTap: () => context.push('/sign-up'),
                                child: Text.rich(
                                  TextSpan(
                                    text: AppLocalizations.of(
                                      context,
                                    )!.dontHaveAccount,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.8),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(
                                          context,
                                        )!.signUpLink,
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
