import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/lawyer_basic_info_model.dart';
import '../models/lawyer_professional_info_model.dart';
import '../models/lawyer_verification_model.dart';

class LawyerOnboardingNotifier
    extends StateNotifier<LawyerBasicInfoModel> {
  LawyerOnboardingNotifier()
      : super(const LawyerBasicInfoModel());

  // ============================================================
  // PROFESSIONAL INFORMATION
  // ============================================================

  LawyerProfessionalInfoModel professionalInfo =
      const LawyerProfessionalInfoModel();

  // ============================================================
  // VERIFICATION INFORMATION
  // ============================================================

  LawyerVerificationModel verificationInfo =
      const LawyerVerificationModel();

  // ============================================================
  // BASIC INFORMATION
  // ============================================================

  void updateFullName(String value) {
    state = state.copyWith(fullName: value);
  }

  void updatePhoneNumber(String value) {
    state = state.copyWith(phoneNumber: value);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updateGender(String value) {
    state = state.copyWith(gender: value);
  }

  void updateCity(String value) {
    state = state.copyWith(city: value);
  }

  void updateProfessionalIntroduction(String value) {
    state = state.copyWith(
      professionalIntroduction: value,
    );
  }

  void updateProfileImage(String? path) {
    state = state.copyWith(
      profileImagePath: path,
    );
  }

  // ============================================================
  // PROFESSIONAL INFORMATION
  // ============================================================

  void updatePracticeAreas(List<String> areas) {
    professionalInfo = professionalInfo.copyWith(
      practiceAreas: List<String>.from(areas),
    );

    _notify();
  }

  void updateYearsOfExperience(int years) {
    professionalInfo = professionalInfo.copyWith(
      yearsOfExperience: years,
    );

    _notify();
  }

  void updateLicenseNumber(String value) {
    professionalInfo = professionalInfo.copyWith(
      licenseNumber: value,
    );

    _notify();
  }

  void updateCourts(List<String> courts) {
    professionalInfo = professionalInfo.copyWith(
      courts: List<String>.from(courts),
    );

    _notify();
  }

  void updateAbout(String value) {
    professionalInfo = professionalInfo.copyWith(
      about: value,
    );

    _notify();
  }

  // ============================================================
  // FORCE RIVERPOD REBUILD
  // ============================================================

  void _notify() {
    state = state.copyWith();
  }

  // ============================================================
  // VERIFICATION INFORMATION
  // ============================================================

  void updateBarCardFront(String? path) {
    verificationInfo = verificationInfo.copyWith(
      barCardFrontPath: path,
    );

    _notify();
  }

  void updateBarCardBack(String? path) {
    verificationInfo = verificationInfo.copyWith(
      barCardBackPath: path,
    );

    _notify();
  }

  void updateIdCardFront(String? path) {
    verificationInfo = verificationInfo.copyWith(
      idCardFrontPath: path,
    );

    _notify();
  }

  void updateIdCardBack(String? path) {
    verificationInfo = verificationInfo.copyWith(
      idCardBackPath: path,
    );

    _notify();
  }

  void updateVerificationStatus(
    LawyerVerificationStatus status,
  ) {
    verificationInfo = verificationInfo.copyWith(
      status: status,
    );

    _notify();
  }

  void submitVerification() {
    verificationInfo = verificationInfo.copyWith(
      status: LawyerVerificationStatus.underReview,
      submittedAt: DateTime.now(),
    );

    _notify();
  }

  void updateVerificationNote(String? note) {
    verificationInfo = verificationInfo.copyWith(
      verificationNote: note,
    );

    _notify();
  }

  // ============================================================
  // RESET
  // ============================================================

  void reset() {
    state = const LawyerBasicInfoModel();

    professionalInfo =
        const LawyerProfessionalInfoModel();

    verificationInfo =
        const LawyerVerificationModel();
  }
}

// ================================================================
// PROVIDER
// ================================================================

final lawyerOnboardingProvider = StateNotifierProvider<
    LawyerOnboardingNotifier,
    LawyerBasicInfoModel>(
  (ref) => LawyerOnboardingNotifier(),
);