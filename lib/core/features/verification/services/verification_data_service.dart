import 'package:flutter/material.dart';

import '../models/verification_category.dart';
import '../models/verification_subcategory.dart';
import '../models/verification_institution.dart';
import '../models/verification_service.dart';

class VerificationDataService {
  /// ==========================
  /// VERIFICATION CATEGORIES
  /// ==========================

  static const List<VerificationCategory> categories = [
    VerificationCategory(
      id: 'courts',
      title: 'Courts',
      description: 'Supreme Court & High Courts',
      icon: Icons.account_balance_rounded,
      color: Color(0xFF2563EB),
    ),

    VerificationCategory(
      id: 'lawyers',
      title: 'Lawyers',
      description: 'Bar Councils & Advocates',
      icon: Icons.gavel_rounded,
      color: Color(0xFFF59E0B),
    ),

    VerificationCategory(
      id: 'property',
      title: 'Property',
      description: 'Land & Revenue Records',
      icon: Icons.home_work_rounded,
      color: Color(0xFF10B981),
    ),

    VerificationCategory(
      id: 'government',
      title: 'Government',
      description: 'Official Government Services',
      icon: Icons.apartment_rounded,
      color: Color(0xFF8B5CF6),
    ),

    VerificationCategory(
      id: 'police',
      title: 'Police',
      description: 'Police Verification',
      icon: Icons.local_police_rounded,
      color: Color(0xFFEF4444),
    ),

    VerificationCategory(
      id: 'business',
      title: 'Business',
      description: 'SECP & Business Records',
      icon: Icons.business_center_rounded,
      color: Color(0xFF0EA5E9),
    ),

    VerificationCategory(
      id: 'education',
      title: 'Education',
      description: 'Degrees & Universities',
      icon: Icons.school_rounded,
      color: Color(0xFF14B8A6),
    ),

    VerificationCategory(
      id: 'documents',
      title: 'Documents',
      description: 'Official Document Services',
      icon: Icons.description_rounded,
      color: Color(0xFFD97706),
    ),
  ];

  /// ==========================
  /// VERIFICATION SUB CATEGORIES
  /// ==========================

  static const List<VerificationSubCategory> subCategories = [
    /// ================= COURTS =================
    VerificationSubCategory(
      id: 'supreme_courts',
      categoryId: 'courts',
      title: 'Supreme Courts',
      description: 'Supreme Courts of Pakistan',
      icon: Icons.gavel_rounded,
      color: Color(0xFF2563EB),
      institutionCount: 2,
    ),

    VerificationSubCategory(
      id: 'federal_shariat',
      categoryId: 'courts',
      title: 'Federal Shariat Court',
      description: 'Federal Shariat Court',
      icon: Icons.balance_rounded,
      color: Color(0xFF2563EB),
      institutionCount: 1,
    ),

    VerificationSubCategory(
      id: 'high_courts',
      categoryId: 'courts',
      title: 'High Courts',
      description: 'All High Courts of Pakistan',
      icon: Icons.account_balance_rounded,
      color: Color(0xFF2563EB),
      institutionCount: 7,
    ),

    VerificationSubCategory(
      id: 'district_courts',
      categoryId: 'courts',
      title: 'District Courts',
      description: 'District Judiciary',
      icon: Icons.gavel,
      color: Color(0xFF2563EB),
      institutionCount: 5,
    ),

    VerificationSubCategory(
      id: 'judicial_academies',
      categoryId: 'courts',
      title: 'Judicial Academies',
      description: 'Judicial Training Institutes',
      icon: Icons.school_rounded,
      color: Color(0xFF2563EB),
      institutionCount: 5,
    ),

    VerificationSubCategory(
      id: 'tribunals',
      categoryId: 'courts',
      title: 'Tribunals',
      description: 'Special Courts & Tribunals',
      icon: Icons.account_balance_wallet_rounded,
      color: Color(0xFF2563EB),
      institutionCount: 8,
    ),

    /// ================= LAWYERS =================
    VerificationSubCategory(
      id: 'bar_councils',
      categoryId: 'lawyers',
      title: 'Bar Councils',
      description: 'Provincial & National Bar Councils',
      icon: Icons.account_balance_rounded,
      color: Color(0xFFF59E0B),
      institutionCount: 8,
    ),

    VerificationSubCategory(
      id: 'bar_associations',
      categoryId: 'lawyers',
      title: 'Bar Associations',
      description: 'High Court & District Bar Associations',
      icon: Icons.groups_rounded,
      color: Color(0xFFF59E0B),
      institutionCount: 50,
    ),

    /// ================= PROPERTY =================
    VerificationSubCategory(
      id: 'land_records',
      categoryId: 'property',
      title: 'Land Records',
      description: 'Provincial Land Record Authorities',
      icon: Icons.map_rounded,
      color: Color(0xFF10B981),
      institutionCount: 6,
    ),

    VerificationSubCategory(
      id: 'development_authorities',
      categoryId: 'property',
      title: 'Development Authorities',
      description: 'City Development Authorities',
      icon: Icons.location_city_rounded,
      color: Color(0xFF10B981),
      institutionCount: 8,
    ),

    VerificationSubCategory(
      id: 'housing_authorities',
      categoryId: 'property',
      title: 'Housing Authorities',
      description: 'Housing & Residential Authorities',
      icon: Icons.home_work_rounded,
      color: Color(0xFF10B981),
      institutionCount: 6,
    ),

    /// ================= GOVERNMENT =================
    VerificationSubCategory(
      id: 'identity_services',
      categoryId: 'government',
      title: 'Identity & Citizenship',
      description: 'Identity and Passport Services',
      icon: Icons.badge_rounded,
      color: Color(0xFF8B5CF6),
      institutionCount: 2,
    ),

    VerificationSubCategory(
      id: 'tax_finance',
      categoryId: 'government',
      title: 'Tax & Finance',
      description: 'Taxation & Financial Services',
      icon: Icons.account_balance_wallet_rounded,
      color: Color(0xFF8B5CF6),
      institutionCount: 2,
    ),

    VerificationSubCategory(
      id: 'corporate_services',
      categoryId: 'government',
      title: 'Corporate Services',
      description: 'Business Registration & Regulation',
      icon: Icons.business_center_rounded,
      color: Color(0xFF8B5CF6),
      institutionCount: 2,
    ),

    VerificationSubCategory(
      id: 'public_services',
      categoryId: 'government',
      title: 'Public Services',
      description: 'Federal Public Institutions',
      icon: Icons.apartment_rounded,
      color: Color(0xFF8B5CF6),
      institutionCount: 3,
    ),

    /// ================= POLICE =================
    VerificationSubCategory(
      id: 'police_departments',
      categoryId: 'police',
      title: 'Police Departments',
      description: 'Provincial Police Departments',
      icon: Icons.local_police_rounded,
      color: Color(0xFFEF4444),
      institutionCount: 6,
    ),

    VerificationSubCategory(
      id: 'traffic_police',
      categoryId: 'police',
      title: 'Traffic Police',
      description: 'Traffic Police Services',
      icon: Icons.traffic_rounded,
      color: Color(0xFFEF4444),
      institutionCount: 5,
    ),

      /// ================= BUSINESS =================

  VerificationSubCategory(
    id: 'company_registration',
    categoryId: 'business',
    title: 'Company Registration',
    description: 'Business Registration Authorities',
    icon: Icons.business_center_rounded,
    color: Color(0xFF0EA5E9),
    institutionCount: 2,
  ),

  VerificationSubCategory(
    id: 'tax_business',
    categoryId: 'business',
    title: 'Business Tax',
    description: 'Tax & Business Compliance',
    icon: Icons.receipt_long_rounded,
    color: Color(0xFF0EA5E9),
    institutionCount: 2,
  ),

  VerificationSubCategory(
    id: 'intellectual_property',
    categoryId: 'business',
    title: 'Intellectual Property',
    description: 'Trademark & Patent Services',
    icon: Icons.lightbulb_rounded,
    color: Color(0xFF0EA5E9),
    institutionCount: 1,
  ),

    /// ================= EDUCATION =================

  VerificationSubCategory(
    id: 'higher_education',
    categoryId: 'education',
    title: 'Higher Education',
    description: 'Universities & HEC',
    icon: Icons.school_rounded,
    color: Color(0xFF14B8A6),
    institutionCount: 3,
  ),

  VerificationSubCategory(
    id: 'boards',
    categoryId: 'education',
    title: 'Boards',
    description: 'Boards of Intermediate & Secondary Education',
    icon: Icons.menu_book_rounded,
    color: Color(0xFF14B8A6),
    institutionCount: 5,
  ),

    /// ================= DOCUMENTS =================

  VerificationSubCategory(
    id: 'identity_documents',
    categoryId: 'documents',
    title: 'Identity Documents',
    description: 'CNIC, Passport & Identity Records',
    icon: Icons.badge_rounded,
    color: Color(0xFFD97706),
    institutionCount: 2,
  ),

  VerificationSubCategory(
    id: 'legal_documents',
    categoryId: 'documents',
    title: 'Legal Documents',
    description: 'Court & Legal Records',
    icon: Icons.description_rounded,
    color: Color(0xFFD97706),
    institutionCount: 2,
  ),

  ];

