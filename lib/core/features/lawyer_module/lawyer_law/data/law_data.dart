import '../models/law_model.dart';

class LawData {
  LawData._();

  static const List<LawModel> laws = [
    // ============================================================
    // A
    // ============================================================

    LawModel(
      id: 'arbitration_act_1940',
      title: 'Arbitration Act, 1940',
      shortTitle: 'Arbitration Act',
      year: 1940,
      jurisdiction: 'Federal',
      categoryId: 'civil',
      categoryName: 'Civil Laws',
      description:
          'Law relating to arbitration and enforcement of arbitral awards.',
      lawNumber: 'X of 1940',
      totalSections: 49,
      isFeatured: true,
      keywords: [
        'arbitration',
        'arbitrator',
        'award',
        'reference',
        'civil',
      ],
    ),

    LawModel(
      id: 'anti_money_laundering_act_2010',
      title: 'Anti-Money Laundering Act, 2010',
      shortTitle: 'Anti-Money Laundering Act',
      year: 2010,
      jurisdiction: 'Federal',
      categoryId: 'criminal',
      categoryName: 'Criminal Laws',
      description:
          'Law concerning prevention of money laundering and related offences.',
      lawNumber: 'VII of 2010',
      totalSections: 38,
      isFeatured: true,
      keywords: [
        'money laundering',
        'AML',
        'financial crime',
        'criminal',
      ],
    ),

    // ============================================================
    // B
    // ============================================================

    LawModel(
      id: 'banking_companies_ordinance_1962',
      title: 'Banking Companies Ordinance, 1962',
      shortTitle: 'Banking Companies Ordinance',
      year: 1962,
      jurisdiction: 'Federal',
      categoryId: 'banking',
      categoryName: 'Banking & Financial Laws',
      description:
          'Law governing banking companies and banking business in Pakistan.',
      lawNumber: 'LVII of 1962',
      totalSections: 133,
      keywords: [
        'banking',
        'bank',
        'financial institution',
        'banking company',
      ],
    ),

    // ============================================================
    // C
    // ============================================================

    LawModel(
      id: 'constitution_pakistan_1973',
      title: 'Constitution of the Islamic Republic of Pakistan, 1973',
      shortTitle: 'Constitution of Pakistan',
      year: 1973,
      jurisdiction: 'Federal',
      categoryId: 'constitutional',
      categoryName: 'Constitutional Laws',
      description:
          'The supreme constitutional law of the Islamic Republic of Pakistan.',
      totalSections: 280,
      isFeatured: true,
      keywords: [
        'constitution',
        'fundamental rights',
        'parliament',
        'judiciary',
        'federal',
        'provincial',
      ],
    ),

    LawModel(
      id: 'code_civil_procedure_1908',
      title: 'Code of Civil Procedure, 1908',
      shortTitle: 'CPC',
      year: 1908,
      jurisdiction: 'Federal',
      categoryId: 'procedural',
      categoryName: 'Procedural Laws',
      description:
          'Law relating to procedure and administration of civil courts.',
      lawNumber: 'V of 1908',
      totalSections: 158,
      isFeatured: true,
      keywords: [
        'CPC',
        'civil procedure',
        'suit',
        'appeal',
        'decree',
        'execution',
        'injunction',
      ],
    ),

    // ============================================================
    // E
    // ============================================================

    LawModel(
      id: 'election_act_2017',
      title: 'Election Act, 2017',
      shortTitle: 'Election Act',
      year: 2017,
      jurisdiction: 'Federal',
      categoryId: 'election',
      categoryName: 'Election Laws',
      description:
          'Law relating to elections, electoral processes and election administration.',
      lawNumber: 'XXXIII of 2017',
      totalSections: 241,
      isFeatured: true,
      keywords: [
        'election',
        'ECP',
        'electoral',
        'candidate',
        'polling',
        'vote',
      ],
    ),

    // ============================================================
    // F
    // ============================================================

    LawModel(
      id: 'family_courts_act_1964',
      title: 'Family Courts Act, 1964',
      shortTitle: 'Family Courts Act',
      year: 1964,
      jurisdiction: 'Federal',
      categoryId: 'family',
      categoryName: 'Family Laws',
      description:
          'Law relating to constitution and jurisdiction of Family Courts.',
      lawNumber: 'XXXV of 1964',
      totalSections: 25,
      isFeatured: true,
      keywords: [
        'family court',
        'family suit',
        'marriage',
        'maintenance',
        'divorce',
        'custody',
      ],
    ),

    // ============================================================
    // I
    // ============================================================

    LawModel(
      id: 'income_tax_ordinance_2001',
      title: 'Income Tax Ordinance, 2001',
      shortTitle: 'Income Tax Ordinance',
      year: 2001,
      jurisdiction: 'Federal',
      categoryId: 'tax',
      categoryName: 'Tax Laws',
      description:
          'Principal legislation governing income tax in Pakistan.',
      lawNumber: 'XLIX of 2001',
      totalSections: 239,
      isFeatured: true,
      keywords: [
        'income tax',
        'tax',
        'FBR',
        'taxpayer',
        'assessment',
        'appeal',
      ],
    ),

    LawModel(
      id: 'illegal_dispossession_act_2005',
      title: 'Illegal Dispossession Act, 2005',
      shortTitle: 'Illegal Dispossession Act',
      year: 2005,
      jurisdiction: 'Federal',
      categoryId: 'property',
      categoryName: 'Property & Land Laws',
      description:
          'Law relating to protection against illegal dispossession from property.',
      lawNumber: 'XI of 2005',
      totalSections: 8,
      isFeatured: true,
      keywords: [
        'illegal dispossession',
        'property',
        'possession',
        'occupier',
        'owner',
      ],
    ),

    // ============================================================
    // M
    // ============================================================

    LawModel(
      id: 'muslim_family_laws_ordinance_1961',
      title: 'Muslim Family Laws Ordinance, 1961',
      shortTitle: 'Muslim Family Laws Ordinance',
      year: 1961,
      jurisdiction: 'Federal',
      categoryId: 'family',
      categoryName: 'Family Laws',
      description:
          'Law dealing with certain aspects of Muslim family law including marriage and divorce.',
      lawNumber: 'VIII of 1961',
      totalSections: 9,
      isFeatured: true,
      keywords: [
        'Muslim family law',
        'marriage',
        'divorce',
        'talaq',
        'maintenance',
        'polygamy',
      ],
    ),

    // ============================================================
    // P
    // ============================================================

    LawModel(
      id: 'pakistan_penal_code_1860',
      title: 'Pakistan Penal Code, 1860',
      shortTitle: 'PPC',
      year: 1860,
      jurisdiction: 'Federal',
      categoryId: 'criminal',
      categoryName: 'Criminal Laws',
      description:
          'Principal criminal law defining offences and prescribing punishments.',
      lawNumber: 'XLV of 1860',
      totalSections: 511,
      isFeatured: true,
      keywords: [
        'PPC',
        'criminal law',
        'offence',
        'punishment',
        'murder',
        'theft',
        'criminal breach of trust',
      ],
    ),

    LawModel(
      id: 'police_order_2002',
      title: 'Police Order, 2002',
      shortTitle: 'Police Order',
      year: 2002,
      jurisdiction: 'Federal',
      categoryId: 'criminal',
      categoryName: 'Criminal Laws',
      description:
          'Law relating to organization, administration and functioning of police.',
      totalSections: 186,
      keywords: [
        'police',
        'investigation',
        'criminal justice',
        'police officer',
      ],
    ),

    // ============================================================
    // Q
    // ============================================================

    LawModel(
      id: 'qanoon_e_shahadat_order_1984',
      title: 'Qanun-e-Shahadat Order, 1984',
      shortTitle: 'Qanun-e-Shahadat',
      year: 1984,
      jurisdiction: 'Federal',
      categoryId: 'evidence',
      categoryName: 'Evidence Laws',
      description:
          'Law governing principles relating to evidence and proof in judicial proceedings.',
      totalSections: 166,
      isFeatured: true,
      keywords: [
        'evidence',
        'proof',
        'witness',
        'documentary evidence',
        'oral evidence',
        'admissibility',
      ],
    ),

    // ============================================================
    // S
    // ============================================================

    LawModel(
      id: 'specific_relief_act_1877',
      title: 'Specific Relief Act, 1877',
      shortTitle: 'Specific Relief Act',
      year: 1877,
      jurisdiction: 'Federal',
      categoryId: 'civil',
      categoryName: 'Civil Laws',
      description:
          'Law relating to specific remedies including recovery of possession and specific performance.',
      lawNumber: 'I of 1877',
      totalSections: 57,
      isFeatured: true,
      keywords: [
        'specific relief',
        'specific performance',
        'possession',
        'injunction',
        'declaration',
      ],
    ),

    // ============================================================
    // T
    // ============================================================

    LawModel(
      id: 'transfer_of_property_act_1882',
      title: 'Transfer of Property Act, 1882',
      shortTitle: 'Transfer of Property Act',
      year: 1882,
      jurisdiction: 'Federal',
      categoryId: 'property',
      categoryName: 'Property & Land Laws',
      description:
          'Law relating to transfer of property by acts of parties.',
      lawNumber: 'IV of 1882',
      totalSections: 137,
      isFeatured: true,
      keywords: [
        'property',
        'transfer',
        'sale',
        'mortgage',
        'lease',
        'gift',
        'exchange',
      ],
    ),

    // ============================================================
    // W
    // ============================================================

    LawModel(
      id: 'west_pakistan_family_courts_act_1964',
      title: 'West Pakistan Family Courts Act, 1964',
      shortTitle: 'Family Courts Act',
      year: 1964,
      jurisdiction: 'Federal',
      categoryId: 'family',
      categoryName: 'Family Laws',
      description:
          'Legislation relating to the constitution and jurisdiction of Family Courts.',
      lawNumber: 'XXXV of 1964',
      totalSections: 25,
      keywords: [
        'family courts',
        'family law',
        'maintenance',
        'custody',
        'dissolution',
      ],
    ),
  ];

