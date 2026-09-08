import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/application/screens/application_home_screen.dart';
import 'package:lawlink360/core/features/client_module/procedure_guide/screens/guider_home_screen.dart';
import 'package:lawlink360/core/features/client_module/scanner/screens/scanner_converter_home_screen.dart';
import 'package:lawlink360/core/features/client_module/screens/find_lawyer_screen.dart';
import 'package:lawlink360/core/features/client_module/translation/screens/translation_screen.dart';
import 'package:lawlink360/core/features/client_module/verification/screens/verification_screen.dart';

import '../models/ai_search_intent.dart';

class AiSearchResolver {
  const AiSearchResolver();

  AiSearchDestination? resolve(String query) {
    final normalized = query.trim().toLowerCase();

    if (normalized.isEmpty) {
      return null;
    }

    if (_matches(normalized, [
      'lawyer',
      'lawyers',
      'advocate',
      'advocates',
      'attorney',
      'legal counsel',
      'find lawyer',
      'criminal lawyer',
      'family lawyer',
      'civil lawyer',
      'property lawyer',
      'corporate lawyer',
      'divorce lawyer',
      'bail lawyer',
    ])) {
      return AiSearchDestination.findLawyer;
    }

    if (_matches(normalized, [
      'application',
      'applications',
      'draft application',
      'legal application',
      'bail application',
      'application for bail',
      'application for injunction',
      'application for maintenance',
      'application for transfer',
    ])) {
      return AiSearchDestination.applications;
    }

    if (_matches(normalized, [
      'procedure',
      'procedures',
      'procedure guide',
      'legal procedure',
      'how to',
      'process',
      'property case',
      'property dispute',
      'partition',
      'inheritance',
      'succession',
      'divorce process',
      'bail process',
      'civil suit',
      'criminal procedure',
      'traffic procedure',
    ])) {
      return AiSearchDestination.procedureGuide;
    }

    if (_matches(normalized, [
      'verification',
      'verify',
      'verification hub',
      'cnic verification',
      'document verification',
      'court verification',
      'record verification',
      'verify document',
    ])) {
      return AiSearchDestination.verificationHub;
    }

    if (_matches(normalized, [
      'translate',
      'translation',
      'translator',
      'translate document',
      'translate text',
      'urdu translation',
      'english translation',
    ])) {
      return AiSearchDestination.translation;
    }

    if (_matches(normalized, [
      'scan',
      'scanner',
      'scanning',
      'scan document',
      'scan legal document',
      'document scanner',
    ])) {
      return AiSearchDestination.scanner;
    }

    return null;
  }

  void openDestination(
    BuildContext context,
    AiSearchDestination destination,
  ) {
    final Widget screen;

    switch (destination) {
      case AiSearchDestination.findLawyer:
        screen = const FindLawyerScreen();
        break;

      case AiSearchDestination.applications:
        screen = const ApplicationHomeScreen();
        break;

      case AiSearchDestination.procedureGuide:
        screen = const GuiderHomeScreen();
        break;

      case AiSearchDestination.verificationHub:
        screen = const VerificationScreen();
        break;

      case AiSearchDestination.translation:
        screen = const TranslationScreen();
        break;

      case AiSearchDestination.scanner:
        screen = const ScannerConverterHomeScreen();
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  bool _matches(
    String query,
    List<String> keywords,
  ) {
    return keywords.any(query.contains);
  }
}
