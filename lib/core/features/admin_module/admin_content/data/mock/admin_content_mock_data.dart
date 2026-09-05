import 'package:lawlink360/core/features/admin_module/admin_content/models/admin_content_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/models/content_category_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/models/content_status_model.dart';

class AdminContentMockData {
  AdminContentMockData._();

  static final DateTime _baseDate = DateTime(2026, 9, 4, 9, 0);

  static final List<ContentCategoryModel> categories = [
    ContentCategoryModel(
      id: 'cat_laws',
      name: 'Laws',
      description: 'Acts, statutes, sections and legal provisions.',
      iconName: 'gavel',
      contentCount: 4,
      sortOrder: 1,
      createdAt: _baseDate,
      updatedAt: _baseDate,
    ),
    ContentCategoryModel(
      id: 'cat_judgments',
      name: 'Judgments',
      description: 'Important Pakistani court judgments and case law.',
      iconName: 'account_balance',
      contentCount: 3,
      sortOrder: 2,
      createdAt: _baseDate,
      updatedAt: _baseDate,
    ),
    ContentCategoryModel(
      id: 'cat_drafting',
      name: 'Drafting',
      description: 'Legal applications, petitions, notices and templates.',
      iconName: 'description',
      contentCount: 3,
      sortOrder: 3,
      createdAt: _baseDate,
      updatedAt: _baseDate,
    ),
    ContentCategoryModel(
      id: 'cat_procedures',
      name: 'Procedures',
      description: 'Step-by-step legal procedures and practical guides.',
      iconName: 'menu_book',
      contentCount: 3,
      sortOrder: 4,
      createdAt: _baseDate,
      updatedAt: _baseDate,
    ),
    ContentCategoryModel(
      id: 'cat_general',
      name: 'General',
      description: 'General legal education and informational content.',
      iconName: 'article',
      contentCount: 2,
      sortOrder: 5,
      createdAt: _baseDate,
      updatedAt: _baseDate,
    ),
  ];

