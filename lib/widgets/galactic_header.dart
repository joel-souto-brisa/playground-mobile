import 'package:flutter/material.dart';

class GalacticHeader extends StatelessWidget {
  const GalacticHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.eyebrow = 'ARQUIVO GALÁCTICO',
    this.totalCount,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String eyebrow;
  final int? totalCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF202C3D), Color(0xFF111925)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x33FFD54F)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0x1AFFD54F),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFFFFD54F), size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eyebrow,
                  style: const TextStyle(
                    color: Color(0xFFFFD54F),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFE0E6ED),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          if (totalCount != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0x1AFFD54F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0x55FFD54F)),
              ),
              child: Text(
                '$totalCount',
                style: const TextStyle(
                  color: Color(0xFFFFD54F),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ] else ...[
            const SizedBox(width: 8),
            const Icon(
              Icons.auto_awesome,
              color: Color(0xFFFFD54F),
              size: 18,
            ),
          ],
        ],
      ),
    );
  }
}
