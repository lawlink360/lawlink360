import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_settings/data/mock/admin_settings_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_settings/models/admin_settings_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_settings/models/system_settings_model.dart';

final adminSettingsProvider =
    NotifierProvider<AdminSettingsNotifier, AsyncValue<AdminSettingsModel>>(
  AdminSettingsNotifier.new,
);

final systemSettingsProvider =
    NotifierProvider<SystemSettingsNotifier, AsyncValue<SystemSettingsModel>>(
  SystemSettingsNotifier.new,
);

class AdminSettingsNotifier
    extends Notifier<AsyncValue<AdminSettingsModel>> {
  @override
  AsyncValue<AdminSettingsModel> build() {
    return AsyncValue.data(
      AdminSettingsMockData.getAdminSettings(),
    );
  }

  AdminSettingsModel? get settings {
    return state.valueOrNull;
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();

    try {
      await Future<void>.delayed(
        const Duration(milliseconds: 150),
      );

      state = AsyncValue.data(
        AdminSettingsMockData.getAdminSettings(),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void updateSettings(AdminSettingsModel updatedSettings) {
    state = AsyncValue.data(updatedSettings);
  }

  void setMaintenanceMode(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        maintenanceMode: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setNewRegistrations(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        allowNewRegistrations: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setLawyerRegistrations(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        allowLawyerRegistrations: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setLawyerVerification(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        requireLawyerVerification: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setUserEmailVerification(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        requireUserEmailVerification: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setNotifications(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enableNotifications: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setPushNotifications(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enablePushNotifications: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setEmailNotifications(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enableEmailNotifications: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setSmsNotifications(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enableSmsNotifications: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setPayments(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enablePayments: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateCommissionRate(double rate) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        commissionRate: rate,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateAppointmentCancellationHours(int hours) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        appointmentCancellationHours: hours,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateMaxBookingDays(int days) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        maxBookingDays: days,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateMaintenanceMessage(String message) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        maintenanceMessage: message,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateSupportEmail(String email) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        supportEmail: email,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateSupportPhone(String phone) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        supportPhone: phone,
        updatedAt: DateTime.now(),
      ),
    );
  }
}

class SystemSettingsNotifier
    extends Notifier<AsyncValue<SystemSettingsModel>> {
  @override
  AsyncValue<SystemSettingsModel> build() {
    return AsyncValue.data(
      AdminSettingsMockData.getSystemSettings(),
    );
  }

  SystemSettingsModel? get settings {
    return state.valueOrNull;
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();

    try {
      await Future<void>.delayed(
        const Duration(milliseconds: 150),
      );

      state = AsyncValue.data(
        AdminSettingsMockData.getSystemSettings(),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void updateSettings(SystemSettingsModel updatedSettings) {
    state = AsyncValue.data(updatedSettings);
  }

  void setMaintenanceMode(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        maintenanceMode: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setDebugMode(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        debugMode: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setTwoFactorAuthentication(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enableTwoFactorAuthentication: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setStrongPasswords(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enforceStrongPasswords: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setPushNotifications(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enablePushNotifications: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setEmailNotifications(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enableEmailNotifications: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setSmsNotifications(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enableSmsNotifications: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setAppointments(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enableAppointments: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setCases(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enableCases: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setChat(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enableChat: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setVoiceCalls(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enableVoiceCalls: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setVideoCalls(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enableVideoCalls: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setPayments(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enablePayments: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void setDocumentUploads(bool enabled) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        enableDocumentUploads: enabled,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateSessionTimeout(int minutes) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        sessionTimeoutMinutes: minutes,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateMaxLoginAttempts(int attempts) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        maxLoginAttempts: attempts,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateMaxFileSize(int sizeMb) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        maxFileSizeMb: sizeMb,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateMaxDocumentsPerUser(int count) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        maxDocumentsPerUser: count,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateApiEnvironment(String environment) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        apiEnvironment: environment,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateDefaultLanguage(String language) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        defaultLanguage: language,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateTimezone(String timezone) {
    final currentSettings = settings;

    if (currentSettings == null) {
      return;
    }

    updateSettings(
      currentSettings.copyWith(
        timezone: timezone,
        updatedAt: DateTime.now(),
      ),
    );
  }
}