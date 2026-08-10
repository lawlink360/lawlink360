import 'package:flutter/material.dart';

import '../models/document_category.dart';
import '../models/document_subcategory.dart';
import '../models/document_template.dart';


class DocumentDataService {
  /// ==========================
  /// DOCUMENT CATEGORIES
  /// ==========================

  static const List<DocumentCategory> categories = [
    DocumentCategory(
      id: 'applications_requests',
      title: 'Applications & Requests',
      description: 'Daily applications and request letters',
      icon: Icons.description_rounded,
      color: Color(0xFF2563EB),
    ),

    DocumentCategory(
      id: 'court_applications',
      title: 'Court Applications',
      description: 'Civil, Family & Criminal Court',
      icon: Icons.gavel_rounded,
      color: Color(0xFFF59E0B),
    ),

    DocumentCategory(
      id: 'government_applications',
      title: 'Government Applications',
      description: 'Government departments',
      icon: Icons.account_balance_rounded,
      color: Color(0xFF10B981),
    ),

    DocumentCategory(
      id: 'legal_notices',
      title: 'Legal Notices',
      description: 'Professional legal notices',
      icon: Icons.campaign_rounded,
      color: Color(0xFFEF4444),
    ),

    DocumentCategory(
      id: 'contracts_agreements',
      title: 'Contracts & Agreements',
      description: 'Business & personal agreements',
      icon: Icons.handshake_rounded,
      color: Color(0xFF8B5CF6),
    ),

    DocumentCategory(
      id: 'business_documents',
      title: 'Business Documents',
      description: 'Corporate documentation',
      icon: Icons.business_center_rounded,
      color: Color(0xFF0EA5E9),
    ),

    DocumentCategory(
      id: 'personal_professional',
      title: 'Personal & Professional',
      description: 'Personal document templates',
      icon: Icons.person_rounded,
      color: Color(0xFF14B8A6),
    ),

    DocumentCategory(
      id: 'affidavits',
      title: 'Affidavits',
      description: 'Affidavit templates',
      icon: Icons.verified_rounded,
      color: Color(0xFFD97706),
    ),

  ];

  /// ==========================
  /// DOCUMENT SUBCATEGORIES
  /// ==========================

  static const List<DocumentSubCategory> subCategories = [
    /// ==========================
    /// GOVERNMENT APPLICATIONS
    /// ==========================
    DocumentSubCategory(
      id: 'police',
      categoryId: 'government_applications',
      title: 'Police',
      description: 'Police complaints, FIRs and certificates',
      icon: Icons.local_police_rounded,
      color: Color(0xFF2563EB),
      templateCount: 3,
    ),

    DocumentSubCategory(
      id: 'nadra',
      categoryId: 'government_applications',
      title: 'NADRA',
      description: 'CNIC and family registration services',
      icon: Icons.badge_rounded,
      color: Color(0xFF10B981),
      templateCount: 3,
    ),

    DocumentSubCategory(
      id: 'revenue',
      categoryId: 'government_applications',
      title: 'Revenue',
      description: 'Land and property record applications',
      icon: Icons.home_work_rounded,
      color: Color(0xFFF59E0B),
      templateCount: 3,
    ),

    DocumentSubCategory(
      id: 'education',
      categoryId: 'government_applications',
      title: 'Education',
      description: 'Educational requests and verification',
      icon: Icons.school_rounded,
      color: Color(0xFF8B5CF6),
      templateCount: 3,
    ),

    DocumentSubCategory(
      id: 'consumer_court',
      categoryId: 'government_applications',
      title: 'Consumer Court',
      description: 'Consumer complaints and refund requests',
      icon: Icons.balance_rounded,
      color: Color(0xFFEF4444),
      templateCount: 2,
    ),

    DocumentSubCategory(
      id: 'excise',
      categoryId: 'government_applications',
      title: 'Excise',
      description: 'Vehicle registration and transfer',
      icon: Icons.directions_car_rounded,
      color: Color(0xFF06B6D4),
      templateCount: 2,
    ),

    DocumentSubCategory(
      id: 'utilities',
      categoryId: 'government_applications',
      title: 'Utilities',
      description: 'Electricity and gas applications',
      icon: Icons.electric_bolt_rounded,
      color: Color(0xFF14B8A6),
      templateCount: 4,
    ),

    DocumentSubCategory(
      id: 'government_portals',
      categoryId: 'government_applications',
      title: 'Government Portals',
      description: 'PM & CM complaint portals',
      icon: Icons.public_rounded,
      color: Color(0xFF6366F1),
      templateCount: 2,
    ),

    DocumentSubCategory(
      id: 'development_authorities',
      categoryId: 'government_applications',
      title: 'Development Authorities',
      description: 'Housing and building approvals',
      icon: Icons.apartment_rounded,
      color: Color(0xFFD97706),
      templateCount: 2,
    ),

    DocumentSubCategory(
  id: 'civil_court',
  categoryId: 'court_applications',
  title: 'Civil Court',
  description: 'Civil suits and related applications.',
  icon: Icons.account_balance_rounded,
  color: Colors.indigo,
  templateCount: 4,
),

DocumentSubCategory(
  id: 'family_court',
  categoryId: 'court_applications',
  title: 'Family Court',
  description: 'Family law applications.',
  icon: Icons.family_restroom_rounded,
  color: Colors.pink,
  templateCount: 4,
),

DocumentSubCategory(
  id: 'criminal_court',
  categoryId: 'court_applications',
  title: 'Criminal Court',
  description: 'Criminal law applications.',
  icon: Icons.gavel_rounded,
  color: Colors.red,
  templateCount: 4,
),

DocumentSubCategory(
  id: 'execution_misc',
  categoryId: 'court_applications',
  title: 'Execution & Miscellaneous',
  description: 'Execution, review and miscellaneous applications.',
  icon: Icons.description_rounded,
  color: Colors.teal,
  templateCount: 4,
),

/// ==========================
/// PROPERTY NOTICES
/// ==========================

DocumentSubCategory(
  id: 'property_notices',
  categoryId: 'legal_notices',
  title: 'Property Notices',
  description: 'Property-related legal notices.',
  icon: Icons.home_work_rounded,
  color: Colors.brown,
  templateCount: 3,
),

/// ==========================
/// BUSINESS NOTICES
/// ==========================

DocumentSubCategory(
  id: 'business_notices',
  categoryId: 'legal_notices',
  title: 'Business Notices',
  description: 'Business and commercial legal notices.',
  icon: Icons.business_center_rounded,
  color: Colors.indigo,
  templateCount: 2,
),

/// ==========================
/// EMPLOYMENT NOTICES
/// ==========================

DocumentSubCategory(
  id: 'employment_notices',
  categoryId: 'legal_notices',
  title: 'Employment Notices',
  description: 'Employment-related legal notices.',
  icon: Icons.work_outline_rounded,
  color: Colors.deepOrange,
  templateCount: 2,
),

/// ==========================
/// PERSONAL NOTICES
/// ==========================

DocumentSubCategory(
  id: 'personal_notices',
  categoryId: 'legal_notices',
  title: 'Personal Notices',
  description: 'Personal legal notices.',
  icon: Icons.person_outline_rounded,
  color: Colors.purple,
  templateCount: 3,
),

// ======================================================
// 🤝 CONTRACTS & AGREEMENTS
// ======================================================

// ------------------------------------------------------
// 🏠 PROPERTY AGREEMENTS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'property_agreements',
  categoryId: 'contracts_agreements',
  title: 'Property Agreements',
  description: 'Property sale, rent and lease agreements.',
  icon: Icons.home_work_rounded,
  color: Colors.brown,
  templateCount: 3,
),

// ------------------------------------------------------
// 🏢 BUSINESS AGREEMENTS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'business_agreements',
  categoryId: 'contracts_agreements',
  title: 'Business Agreements',
  description: 'Business and commercial agreements.',
  icon: Icons.business_center_rounded,
  color: Colors.indigo,
  templateCount: 3,
),