  static final List<AdminContentModel> contents = [
    AdminContentModel(
      id: 'content_001',
      title: 'Punjab Protection of Ownership of Immovable Property Act 2025',
      description:
          'Overview of the Punjab Protection of Ownership of Immovable Property Act 2025 and its key provisions.',
      content:
          'Detailed legal content regarding ownership protection, proceedings, jurisdiction and remedies available under the Act.',
      category: 'Laws',
      authorId: 'admin_001',
      authorName: 'LawLink360 Admin',
      status: ContentStatus.published,
      relatedLaw: 'Punjab Protection of Ownership of Immovable Property Act 2025',
      viewCount: 1842,
      likeCount: 326,
      shareCount: 94,
      isFeatured: true,
      publishedAt: _baseDate.subtract(const Duration(days: 15)),
      createdAt: _baseDate.subtract(const Duration(days: 20)),
      updatedAt: _baseDate.subtract(const Duration(days: 2)),
    ),
    AdminContentModel(
      id: 'content_002',
      title: 'Code of Criminal Procedure 1898',
      description:
          'Important provisions of the Code of Criminal Procedure applicable in Pakistan.',
      content:
          'Structured legal reference covering criminal procedure, investigation, trial, bail and related proceedings.',
      category: 'Laws',
      authorId: 'admin_001',
      authorName: 'LawLink360 Admin',
      status: ContentStatus.published,
      relatedLaw: 'Code of Criminal Procedure 1898',
      viewCount: 3210,
      likeCount: 581,
      shareCount: 142,
      isFeatured: true,
      publishedAt: _baseDate.subtract(const Duration(days: 40)),
      createdAt: _baseDate.subtract(const Duration(days: 45)),
      updatedAt: _baseDate.subtract(const Duration(days: 5)),
    ),
    AdminContentModel(
      id: 'content_003',
      title: 'Pakistan Penal Code 1860',
      description:
          'Reference guide to major offences and provisions under the Pakistan Penal Code.',
      content:
          'Legal reference covering offences, punishments, definitions and important provisions of the Pakistan Penal Code.',
      category: 'Laws',
      authorId: 'admin_002',
      authorName: 'Legal Content Team',
      status: ContentStatus.published,
      relatedLaw: 'Pakistan Penal Code 1860',
      viewCount: 2765,
      likeCount: 492,
      shareCount: 118,
      publishedAt: _baseDate.subtract(const Duration(days: 55)),
      createdAt: _baseDate.subtract(const Duration(days: 60)),
      updatedAt: _baseDate.subtract(const Duration(days: 7)),
    ),
    AdminContentModel(
      id: 'content_004',
      title: 'Contract Act 1872 — Key Provisions',
      description:
          'A concise overview of important principles under the Contract Act.',
      content:
          'Overview of offer, acceptance, consideration, capacity, free consent and enforceability of contracts.',
      category: 'Laws',
      authorId: 'admin_002',
      authorName: 'Legal Content Team',
      status: ContentStatus.draft,
      relatedLaw: 'Contract Act 1872',
      viewCount: 0,
      likeCount: 0,
      shareCount: 0,
      createdAt: _baseDate.subtract(const Duration(days: 3)),
      updatedAt: _baseDate.subtract(const Duration(days: 1)),
    ),
    AdminContentModel(
      id: 'content_005',
      title: 'Supreme Court Judgment — Bail Principles',
      description:
          'Important principles regarding grant and cancellation of bail.',
      content:
          'Summary of judicial principles governing bail, further inquiry and discretionary considerations.',
      category: 'Judgments',
      authorId: 'admin_001',
      authorName: 'LawLink360 Admin',
      status: ContentStatus.published,
      relatedCase: 'Supreme Court Bail Principles',
      viewCount: 2134,
      likeCount: 374,
      shareCount: 87,
      isFeatured: true,
      publishedAt: _baseDate.subtract(const Duration(days: 10)),
      createdAt: _baseDate.subtract(const Duration(days: 14)),
      updatedAt: _baseDate.subtract(const Duration(days: 3)),
    ),
    AdminContentModel(
      id: 'content_006',
      title: 'Lahore High Court — Property Dispute Judgment',
      description:
          'Case law reference concerning possession and ownership disputes.',
      content:
          'Summary of judicial reasoning regarding ownership, possession and evidentiary requirements in property disputes.',
      category: 'Judgments',
      authorId: 'admin_003',
      authorName: 'Case Law Team',
      status: ContentStatus.published,
      relatedCase: 'Lahore High Court Property Judgment',
      viewCount: 1567,
      likeCount: 251,
      shareCount: 61,
      publishedAt: _baseDate.subtract(const Duration(days: 25)),
      createdAt: _baseDate.subtract(const Duration(days: 30)),
      updatedAt: _baseDate.subtract(const Duration(days: 6)),
    ),
    AdminContentModel(
      id: 'content_007',
      title: 'Family Court Maintenance Judgment',
      description:
          'Important principles relating to maintenance proceedings.',
      content:
          'Summary of principles concerning maintenance claims, financial capacity and family court proceedings.',
      category: 'Judgments',
      authorId: 'admin_003',
      authorName: 'Case Law Team',
      status: ContentStatus.scheduled,
      relatedCase: 'Family Court Maintenance Case',
      viewCount: 0,
      likeCount: 0,
      shareCount: 0,
      publishedAt: _baseDate.add(const Duration(days: 3)),
      createdAt: _baseDate.subtract(const Duration(days: 2)),
      updatedAt: _baseDate.subtract(const Duration(days: 1)),
    ),
    AdminContentModel(
      id: 'content_008',
      title: 'Application for Restoration of Suit',
      description:
          'Standard legal drafting template for restoration of a dismissed suit.',
      content:
          'Draft application containing title, introductory facts, grounds and prayer for restoration of proceedings.',
      category: 'Drafting',
      authorId: 'admin_001',
      authorName: 'LawLink360 Admin',
      status: ContentStatus.published,
      viewCount: 1987,
      likeCount: 298,
      shareCount: 73,
      isFeatured: true,
      publishedAt: _baseDate.subtract(const Duration(days: 18)),
      createdAt: _baseDate.subtract(const Duration(days: 22)),
      updatedAt: _baseDate.subtract(const Duration(days: 4)),
    ),
    AdminContentModel(
      id: 'content_009',
      title: 'Legal Notice for Recovery of Money',
      description:
          'Drafting template for a legal notice demanding recovery of outstanding money.',
      content:
          'Structured legal notice containing facts, demand, timeline and consequences of non-compliance.',
      category: 'Drafting',
      authorId: 'admin_002',
      authorName: 'Drafting Team',
      status: ContentStatus.published,
      viewCount: 1422,
      likeCount: 219,
      shareCount: 54,
      publishedAt: _baseDate.subtract(const Duration(days: 28)),
      createdAt: _baseDate.subtract(const Duration(days: 32)),
      updatedAt: _baseDate.subtract(const Duration(days: 8)),
    ),
    AdminContentModel(
      id: 'content_010',
      title: 'Bail Application Before Magistrate',
      description:
          'Drafting guide and sample structure for a bail application.',
      content:
          'Template covering case title, factual background, legal grounds and prayer for bail.',
      category: 'Drafting',
      authorId: 'admin_002',
      authorName: 'Drafting Team',
      status: ContentStatus.draft,
      viewCount: 0,
      likeCount: 0,
      shareCount: 0,
      createdAt: _baseDate.subtract(const Duration(days: 4)),
      updatedAt: _baseDate.subtract(const Duration(days: 2)),
    ),
    AdminContentModel(
      id: 'content_011',
      title: 'How to File a Civil Suit',
      description:
          'Step-by-step guide explaining the basic process of filing a civil suit.',
      content:
          'Guide covering cause of action, jurisdiction, plaint preparation, court fee, filing and subsequent proceedings.',
      category: 'Procedures',
      authorId: 'admin_001',
      authorName: 'LawLink360 Admin',
      status: ContentStatus.published,
      relatedProcedure: 'Civil Suit Filing',
      viewCount: 2678,
      likeCount: 441,
      shareCount: 103,
      isFeatured: true,
      publishedAt: _baseDate.subtract(const Duration(days: 12)),
      createdAt: _baseDate.subtract(const Duration(days: 16)),
      updatedAt: _baseDate.subtract(const Duration(days: 2)),
    ),
    AdminContentModel(
      id: 'content_012',
      title: 'Procedure for Obtaining Pre-Arrest Bail',
      description:
          'Practical guide to the pre-arrest bail process in Pakistan.',
      content:
          'Step-by-step overview of filing, grounds, interim relief, investigation and final confirmation of bail.',
      category: 'Procedures',
      authorId: 'admin_003',
      authorName: 'Procedure Team',
      status: ContentStatus.published,
      relatedProcedure: 'Pre-Arrest Bail',
      viewCount: 2315,
      likeCount: 387,
      shareCount: 92,
      publishedAt: _baseDate.subtract(const Duration(days: 22)),
      createdAt: _baseDate.subtract(const Duration(days: 27)),
      updatedAt: _baseDate.subtract(const Duration(days: 5)),
    ),
    AdminContentModel(
      id: 'content_013',
      title: 'Property Mutation Procedure',
      description:
          'Guide to the general process of mutation of property records.',
      content:
          'Overview of documents, application process, verification and updating of land records.',
      category: 'Procedures',
      authorId: 'admin_003',
      authorName: 'Procedure Team',
      status: ContentStatus.scheduled,
      relatedProcedure: 'Property Mutation',
      viewCount: 0,
      likeCount: 0,
      shareCount: 0,
      publishedAt: _baseDate.add(const Duration(days: 5)),
      createdAt: _baseDate.subtract(const Duration(days: 1)),
      updatedAt: _baseDate,
    ),
    AdminContentModel(
      id: 'content_014',
      title: 'Understanding Your Legal Rights',
      description:
          'Educational article explaining basic legal rights for ordinary citizens.',
      content:
          'General legal education covering access to justice, legal representation, documentation and available remedies.',
      category: 'General',
      authorId: 'admin_001',
      authorName: 'LawLink360 Admin',
      status: ContentStatus.published,
      viewCount: 3890,
      likeCount: 672,
      shareCount: 201,
      isFeatured: true,
      publishedAt: _baseDate.subtract(const Duration(days: 35)),
      createdAt: _baseDate.subtract(const Duration(days: 40)),
      updatedAt: _baseDate.subtract(const Duration(days: 10)),
    ),
    AdminContentModel(
      id: 'content_015',
      title: 'When Should You Consult a Lawyer?',
      description:
          'Educational guide helping users understand when professional legal advice may be required.',
      content:
          'General information about situations involving property, family, criminal, civil and commercial legal issues.',
      category: 'General',
      authorId: 'admin_002',
      authorName: 'Legal Education Team',
      status: ContentStatus.archived,
      viewCount: 987,
      likeCount: 145,
      shareCount: 32,
      publishedAt: _baseDate.subtract(const Duration(days: 90)),
      createdAt: _baseDate.subtract(const Duration(days: 95)),
      updatedAt: _baseDate.subtract(const Duration(days: 20)),
    ),
  ];

  static List<AdminContentModel> getContents() {
    return List.unmodifiable(contents);
  }

  static List<ContentCategoryModel> getCategories() {
    return List.unmodifiable(categories);
  }

  static AdminContentModel? getContentById(String id) {
    for (final content in contents) {
      if (content.id == id) {
        return content;
      }
    }

    return null;
  }

  static ContentCategoryModel? getCategoryById(String id) {
    for (final category in categories) {
      if (category.id == id) {
        return category;
      }
    }

    return null;
  }
}