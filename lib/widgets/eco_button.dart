import 'package:flutter/material.dart';

class EcoButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isOutlined;

  const EcoButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              child: _buildButtonContent(),
            )
          : ElevatedButton(
              onPressed: onPressed,
              child: _buildButtonContent(),
            ),
    );
  }

  Widget _buildButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ],
    );
  }
} 