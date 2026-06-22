import 'dart:io';

import 'package:flutter/material.dart';

class ShoeCard extends StatelessWidget {
  final String brandName;
  final String modelName;
  final String? imagePath;
  final bool isFavorite;
  final String? archiveNumber;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;

  const ShoeCard({
    super.key,
    required this.brandName,
    required this.modelName,
    this.imagePath,
    this.isFavorite = false,
    this.archiveNumber,
    required this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _ShoeImage(imagePath: imagePath),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        color: isFavorite ? Theme.of(context).colorScheme.primary : null,
                      ),
                      onPressed: onFavoriteTap,
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .surface
                            .withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    modelName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    brandName,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (archiveNumber != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      archiveNumber!,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShoeImage extends StatelessWidget {
  final String? imagePath;

  const _ShoeImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final path = imagePath;
    if (path == null || path.isEmpty) {
      return _ImagePlaceholder(
        iconColor: Theme.of(context).colorScheme.outline,
      );
    }

    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _ImagePlaceholder(
        iconColor: Theme.of(context).colorScheme.outline,
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  final Color iconColor;

  const _ImagePlaceholder({required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.image_outlined,
        size: 64,
        color: iconColor,
      ),
    );
  }
}
