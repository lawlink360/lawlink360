import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

/// Local-only multi-image picker for Copy House forms.
///
/// Phase 2 (S2): images are selected and previewed locally. They are
/// NOT uploaded and NOT stored on the request. The caller is
/// responsible for showing this widget's results to the user and must
/// NOT treat them as submitted.
///
/// Callers own the list of `XFile`s; this widget is stateless with
/// respect to selection state.
class CopyHouseImageAttachments extends StatelessWidget {
  final List<XFile> images;
  final VoidCallback onAdd;
  final void Function(int index) onRemove;

  const CopyHouseImageAttachments({
    super.key,
    required this.images,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Attach Pictures (Optional)',
          style: AppTextStyles.body.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Attach pictures of the document or relevant record, if available.',
          style: AppTextStyles.caption.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.35,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.12),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 16,
                color: colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'Pictures are attached for this session only. They will '
                  'not be uploaded or sent with your request until cloud '
                  'storage is configured.',
                  style: AppTextStyles.caption.copyWith(
                    color: colorScheme.onSurface,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (images.isNotEmpty)
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (var i = 0; i < images.length; i++)
                _Thumbnail(
                  file: images[i],
                  onRemove: () => onRemove(i),
                ),
            ],
          ),
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add_photo_alternate_outlined),
          label: const Text('Add Pictures'),
        ),
      ],
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final XFile file;
  final VoidCallback onRemove;

  const _Thumbnail({required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.55),
            ),
            image: DecorationImage(
              image: _imageProvider(file),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: -8,
          right: -8,
          child: Material(
            color: colorScheme.surface,
            shape: const CircleBorder(),
            elevation: 2,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onRemove,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Icon(
                  Icons.close_rounded,
                  size: 16,
                  color: colorScheme.error,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ImageProvider _imageProvider(XFile f) {
    if (kIsWeb) {
      // On web, XFile exposes a blob URL. Use NetworkImage on web.
      return NetworkImage(f.path);
    }
    return FileImage(File(f.path));
  }
}

/// Convenience helper that owns picker logic. Returns the picked
/// images, or an empty list on cancel/error.
class CopyHouseImagePicker {
  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>> pickMultiple() async {
    try {
      final picked = await _picker.pickMultiImage(
        imageQuality: 85,
        maxWidth: 2000,
      );
      return picked;
    } catch (_) {
      return const <XFile>[];
    }
  }
}