  /// ==========================
  /// VERIFICATION INSTITUTIONS
  /// ==========================

  static const List<VerificationInstitution> institutions = [
    /// Supreme Courts
    VerificationInstitution(
      id: 'supreme_court_pakistan',
      categoryId: 'courts',
      subCategoryId: 'supreme_courts',
      title: 'Supreme Court of Pakistan',
      description: 'Supreme Judicial Authority',
      icon: Icons.gavel_rounded,
      color: Color(0xFF2563EB),
      serviceCount: 6,
    ),

    VerificationInstitution(
      id: 'federal_shariat_court',
      categoryId: 'courts',
      subCategoryId: 'federal_shariat',
      title: 'Federal Shariat Court',
      description: 'Federal Shariat Court of Pakistan',
      icon: Icons.balance_rounded,
      color: Color(0xFF2563EB),
      serviceCount: 5,
    ),

    /// High Courts
    VerificationInstitution(
      id: 'lahore_high_court',
      categoryId: 'courts',
      subCategoryId: 'high_courts',
      title: 'Lahore High Court',
      description: 'Lahore High Court',
      icon: Icons.account_balance_rounded,
      color: Color(0xFF2563EB),
      serviceCount: 8,
    ),

    VerificationInstitution(
      id: 'islamabad_high_court',
      categoryId: 'courts',
      subCategoryId: 'high_courts',
      title: 'Islamabad High Court',
      description: 'Islamabad High Court',
      icon: Icons.account_balance_rounded,
      color: Color(0xFF2563EB),
      serviceCount: 8,
    ),

    VerificationInstitution(
      id: 'sindh_high_court',
      categoryId: 'courts',
      subCategoryId: 'high_courts',
      title: 'Sindh High Court',
      description: 'Sindh High Court',
      icon: Icons.account_balance_rounded,
      color: Color(0xFF2563EB),
      serviceCount: 8,
    ),

    VerificationInstitution(
      id: 'peshawar_high_court',
      categoryId: 'courts',
      subCategoryId: 'high_courts',
      title: 'Peshawar High Court',
      description: 'Peshawar High Court',
      icon: Icons.account_balance_rounded,
      color: Color(0xFF2563EB),
      serviceCount: 8,
    ),

    VerificationInstitution(
      id: 'balochistan_high_court',
      categoryId: 'courts',
      subCategoryId: 'high_courts',
      title: 'Balochistan High Court',
      description: 'Balochistan High Court',
      icon: Icons.account_balance_rounded,
      color: Color(0xFF2563EB),
      serviceCount: 8,
    ),

    /// ================= LAWYERS =================
    VerificationInstitution(
      id: 'pakistan_bar_council',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      title: 'Pakistan Bar Council',
      description: 'National Bar Council',
      icon: Icons.gavel_rounded,
      color: Color(0xFFF59E0B),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'punjab_bar_council',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      title: 'Punjab Bar Council',
      description: 'Punjab Bar Council',
      icon: Icons.gavel_rounded,
      color: Color(0xFFF59E0B),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'sindh_bar_council',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      title: 'Sindh Bar Council',
      description: 'Sindh Bar Council',
      icon: Icons.gavel_rounded,
      color: Color(0xFFF59E0B),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'kp_bar_council',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      title: 'Khyber Pakhtunkhwa Bar Council',
      description: 'KP Bar Council',
      icon: Icons.gavel_rounded,
      color: Color(0xFFF59E0B),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'balochistan_bar_council',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      title: 'Balochistan Bar Council',
      description: 'Balochistan Bar Council',
      icon: Icons.gavel_rounded,
      color: Color(0xFFF59E0B),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'islamabad_bar_council',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      title: 'Islamabad Bar Council',
      description: 'Islamabad Bar Council',
      icon: Icons.gavel_rounded,
      color: Color(0xFFF59E0B),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'ajk_bar_council',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      title: 'AJK Bar Council',
      description: 'Azad Jammu & Kashmir Bar Council',
      icon: Icons.gavel_rounded,
      color: Color(0xFFF59E0B),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'gb_bar_council',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      title: 'Gilgit Baltistan Bar Council',
      description: 'Gilgit Baltistan Bar Council',
      icon: Icons.gavel_rounded,
      color: Color(0xFFF59E0B),
      serviceCount: 4,
    ),

    /// ================= PROPERTY =================

    /// Land Records
    VerificationInstitution(
      id: 'plra',
      categoryId: 'property',
      subCategoryId: 'land_records',
      title: 'Punjab Land Record Authority',
      description: 'Punjab Land Record Authority',
      icon: Icons.map_rounded,
      color: Color(0xFF10B981),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'sindh_land_records',
      categoryId: 'property',
      subCategoryId: 'land_records',
      title: 'Sindh Board of Revenue',
      description: 'Sindh Land Records',
      icon: Icons.map_rounded,
      color: Color(0xFF10B981),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'kp_land_records',
      categoryId: 'property',
      subCategoryId: 'land_records',
      title: 'KP Board of Revenue',
      description: 'Khyber Pakhtunkhwa Land Records',
      icon: Icons.map_rounded,
      color: Color(0xFF10B981),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'balochistan_land_records',
      categoryId: 'property',
      subCategoryId: 'land_records',
      title: 'Balochistan Board of Revenue',
      description: 'Balochistan Land Records',
      icon: Icons.map_rounded,
      color: Color(0xFF10B981),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'ajk_land_records',
      categoryId: 'property',
      subCategoryId: 'land_records',
      title: 'AJK Land Records',
      description: 'Azad Jammu & Kashmir',
      icon: Icons.map_rounded,
      color: Color(0xFF10B981),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'gb_land_records',
      categoryId: 'property',
      subCategoryId: 'land_records',
      title: 'Gilgit Baltistan Land Records',
      description: 'Gilgit Baltistan',
      icon: Icons.map_rounded,
      color: Color(0xFF10B981),
      serviceCount: 4,
    ),

    /// Development Authorities
    VerificationInstitution(
      id: 'cda',
      categoryId: 'property',
      subCategoryId: 'development_authorities',
      title: 'Capital Development Authority',
      description: 'Islamabad CDA',
      icon: Icons.location_city_rounded,
      color: Color(0xFF10B981),
      serviceCount: 3,
    ),

    VerificationInstitution(
      id: 'lda',
      categoryId: 'property',
      subCategoryId: 'development_authorities',
      title: 'Lahore Development Authority',
      description: 'LDA Lahore',
      icon: Icons.location_city_rounded,
      color: Color(0xFF10B981),
      serviceCount: 3,
    ),

    VerificationInstitution(
      id: 'rda',
      categoryId: 'property',
      subCategoryId: 'development_authorities',
      title: 'Rawalpindi Development Authority',
      description: 'RDA Rawalpindi',
      icon: Icons.location_city_rounded,
      color: Color(0xFF10B981),
      serviceCount: 3,
    ),

    /// Housing Authorities
    VerificationInstitution(
      id: 'dha',
      categoryId: 'property',
      subCategoryId: 'housing_authorities',
      title: 'Defence Housing Authority',
      description: 'DHA Pakistan',
      icon: Icons.home_work_rounded,
      color: Color(0xFF10B981),
      serviceCount: 3,
    ),

    VerificationInstitution(
      id: 'phata',
      categoryId: 'property',
      subCategoryId: 'housing_authorities',
      title: 'Punjab Housing & Town Planning Agency',
      description: 'PHATA',
      icon: Icons.home_work_rounded,
      color: Color(0xFF10B981),
      serviceCount: 3,
    ),

    /// ================= GOVERNMENT =================

    /// Identity & Citizenship
    VerificationInstitution(
      id: 'nadra',
      categoryId: 'government',
      subCategoryId: 'identity_services',
      title: 'NADRA',
      description: 'National Database & Registration Authority',
      icon: Icons.badge_rounded,
      color: Color(0xFF8B5CF6),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'passport_office',
      categoryId: 'government',
      subCategoryId: 'identity_services',
      title: 'Directorate General Immigration & Passports',
      description: 'Passport Services',
      icon: Icons.book_rounded,
      color: Color(0xFF8B5CF6),
      serviceCount: 4,
    ),

    /// Tax & Finance
    VerificationInstitution(
      id: 'fbr',
      categoryId: 'government',
      subCategoryId: 'tax_finance',
      title: 'Federal Board of Revenue',
      description: 'Taxation & Revenue',
      icon: Icons.account_balance_wallet_rounded,
      color: Color(0xFF8B5CF6),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'agpr',
      categoryId: 'government',
      subCategoryId: 'tax_finance',
      title: 'Accountant General Pakistan Revenues',
      description: 'Government Financial Services',
      icon: Icons.payments_rounded,
      color: Color(0xFF8B5CF6),
      serviceCount: 3,
    ),

    /// Corporate Services
    VerificationInstitution(
      id: 'secp',
      categoryId: 'government',
      subCategoryId: 'corporate_services',
      title: 'Securities & Exchange Commission of Pakistan',
      description: 'Corporate Registration',
      icon: Icons.business_center_rounded,
      color: Color(0xFF8B5CF6),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'ipo_pakistan',
      categoryId: 'government',
      subCategoryId: 'corporate_services',
      title: 'Intellectual Property Organization',
      description: 'Trademarks, Patents & Copyright',
      icon: Icons.lightbulb_rounded,
      color: Color(0xFF8B5CF6),
      serviceCount: 3,
    ),

    /// Public Services
    VerificationInstitution(
      id: 'ecp',
      categoryId: 'government',
      subCategoryId: 'public_services',
      title: 'Election Commission of Pakistan',
      description: 'Election Services',
      icon: Icons.how_to_vote_rounded,
      color: Color(0xFF8B5CF6),
      serviceCount: 3,
    ),

    VerificationInstitution(
      id: 'fia',
      categoryId: 'government',
      subCategoryId: 'public_services',
      title: 'Federal Investigation Agency',
      description: 'FIA Services',
      icon: Icons.security_rounded,
      color: Color(0xFF8B5CF6),
      serviceCount: 3,
    ),

    VerificationInstitution(
      id: 'pemra',
      categoryId: 'government',
      subCategoryId: 'public_services',
      title: 'Pakistan Electronic Media Regulatory Authority',
      description: 'PEMRA',
      icon: Icons.tv_rounded,
      color: Color(0xFF8B5CF6),
      serviceCount: 3,
    ),

    /// ================= POLICE =================
    VerificationInstitution(
      id: 'punjab_police',
      categoryId: 'police',
      subCategoryId: 'police_departments',
      title: 'Punjab Police',
      description: 'Punjab Police Department',
      icon: Icons.local_police_rounded,
      color: Color(0xFFEF4444),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'islamabad_police',
      categoryId: 'police',
      subCategoryId: 'police_departments',
      title: 'Islamabad Capital Police',
      description: 'Islamabad Police',
      icon: Icons.local_police_rounded,
      color: Color(0xFFEF4444),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'sindh_police',
      categoryId: 'police',
      subCategoryId: 'police_departments',
      title: 'Sindh Police',
      description: 'Sindh Police Department',
      icon: Icons.local_police_rounded,
      color: Color(0xFFEF4444),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'kp_police',
      categoryId: 'police',
      subCategoryId: 'police_departments',
      title: 'Khyber Pakhtunkhwa Police',
      description: 'KP Police',
      icon: Icons.local_police_rounded,
      color: Color(0xFFEF4444),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'balochistan_police',
      categoryId: 'police',
      subCategoryId: 'police_departments',
      title: 'Balochistan Police',
      description: 'Balochistan Police',
      icon: Icons.local_police_rounded,
      color: Color(0xFFEF4444),
      serviceCount: 4,
    ),

    VerificationInstitution(
      id: 'nhmp',
      categoryId: 'police',
      subCategoryId: 'traffic_police',
      title: 'National Highways & Motorway Police',
      description: 'NHMP',
      icon: Icons.traffic_rounded,
      color: Color(0xFFEF4444),
      serviceCount: 4,
    ),

      /// ================= BUSINESS =================

  VerificationInstitution(
    id: 'secp_business',
    categoryId: 'business',
    subCategoryId: 'company_registration',
    title: 'SECP',
    description: 'Company Registration',
    icon: Icons.business_center_rounded,
    color: Color(0xFF0EA5E9),
    serviceCount: 4,
  ),

  VerificationInstitution(
    id: 'registrar_firms',
    categoryId: 'business',
    subCategoryId: 'company_registration',
    title: 'Registrar of Firms',
    description: 'Partnership Firm Registration',
    icon: Icons.store_rounded,
    color: Color(0xFF0EA5E9),
    serviceCount: 3,
  ),

  VerificationInstitution(
    id: 'fbr_business',
    categoryId: 'business',
    subCategoryId: 'tax_business',
    title: 'Federal Board of Revenue',
    description: 'Business Tax Services',
    icon: Icons.receipt_long_rounded,
    color: Color(0xFF0EA5E9),
    serviceCount: 4,
  ),

  VerificationInstitution(
    id: 'ipo_business',
    categoryId: 'business',
    subCategoryId: 'intellectual_property',
    title: 'IPO Pakistan',
    description: 'Trademark & Patent Registration',
    icon: Icons.lightbulb_rounded,
    color: Color(0xFF0EA5E9),
    serviceCount: 4,
  ),

    /// ================= EDUCATION =================

  VerificationInstitution(
    id: 'hec',
    categoryId: 'education',
    subCategoryId: 'higher_education',
    title: 'Higher Education Commission',
    description: 'Degree Attestation & Verification',
    icon: Icons.school_rounded,
    color: Color(0xFF14B8A6),
    serviceCount: 4,
  ),

  VerificationInstitution(
    id: 'pu',
    categoryId: 'education',
    subCategoryId: 'higher_education',
    title: 'University of the Punjab',
    description: 'Degree Verification',
    icon: Icons.account_balance_rounded,
    color: Color(0xFF14B8A6),
    serviceCount: 3,
  ),

  VerificationInstitution(
    id: 'bise_lahore',
    categoryId: 'education',
    subCategoryId: 'boards',
    title: 'BISE Lahore',
    description: 'Board Verification',
    icon: Icons.menu_book_rounded,
    color: Color(0xFF14B8A6),
    serviceCount: 3,
  ),

    /// ================= DOCUMENTS =================

  VerificationInstitution(
    id: 'nadra_documents',
    categoryId: 'documents',
    subCategoryId: 'identity_documents',
    title: 'NADRA Documents',
    description: 'Identity Document Services',
    icon: Icons.badge_rounded,
    color: Color(0xFFD97706),
    serviceCount: 3,
  ),

  VerificationInstitution(
    id: 'passport_documents',
    categoryId: 'documents',
    subCategoryId: 'identity_documents',
    title: 'Passport Documents',
    description: 'Passport Related Services',
    icon: Icons.book_rounded,
    color: Color(0xFFD97706),
    serviceCount: 3,
  ),

  VerificationInstitution(
    id: 'court_documents',
    categoryId: 'documents',
    subCategoryId: 'legal_documents',
    title: 'Court Documents',
    description: 'Certified Copies & Court Records',
    icon: Icons.gavel_rounded,
    color: Color(0xFFD97706),
    serviceCount: 3,
  ),

  ];