// ------------------------------------------------------
// 💼 EMPLOYMENT AGREEMENTS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'employment_agreements',
  categoryId: 'contracts_agreements',
  title: 'Employment Agreements',
  description: 'Employment and freelance agreements.',
  icon: Icons.work_rounded,
  color: Colors.deepOrange,
  templateCount: 3,
),

// ------------------------------------------------------
// 👨‍👩‍👧 PERSONAL AGREEMENTS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'personal_agreements',
  categoryId: 'contracts_agreements',
  title: 'Personal Agreements',
  description: 'Personal and family agreements.',
  icon: Icons.people_alt_rounded,
  color: Colors.purple,
  templateCount: 2,
),

// ======================================================
// 🏢 BUSINESS DOCUMENTS
// ======================================================

// ------------------------------------------------------
// 🏢 COMPANY FORMATION
// ------------------------------------------------------

DocumentSubCategory(
  id: 'company_formation',
  categoryId: 'business_documents',
  title: 'Company Formation',
  description: 'Documents required for company formation.',
  icon: Icons.business_rounded,
  color: Colors.blue,
  templateCount: 2,
),

// ------------------------------------------------------
// 🏛 CORPORATE DOCUMENTS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'corporate_documents',
  categoryId: 'business_documents',
  title: 'Corporate Documents',
  description: 'Professional corporate documentation.',
  icon: Icons.apartment_rounded,
  color: Colors.indigo,
  templateCount: 3,
),

// ------------------------------------------------------
// 👨‍💼 HUMAN RESOURCES
// ------------------------------------------------------

DocumentSubCategory(
  id: 'human_resources',
  categoryId: 'business_documents',
  title: 'Human Resources',
  description: 'Employee and HR documents.',
  icon: Icons.groups_rounded,
  color: Colors.teal,
  templateCount: 5,
),

// ------------------------------------------------------
// 📦 BUSINESS OPERATIONS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'business_operations',
  categoryId: 'business_documents',
  title: 'Business Operations',
  description: 'Daily business operation documents.',
  icon: Icons.inventory_2_rounded,
  color: Colors.deepOrange,
  templateCount: 3,
),

// ======================================================
// 👤 PERSONAL & PROFESSIONAL DOCUMENTS
// ======================================================

// ------------------------------------------------------
// 👤 PERSONAL DOCUMENTS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'personal_documents',
  categoryId: 'personal_professional',
  title: 'Personal Documents',
  description: 'Common personal applications and declarations.',
  icon: Icons.person_rounded,
  color: Colors.purple,
  templateCount: 4,
),

// ------------------------------------------------------
// 🎓 EDUCATIONAL DOCUMENTS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'educational_documents',
  categoryId: 'personal_professional',
  title: 'Educational Documents',
  description: 'Applications and letters for educational institutions.',
  icon: Icons.school_rounded,
  color: Colors.blue,
  templateCount: 4,
),

// ------------------------------------------------------
// 💼 PROFESSIONAL DOCUMENTS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'professional_documents',
  categoryId: 'personal_professional',
  title: 'Professional Documents',
  description: 'Career and professional documentation.',
  icon: Icons.work_rounded,
  color: Colors.teal,
  templateCount: 4,
),

// ------------------------------------------------------
// 🌍 TRAVEL DOCUMENTS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'travel_documents',
  categoryId: 'personal_professional',
  title: 'Travel Documents',
  description: 'Passport, visa and travel-related documents.',
  icon: Icons.flight_takeoff_rounded,
  color: Colors.deepOrange,
  templateCount: 3,
),

// ======================================================
// 📜 AFFIDAVITS
// ======================================================

// ------------------------------------------------------
// 👤 PERSONAL AFFIDAVITS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'personal_affidavits',
  categoryId: 'affidavits',
  title: 'Personal Affidavits',
  description: 'Personal declarations and affidavits.',
  icon: Icons.person_rounded,
  color: Colors.deepPurple,
  templateCount: 4,
),

// ------------------------------------------------------
// 🏠 PROPERTY AFFIDAVITS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'property_affidavits',
  categoryId: 'affidavits',
  title: 'Property Affidavits',
  description: 'Property ownership and possession affidavits.',
  icon: Icons.home_work_rounded,
  color: Colors.brown,
  templateCount: 3,
),

// ------------------------------------------------------
// 👨‍👩‍👧 FAMILY AFFIDAVITS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'family_affidavits',
  categoryId: 'affidavits',
  title: 'Family Affidavits',
  description: 'Marriage, inheritance and family affidavits.',
  icon: Icons.family_restroom_rounded,
  color: Colors.pink,
  templateCount: 3,
),

