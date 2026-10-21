import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';

/// A single service category offered by Copy House.
///
/// Phase 1 only describes the service. No request submission,
/// pricing, status, or persistence is represented here.
@immutable
class CopyHouseService {
  final String id;
  final String title;
  final String summary;
  final String description;
  final IconData icon;
  final Color color;

  const CopyHouseService({
    required this.id,
    required this.title,
    required this.summary,
    required this.description,
    required this.icon,
    required this.color,
  });
}

/// Static, local service list for Copy House Phase 1.
///
/// No backend, no Firestore, no persistence.
const List<CopyHouseService> copyHouseServices = [
  CopyHouseService(
    id: 'district_court_certified_copies',
    title: 'Court Certified Copies',
    summary: 'Certified copies of records held by courts.',
    description:
        'Facilitates requests for certified copies of court records '
        'and proceedings. Choose the relevant court on the next screen.',
    icon: Icons.account_balance_outlined,
    color: AppColors.primary,
  ),
  CopyHouseService(
    id: 'mutation_copies',
    title: 'Mutation Copies',
    summary: 'Copies of revenue mutation records.',
    description:
        'Facilitates requests for copies of revenue mutation records. '
        'Online requests will be available in a later phase.',
    icon: Icons.map_outlined,
    color: AppColors.secondary,
  ),
  CopyHouseService(
    id: 'registered_document_copies',
    title: 'Registered Document Copies',
    summary: 'Copies of documents held with the Registrar.',
    description:
        'Facilitates requests for copies of registered documents. '
        'Online requests will be available in a later phase.',
    icon: Icons.description_outlined,
    color: AppColors.accent,
  ),
];