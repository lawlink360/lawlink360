import 'package:url_launcher/url_launcher.dart';

import '../data/copy_house_request_constants.dart';

/// Result of a support-launch attempt.
enum SupportLaunchResult {
  /// Launch handed off to the OS.
  launched,
  /// Support number is still the placeholder. Nothing was launched.
  notConfigured,
  /// The current device cannot handle the URI, or the launch failed.
  unsupportedOrFailed,
}

/// Thin wrapper over `url_launcher` for the Copy House Customer Support
/// Center.
///
/// All failure modes are reported via [SupportLaunchResult] rather than
/// exceptions, so the caller can render a user-facing message without
/// needing to catch.
class CopyHouseSupportLauncher {
  const CopyHouseSupportLauncher();

  bool get isConfigured =>
      copyHouseSupportPhoneE164 != copyHouseSupportPhoneE164Placeholder &&
      copyHouseSupportPhoneE164.trim().isNotEmpty;

  /// Opens WhatsApp to the configured number with a prefilled message.
  /// The user reviews and sends manually; this method does not send.
  Future<SupportLaunchResult> openWhatsApp() async {
    if (!isConfigured) return SupportLaunchResult.notConfigured;

    final digits = _normalisePhoneForWhatsApp(copyHouseSupportPhoneE164);
    final message = Uri.encodeComponent(copyHouseWhatsAppPrefillMessage);
    final uri = Uri.parse('https://wa.me/$digits?text=$message');

    return _launch(uri);
  }

  /// Opens the dialler with the configured number. Does not place the call.
  Future<SupportLaunchResult> openDialler() async {
    if (!isConfigured) return SupportLaunchResult.notConfigured;

    final uri = Uri(scheme: 'tel', path: copyHouseSupportPhoneE164);

    return _launch(uri);
  }

  Future<SupportLaunchResult> _launch(Uri uri) async {
    try {
      final supported =
          await canLaunchUrl(uri).timeout(const Duration(seconds: 5));
      if (!supported) return SupportLaunchResult.unsupportedOrFailed;

      final ok = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      ).timeout(const Duration(seconds: 10));
      return ok
          ? SupportLaunchResult.launched
          : SupportLaunchResult.unsupportedOrFailed;
    } catch (_) {
      return SupportLaunchResult.unsupportedOrFailed;
    }
  }

  String _normalisePhoneForWhatsApp(String phone) {
    // wa.me expects digits only, no leading `+`, no separators.
    return phone.replaceAll(RegExp(r'[^0-9]'), '');
  }
}