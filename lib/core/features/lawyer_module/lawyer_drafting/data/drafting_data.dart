
import '../models/draft_model.dart';

class DraftingData {
  static final List<DraftModel> drafts = [
    DraftModel(
      id: 'draft_001',
      title: 'Application for Adjournment',
      category: 'Applications',
      clientId: 'client_001',
      clientName: 'Ali Khan',
      caseId: 'case_001',
      caseTitle: 'Ali Khan vs. Ahmad',
      content: 'Sample application for adjournment.',
      status: 'Draft',
      createdAt: DateTime.now().subtract(
        const Duration(days: 2),
      ),
      updatedAt: DateTime.now().subtract(
        const Duration(days: 1),
      ),
    ),

    DraftModel(
      id: 'draft_002',
      title: 'Legal Notice',
      category: 'Legal Notices',
      clientId: 'client_002',
      clientName: 'Muhammad Usman',
      caseId: 'case_002',
      caseTitle: 'Recovery of Amount',
      content: 'Sample legal notice.',
      status: 'Draft',
      createdAt: DateTime.now().subtract(
        const Duration(days: 4),
      ),
      updatedAt: DateTime.now().subtract(
        const Duration(days: 3),
      ),
    ),

    DraftModel(
      id: 'draft_003',
      title: 'Bail Application',
      category: 'Criminal',
      clientId: 'client_003',
      clientName: 'Ahmed Raza',
      caseId: 'case_003',
      caseTitle: 'State vs. Ahmed Raza',
      content: 'Sample bail application.',
      status: 'Draft',
      createdAt: DateTime.now().subtract(
        const Duration(days: 6),
      ),
      updatedAt: DateTime.now().subtract(
        const Duration(days: 5),
      ),
    ),
  ];
}
