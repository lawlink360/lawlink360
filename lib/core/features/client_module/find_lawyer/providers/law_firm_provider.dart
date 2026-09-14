import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/law_firm_model.dart';

/// Provides the local law-firm directory during the UI/polish phase.
///
/// The provider is deliberately isolated so the future backend can replace
/// this data source without requiring changes to the Find Lawyer UI.
final lawFirmDirectoryProvider = StreamProvider<List<LawFirm>>((ref) {
  return Stream.value(
    [
      LawFirm(
        id: 'firm_demo_001',
        name: 'Raza & Associates',
        location: 'Lahore',
        description:
            'Full-service legal practice providing representation and consultation across major areas of law.',
        practiceAreas: const [
          'Civil Law',
          'Corporate & Commercial Law',
          'Family & Guardian',
        ],
        rating: 4.9,
        lawyersCount: 18,
        verified: true,
        consultationFee: 5000,
        specializationSummary:
            'Civil litigation • Corporate matters • Property disputes • Family law',
        isOnline: true,
        isFeatured: true,
        promotionPriority: 100,
      ),
      LawFirm(
        id: 'firm_demo_002',
        name: 'Khan Legal Chambers',
        location: 'Lahore',
        description:
            'Experienced legal team focused on litigation, family matters, property disputes, and commercial work.',
        practiceAreas: const [
          'Civil Law',
          'Family & Guardian',
          'BOR / Revenue',
        ],
        rating: 4.8,
        lawyersCount: 14,
        verified: true,
        consultationFee: 4500,
        specializationSummary:
            'Civil litigation • Family disputes • Property matters • Revenue cases',
        isOnline: true,
        isFeatured: true,
        promotionPriority: 90,
      ),
      LawFirm(
        id: 'firm_demo_003',
        name: 'Horizon Legal Consultants',
        location: 'Islamabad',
        description:
            'Professional legal consultancy serving individuals, businesses, and institutions.',
        practiceAreas: const [
          'Corporate & Commercial Law',
          'Banking & Finance',
          'Constitutional Law',
        ],
        rating: 4.7,
        lawyersCount: 11,
        verified: true,
        consultationFee: 6000,
        specializationSummary:
            'Corporate advisory • Banking matters • Commercial disputes • Constitutional law',
        isOnline: false,
      ),
      LawFirm(
        id: 'firm_demo_004',
        name: 'Malik & Partners',
        location: 'Rawalpindi',
        description:
            'Legal practice providing litigation, family, criminal, and property-related legal services.',
        practiceAreas: const [
          'Criminal Law',
          'Family & Guardian',
          'Civil Law',
        ],
        rating: 4.7,
        lawyersCount: 9,
        verified: true,
        consultationFee: 4000,
        specializationSummary:
            'Criminal defense • Family matters • Civil litigation • Property disputes',
        isOnline: true,
      ),
    ],
  );
});