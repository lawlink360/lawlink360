import '../models/law_category_model.dart';

class LawCategoriesData {
  LawCategoriesData._();

  static const List<LawCategoryModel> categories = [
    LawCategoryModel(
      id: 'constitutional',
      name: 'Constitutional Laws',
      description: 'Constitution, fundamental rights and constitutional matters.',
      iconName: 'gavel',
      isFeatured: true,
      displayOrder: 1,
    ),
    LawCategoryModel(
      id: 'civil',
      name: 'Civil Laws',
      description: 'Civil rights, suits, remedies and general civil matters.',
      iconName: 'account_balance',
      isFeatured: true,
      displayOrder: 2,
    ),
    LawCategoryModel(
      id: 'criminal',
      name: 'Criminal Laws',
      description: 'Offences, punishments, criminal procedure and investigation.',
      iconName: 'security',
      isFeatured: true,
      displayOrder: 3,
    ),
    LawCategoryModel(
      id: 'family',
      name: 'Family Laws',
      description: 'Marriage, divorce, maintenance, guardianship and family matters.',
      iconName: 'family_restroom',
      isFeatured: true,
      displayOrder: 4,
    ),
    LawCategoryModel(
      id: 'property',
      name: 'Property & Land Laws',
      description: 'Property ownership, transfer, possession, land and revenue matters.',
      iconName: 'home_work',
      isFeatured: true,
      displayOrder: 5,
    ),
    LawCategoryModel(
      id: 'evidence',
      name: 'Evidence Laws',
      description: 'Rules relating to evidence, relevancy, admissibility and proof.',
      iconName: 'fact_check',
      isFeatured: false,
      displayOrder: 6,
    ),
    LawCategoryModel(
      id: 'procedural',
      name: 'Procedural Laws',
      description: 'Civil and criminal procedure governing court proceedings.',
      iconName: 'description',
      isFeatured: false,
      displayOrder: 7,
    ),
    LawCategoryModel(
      id: 'banking',
      name: 'Banking & Financial Laws',
      description: 'Banking, financial institutions, negotiable instruments and finance.',
      iconName: 'account_balance_wallet',
      isFeatured: false,
      displayOrder: 8,
    ),
    LawCategoryModel(
      id: 'corporate',
      name: 'Corporate & Commercial Laws',
      description: 'Companies, businesses, commercial transactions and corporate matters.',
      iconName: 'business',
      isFeatured: false,
      displayOrder: 9,
    ),
    LawCategoryModel(
      id: 'tax',
      name: 'Tax Laws',
      description: 'Income tax, sales tax, customs and other taxation matters.',
      iconName: 'payments',
      isFeatured: false,
      displayOrder: 10,
    ),
    LawCategoryModel(
      id: 'labour',
      name: 'Labour Laws',
      description: 'Employment, workers, industrial relations and workplace matters.',
      iconName: 'engineering',
      isFeatured: false,
      displayOrder: 11,
    ),
    LawCategoryModel(
      id: 'service',
      name: 'Service Laws',
      description: 'Government service, employment, disciplinary and service matters.',
      iconName: 'badge',
      isFeatured: false,
      displayOrder: 12,
    ),
    LawCategoryModel(
      id: 'election',
      name: 'Election Laws',
      description: 'Election procedures, electoral matters and representation laws.',
      iconName: 'how_to_vote',
      isFeatured: false,
      displayOrder: 13,
    ),
    LawCategoryModel(
      id: 'local_government',
      name: 'Local Government Laws',
      description: 'Local government institutions, powers and municipal matters.',
      iconName: 'location_city',
      isFeatured: false,
      displayOrder: 14,
    ),
    LawCategoryModel(
      id: 'special',
      name: 'Special Laws',
      description: 'Special statutes dealing with specific legal subjects and institutions.',
      iconName: 'library_books',
      isFeatured: false,
      displayOrder: 15,
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