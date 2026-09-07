import 'package:lawlink360/core/features/procedure_guide/models/procedure_model.dart';
import 'package:flutter/material.dart';
import 'package:lawlink360/core/features/procedure_guide/models/procedure_category.dart';
import 'property_procedures.dart';
import 'family_procedures.dart';
import 'criminal_procedures.dart';
import 'civil_procedures.dart';
import 'government_procedures.dart';
import 'banking_procedures.dart';
import 'labour_procedures.dart';
import 'traffic_procedures.dart';
import 'registration_procedures.dart';
import 'inheritance_procedures.dart';

class ProcedureData {

  static const List<ProcedureCategory> categories = [
    ProcedureCategory(
      id: "property",
      title: "Property Matters",
      description: "Property registration, mutation, transfer, partition and related matters",
      icon: Icons.home_work_rounded,
      color: Color(0xFF4F46E5),
    ),
    ProcedureCategory(
      id: "family",
      title: "Family Matters",
      description: "Marriage, divorce, custody, maintenance, succession and family disputes",
      icon: Icons.family_restroom_rounded,
      color: Color(0xFFDC2626),
    ),
    ProcedureCategory(
      id: "criminal",
      title: "Criminal Matters",
      description: "FIR, bail, criminal trials, appeals and criminal proceedings",
      icon: Icons.gavel_rounded,
      color: Color(0xFF059669),
    ),
    ProcedureCategory(
      id: "civil",
      title: "Civil Matters",
      description: "Civil suits, injunctions, recovery, declarations and civil proceedings",
      icon: Icons.account_balance_rounded,
      color: Color(0xFFD97706),
    ),
    ProcedureCategory(
      id: "government",
      title: "Government Matters",
      description: "CNIC, official documents and government-related procedures",
      icon: Icons.account_balance_rounded,
      color: Color(0xFF7C3AED),
    ),
    ProcedureCategory(
      id: "labour",
      title: "Labour Matters",
      description: "Employment, labour disputes, workplace rights and related matters",
      icon: Icons.work_rounded,
      color: Color(0xFF0891B2),
    ),
    ProcedureCategory(
      id: "traffic",
      title: "Traffic Matters",
      description: "Traffic violations, licenses, registration and related matters",
      icon: Icons.traffic_rounded,
      color: Color(0xFFB91C1C),
    ),
    ProcedureCategory(
      id: "registration",
      title: "Registration Matters",
      description: "Property registration, deeds and official registration procedures",
      icon: Icons.text_snippet_rounded,
      color: Color(0xFF15803D),
    ),
    ProcedureCategory(
      id: "inheritance",
      title: "Inheritance Matters",
      description: "Succession, inheritance distribution and legal heir procedures",
      icon: Icons.family_restroom_rounded,
      color: Color(0xFF6B21A8),
    ),
    ProcedureCategory(
      id: "banking",
      title: "Banking Matters",
      description: "Banking procedures, loans, mortgage and financial matters",
      icon: Icons.account_balance_rounded,
      color: Color(0xFF2563EB),
    ),
  ];

  static final List<ProcedureModel> procedures = [

    ...propertyProcedures,

    ...familyProcedures,

    ...criminalProcedures,

    ...civilProcedures,

    ...governmentProcedures,

    ...bankingProcedures,

    ...labourProcedures,

    ...trafficProcedures,

    ...registrationProcedures,

    ...inheritanceProcedures,

  ];

}