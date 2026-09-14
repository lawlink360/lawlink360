import '../models/law_category_model.dart';

class LawCategoriesData {
  LawCategoriesData._();

  static const List<LawCategoryModel> categories = [
    LawCategoryModel(
      id: 'civil',
      name: 'Civil Law',
      description: 'Civil rights, suits, remedies, property and general civil matters.',
      iconName: 'account_balance',
      isFeatured: true,
      displayOrder: 1,
    ),
    LawCategoryModel(
      id: 'criminal',
      name: 'Criminal Law',
      description: 'Offences, punishments, criminal procedure and criminal justice.',
      iconName: 'security',
      isFeatured: true,
      displayOrder: 2,
    ),
    LawCategoryModel(
      id: 'family_guardian',
      name: 'Family & Guardian',
      description: 'Marriage, divorce, maintenance, custody, guardianship and family matters.',
      iconName: 'family_restroom',
      isFeatured: true,
      displayOrder: 3,
    ),
    LawCategoryModel(
      id: 'corporate_commercial',
      name: 'Corporate & Commercial Law',
      description: 'Companies, businesses, commercial transactions and corporate matters.',
      iconName: 'business',
      isFeatured: true,
      displayOrder: 4,
    ),
    LawCategoryModel(
      id: 'company_firm_registration',
      name: 'Company & Firm Registration',
      description: 'Company incorporation, firm registration and business registration matters.',
      iconName: 'app_registration',
      isFeatured: false,
      displayOrder: 5,
    ),
    LawCategoryModel(
      id: 'tax_fbr',
      name: 'Tax & FBR',
      description: 'Income tax, sales tax, FBR matters, assessments and tax appeals.',
      iconName: 'payments',
      isFeatured: false,
      displayOrder: 6,
    ),
    LawCategoryModel(
      id: 'labour_employment',
      name: 'Labour & Employment',
      description: 'Employment, workers, industrial relations and workplace matters.',
      iconName: 'engineering',
      isFeatured: false,
      displayOrder: 7,
    ),
    LawCategoryModel(
      id: 'immigration',
      name: 'Immigration Law',
      description: 'Immigration, visas, nationality and related legal matters.',
      iconName: 'flight_takeoff',
      isFeatured: false,
      displayOrder: 8,
    ),
    LawCategoryModel(
      id: 'banking_finance',
      name: 'Banking & Finance',
      description: 'Banking, financial institutions, negotiable instruments and finance.',
      iconName: 'account_balance_wallet',
      isFeatured: false,
      displayOrder: 9,
    ),
    LawCategoryModel(
      id: 'constitutional',
      name: 'Constitutional Law',
      description: 'Constitution, fundamental rights and constitutional matters.',
      iconName: 'gavel',
      isFeatured: true,
      displayOrder: 10,
    ),
    LawCategoryModel(
      id: 'narcotics',
      name: 'Narcotics',
      description: 'Narcotics offences, controlled substances and related proceedings.',
      iconName: 'local_pharmacy',
      isFeatured: false,
      displayOrder: 11,
    ),
    LawCategoryModel(
      id: 'nab_fia',
      name: 'NAB & FIA',
      description: 'NAB, FIA, financial crimes, investigations and related proceedings.',
      iconName: 'policy',
      isFeatured: false,
      displayOrder: 12,
    ),
    LawCategoryModel(
      id: 'consumer_protection',
      name: 'Consumer Protection',
      description: 'Consumer rights, complaints, claims and consumer protection matters.',
      iconName: 'shopping_basket',
      isFeatured: false,
      displayOrder: 13,
    ),
    LawCategoryModel(
      id: 'cyber_crime_harassment',
      name: 'Cyber Crime & Harassment',
      description: 'Cyber offences, online harassment, digital crimes and related matters.',
      iconName: 'security_update_warning',
      isFeatured: false,
      displayOrder: 14,
    ),
    LawCategoryModel(
      id: 'medical_drugs',
      name: 'Medical & Drugs',
      description: 'Medical law, healthcare regulation, medicines and pharmaceutical matters.',
      iconName: 'medical_services',
      isFeatured: false,
      displayOrder: 15,
    ),
    LawCategoryModel(
      id: 'bor_revenue',
      name: 'BOR / Revenue',
      description: 'Board of Revenue, land records, revenue and related matters.',
      iconName: 'landscape',
      isFeatured: false,
      displayOrder: 16,
    ),
    LawCategoryModel(
      id: 'environmental',
      name: 'Environmental Law',
      description: 'Environmental protection, regulation and environmental disputes.',
      iconName: 'eco',
      isFeatured: false,
      displayOrder: 17,
    ),
    LawCategoryModel(
      id: 'intellectual_property',
      name: 'Intellectual Property',
      description: 'Trademarks, copyrights, patents and other intellectual property matters.',
      iconName: 'copyright',
      isFeatured: false,
      displayOrder: 18,
    ),
    LawCategoryModel(
      id: 'adr',
      name: 'Alternative Dispute Resolution (ADR)',
      description: 'Arbitration, mediation, conciliation and alternative dispute resolution.',
      iconName: 'handshake',
      isFeatured: false,
      displayOrder: 19,
    ),
  ];

  static List<LawCategoryModel> get featuredCategories {
    return categories
        .where((category) => category.isFeatured)
        .toList();
  }

  static List<LawCategoryModel> get allCategories {
    final sortedCategories = [...categories];

    sortedCategories.sort(
      (a, b) => a.displayOrder.compareTo(b.displayOrder),
    );

    return sortedCategories;
  }

  static LawCategoryModel? getById(String id) {
    try {
      return categories.firstWhere(
        (category) => category.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}