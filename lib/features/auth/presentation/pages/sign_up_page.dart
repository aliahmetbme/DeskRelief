import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_primary_button.dart';

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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    // Android'de klavyeyi güvenlice kapatmak için
    FocusScope.of(context).unfocus();
    
    if (_formKey.currentState!.validate()) {
      // TODO: MVVM/Provider mimarisinden gelecek AuthService/AuthViewModel çağrılacak.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form Validated! Proceeding to Sign Up...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // LayoutBuilder + SingleChildScrollView + IntrinsicHeight = Android Klavyelerinde Taşma Önleyici Mimari
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Create an Account',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start your pain-free journey',
                          style: theme.textTheme.bodyMedium,
                        ),
                        // Sabit boşluk yerine küçük ekranlarda daralan, büyüklerde artan yapı eklendi
                        SizedBox(height: constraints.maxHeight * 0.05),

                        // Name Field
                        _buildFieldLabel('FULL NAME', theme),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nameController,
                          textInputAction: TextInputAction.next, // Klavye "Next" özelliği
                          decoration: const InputDecoration(hintText: 'John Doe'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) return 'Please enter your name';
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        // Email Field
                        _buildFieldLabel('EMAIL', theme),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(hintText: 'name@example.com'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        // Password Field
                        _buildFieldLabel('PASSWORD', theme),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.done, // Klavyede "Done" özelliği
                          onFieldSubmitted: (_) => _onSignUp(), // Done basılınca otomatik tetikle
                          decoration: const InputDecoration(hintText: '••••••••'),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        
                        // Expanded Spacer: Ekran müsaitse kolonu yukarı ve butonu aşağı iter
                        // Klavye açıldığında ise bu alan sıkışır veya kaybolarak "overflow" engellenir (IntrinsicHeight sayesinde)
                        const Expanded(child: SizedBox(height: 32)),

                        // Sign Up Button
                        CustomPrimaryButton(
                          text: 'Sign Up',
                          onPressed: _onSignUp,
                        ),
                        const SizedBox(height: 16), // Bottom padding
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text, ThemeData theme) {
    return Text(
      text,
      style: theme.textTheme.labelMedium?.copyWith(
        color: theme.textTheme.bodyMedium?.color,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.0,
      ),
    );
  }
}
