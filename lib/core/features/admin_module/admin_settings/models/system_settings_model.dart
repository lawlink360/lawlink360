class SystemSettingsModel {
  final String id;

  // System status
  final bool maintenanceMode;
  final String maintenanceMessage;
  final bool debugMode;

  // Security
  final bool enableTwoFactorAuthentication;
  final bool enforceStrongPasswords;
  final int sessionTimeoutMinutes;
  final int maxLoginAttempts;

  // Notifications
  final bool enablePushNotifications;
  final bool enableEmailNotifications;
  final bool enableSmsNotifications;

  // Platform features
  final bool enableAppointments;
  final bool enableCases;
  final bool enableChat;
  final bool enableVoiceCalls;
  final bool enableVideoCalls;
  final bool enablePayments;
  final bool enableDocumentUploads;

  // File & storage
  final int maxFileSizeMb;
  final int maxDocumentsPerUser;

  // API / services
  final String apiEnvironment;
  final String defaultLanguage;
  final String defaultCountry;
  final String timezone;

  final DateTime updatedAt;

  const SystemSettingsModel({
    required this.id,
    required this.maintenanceMode,
    required this.maintenanceMessage,
    required this.debugMode,
    required this.enableTwoFactorAuthentication,
    required this.enforceStrongPasswords,
    required this.sessionTimeoutMinutes,
    required this.maxLoginAttempts,
    required this.enablePushNotifications,
    required this.enableEmailNotifications,
    required this.enableSmsNotifications,
    required this.enableAppointments,
    required this.enableCases,
    required this.enableChat,
    required this.enableVoiceCalls,
    required this.enableVideoCalls,
    required this.enablePayments,
    required this.enableDocumentUploads,
    required this.maxFileSizeMb,
    required this.maxDocumentsPerUser,
    required this.apiEnvironment,
    required this.defaultLanguage,
    required this.defaultCountry,
    required this.timezone,
    required this.updatedAt,
  });

  SystemSettingsModel copyWith({
    String? id,
    bool? maintenanceMode,
    String? maintenanceMessage,
    bool? debugMode,
    bool? enableTwoFactorAuthentication,
    bool? enforceStrongPasswords,
    int? sessionTimeoutMinutes,
    int? maxLoginAttempts,
    bool? enablePushNotifications,
    bool? enableEmailNotifications,
    bool? enableSmsNotifications,
    bool? enableAppointments,
    bool? enableCases,
    bool? enableChat,
    bool? enableVoiceCalls,
    bool? enableVideoCalls,
    bool? enablePayments,
    bool? enableDocumentUploads,
    int? maxFileSizeMb,
    int? maxDocumentsPerUser,
    String? apiEnvironment,
    String? defaultLanguage,
    String? defaultCountry,
    String? timezone,
    DateTime? updatedAt,
  }) {
    return SystemSettingsModel(
      id: id ?? this.id,
      maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      maintenanceMessage:
          maintenanceMessage ?? this.maintenanceMessage,
      debugMode: debugMode ?? this.debugMode,
      enableTwoFactorAuthentication:
          enableTwoFactorAuthentication ??
              this.enableTwoFactorAuthentication,
      enforceStrongPasswords:
          enforceStrongPasswords ?? this.enforceStrongPasswords,
      sessionTimeoutMinutes:
          sessionTimeoutMinutes ?? this.sessionTimeoutMinutes,
      maxLoginAttempts:
          maxLoginAttempts ?? this.maxLoginAttempts,
      enablePushNotifications:
          enablePushNotifications ?? this.enablePushNotifications,
      enableEmailNotifications:
          enableEmailNotifications ?? this.enableEmailNotifications,
      enableSmsNotifications:
          enableSmsNotifications ?? this.enableSmsNotifications,
      enableAppointments:
          enableAppointments ?? this.enableAppointments,
      enableCases:
          enableCases ?? this.enableCases,
      enableChat:
          enableChat ?? this.enableChat,
      enableVoiceCalls:
          enableVoiceCalls ?? this.enableVoiceCalls,
      enableVideoCalls:
          enableVideoCalls ?? this.enableVideoCalls,
      enablePayments:
          enablePayments ?? this.enablePayments,
      enableDocumentUploads:
          enableDocumentUploads ?? this.enableDocumentUploads,
      maxFileSizeMb:
          maxFileSizeMb ?? this.maxFileSizeMb,
      maxDocumentsPerUser:
          maxDocumentsPerUser ?? this.maxDocumentsPerUser,
      apiEnvironment:
          apiEnvironment ?? this.apiEnvironment,
      defaultLanguage:
          defaultLanguage ?? this.defaultLanguage,
      defaultCountry:
          defaultCountry ?? this.defaultCountry,
      timezone:
          timezone ?? this.timezone,
      updatedAt:
          updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'maintenanceMode': maintenanceMode,
      'maintenanceMessage': maintenanceMessage,
      'debugMode': debugMode,
      'enableTwoFactorAuthentication':
          enableTwoFactorAuthentication,
      'enforceStrongPasswords':
          enforceStrongPasswords,
      'sessionTimeoutMinutes':
          sessionTimeoutMinutes,
      'maxLoginAttempts':
          maxLoginAttempts,
      'enablePushNotifications':
          enablePushNotifications,
      'enableEmailNotifications':
          enableEmailNotifications,
      'enableSmsNotifications':
          enableSmsNotifications,
      'enableAppointments':
          enableAppointments,
      'enableCases':
          enableCases,
      'enableChat':
          enableChat,
      'enableVoiceCalls':
          enableVoiceCalls,
      'enableVideoCalls':
          enableVideoCalls,
      'enablePayments':
          enablePayments,
      'enableDocumentUploads':
          enableDocumentUploads,
      'maxFileSizeMb':
          maxFileSizeMb,
      'maxDocumentsPerUser':
          maxDocumentsPerUser,
      'apiEnvironment':
          apiEnvironment,
      'defaultLanguage':
          defaultLanguage,
      'defaultCountry':
          defaultCountry,
      'timezone':
          timezone,
      'updatedAt':
          updatedAt.toIso8601String(),
    };
  }

  factory SystemSettingsModel.fromMap(Map<String, dynamic> map) {
    return SystemSettingsModel(
      id: map['id']?.toString() ?? '',

      maintenanceMode:
          map['maintenanceMode'] as bool? ?? false,

      maintenanceMessage:
          map['maintenanceMessage']?.toString() ?? '',

      debugMode:
          map['debugMode'] as bool? ?? false,

      enableTwoFactorAuthentication:
          map['enableTwoFactorAuthentication'] as bool? ?? false,

      enforceStrongPasswords:
          map['enforceStrongPasswords'] as bool? ?? true,

      sessionTimeoutMinutes:
          (map['sessionTimeoutMinutes'] as num?)?.toInt() ?? 60,

      maxLoginAttempts:
          (map['maxLoginAttempts'] as num?)?.toInt() ?? 5,

      enablePushNotifications:
          map['enablePushNotifications'] as bool? ?? true,

      enableEmailNotifications:
          map['enableEmailNotifications'] as bool? ?? true,

      enableSmsNotifications:
          map['enableSmsNotifications'] as bool? ?? false,

      enableAppointments:
          map['enableAppointments'] as bool? ?? true,

      enableCases:
          map['enableCases'] as bool? ?? true,

      enableChat:
          map['enableChat'] as bool? ?? true,

      enableVoiceCalls:
          map['enableVoiceCalls'] as bool? ?? true,

      enableVideoCalls:
          map['enableVideoCalls'] as bool? ?? true,

      enablePayments:
          map['enablePayments'] as bool? ?? true,

      enableDocumentUploads:
          map['enableDocumentUploads'] as bool? ?? true,

      maxFileSizeMb:
          (map['maxFileSizeMb'] as num?)?.toInt() ?? 10,

      maxDocumentsPerUser:
          (map['maxDocumentsPerUser'] as num?)?.toInt() ?? 50,

      apiEnvironment:
          map['apiEnvironment']?.toString() ?? 'development',

      defaultLanguage:
          map['defaultLanguage']?.toString() ?? 'English',

      defaultCountry:
          map['defaultCountry']?.toString() ?? 'Pakistan',

      timezone:
          map['timezone']?.toString() ?? 'Asia/Karachi',

      updatedAt:
          _parseDate(map['updatedAt']),
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