  /// All laws sorted alphabetically by title.
  static List<LawModel> get alphabeticalLaws {
    final sortedLaws = [...laws];

    sortedLaws.sort(
      (a, b) => a.title.toLowerCase().compareTo(
            b.title.toLowerCase(),
          ),
    );

    return sortedLaws;
  }

  /// Returns laws beginning with a specific letter.
  static List<LawModel> getByLetter(String letter) {
    final normalizedLetter = letter.trim().toUpperCase();

    return alphabeticalLaws.where((law) {
      return law.alphabeticalLetter == normalizedLetter;
    }).toList();
  }

  /// Returns laws belonging to a category.
  static List<LawModel> getByCategory(String categoryId) {
    return laws
        .where((law) => law.categoryId == categoryId)
        .toList();
  }

  /// Returns featured laws for the dashboard.
  static List<LawModel> get featuredLaws {
    return laws
        .where((law) => law.isFeatured)
        .toList();
  }

  /// Searches laws by title, short title, category or keywords.
  static List<LawModel> search(String query) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return [];
    }

    return laws.where((law) {
      final titleMatch = law.title.toLowerCase().contains(normalizedQuery);

      final shortTitleMatch =
          law.shortTitle.toLowerCase().contains(normalizedQuery);

      final categoryMatch =
          law.categoryName.toLowerCase().contains(normalizedQuery);

      final keywordMatch = law.keywords.any(
        (keyword) => keyword.toLowerCase().contains(normalizedQuery),
      );

      return titleMatch ||
          shortTitleMatch ||
          categoryMatch ||
          keywordMatch;
    }).toList();
  }

  /// Finds a law by its unique ID.
  static LawModel? getById(String id) {
    try {
      return laws.firstWhere(
        (law) => law.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}