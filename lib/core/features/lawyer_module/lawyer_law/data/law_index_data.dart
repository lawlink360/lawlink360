import 'law_data.dart';
import '../models/law_model.dart';

class LawIndexData {
  LawIndexData._();

  /// Complete alphabet used by the A-Z Law Index.
  static const List<String> alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  /// Returns laws grouped alphabetically.
  static Map<String, List<LawModel>> get groupedLaws {
    final Map<String, List<LawModel>> grouped = {
      for (final letter in alphabet) letter: [],
    };

    for (final law in LawData.alphabeticalLaws) {
      final letter = law.alphabeticalLetter;

      if (grouped.containsKey(letter)) {
        grouped[letter]!.add(law);
      }
    }

    return grouped;
  }

  /// Returns laws beginning with a particular letter.
  static List<LawModel> getLawsByLetter(String letter) {
    final normalizedLetter = letter.trim().toUpperCase();

    if (!alphabet.contains(normalizedLetter)) {
      return [];
    }

    return LawData.getByLetter(normalizedLetter);
  }

  /// Returns only alphabet letters that currently contain laws.
  static List<String> get availableLetters {
    return alphabet.where((letter) {
      return getLawsByLetter(letter).isNotEmpty;
    }).toList();
  }

  /// Returns whether a particular letter currently has laws.
  static bool hasLaws(String letter) {
    return getLawsByLetter(letter).isNotEmpty;
  }

  /// Number of laws under a particular letter.
  static int lawCount(String letter) {
    return getLawsByLetter(letter).length;
  }

  /// Total number of laws currently available.
  static int get totalLawCount {
    return LawData.laws.length;
  }

  /// Returns the first available letter.
  static String? get firstAvailableLetter {
    for (final letter in alphabet) {
      if (hasLaws(letter)) {
        return letter;
      }
    }

    return null;
  }

  /// Returns the last available letter.
  static String? get lastAvailableLetter {
    for (final letter in alphabet.reversed) {
      if (hasLaws(letter)) {
        return letter;
      }
    }

    return null;
  }

  /// Searches laws through the alphabetical index.
  static List<LawModel> search(String query) {
    return LawData.search(query);
  }
}