  /// ==========================
  /// VERIFICATION SERVICES
  /// ==========================

  static const List<VerificationService> services = [
    // ================= Lahore High Court =================
    VerificationService(
      id: 'lhc_official',
      categoryId: 'courts',
      subCategoryId: 'high_courts',
      institutionId: 'lahore_high_court',
      title: 'Official Website',
      description: 'Visit Lahore High Court official website',
      authority: 'Lahore High Court',
      websiteUrl: 'https://lhc.gov.pk/',
      icon: Icons.language_rounded,
      color: Color(0xFF2563EB),
      isPopular: true,
    ),

    VerificationService(
      id: 'lhc_case_management',
      categoryId: 'courts',
      subCategoryId: 'high_courts',
      institutionId: 'lahore_high_court',
      title: 'Case Management',
      description: 'Search and track your case',
      authority: 'Lahore High Court',
      websiteUrl: 'https://lhc.gov.pk/case_management',
      icon: Icons.search_rounded,
      color: Color(0xFF2563EB),
    ),

    VerificationService(
      id: 'lhc_biometric',
      categoryId: 'courts',
      subCategoryId: 'high_courts',
      institutionId: 'lahore_high_court',
      title: 'Biometric Verification',
      description: 'Lawyer biometric verification',
      authority: 'Lahore High Court',
      websiteUrl: 'https://biosystid.lhc.gov.pk/biosystno',
      icon: Icons.fingerprint_rounded,
      color: Color(0xFF2563EB),
    ),

    // ================= Islamabad High Court =================
    VerificationService(
      id: 'ihc_official',
      categoryId: 'courts',
      subCategoryId: 'high_courts',
      institutionId: 'islamabad_high_court',
      title: 'Official Website',
      description: 'Visit Islamabad High Court',
      authority: 'Islamabad High Court',
      websiteUrl: 'https://ihc.gov.pk/',
      icon: Icons.language_rounded,
      color: Color(0xFF2563EB),
    ),

    // ================= Sindh High Court =================
    VerificationService(
      id: 'shc_case_search',
      categoryId: 'courts',
      subCategoryId: 'high_courts',
      institutionId: 'sindh_high_court',
      title: 'Case Search',
      description: 'Search Sindh High Court cases',
      authority: 'Sindh High Court',
      websiteUrl: 'https://cases.shc.gov.pk/',
      icon: Icons.search_rounded,
      color: Color(0xFF2563EB),
    ),

    // ================= Peshawar High Court =================
    VerificationService(
      id: 'phc_official',
      categoryId: 'courts',
      subCategoryId: 'high_courts',
      institutionId: 'peshawar_high_court',
      title: 'Official Website',
      description: 'Visit Peshawar High Court',
      authority: 'Peshawar High Court',
      websiteUrl: 'https://www.peshawarhighcourt.gov.pk/app/site/',
      icon: Icons.language_rounded,
      color: Color(0xFF2563EB),
    ),

    VerificationService(
      id: 'phc_cfmis',
      categoryId: 'courts',
      subCategoryId: 'high_courts',
      institutionId: 'peshawar_high_court',
      title: 'CFMIS Case Search',
      description: 'District judiciary case search',
      authority: 'Peshawar High Court',
      websiteUrl: 'https://cfmisdcportal.peshawarhighcourt.gov.pk/',
      icon: Icons.search_rounded,
      color: Color(0xFF2563EB),
    ),

    // ================= Balochistan High Court =================
    VerificationService(
      id: 'bhc_cause_list',
      categoryId: 'courts',
      subCategoryId: 'high_courts',
      institutionId: 'balochistan_high_court',
      title: 'Cause Lists',
      description: 'Daily cause lists',
      authority: 'High Court of Balochistan',
      websiteUrl: 'https://portal.bhc.gov.pk/dj-case-status/',
      icon: Icons.list_alt_rounded,
      color: Color(0xFF2563EB),
    ),

    // ================= Supreme Court of Pakistan =================
    VerificationService(
      id: 'scp_case_status',
      categoryId: 'courts',
      subCategoryId: 'supreme_courts',
      institutionId: 'supreme_court_pakistan',
      title: 'Online Case Status',
      description: 'Search Supreme Court cases',
      authority: 'Supreme Court of Pakistan',
      websiteUrl: 'https://share.google/kW0RR38RRFn6PpAok',
      icon: Icons.search_rounded,
      color: Color(0xFF2563EB),
      isPopular: true,
    ),

    // ================= Federal Special Courts =================
    VerificationService(
      id: 'special_courts',
      categoryId: 'courts',
      subCategoryId: 'tribunals',
      institutionId: 'federal_special_courts',
      title: 'Cases Search',
      description: 'Federal Special Courts & Tribunals',
      authority: 'Government of Pakistan',
      websiteUrl: 'https://share.google/xPkmtqJ0Rni2DwZkF',
      icon: Icons.gavel_rounded,
      color: Color(0xFF2563EB),
    ),

    // ================= Punjab District Judiciary =================
    VerificationService(
      id: 'district_case_management',
      categoryId: 'courts',
      subCategoryId: 'district_courts',
      institutionId: 'punjab_district_judiciary',
      title: 'Case Management',
      description: 'District Judiciary Punjab',
      authority: 'District Judiciary Punjab',
      websiteUrl: 'https://share.google/zPdUed9cpJIOf9RCo',
      icon: Icons.account_balance_rounded,
      color: Color(0xFF2563EB),
    ),

    /// ================= LAWYERS =================
    VerificationService(
      id: 'pbc_official',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      institutionId: 'pakistan_bar_council',
      title: 'Official Website',
      description: 'Visit official website',
      authority: 'Pakistan Bar Council',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFF59E0B),
      isPopular: true,
    ),

