import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radius.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';

class ChatQuickActionBar extends StatefulWidget {
  final void Function({
    required String name,
    required String type,
    required int? size,
    required String? path,
  }) onAttachmentSelected;

  const ChatQuickActionBar({
    super.key,
    required this.onAttachmentSelected,
  });

  @override
  State<ChatQuickActionBar> createState() =>
      _ChatQuickActionBarState();
}

class _ChatQuickActionBarState extends State<ChatQuickActionBar> {
  final AudioRecorder _audioRecorder = AudioRecorder();

  bool _isRecording = false;

  Future<void> _pickFile(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      final file = result.files.single;

      widget.onAttachmentSelected(
        name: file.name,
        type: file.extension ?? 'file',
        size: file.size,
        path: file.path,
      );
    } catch (_) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to select the file.'),
        ),
      );
    }
  }

  Future<void> _openCamera(BuildContext context) async {
    try {
      final picker = ImagePicker();

      final image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) {
        return;
      }

      widget.onAttachmentSelected(
        name: image.name,
        type: 'image',
        size: await image.length(),
        path: image.path,
      );
    } catch (_) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to open the camera.'),
        ),
      );
    }
  }

  Future<void> _openGallery(BuildContext context) async {
    try {
      final picker = ImagePicker();

      final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image == null) {
        return;
      }

      widget.onAttachmentSelected(
        name: image.name,
        type: 'image',
        size: await image.length(),
        path: image.path,
      );
    } catch (_) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to select an image.'),
        ),
      );
    }
  }

  Future<void> _toggleVoiceRecording(BuildContext context) async {
    if (_isRecording) {
      await _stopVoiceRecording(context);
    } else {
      await _startVoiceRecording(context);
    }
  }

  Future<void> _startVoiceRecording(BuildContext context) async {
    try {
      final hasPermission = await _audioRecorder.hasPermission();

      if (!hasPermission) {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Microphone permission is required to record voice messages.',
            ),
          ),
        );

        return;
      }

      final directory = await getTemporaryDirectory();

      final path =
          '${directory.path}/lawlink_voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
          numChannels: 1,
        ),
        path: path,
      );

      if (!mounted) return;

      setState(() {
        _isRecording = true;
      });
    } catch (_) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to start voice recording.'),
        ),
      );
    }
  }

  Future<void> _stopVoiceRecording(BuildContext context) async {
    try {
      final path = await _audioRecorder.stop();

      if (!mounted) return;

      setState(() {
        _isRecording = false;
      });

      if (path == null || path.isEmpty) {
        return;
      }

      widget.onAttachmentSelected(
        name: 'Voice message.m4a',
        type: 'audio',
        size: null,
        path: path,
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _isRecording = false;
      });

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to stop voice recording.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.25),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark
                  ? 0.18
                  : 0.04,
            ),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _QuickAction(
              icon: Icons.attach_file_rounded,
              title: 'File',
              onTap: () => _pickFile(context),
            ),
            _QuickAction(
              icon: Icons.camera_alt_outlined,
              title: 'Camera',
              onTap: () => _openCamera(context),
            ),
            _QuickAction(
              icon: Icons.photo_outlined,
              title: 'Gallery',
              onTap: () => _openGallery(context),
            ),
            _QuickAction(
              icon: _isRecording
                  ? Icons.stop_rounded
                  : Icons.mic_none_rounded,
              title: _isRecording ? 'Stop' : 'Voice',
              onTap: () => _toggleVoiceRecording(context),
              isActive: _isRecording,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool isActive;

  const _QuickAction({
    required this.icon,
    required this.title,
    this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xs,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.error
                    : AppColors.accent,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              title,
              style: AppTextStyles.caption.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}