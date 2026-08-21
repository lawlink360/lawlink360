import 'lawyer_basic_info_model.dart';
import 'lawyer_professional_info_model.dart';

class LawyerOnboardingModel {
  final LawyerBasicInfoModel basicInfo;
  final LawyerProfessionalInfoModel professionalInfo;

  const LawyerOnboardingModel({
    this.basicInfo = const LawyerBasicInfoModel(),
    this.professionalInfo = const LawyerProfessionalInfoModel(),
  });

  LawyerOnboardingModel copyWith({
    LawyerBasicInfoModel? basicInfo,
    LawyerProfessionalInfoModel? professionalInfo,
  }) {
    return LawyerOnboardingModel(
      basicInfo: basicInfo ?? this.basicInfo,
      professionalInfo:
          professionalInfo ?? this.professionalInfo,
    );
  }
}