// ------------------------------------------------------
// 🏛 GENERAL LEGAL AFFIDAVITS
// ------------------------------------------------------

DocumentSubCategory(
  id: 'general_legal_affidavits',
  categoryId: 'affidavits',
  title: 'General Legal Affidavits',
  description: 'General legal affidavits for various purposes.',
  icon: Icons.gavel_rounded,
  color: Colors.indigo,
  templateCount: 5,
),

  ];

// ------------------------------------------------------
// DOCUMENTS TEMPLATE
// ------------------------------------------------------

  
static const List<DocumentTemplate> templates = [
  /// ==========================
  /// POLICE
  /// ==========================
  DocumentTemplate(
    id: 'police_complaint',
    subCategoryId: 'police',
    title: 'Complaint Applications',
    description: 'Application for filing a police complaint.',
    icon: Icons.report_problem_rounded,
    color: Color(0xFF2563EB),
    isPopular: true,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'fir_request',
    subCategoryId: 'police',
    title: 'FIR Request',
    description: 'Request for registration of an FIR.',
    icon: Icons.description_rounded,
    color: Color(0xFF2563EB),
    isPopular: true,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'character_certificate',
    subCategoryId: 'police',
    title: 'Character Certificate Request',
    description: 'Application for issuance of a character certificate.',
    icon: Icons.verified_user_rounded,
    color: Color(0xFF2563EB),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  /// ==========================
  /// NADRA
  /// ==========================
  DocumentTemplate(
    id: 'cnic_correction',
    subCategoryId: 'nadra',
    title: 'CNIC Correction Request',
    description: 'Application for correction of CNIC information.',
    icon: Icons.badge_rounded,
    color: Color(0xFF2563EB),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'lost_cnic',
    subCategoryId: 'nadra',
    title: 'Lost CNIC Application',
    description: 'Application for issuance of a duplicate CNIC.',
    icon: Icons.credit_card_off_rounded,
    color: Color(0xFF2563EB),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'family_registration_certificate',
    subCategoryId: 'nadra',
    title: 'Family Registration Certificate',
    description: 'Application for Family Registration Certificate (FRC).',
    icon: Icons.family_restroom_rounded,
    color: Color(0xFF2563EB),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  /// ==========================
  /// REVENUE
  /// ==========================
  DocumentTemplate(
    id: 'fard_application',
    subCategoryId: 'revenue',
    title: 'Fard Application',
    description: 'Application for obtaining Fard.',
    icon: Icons.description_rounded,
    color: Color(0xFF059669),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'mutation_application',
    subCategoryId: 'revenue',
    title: 'Mutation Application',
    description: 'Application for property mutation.',
    icon: Icons.swap_horiz_rounded,
    color: Color(0xFF059669),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'property_record',
    subCategoryId: 'revenue',
    title: 'Property Record Request',
    description: 'Request for certified property records.',
    icon: Icons.home_work_rounded,
    color: Color(0xFF059669),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  /// ==========================
  /// EDUCATION
  /// ==========================
  DocumentTemplate(
    id: 'degree_verification',
    subCategoryId: 'education',
    title: 'Degree Verification',
    description: 'Application for degree verification.',
    icon: Icons.school_rounded,
    color: Color(0xFFF59E0B),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'scholarship_application',
    subCategoryId: 'education',
    title: 'Scholarship Application',
    description: 'Application for scholarship.',
    icon: Icons.workspace_premium_rounded,
    color: Color(0xFFF59E0B),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'migration_certificate',
    subCategoryId: 'education',
    title: 'Migration Certificate Request',
    description: 'Application for migration certificate.',
    icon: Icons.swap_horizontal_circle_rounded,
    color: Color(0xFFF59E0B),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  /// ==========================
  /// CONSUMER COURT
  /// ==========================
  DocumentTemplate(
    id: 'consumer_complaint',
    subCategoryId: 'consumer_court',
    title: 'Consumer Complaint',
    description: 'Application for filing a consumer complaint.',
    icon: Icons.support_agent_rounded,
    color: Color(0xFFDC2626),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'refund_request',
    subCategoryId: 'consumer_court',
    title: 'Refund Request',
    description: 'Application requesting refund.',
    icon: Icons.payments_rounded,
    color: Color(0xFFDC2626),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  /// ==========================
  /// EXCISE
  /// ==========================
  DocumentTemplate(
    id: 'vehicle_registration',
    subCategoryId: 'excise',
    title: 'Vehicle Registration Request',
    description: 'Application for vehicle registration.',
    icon: Icons.directions_car_rounded,
    color: Color(0xFF7C3AED),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'vehicle_transfer',
    subCategoryId: 'excise',
    title: 'Vehicle Transfer Request',
    description: 'Application for transfer of vehicle ownership.',
    icon: Icons.sync_alt_rounded,
    color: Color(0xFF7C3AED),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  /// ==========================
  /// UTILITIES
  /// ==========================
  DocumentTemplate(
    id: 'wapda_complaint',
    subCategoryId: 'utilities',
    title: 'WAPDA Complaint',
    description: 'Complaint regarding electricity services.',
    icon: Icons.electric_bolt_rounded,
    color: Color(0xFF2563EB),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'new_electricity_connection',
    subCategoryId: 'utilities',
    title: 'New Electricity Connection',
    description: 'Application for a new electricity connection.',
    icon: Icons.power_rounded,
    color: Color(0xFF2563EB),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'sui_gas_complaint',
    subCategoryId: 'utilities',
    title: 'Sui Gas Complaint',
    description: 'Complaint regarding gas services.',
    icon: Icons.local_fire_department_rounded,
    color: Color(0xFF2563EB),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'new_gas_connection',
    subCategoryId: 'utilities',
    title: 'New Gas Connection',
    description: 'Application for a new gas connection.',
    icon: Icons.gas_meter_rounded,
    color: Color(0xFF2563EB),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  /// ==========================
  /// GOVERNMENT PORTALS
  /// ==========================
  DocumentTemplate(
    id: 'pm_portal_complaint',
    subCategoryId: 'government_portals',
    title: 'PM Portal Complaint',
    description: 'Submit a complaint through the Prime Minister Portal.',
    icon: Icons.account_balance_rounded,
    color: Color(0xFF0F766E),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'cm_portal_complaint',
    subCategoryId: 'government_portals',
    title: 'CM Portal Complaint',
    description: 'Submit a complaint through the Chief Minister Portal.',
    icon: Icons.apartment_rounded,
    color: Color(0xFF0F766E),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  /// ==========================
  /// DEVELOPMENT AUTHORITIES
  /// ==========================
  DocumentTemplate(
    id: 'building_approval',
    subCategoryId: 'development_authorities',
    title: 'Building Approval Request',
    description: 'Application for building plan approval.',
    icon: Icons.architecture_rounded,
    color: Color(0xFFEA580C),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'housing_scheme',
    subCategoryId: 'development_authorities',
    title: 'Housing Scheme Application',
    description: 'Application for housing schemes.',
    icon: Icons.location_city_rounded,
    color: Color(0xFFEA580C),
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  /// ==========================
  /// CIVIL COURT
  /// ==========================
  DocumentTemplate(
    id: 'stay_application',
    subCategoryId: 'civil_court',
    title: 'Stay Application',
    description: 'Generate a civil court stay application.',
    icon: Icons.pause_circle_outline_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'injunction_application',
    subCategoryId: 'civil_court',
    title: 'Injunction Application',
    description: 'Generate an injunction application.',
    icon: Icons.gavel_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'succession_certificate',
    subCategoryId: 'civil_court',
    title: 'Succession Certificate Application',
    description: 'Generate a succession certificate application.',
    icon: Icons.description_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'guardianship_application',
    subCategoryId: 'civil_court',
    title: 'Guardianship Application',
    description: 'Generate a guardianship application.',
    icon: Icons.family_restroom_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  /// ==========================
  /// FAMILY COURT
  /// ==========================
  DocumentTemplate(
    id: 'divorce_application',
    subCategoryId: 'family_court',
    title: 'Divorce Application',
    description: 'Generate a divorce application.',
    icon: Icons.gavel_rounded,
    color: Colors.pink,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'khula_application',
    subCategoryId: 'family_court',
    title: 'Khula Application',
    description: 'Generate a khula application.',
    icon: Icons.balance_rounded,
    color: Colors.pink,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'child_custody_application',
    subCategoryId: 'family_court',
    title: 'Child Custody Application',
    description: 'Generate a child custody application.',
    icon: Icons.child_care_rounded,
    color: Colors.pink,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'maintenance_application',
    subCategoryId: 'family_court',
    title: 'Maintenance Application',
    description: 'Generate a maintenance application.',
    icon: Icons.volunteer_activism_rounded,
    color: Colors.pink,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  /// ==========================
  /// CRIMINAL COURT
  /// ==========================
  DocumentTemplate(
    id: 'bail_application',
    subCategoryId: 'criminal_court',
    title: 'Bail Application',
    description: 'Generate a bail application.',
    icon: Icons.lock_open_rounded,
    color: Colors.red,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'pre_arrest_bail',
    subCategoryId: 'criminal_court',
    title: 'Pre-Arrest Bail Application',
    description: 'Generate a pre-arrest bail application.',
    icon: Icons.security_rounded,
    color: Colors.red,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'post_arrest_bail',
    subCategoryId: 'criminal_court',
    title: 'Post-Arrest Bail Application',
    description: 'Generate a post-arrest bail application.',
    icon: Icons.shield_outlined,
    color: Colors.red,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'fir_related_application',
    subCategoryId: 'criminal_court',
    title: 'FIR Related Application',
    description: 'Generate an FIR-related application.',
    icon: Icons.local_police_rounded,
    color: Colors.red,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  /// ==========================
  /// EXECUTION & MISC
  /// ==========================
  DocumentTemplate(
    id: 'delay_condonation',
    subCategoryId: 'execution_misc',
    title: 'Delay Condonation Application',
    description: 'Generate a delay condonation application.',
    icon: Icons.schedule_rounded,
    color: Colors.teal,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'certified_copy',
    subCategoryId: 'execution_misc',
    title: 'Certified Copy Application',
    description: 'Generate a certified copy application.',
    icon: Icons.file_copy_rounded,
    color: Colors.teal,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'review_application',
    subCategoryId: 'execution_misc',
    title: 'Review Application',
    description: 'Generate a review application.',
    icon: Icons.rate_review_rounded,
    color: Colors.teal,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'appeal_application',
    subCategoryId: 'execution_misc',
    title: 'Appeal Application',
    description: 'Generate an appeal application.',
    icon: Icons.assignment_turned_in_rounded,
    color: Colors.teal,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // Property Notices
  DocumentTemplate(
    id: 'tenant_eviction_notice',
    subCategoryId: 'property_notices',
    title: 'Tenant Eviction Notice',
    description: 'Generate a legal notice for tenant eviction.',
    icon: Icons.home_work_rounded,
    color: Colors.brown,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'rent_recovery_notice',
    subCategoryId: 'property_notices',
    title: 'Rent Recovery Notice',
    description: 'Generate a rent recovery legal notice.',
    icon: Icons.payments_rounded,
    color: Colors.brown,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'property_dispute_notice',
    subCategoryId: 'property_notices',
    title: 'Property Dispute Notice',
    description: 'Generate a property dispute legal notice.',
    icon: Icons.gavel_rounded,
    color: Colors.brown,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // Business Notices
  DocumentTemplate(
    id: 'payment_recovery_notice',
    subCategoryId: 'business_notices',
    title: 'Payment Recovery Notice',
    description: 'Generate a payment recovery notice.',
    icon: Icons.account_balance_wallet_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'contract_breach_notice',
    subCategoryId: 'business_notices',
    title: 'Contract Breach Notice',
    description: 'Generate a contract breach notice.',
    icon: Icons.description_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // Employment Notices
  DocumentTemplate(
    id: 'employee_warning_notice',
    subCategoryId: 'employment_notices',
    title: 'Employee Warning Notice',
    description: 'Generate an employee warning notice.',
    icon: Icons.warning_amber_rounded,
    color: Colors.deepOrange,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'termination_notice',
    subCategoryId: 'employment_notices',
    title: 'Termination Notice',
    description: 'Generate an employee termination notice.',
    icon: Icons.person_remove_rounded,
    color: Colors.deepOrange,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // Personal Notice
  DocumentTemplate(
    id: 'defamation_notice',
    subCategoryId: 'personal_notices',
    title: 'Defamation Notice',
    description: 'Generate a defamation legal notice.',
    icon: Icons.campaign_rounded,
    color: Colors.purple,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'harassment_notice',
    subCategoryId: 'personal_notices',
    title: 'Harassment Notice',
    description: 'Generate a harassment legal notice.',
    icon: Icons.report_problem_rounded,
    color: Colors.purple,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'legal_warning_notice',
    subCategoryId: 'personal_notices',
    title: 'Legal Warning Notice',
    description: 'Generate a general legal warning notice.',
    icon: Icons.warning_rounded,
    color: Colors.purple,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ======================================================
  // 🤝 CONTRACTS & AGREEMENTS
  // ======================================================

  // ------------------------------------------------------
  // 🏠 PROPERTY AGREEMENTS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'rent_agreement',
    subCategoryId: 'property_agreements',
    title: 'Rent Agreement',
    description: 'Generate a residential or commercial rent agreement.',
    icon: Icons.home_work_rounded,
    color: Colors.brown,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'sale_agreement',
    subCategoryId: 'property_agreements',
    title: 'Sale Agreement',
    description: 'Generate a property sale agreement.',
    icon: Icons.sell_rounded,
    color: Colors.brown,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'lease_agreement',
    subCategoryId: 'property_agreements',
    title: 'Lease Agreement',
    description: 'Generate a lease agreement document.',
    icon: Icons.assignment_rounded,
    color: Colors.brown,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ------------------------------------------------------
  // 🏢 BUSINESS AGREEMENTS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'partnership_agreement',
    subCategoryId: 'business_agreements',
    title: 'Partnership Agreement',
    description: 'Generate a business partnership agreement.',
    icon: Icons.handshake_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'service_agreement',
    subCategoryId: 'business_agreements',
    title: 'Service Agreement',
    description: 'Generate a professional service agreement.',
    icon: Icons.design_services_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'vendor_agreement',
    subCategoryId: 'business_agreements',
    title: 'Vendor Agreement',
    description: 'Generate a vendor or supplier agreement.',
    icon: Icons.storefront_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ------------------------------------------------------
  // 💼 EMPLOYMENT AGREEMENTS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'employment_contract',
    subCategoryId: 'employment_agreements',
    title: 'Employment Contract',
    description: 'Generate an employment contract.',
    icon: Icons.work_rounded,
    color: Colors.deepOrange,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'freelancer_agreement',
    subCategoryId: 'employment_agreements',
    title: 'Freelancer Agreement',
    description: 'Generate a freelancer agreement.',
    icon: Icons.laptop_mac_rounded,
    color: Colors.deepOrange,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'internship_agreement',
    subCategoryId: 'employment_agreements',
    title: 'Internship Agreement',
    description: 'Generate an internship agreement.',
    icon: Icons.school_rounded,
    color: Colors.deepOrange,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ------------------------------------------------------
  // 👨‍👩‍👧 PERSONAL AGREEMENTS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'loan_agreement',
    subCategoryId: 'personal_agreements',
    title: 'Loan Agreement',
    description: 'Generate a personal loan agreement.',
    icon: Icons.account_balance_wallet_rounded,
    color: Colors.purple,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'family_settlement_agreement',
    subCategoryId: 'personal_agreements',
    title: 'Family Settlement Agreement',
    description: 'Generate a family settlement agreement.',
    icon: Icons.family_restroom_rounded,
    color: Colors.purple,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ======================================================
  // 🏢 BUSINESS DOCUMENTS
  // ======================================================

  // ------------------------------------------------------
  // 🏢 COMPANY FORMATION
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'partnership_deed',
    subCategoryId: 'company_formation',
    title: 'Partnership Deed',
    description: 'Generate a business partnership deed.',
    icon: Icons.handshake_rounded,
    color: Colors.blue,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'company_resolution',
    subCategoryId: 'company_formation',
    title: 'Company Resolution',
    description: 'Generate a company board resolution.',
    icon: Icons.apartment_rounded,
    color: Colors.blue,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ------------------------------------------------------
  // 🏛 CORPORATE DOCUMENTS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'business_proposal',
    subCategoryId: 'corporate_documents',
    title: 'Business Proposal',
    description: 'Generate a professional business proposal.',
    icon: Icons.description_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'memorandum_letter',
    subCategoryId: 'corporate_documents',
    title: 'Memorandum Letter',
    description: 'Generate an official memorandum letter.',
    icon: Icons.article_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'corporate_notice',
    subCategoryId: 'corporate_documents',
    title: 'Corporate Notice',
    description: 'Generate an official corporate notice.',
    icon: Icons.campaign_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ------------------------------------------------------
  // 👨‍💼 HUMAN RESOURCES
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'offer_letter',
    subCategoryId: 'human_resources',
    title: 'Offer Letter',
    description: 'Generate an employee offer letter.',
    icon: Icons.mail_outline_rounded,
    color: Colors.teal,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'appointment_letter',
    subCategoryId: 'human_resources',
    title: 'Appointment Letter',
    description: 'Generate an appointment letter.',
    icon: Icons.badge_rounded,
    color: Colors.teal,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'experience_letter',
    subCategoryId: 'human_resources',
    title: 'Experience Letter',
    description: 'Generate an employee experience letter.',
    icon: Icons.workspace_premium_rounded,
    color: Colors.teal,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'relieving_letter',
    subCategoryId: 'human_resources',
    title: 'Relieving Letter',
    description: 'Generate an employee relieving letter.',
    icon: Icons.logout_rounded,
    color: Colors.teal,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'warning_letter',
    subCategoryId: 'human_resources',
    title: 'Warning Letter',
    description: 'Generate an employee warning letter.',
    icon: Icons.warning_amber_rounded,
    color: Colors.teal,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ------------------------------------------------------
  // 📦 BUSINESS OPERATIONS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'invoice',
    subCategoryId: 'business_operations',
    title: 'Invoice',
    description: 'Generate a professional invoice.',
    icon: Icons.receipt_long_rounded,
    color: Colors.deepOrange,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'quotation',
    subCategoryId: 'business_operations',
    title: 'Quotation',
    description: 'Generate a quotation document.',
    icon: Icons.request_quote_rounded,
    color: Colors.deepOrange,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'purchase_order',
    subCategoryId: 'business_operations',
    title: 'Purchase Order',
    description: 'Generate a purchase order.',
    icon: Icons.shopping_cart_checkout_rounded,
    color: Colors.deepOrange,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ======================================================
  // 👤 PERSONAL & PROFESSIONAL DOCUMENTS
  // ======================================================

  // ------------------------------------------------------
  // 👤 PERSONAL DOCUMENTS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'authority_letter',
    subCategoryId: 'personal_documents',
    title: 'Authority Letter',
    description: 'Generate an authority letter.',
    icon: Icons.assignment_ind_rounded,
    color: Colors.purple,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'undertaking',
    subCategoryId: 'personal_documents',
    title: 'Undertaking',
    description: 'Generate an undertaking document.',
    icon: Icons.fact_check_rounded,
    color: Colors.purple,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'declaration_letter',
    subCategoryId: 'personal_documents',
    title: 'Declaration Letter',
    description: 'Generate a declaration letter.',
    icon: Icons.description_rounded,
    color: Colors.purple,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'character_certificate_request',
    subCategoryId: 'personal_documents',
    title: 'Character Certificate Request',
    description: 'Generate an application for a character certificate.',
    icon: Icons.verified_user_rounded,
    color: Colors.purple,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ------------------------------------------------------
  // 🎓 EDUCATIONAL DOCUMENTS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'leave_application',
    subCategoryId: 'educational_documents',
    title: 'Leave Application',
    description: 'Generate a school or college leave application.',
    icon: Icons.event_busy_rounded,
    color: Colors.blue,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'bonafide_certificate_request',
    subCategoryId: 'educational_documents',
    title: 'Bonafide Certificate Request',
    description: 'Generate a bonafide certificate request.',
    icon: Icons.school_rounded,
    color: Colors.blue,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'transcript_request',
    subCategoryId: 'educational_documents',
    title: 'Transcript Request',
    description: 'Generate a transcript request application.',
    icon: Icons.menu_book_rounded,
    color: Colors.blue,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'degree_verification_request',
    subCategoryId: 'educational_documents',
    title: 'Degree Verification Request',
    description: 'Generate a degree verification request.',
    icon: Icons.workspace_premium_rounded,
    color: Colors.blue,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ------------------------------------------------------
  // 💼 PROFESSIONAL DOCUMENTS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'cv_resume',
    subCategoryId: 'professional_documents',
    title: 'CV / Resume',
    description: 'Generate a professional CV or resume.',
    icon: Icons.badge_rounded,
    color: Colors.teal,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'cover_letter',
    subCategoryId: 'professional_documents',
    title: 'Cover Letter',
    description: 'Generate a professional cover letter.',
    icon: Icons.mail_outline_rounded,
    color: Colors.teal,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'recommendation_letter',
    subCategoryId: 'professional_documents',
    title: 'Recommendation Letter',
    description: 'Generate a recommendation letter.',
    icon: Icons.thumb_up_alt_rounded,
    color: Colors.teal,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'resignation_letter',
    subCategoryId: 'professional_documents',
    title: 'Resignation Letter',
    description: 'Generate a resignation letter.',
    icon: Icons.logout_rounded,
    color: Colors.teal,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ------------------------------------------------------
  // 🌍 TRAVEL DOCUMENTS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'visa_request_letter',
    subCategoryId: 'travel_documents',
    title: 'Visa Request Letter',
    description: 'Generate a visa request letter.',
    icon: Icons.flight_takeoff_rounded,
    color: Colors.deepOrange,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'passport_renewal_request',
    subCategoryId: 'travel_documents',
    title: 'Passport Renewal Request',
    description: 'Generate a passport renewal request.',
    icon: Icons.badge_outlined,
    color: Colors.deepOrange,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'travel_noc',
    subCategoryId: 'travel_documents',
    title: 'No Objection Certificate (Travel)',
    description: 'Generate a travel No Objection Certificate.',
    icon: Icons.public_rounded,
    color: Colors.deepOrange,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ======================================================
  // 📜 AFFIDAVITS
  // ======================================================

  // ------------------------------------------------------
  // 👤 PERSONAL AFFIDAVITS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'affidavit_identity',
    subCategoryId: 'personal_affidavits',
    title: 'Affidavit of Identity',
    description: 'Generate an affidavit confirming personal identity.',
    icon: Icons.person_rounded,
    color: Colors.deepPurple,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'affidavit_name_change',
    subCategoryId: 'personal_affidavits',
    title: 'Affidavit of Name Change',
    description: 'Generate an affidavit for change of name.',
    icon: Icons.edit_rounded,
    color: Colors.deepPurple,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'affidavit_residence',
    subCategoryId: 'personal_affidavits',
    title: 'Affidavit of Residence',
    description: 'Generate an affidavit confirming residence.',
    icon: Icons.home_rounded,
    color: Colors.deepPurple,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'affidavit_loss',
    subCategoryId: 'personal_affidavits',
    title: 'Affidavit of Loss',
    description: 'Generate an affidavit for lost documents or items.',
    icon: Icons.report_problem_rounded,
    color: Colors.deepPurple,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ------------------------------------------------------
  // 🏠 PROPERTY AFFIDAVITS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'affidavit_property_ownership',
    subCategoryId: 'property_affidavits',
    title: 'Affidavit of Ownership',
    description: 'Generate an affidavit of property ownership.',
    icon: Icons.home_work_rounded,
    color: Colors.brown,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'affidavit_property_possession',
    subCategoryId: 'property_affidavits',
    title: 'Affidavit of Possession',
    description: 'Generate an affidavit of property possession.',
    icon: Icons.key_rounded,
    color: Colors.brown,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'affidavit_property_transfer',
    subCategoryId: 'property_affidavits',
    title: 'Affidavit for Property Transfer',
    description: 'Generate an affidavit for transfer of property.',
    icon: Icons.swap_horiz_rounded,
    color: Colors.brown,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ------------------------------------------------------
  // 👨‍👩‍👧 FAMILY AFFIDAVITS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'marriage_affidavit',
    subCategoryId: 'family_affidavits',
    title: 'Marriage Affidavit',
    description: 'Generate a marriage affidavit.',
    icon: Icons.favorite_rounded,
    color: Colors.pink,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'legal_heir_affidavit',
    subCategoryId: 'family_affidavits',
    title: 'Legal Heir Affidavit',
    description: 'Generate a legal heir affidavit.',
    icon: Icons.family_restroom_rounded,
    color: Colors.pink,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'family_settlement_affidavit',
    subCategoryId: 'family_affidavits',
    title: 'Family Settlement Affidavit',
    description: 'Generate a family settlement affidavit.',
    icon: Icons.groups_rounded,
    color: Colors.pink,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  // ------------------------------------------------------
  // 🏛 GENERAL LEGAL AFFIDAVITS
  // ------------------------------------------------------
  DocumentTemplate(
    id: 'general_affidavit',
    subCategoryId: 'general_legal_affidavits',
    title: 'General Affidavit',
    description: 'Generate a general purpose affidavit.',
    icon: Icons.gavel_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'affidavit_evidence',
    subCategoryId: 'general_legal_affidavits',
    title: 'Affidavit in Evidence',
    description: 'Generate an affidavit to be filed as evidence.',
    icon: Icons.description_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'affidavit_support',
    subCategoryId: 'general_legal_affidavits',
    title: 'Affidavit of Support',
    description: 'Generate an affidavit of support.',
    icon: Icons.volunteer_activism_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'affidavit_correction',
    subCategoryId: 'general_legal_affidavits',
    title: 'Affidavit for Correction',
    description: 'Generate an affidavit for correction of records.',
    icon: Icons.edit_document,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

  DocumentTemplate(
    id: 'affidavit_court',
    subCategoryId: 'general_legal_affidavits',
    title: 'Affidavit for Court Proceedings',
    description: 'Generate an affidavit for court proceedings.',
    icon: Icons.balance_rounded,
    color: Colors.indigo,
    body: '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.

The final document will include:

• Proper legal format
• Professional drafting
• Relevant headings
• Applicant and respondent details
• Subject
• Complete body
• Closing paragraph
• Signature section

This template is currently under development.
''',
  ),

// ==========================================================
// SUBCATEGORY: Contracts & Agreements
// ==========================================================

// EMPLOYMENT AGREEMENT

DocumentTemplate(
  id: 'employment_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Employment Agreement',
  description: 'Create an employment agreement.',
  icon: Icons.work_outline,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// SERVICE AGREEMENT

DocumentTemplate(
  id: 'service_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Service Agreement',
  description: 'Create a professional service agreement.',
  icon: Icons.design_services_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// SALE AGREEMENT

DocumentTemplate(
  id: 'sale_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Sale Agreement',
  description: 'Create a sale agreement.',
  icon: Icons.sell_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// PURCHASE AGREEMENT

DocumentTemplate(
  id: 'purchase_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Purchase Agreement',
  description: 'Create a purchase agreement.',
  icon: Icons.shopping_cart_checkout,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// RENT AGREEMENT

DocumentTemplate(
  id: 'rent_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Rent Agreement',
  description: 'Create a residential or commercial rent agreement.',
  icon: Icons.home_work_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Lease Agreement
// ----------------------

DocumentTemplate(
  id: 'lease_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Lease Agreement',
  description: 'Create a residential or commercial lease agreement.',
  icon: Icons.apartment_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Partnership Agreement
// ----------------------

DocumentTemplate(
  id: 'partnership_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Partnership Agreement',
  description: 'Create a partnership agreement.',
  icon: Icons.people_outline,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Business Agreement
// ----------------------

DocumentTemplate(
  id: 'business_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Business Agreement',
  description: 'Create a business agreement.',
  icon: Icons.business_center_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Independent Contractor Agreement
// ----------------------

DocumentTemplate(
  id: 'independent_contractor_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Independent Contractor Agreement',
  description: 'Create an independent contractor agreement.',
  icon: Icons.engineering_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Confidentiality Agreement (NDA)
// ----------------------

DocumentTemplate(
  id: 'confidentiality_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Confidentiality Agreement (NDA)',
  description: 'Create a non-disclosure agreement.',
  icon: Icons.lock_outline,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Memorandum of Understanding (MOU)
// ----------------------

DocumentTemplate(
  id: 'memorandum_understanding',
  subCategoryId: 'contracts_agreements',
  title: 'Memorandum of Understanding (MOU)',
  description: 'Create a Memorandum of Understanding.',
  icon: Icons.description_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Loan Agreement
// ----------------------

DocumentTemplate(
  id: 'loan_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Loan Agreement',
  description: 'Create a loan agreement.',
  icon: Icons.account_balance_wallet_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Security Agreement
// ----------------------

DocumentTemplate(
  id: 'security_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Security Agreement',
  description: 'Create a security agreement.',
  icon: Icons.security_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Settlement Agreement
// ----------------------

DocumentTemplate(
  id: 'settlement_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Settlement Agreement',
  description: 'Create a legal settlement agreement.',
  icon: Icons.gavel_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Cancellation Agreement
// ----------------------

DocumentTemplate(
  id: 'cancellation_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Cancellation Agreement',
  description: 'Create a cancellation agreement.',
  icon: Icons.cancel_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Agency Agreement
// ----------------------

DocumentTemplate(
  id: 'agency_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Agency Agreement',
  description: 'Create an agency agreement.',
  icon: Icons.handshake_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Power of Attorney Agreement
// ----------------------

DocumentTemplate(
  id: 'power_of_attorney_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Power of Attorney Agreement',
  description: 'Create a Power of Attorney agreement.',
  icon: Icons.gavel_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Franchise Agreement
// ----------------------

DocumentTemplate(
  id: 'franchise_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Franchise Agreement',
  description: 'Create a franchise agreement.',
  icon: Icons.storefront_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Joint Venture Agreement
// ----------------------

DocumentTemplate(
  id: 'joint_venture_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Joint Venture Agreement',
  description: 'Create a joint venture agreement.',
  icon: Icons.groups_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Affidavit of Agreement
// ----------------------

DocumentTemplate(
  id: 'affidavit_of_agreement',
  subCategoryId: 'contracts_agreements',
  title: 'Affidavit of Agreement',
  description: 'Create an affidavit of agreement.',
  icon: Icons.verified_outlined,
  color: Colors.indigo,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ==========================================================
// SUBCATEGORY: Personal & Professional
// ==========================================================

// ----------------------
// Curriculum Vitae (CV)
// ----------------------

DocumentTemplate(
  id: 'curriculum_vitae',
  subCategoryId: 'personal_professional',
  title: 'Curriculum Vitae (CV)',
  description: 'Create a professional Curriculum Vitae.',
  icon: Icons.description_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Resume
// ----------------------

DocumentTemplate(
  id: 'resume',
  subCategoryId: 'personal_professional',
  title: 'Resume',
  description: 'Create a professional resume.',
  icon: Icons.assignment_ind_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Job Application
// ----------------------

DocumentTemplate(
  id: 'job_application',
  subCategoryId: 'personal_professional',
  title: 'Job Application',
  description: 'Create a job application.',
  icon: Icons.work_outline,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Cover Letter
// ----------------------

DocumentTemplate(
  id: 'cover_letter',
  subCategoryId: 'personal_professional',
  title: 'Cover Letter',
  description: 'Create a professional cover letter.',
  icon: Icons.mail_outline,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Experience Certificate Request
// ----------------------

DocumentTemplate(
  id: 'experience_certificate_request',
  subCategoryId: 'personal_professional',
  title: 'Experience Certificate Request',
  description: 'Request an experience certificate.',
  icon: Icons.workspace_premium_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Character Certificate Request
// ----------------------

DocumentTemplate(
  id: 'character_certificate_request',
  subCategoryId: 'personal_professional',
  title: 'Character Certificate Request',
  description: 'Request a character certificate.',
  icon: Icons.verified_user_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Bonafide Certificate Request
// ----------------------

DocumentTemplate(
  id: 'bonafide_certificate_request',
  subCategoryId: 'personal_professional',
  title: 'Bonafide Certificate Request',
  description: 'Request a bonafide certificate.',
  icon: Icons.school_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Internship Request
// ----------------------

DocumentTemplate(
  id: 'internship_request',
  subCategoryId: 'personal_professional',
  title: 'Internship Request',
  description: 'Create an internship request application.',
  icon: Icons.business_center_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Leave Application
// ----------------------

DocumentTemplate(
  id: 'leave_application',
  subCategoryId: 'personal_professional',
  title: 'Leave Application',
  description: 'Create a leave application.',
  icon: Icons.event_busy_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Resignation Letter
// ----------------------

DocumentTemplate(
  id: 'resignation_letter',
  subCategoryId: 'personal_professional',
  title: 'Resignation Letter',
  description: 'Create a professional resignation letter.',
  icon: Icons.logout_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Joining Letter
// ----------------------

DocumentTemplate(
  id: 'joining_letter',
  subCategoryId: 'personal_professional',
  title: 'Joining Letter',
  description: 'Create a professional joining letter.',
  icon: Icons.how_to_reg_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// No Objection Certificate (NOC)
// ----------------------

DocumentTemplate(
  id: 'noc_request',
  subCategoryId: 'personal_professional',
  title: 'No Objection Certificate (NOC)',
  description: 'Generate a No Objection Certificate (NOC).',
  icon: Icons.verified_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Recommendation Letter
// ----------------------

DocumentTemplate(
  id: 'recommendation_letter',
  subCategoryId: 'personal_professional',
  title: 'Recommendation Letter',
  description: 'Create a recommendation letter.',
  icon: Icons.thumb_up_alt_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Scholarship Application
// ----------------------

DocumentTemplate(
  id: 'scholarship_application',
  subCategoryId: 'personal_professional',
  title: 'Scholarship Application',
  description: 'Create a scholarship application.',
  icon: Icons.school_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Admission Application
// ----------------------

DocumentTemplate(
  id: 'admission_application',
  subCategoryId: 'personal_professional',
  title: 'Admission Application',
  description: 'Create an admission application.',
  icon: Icons.menu_book_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Bank Account Opening Request
// ----------------------

DocumentTemplate(
  id: 'bank_account_opening_request',
  subCategoryId: 'personal_professional',
  title: 'Bank Account Opening Request',
  description: 'Create a request for opening a bank account.',
  icon: Icons.account_balance_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Passport Application Request
// ----------------------

DocumentTemplate(
  id: 'passport_application_request',
  subCategoryId: 'personal_professional',
  title: 'Passport Application Request',
  description: 'Create a passport application request.',
  icon: Icons.badge_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Visa Request Letter
// ----------------------

DocumentTemplate(
  id: 'visa_request_letter',
  subCategoryId: 'personal_professional',
  title: 'Visa Request Letter',
  description: 'Create a visa request letter.',
  icon: Icons.flight_takeoff_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Medical Leave Application
// ----------------------

DocumentTemplate(
  id: 'medical_leave_application',
  subCategoryId: 'personal_professional',
  title: 'Medical Leave Application',
  description: 'Create a medical leave application.',
  icon: Icons.local_hospital_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

// ----------------------
// Police Clearance Request
// ----------------------

DocumentTemplate(
  id: 'police_clearance_request',
  subCategoryId: 'personal_professional',
  title: 'Police Clearance Request',
  description: 'Create a police clearance certificate request.',
  icon: Icons.local_police_outlined,
  color: Colors.teal,
  body: '''
Temporary document body.

This template will later be loaded from the LawLink360 database.

Users will be able to edit the complete document manually before downloading it as PDF or DOCX.
''',
),

];

  /// ==========================
  /// GET SUB CATEGORIES
  /// ==========================

  static List<DocumentSubCategory> getSubCategories(String categoryId) {
    return subCategories
        .where((item) => item.categoryId == categoryId)
        .toList();
  }

  /// ==========================
  /// GET DOCUMENT TEMPLATES
  /// ==========================

  static List<DocumentTemplate> getTemplates(String subCategoryId) {
    return templates
        .where((item) => item.subCategoryId == subCategoryId)
        .toList();
  }

  /// ==========================
  /// GET CATEGORY BY ID
  /// ==========================

  static DocumentCategory? getCategory(String id) {
    try {
      return categories.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }
}