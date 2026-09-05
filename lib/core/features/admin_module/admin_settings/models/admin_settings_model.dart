class AdminSettingsModel {
  final String id;
  final String appName;
  final String appVersion;

  // Registration & verification
  final bool allowNewRegistrations;
  final bool allowLawyerRegistrations;
  final bool requireLawyerVerification;
  final bool requireUserEmailVerification;

  // Notifications
  final bool enableNotifications;
  final bool enablePushNotifications;
  final bool enableEmailNotifications;
  final bool enableSmsNotifications;

  // Payments
  final bool enablePayments;
  final double commissionRate;

  // Appointments
  final int appointmentCancellationHours;
  final int maxBookingDays;

  // Maintenance
  final bool maintenanceMode;
  final String maintenanceMessage;

  // Support
  final String supportEmail;
  final String supportPhone;

  // Legal
  final String privacyPolicyUrl;
  final String termsUrl;

  final DateTime updatedAt;

  const AdminSettingsModel({
    required this.id,
    required this.appName,
    required this.appVersion,
    required this.allowNewRegistrations,
    required this.allowLawyerRegistrations,
    required this.requireLawyerVerification,
    required this.requireUserEmailVerification,
    required this.enableNotifications,
    required this.enablePushNotifications,
    required this.enableEmailNotifications,
    required this.enableSmsNotifications,
    required this.enablePayments,
    required this.commissionRate,
    required this.appointmentCancellationHours,
    required this.maxBookingDays,
    required this.maintenanceMode,
    required this.maintenanceMessage,
    required this.supportEmail,
    required this.supportPhone,
    required this.privacyPolicyUrl,
    required this.termsUrl,
    required this.updatedAt,
  });

  AdminSettingsModel copyWith({
    String? id,
    String? appName,
    String? appVersion,
    bool? allowNewRegistrations,
    bool? allowLawyerRegistrations,
    bool? requireLawyerVerification,
    bool? requireUserEmailVerification,
    bool? enableNotifications,
    bool? enablePushNotifications,
    bool? enableEmailNotifications,
    bool? enableSmsNotifications,
    bool? enablePayments,
    double? commissionRate,
    int? appointmentCancellationHours,
    int? maxBookingDays,
    bool? maintenanceMode,
    String? maintenanceMessage,
    String? supportEmail,
    String? supportPhone,
    String? privacyPolicyUrl,
    String? termsUrl,
    DateTime? updatedAt,
  }) {
    return AdminSettingsModel(
      id: id ?? this.id,
      appName: appName ?? this.appName,
      appVersion: appVersion ?? this.appVersion,
      allowNewRegistrations:
          allowNewRegistrations ?? this.allowNewRegistrations,
      allowLawyerRegistrations:
          allowLawyerRegistrations ?? this.allowLawyerRegistrations,
      requireLawyerVerification:
          requireLawyerVerification ?? this.requireLawyerVerification,
      requireUserEmailVerification: requireUserEmailVerification ??
          this.requireUserEmailVerification,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      enablePushNotifications:
          enablePushNotifications ?? this.enablePushNotifications,
      enableEmailNotifications:
          enableEmailNotifications ?? this.enableEmailNotifications,
      enableSmsNotifications:
          enableSmsNotifications ?? this.enableSmsNotifications,
      enablePayments: enablePayments ?? this.enablePayments,
      commissionRate: commissionRate ?? this.commissionRate,
      appointmentCancellationHours: appointmentCancellationHours ??
          this.appointmentCancellationHours,
      maxBookingDays: maxBookingDays ?? this.maxBookingDays,
      maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      maintenanceMessage: maintenanceMessage ?? this.maintenanceMessage,
      supportEmail: supportEmail ?? this.supportEmail,
      supportPhone: supportPhone ?? this.supportPhone,
      privacyPolicyUrl: privacyPolicyUrl ?? this.privacyPolicyUrl,
      termsUrl: termsUrl ?? this.termsUrl,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'appName': appName,
      'appVersion': appVersion,
      'allowNewRegistrations': allowNewRegistrations,
      'allowLawyerRegistrations': allowLawyerRegistrations,
      'requireLawyerVerification': requireLawyerVerification,
      'requireUserEmailVerification': requireUserEmailVerification,
      'enableNotifications': enableNotifications,
      'enablePushNotifications': enablePushNotifications,
      'enableEmailNotifications': enableEmailNotifications,
      'enableSmsNotifications': enableSmsNotifications,
      'enablePayments': enablePayments,
      'commissionRate': commissionRate,
      'appointmentCancellationHours': appointmentCancellationHours,
      'maxBookingDays': maxBookingDays,
      'maintenanceMode': maintenanceMode,
      'maintenanceMessage': maintenanceMessage,
      'supportEmail': supportEmail,
      'supportPhone': supportPhone,
      'privacyPolicyUrl': privacyPolicyUrl,
      'termsUrl': termsUrl,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory AdminSettingsModel.fromMap(Map<String, dynamic> map) {
    return AdminSettingsModel(
      id: map['id']?.toString() ?? '',
      appName: map['appName']?.toString() ?? 'LawLink360',
      appVersion: map['appVersion']?.toString() ?? '1.0.0',
      allowNewRegistrations:
          map['allowNewRegistrations'] as bool? ?? true,
      allowLawyerRegistrations:
          map['allowLawyerRegistrations'] as bool? ?? true,
      requireLawyerVerification:
          map['requireLawyerVerification'] as bool? ?? true,
      requireUserEmailVerification:
          map['requireUserEmailVerification'] as bool? ?? false,
      enableNotifications:
          map['enableNotifications'] as bool? ?? true,
      enablePushNotifications:
          map['enablePushNotifications'] as bool? ?? true,
      enableEmailNotifications:
          map['enableEmailNotifications'] as bool? ?? true,
      enableSmsNotifications:
          map['enableSmsNotifications'] as bool? ?? false,
      enablePayments:
          map['enablePayments'] as bool? ?? true,
      commissionRate:
          (map['commissionRate'] as num?)?.toDouble() ?? 10.0,
      appointmentCancellationHours:
          (map['appointmentCancellationHours'] as num?)?.toInt() ?? 24,
      maxBookingDays:
          (map['maxBookingDays'] as num?)?.toInt() ?? 30,
      maintenanceMode:
          map['maintenanceMode'] as bool? ?? false,
      maintenanceMessage:
          map['maintenanceMessage']?.toString() ?? '',
      supportEmail:
          map['supportEmail']?.toString() ?? '',
      supportPhone:
          map['supportPhone']?.toString() ?? '',
      privacyPolicyUrl:
          map['privacyPolicyUrl']?.toString() ?? '',
      termsUrl:
          map['termsUrl']?.toString() ?? '',
      updatedAt: _parseDate(map['updatedAt']),
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }

    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }

    return DateTime.now();
  }
}