    VerificationService(
      id: 'pbc_verification',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      institutionId: 'pakistan_bar_council',
      title: 'Lawyer Verification',
      description: 'Verify enrolled advocates',
      authority: 'Pakistan Bar Council',
      websiteUrl: 'https://example.com',
      icon: Icons.verified_user_rounded,
      color: Color(0xFFF59E0B),
    ),

    VerificationService(
      id: 'punjab_bar_official',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      institutionId: 'punjab_bar_council',
      title: 'Official Website',
      description: 'Visit official website',
      authority: 'Punjab Bar Council',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFF59E0B),
    ),

    VerificationService(
      id: 'punjab_bar_verify',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      institutionId: 'punjab_bar_council',
      title: 'Lawyer Verification',
      description: 'Verify enrolled advocates',
      authority: 'Punjab Bar Council',
      websiteUrl: 'https://example.com',
      icon: Icons.verified_user_rounded,
      color: Color(0xFFF59E0B),
    ),

    VerificationService(
      id: 'sindh_bar_official',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      institutionId: 'sindh_bar_council',
      title: 'Official Website',
      description: 'Visit official website',
      authority: 'Sindh Bar Council',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFF59E0B),
    ),

    VerificationService(
      id: 'kp_bar_official',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      institutionId: 'kp_bar_council',
      title: 'Official Website',
      description: 'Visit official website',
      authority: 'KP Bar Council',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFF59E0B),
    ),

    VerificationService(
      id: 'balochistan_bar_official',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      institutionId: 'balochistan_bar_council',
      title: 'Official Website',
      description: 'Visit official website',
      authority: 'Balochistan Bar Council',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFF59E0B),
    ),

    VerificationService(
      id: 'islamabad_bar_official',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      institutionId: 'islamabad_bar_council',
      title: 'Official Website',
      description: 'Visit official website',
      authority: 'Islamabad Bar Council',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFF59E0B),
    ),

    VerificationService(
      id: 'ajk_bar_official',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      institutionId: 'ajk_bar_council',
      title: 'Official Website',
      description: 'Visit official website',
      authority: 'AJK Bar Council',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFF59E0B),
    ),

    VerificationService(
      id: 'gb_bar_official',
      categoryId: 'lawyers',
      subCategoryId: 'bar_councils',
      institutionId: 'gb_bar_council',
      title: 'Official Website',
      description: 'Visit official website',
      authority: 'Gilgit Baltistan Bar Council',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFF59E0B),
    ),

    /// ================= PROPERTY =================

    /// Punjab Land Record Authority
    VerificationService(
      id: 'plra_official',
      categoryId: 'property',
      subCategoryId: 'land_records',
      institutionId: 'plra',
      title: 'Official Website',
      description: 'Visit official website',
      authority: 'Punjab Land Record Authority',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF10B981),
      isPopular: true,
    ),

    VerificationService(
      id: 'plra_property_search',
      categoryId: 'property',
      subCategoryId: 'land_records',
      institutionId: 'plra',
      title: 'Property Search',
      description: 'Search land records',
      authority: 'Punjab Land Record Authority',
      websiteUrl: 'https://example.com',
      icon: Icons.search_rounded,
      color: Color(0xFF10B981),
    ),

    /// Sindh Board of Revenue
    VerificationService(
      id: 'sindh_land_official',
      categoryId: 'property',
      subCategoryId: 'land_records',
      institutionId: 'sindh_land_records',
      title: 'Official Website',
      description: 'Visit official website',
      authority: 'Sindh Board of Revenue',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF10B981),
    ),

    /// KP Board of Revenue
    VerificationService(
      id: 'kp_land_official',
      categoryId: 'property',
      subCategoryId: 'land_records',
      institutionId: 'kp_land_records',
      title: 'Official Website',
      description: 'Visit official website',
      authority: 'KP Board of Revenue',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF10B981),
    ),

    /// Balochistan Board of Revenue
    VerificationService(
      id: 'balochistan_land_official',
      categoryId: 'property',
      subCategoryId: 'land_records',
      institutionId: 'balochistan_land_records',
      title: 'Official Website',
      description: 'Visit official website',
      authority: 'Balochistan Board of Revenue',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF10B981),
    ),

    /// CDA
    VerificationService(
      id: 'cda_official',
      categoryId: 'property',
      subCategoryId: 'development_authorities',
      institutionId: 'cda',
      title: 'Official Website',
      description: 'Capital Development Authority',
      authority: 'CDA',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF10B981),
    ),

    /// LDA
    VerificationService(
      id: 'lda_official',
      categoryId: 'property',
      subCategoryId: 'development_authorities',
      institutionId: 'lda',
      title: 'Official Website',
      description: 'Lahore Development Authority',
      authority: 'LDA',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF10B981),
    ),

    /// DHA
    VerificationService(
      id: 'dha_official',
      categoryId: 'property',
      subCategoryId: 'housing_authorities',
      institutionId: 'dha',
      title: 'Official Website',
      description: 'Defence Housing Authority',
      authority: 'DHA',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF10B981),
    ),

    /// PHATA
    VerificationService(
      id: 'phata_official',
      categoryId: 'property',
      subCategoryId: 'housing_authorities',
      institutionId: 'phata',
      title: 'Official Website',
      description: 'Punjab Housing & Town Planning Agency',
      authority: 'PHATA',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF10B981),
    ),

    /// ================= GOVERNMENT =================

    /// NADRA
    VerificationService(
      id: 'nadra_official',
      categoryId: 'government',
      subCategoryId: 'identity_services',
      institutionId: 'nadra',
      title: 'Official Website',
      description: 'Visit NADRA official website',
      authority: 'NADRA',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF8B5CF6),
      isPopular: true,
    ),

    VerificationService(
      id: 'nadra_services',
      categoryId: 'government',
      subCategoryId: 'identity_services',
      institutionId: 'nadra',
      title: 'Citizen Services',
      description: 'Identity & Registration Services',
      authority: 'NADRA',
      websiteUrl: 'https://example.com',
      icon: Icons.badge_rounded,
      color: Color(0xFF8B5CF6),
    ),

    /// Passport Office
    VerificationService(
      id: 'passport_official',
      categoryId: 'government',
      subCategoryId: 'identity_services',
      institutionId: 'passport_office',
      title: 'Official Website',
      description: 'Passport Services',
      authority: 'DGIP',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF8B5CF6),
    ),

    /// FBR
    VerificationService(
      id: 'fbr_official',
      categoryId: 'government',
      subCategoryId: 'tax_finance',
      institutionId: 'fbr',
      title: 'Official Website',
      description: 'Federal Board of Revenue',
      authority: 'FBR',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF8B5CF6),
    ),

    VerificationService(
      id: 'fbr_tax_services',
      categoryId: 'government',
      subCategoryId: 'tax_finance',
      institutionId: 'fbr',
      title: 'Tax Services',
      description: 'Income Tax & Sales Tax',
      authority: 'FBR',
      websiteUrl: 'https://example.com',
      icon: Icons.receipt_long_rounded,
      color: Color(0xFF8B5CF6),
    ),

    /// SECP
    VerificationService(
      id: 'secp_official',
      categoryId: 'government',
      subCategoryId: 'corporate_services',
      institutionId: 'secp',
      title: 'Official Website',
      description: 'Corporate Services',
      authority: 'SECP',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF8B5CF6),
    ),

    /// FIA
    VerificationService(
      id: 'fia_official',
      categoryId: 'government',
      subCategoryId: 'public_services',
      institutionId: 'fia',
      title: 'Official Website',
      description: 'Federal Investigation Agency',
      authority: 'FIA',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF8B5CF6),
    ),

    /// ECP
    VerificationService(
      id: 'ecp_official',
      categoryId: 'government',
      subCategoryId: 'public_services',
      institutionId: 'ecp',
      title: 'Official Website',
      description: 'Election Commission of Pakistan',
      authority: 'ECP',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFF8B5CF6),
    ),

    /// ================= POLICE =================
    VerificationService(
      id: 'punjab_police_official',
      categoryId: 'police',
      subCategoryId: 'police_departments',
      institutionId: 'punjab_police',
      title: 'Official Website',
      description: 'Visit Punjab Police official website',
      authority: 'Punjab Police',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFEF4444),
      isPopular: true,
    ),

    VerificationService(
      id: 'punjab_police_complaint',
      categoryId: 'police',
      subCategoryId: 'police_departments',
      institutionId: 'punjab_police',
      title: 'Complaint Portal',
      description: 'Register online complaints',
      authority: 'Punjab Police',
      websiteUrl: 'https://example.com',
      icon: Icons.report_problem_rounded,
      color: Color(0xFFEF4444),
    ),

    VerificationService(
      id: 'islamabad_police_official',
      categoryId: 'police',
      subCategoryId: 'police_departments',
      institutionId: 'islamabad_police',
      title: 'Official Website',
      description: 'Visit Islamabad Police website',
      authority: 'Islamabad Police',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFEF4444),
    ),

    VerificationService(
      id: 'sindh_police_official',
      categoryId: 'police',
      subCategoryId: 'police_departments',
      institutionId: 'sindh_police',
      title: 'Official Website',
      description: 'Visit Sindh Police website',
      authority: 'Sindh Police',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFEF4444),
    ),

    VerificationService(
      id: 'kp_police_official',
      categoryId: 'police',
      subCategoryId: 'police_departments',
      institutionId: 'kp_police',
      title: 'Official Website',
      description: 'Visit KP Police website',
      authority: 'KP Police',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFEF4444),
    ),

    VerificationService(
      id: 'balochistan_police_official',
      categoryId: 'police',
      subCategoryId: 'police_departments',
      institutionId: 'balochistan_police',
      title: 'Official Website',
      description: 'Visit Balochistan Police website',
      authority: 'Balochistan Police',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFEF4444),
    ),

    VerificationService(
      id: 'nhmp_official',
      categoryId: 'police',
      subCategoryId: 'traffic_police',
      institutionId: 'nhmp',
      title: 'Official Website',
      description: 'National Highways & Motorway Police',
      authority: 'NHMP',
      websiteUrl: 'https://example.com',
      icon: Icons.language_rounded,
      color: Color(0xFFEF4444),
    ),

      /// ================= BUSINESS =================

  /// SECP

  VerificationService(
    id: 'secp_business_official',
    categoryId: 'business',
    subCategoryId: 'company_registration',
    institutionId: 'secp_business',
    title: 'Official Website',
    description: 'Company Registration Portal',
    authority: 'SECP',
    websiteUrl: 'https://example.com',
    icon: Icons.language_rounded,
    color: Color(0xFF0EA5E9),
    isPopular: true,
  ),

  VerificationService(
    id: 'secp_company_search',
    categoryId: 'business',
    subCategoryId: 'company_registration',
    institutionId: 'secp_business',
    title: 'Company Search',
    description: 'Search Registered Companies',
    authority: 'SECP',
    websiteUrl: 'https://example.com',
    icon: Icons.search_rounded,
    color: Color(0xFF0EA5E9),
  ),

  /// Registrar of Firms

  VerificationService(
    id: 'firm_registration',
    categoryId: 'business',
    subCategoryId: 'company_registration',
    institutionId: 'registrar_firms',
    title: 'Firm Registration',
    description: 'Partnership Registration Services',
    authority: 'Registrar of Firms',
    websiteUrl: 'https://example.com',
    icon: Icons.store_rounded,
    color: Color(0xFF0EA5E9),
  ),

  /// FBR Business

  VerificationService(
    id: 'business_tax',
    categoryId: 'business',
    subCategoryId: 'tax_business',
    institutionId: 'fbr_business',
    title: 'Business Tax Portal',
    description: 'Business Tax Services',
    authority: 'FBR',
    websiteUrl: 'https://example.com',
    icon: Icons.receipt_long_rounded,
    color: Color(0xFF0EA5E9),
  ),

  /// IPO Pakistan

  VerificationService(
    id: 'trademark_search',
    categoryId: 'business',
    subCategoryId: 'intellectual_property',
    institutionId: 'ipo_business',
    title: 'Trademark Search',
    description: 'Search Registered Trademarks',
    authority: 'IPO Pakistan',
    websiteUrl: 'https://example.com',
    icon: Icons.search_rounded,
    color: Color(0xFF0EA5E9),
  ),

  VerificationService(
    id: 'patent_services',
    categoryId: 'business',
    subCategoryId: 'intellectual_property',
    institutionId: 'ipo_business',
    title: 'Patent Services',
    description: 'Patent Registration Services',
    authority: 'IPO Pakistan',
    websiteUrl: 'https://example.com',
    icon: Icons.lightbulb_rounded,
    color: Color(0xFF0EA5E9),
  ),

    /// ================= EDUCATION =================

  VerificationService(
    id: 'hec_official',
    categoryId: 'education',
    subCategoryId: 'higher_education',
    institutionId: 'hec',
    title: 'Official Website',
    description: 'Higher Education Commission',
    authority: 'HEC Pakistan',
    websiteUrl: 'https://example.com',
    icon: Icons.language_rounded,
    color: Color(0xFF14B8A6),
    isPopular: true,
  ),

  VerificationService(
    id: 'degree_attestation',
    categoryId: 'education',
    subCategoryId: 'higher_education',
    institutionId: 'hec',
    title: 'Degree Attestation',
    description: 'Degree Attestation Portal',
    authority: 'HEC Pakistan',
    websiteUrl: 'https://example.com',
    icon: Icons.verified_rounded,
    color: Color(0xFF14B8A6),
  ),

  VerificationService(
    id: 'pu_verification',
    categoryId: 'education',
    subCategoryId: 'higher_education',
    institutionId: 'pu',
    title: 'Degree Verification',
    description: 'Punjab University Verification',
    authority: 'University of the Punjab',
    websiteUrl: 'https://example.com',
    icon: Icons.school_rounded,
    color: Color(0xFF14B8A6),
  ),

  VerificationService(
    id: 'bise_result',
    categoryId: 'education',
    subCategoryId: 'boards',
    institutionId: 'bise_lahore',
    title: 'Result Verification',
    description: 'Verify Board Results',
    authority: 'BISE Lahore',
    websiteUrl: 'https://example.com',
    icon: Icons.fact_check_rounded,
    color: Color(0xFF14B8A6),
  ),

    /// ================= DOCUMENTS =================

  VerificationService(
    id: 'cnic_services',
    categoryId: 'documents',
    subCategoryId: 'identity_documents',
    institutionId: 'nadra_documents',
    title: 'CNIC Services',
    description: 'Identity Card Services',
    authority: 'NADRA',
    websiteUrl: 'https://example.com',
    icon: Icons.badge_rounded,
    color: Color(0xFFD97706),
    isPopular: true,
  ),

  VerificationService(
    id: 'passport_services',
    categoryId: 'documents',
    subCategoryId: 'identity_documents',
    institutionId: 'passport_documents',
    title: 'Passport Services',
    description: 'Passport Applications & Tracking',
    authority: 'DGIP',
    websiteUrl: 'https://example.com',
    icon: Icons.book_rounded,
    color: Color(0xFFD97706),
  ),

  VerificationService(
    id: 'certified_copy',
    categoryId: 'documents',
    subCategoryId: 'legal_documents',
    institutionId: 'court_documents',
    title: 'Certified Copies',
    description: 'Apply for Certified Court Copies',
    authority: 'District Judiciary',
    websiteUrl: 'https://example.com',
    icon: Icons.description_rounded,
    color: Color(0xFFD97706),
  ),

  VerificationService(
    id: 'court_record',
    categoryId: 'documents',
    subCategoryId: 'legal_documents',
    institutionId: 'court_documents',
    title: 'Court Record Search',
    description: 'Search Court Records',
    authority: 'District Judiciary',
    websiteUrl: 'https://example.com',
    icon: Icons.search_rounded,
    color: Color(0xFFD97706),
  ),

  ];

  /// ==========================
  /// GET CATEGORY BY ID
  /// ==========================

  static VerificationCategory? getCategory(String id) {
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (_) {
      return null;
    }
  }

  /// ==========================
  /// GET SUB CATEGORIES
  /// ==========================

  static List<VerificationSubCategory> getSubCategories(String categoryId) {
    return subCategories
        .where((item) => item.categoryId == categoryId)
        .toList();
  }

  /// ==========================
  /// GET INSTITUTIONS
  /// ==========================

  static List<VerificationInstitution> getInstitutions(String subCategoryId) {
    return institutions
        .where((item) => item.subCategoryId == subCategoryId)
        .toList();
  }

  /// ==========================
  /// GET SERVICES
  /// ==========================

  static List<VerificationService> getServices(String institutionId) {
    return services
        .where((item) => item.institutionId == institutionId)
        .toList();
  }
}
