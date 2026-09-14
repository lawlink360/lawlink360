import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/lawyer_model.dart';

/// Provides the local lawyer directory used during the UI/polish phase.
///
/// Firebase integration will replace this data source during the backend
/// phase without requiring changes to the Find Lawyer screen.
final lawyerDirectoryProvider = StreamProvider<List<Lawyer>>((ref) {
  return Stream.value(
    [
      Lawyer(
        id: 'lawyer_demo_001',
        name: 'Adv. Ahmed Raza',
        speciality: 'Civil Law',
        specializationSummary:
            'Property disputes • Partition • Inheritance • Land litigation',
        location: 'Lahore',
        rating: 4.9,
        experience: 12,
        verified: true,
        casesHandled: 320,
        phone: '',
        email: '',
        consultationFee: 5000,
        isOnline: true,
        isFeatured: true,
        promotionPriority: 100,
      ),
      Lawyer(
        id: 'lawyer_demo_002',
        name: 'Adv. Sara Khan',
        speciality: 'Family Law',
        specializationSummary:
            'Family disputes • Divorce • Child custody • Maintenance',
        location: 'Lahore',
        rating: 4.8,
        experience: 9,
        verified: true,
        casesHandled: 245,
        phone: '',
        email: '',
        consultationFee: 4000,
        isOnline: true,
      ),
      Lawyer(
        id: 'lawyer_demo_003',
        name: 'Adv. Muhammad Usman',
        speciality: 'Criminal Law',
        specializationSummary:
            'Criminal defense • Bail matters • FIRs • Criminal trials',
        location: 'Islamabad',
        rating: 4.7,
        experience: 11,
        verified: true,
        casesHandled: 280,
        phone: '',
        email: '',
        consultationFee: 6000,
        isOnline: false,
        isFeatured: true,
        promotionPriority: 80,
      ),
      Lawyer(
        id: 'lawyer_demo_004',
        name: 'Adv. Ayesha Malik',
        speciality: 'Property Law',
        specializationSummary:
            'Property disputes • Sale and purchase • Land records • Partition',
        location: 'Rawalpindi',
        rating: 4.9,
        experience: 10,
        verified: true,
        casesHandled: 198,
        phone: '',
        email: '',
        consultationFee: 4500,
        isOnline: true,
      ),
      Lawyer(
        id: 'lawyer_demo_005',
        name: 'Adv. Hamza Ali',
        speciality: 'Corporate Law',
        specializationSummary:
            'Company matters • Contracts • Business disputes • Compliance',
        location: 'Karachi',
        rating: 4.6,
        experience: 8,
        verified: true,
        casesHandled: 175,
        phone: '',
        email: '',
        consultationFee: 7000,
        isOnline: false,
      ),
      Lawyer(
        id: 'lawyer_demo_006',
        name: 'Adv. Fatima Noor',
        speciality: 'Labour Law',
        specializationSummary:
            'Employment disputes • Labour claims • Service matters • Workplace issues',
        location: 'Lahore',
        rating: 4.7,
        experience: 7,
        verified: true,
        casesHandled: 156,
        phone: '',
        email: '',
        consultationFee: 3500,
        isOnline: true,
      ),
    ],
  );
});