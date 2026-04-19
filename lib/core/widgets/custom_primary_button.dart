import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;

  const CustomPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // ElevetedButton style'ı dinamik olarak AppTheme içerisinden
    // (ve dolayısıyla provider üzerinden gelen palette'den) alınıyor
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const CupertinoActivityIndicator(color: Colors.white)
          : Text(text),
    );
  }
}
