import 'package:flutter/material.dart';
import 'package:lawlink360/widgets/cards/glass_card.dart';

class RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool selected;
  final Color highlightColor;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.selected,
    required this.highlightColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: selected
                  ? highlightColor
                  : colors.outline.withValues(alpha: 0.40),
              width: selected ? 2.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                  child: Image.asset(
                    imagePath,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Theme.of(context).colorScheme.onSurface,
),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        description,
                        style: TextStyle(
  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
  height: 1.6,
),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}