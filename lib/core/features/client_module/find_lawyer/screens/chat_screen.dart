import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../widgets/chat_header.dart';
import '../widgets/chat_secure_chat_card.dart';
import '../widgets/chat_date_divider.dart';
import '../widgets/chat_lawyer_message.dart';
import '../widgets/chat_client_message.dart';
import '../widgets/chat_document_message.dart';
import '../widgets/chat_quick_action_bar.dart';
import '../widgets/chat_message_input_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<_ChatMessage> _messages = [];

  void _addTextMessage(String message) {
    final text = message.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      _messages.add(
        _ChatMessage.text(text),
      );
    });
  }

  void _addAttachment({
    required String name,
    required String type,
    required int? size,
    required String? path,
  }) {
    setState(() {
      _messages.add(
        _ChatMessage.attachment(
          name: name,
          type: type,
          size: size,
          path: path,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const ChatHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                physics: const BouncingScrollPhysics(),
                children: [
                  const ChatSecureChatCard(),
                  const SizedBox(height: AppSpacing.lg),
                  const ChatDateDivider(),
                  const SizedBox(height: AppSpacing.lg),

                  const ChatLawyerMessage(),
                  const ChatClientMessage(),
                  const ChatLawyerMessage(),
                  const ChatClientMessage(),
                  const ChatDocumentMessage(),
                  const ChatClientMessage(),

                  ..._messages.map(
                    (message) {
                      if (message.type == _ChatMessageType.text) {
                        return _SentTextMessage(
                          message: message.text!,
                        );
                      }

                      if (message.type == _ChatMessageType.voice) {
                        return _SentVoiceMessage(
                          path: message.path!,
                        );
                      }

                      return _SentAttachmentMessage(
                        name: message.name!,
                        type: message.attachmentType!,
                        size: message.size,
                        path: message.path,
                      );
                    },
                  ),

                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
            ChatQuickActionBar(
              onAttachmentSelected: _addAttachment,
            ),
            ChatMessageInputBar(
              onSend: _addTextMessage,
            ),
          ],
        ),
      ),
    );
  }
}

enum _ChatMessageType {
  text,
  attachment,
  voice,
}

class _ChatMessage {
  final _ChatMessageType type;
  final String? text;
  final String? name;
  final String? attachmentType;
  final int? size;
  final String? path;

  const _ChatMessage({
    required this.type,
    this.text,
    this.name,
    this.attachmentType,
    this.size,
    this.path,
  });

  factory _ChatMessage.text(String text) {
    return _ChatMessage(
      type: _ChatMessageType.text,
      text: text,
    );
  }

  factory _ChatMessage.attachment({
    required String name,
    required String type,
    required int? size,
    required String? path,
  }) {
    return _ChatMessage(
      type: type == 'audio'
          ? _ChatMessageType.voice
          : _ChatMessageType.attachment,
      name: name,
      attachmentType: type,
      size: size,
      path: path,
    );
  }
}

class _SentTextMessage extends StatelessWidget {
  final String message;

  const _SentTextMessage({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: AppSpacing.md,
          left: AppSpacing.xxl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.lg),
                  topRight: Radius.circular(AppRadius.sm),
                  bottomLeft: Radius.circular(AppRadius.lg),
                  bottomRight: Radius.circular(AppRadius.sm),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                message,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white,
                  height: 1.45,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _currentTime(),
                  style: AppTextStyles.caption.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Icon(
                  Icons.done_all_rounded,
                  size: 15,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SentVoiceMessage extends StatelessWidget {
  final String path;

  const _SentVoiceMessage({
    required this.path,
  });

  Future<void> _playVoice(BuildContext context) async {
    try {
      await OpenFilex.open(path);
    } catch (_) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to play the voice message.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: AppSpacing.md,
          left: AppSpacing.xxl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Material(
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.lg),
                topRight: Radius.circular(AppRadius.sm),
                bottomLeft: Radius.circular(AppRadius.lg),
                bottomRight: Radius.circular(AppRadius.sm),
              ),
              child: InkWell(
                onTap: () => _playVoice(context),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.lg),
                  topRight: Radius.circular(AppRadius.sm),
                  bottomLeft: Radius.circular(AppRadius.lg),
                  bottomRight: Radius.circular(AppRadius.sm),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Voice message',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Tap to play',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white.withValues(alpha: 0.75),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _currentTime(),
                  style: AppTextStyles.caption.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Icon(
                  Icons.done_all_rounded,
                  size: 15,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SentAttachmentMessage extends StatelessWidget {
  final String name;
  final String type;
  final int? size;
  final String? path;

  const _SentAttachmentMessage({
    required this.name,
    required this.type,
    required this.size,
    required this.path,
  });

  bool get _isImage {
    final lowerType = type.toLowerCase();

    return lowerType.startsWith('image/') ||
        lowerType == 'jpg' ||
        lowerType == 'jpeg' ||
        lowerType == 'png' ||
        lowerType == 'webp';
  }

  String get _displaySize {
    if (size == null || size == 0) {
      return 'Image';
    }

    final bytes = size!;

    if (bytes < 1024) {
      return '$bytes B';
    }

    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }

    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  IconData get _fileIcon {
    final lowerName = name.toLowerCase();

    if (lowerName.endsWith('.pdf')) {
      return Icons.picture_as_pdf_rounded;
    }

    if (lowerName.endsWith('.doc') ||
        lowerName.endsWith('.docx')) {
      return Icons.description_rounded;
    }

    if (lowerName.endsWith('.xls') ||
        lowerName.endsWith('.xlsx')) {
      return Icons.table_chart_rounded;
    }

    return Icons.insert_drive_file_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: AppSpacing.md,
          left: AppSpacing.xxl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 290,
              ),
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.45),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: _isImage && path != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppRadius.md,
                          ),
                          child: Image.file(
                            File(path!),
                            width: 270,
                            height: 190,
                            fit: BoxFit.cover,
                            errorBuilder: (
                              context,
                              error,
                              stackTrace,
                            ) {
                              return _FilePreview(
                                icon: Icons.broken_image_outlined,
                                name: name,
                                size: _displaySize,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : _FilePreview(
                      icon: _fileIcon,
                      name: name,
                      size: _displaySize,
                    ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _currentTime(),
                  style: AppTextStyles.caption.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Icon(
                  Icons.done_all_rounded,
                  size: 15,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FilePreview extends StatelessWidget {
  final IconData icon;
  final String name;
  final String size;

  const _FilePreview({
    required this.icon,
    required this.name,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(
            icon,
            color: AppColors.accent,
            size: 25,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                size,
                style: AppTextStyles.caption.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String _currentTime() {
  final now = TimeOfDay.now();

  final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
  final minute = now.minute.toString().padLeft(2, '0');
  final period = now.period == DayPeriod.am ? 'AM' : 'PM';

  return '$hour:$minute $period';
}