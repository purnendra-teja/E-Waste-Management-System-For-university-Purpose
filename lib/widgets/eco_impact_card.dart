import 'package:flutter/material.dart';

class EcoImpactCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  final Color color;
  final double progress;
  final String? unit;
  final bool isWide;

  const EcoImpactCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.progress,
    this.unit,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isWide 
        ? _buildWideLayout()
        : _buildCompactLayout(),
    );
  }

  Widget _buildWideLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildIcon(),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),
                  const SizedBox(height: 4),
                  _buildValue(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildProgressBar(),
      ],
    );
  }

  Widget _buildCompactLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIcon(),
        const SizedBox(height: 16),
        _buildTitle(),
        const SizedBox(height: 4),
        _buildValue(),
        const SizedBox(height: 16),
        _buildProgressBar(),
      ],
    );
  }

  Widget _buildIcon() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: color.withOpacity(0.2),
      child: Icon(
        icon,
        color: color,
        size: 20,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF757575),
      ),
    );
  }

  Widget _buildValue() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        if (unit != null)
          Text(
            ' $unit',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color.withOpacity(0.7),
            ),
          ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Stack(
      children: [
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        FractionallySizedBox(
          widthFactor: progress,
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ],
    );
  }
} 