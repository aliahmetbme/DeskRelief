import 'package:deskrelief/l10n/app_localizations.dart';

class RedFlagQuestion {
  final int id;
  final int step;

  const RedFlagQuestion({
    required this.id,
    required this.step,
  });

  String getCategoryTitle(AppLocalizations loc) {
    if (step == 1) return loc.qCat1;
    if (step == 2) return loc.qCat2;
    return loc.qCat3;
  }

  String getQuestionText(AppLocalizations loc) {
    switch (id) {
      case 1: return loc.q1;
      case 2: return loc.q2;
      case 3: return loc.q3;
      case 4: return loc.q4;
      case 5: return loc.q5;
      case 6: return loc.q6;
      case 7: return loc.q7;
      case 8: return loc.q8;
      case 9: return loc.q9;
      case 10: return loc.q10;
      case 11: return loc.q11;
      case 12: return loc.q12;
      case 13: return loc.q13;
      case 14: return loc.q14;
      case 15: return loc.q15;
      case 16: return loc.q16;
      case 17: return loc.q17;
      case 18: return loc.q18;
      default: return '';
    }
  }
}

final List<RedFlagQuestion> redFlagsMockData = [
  // Step 1: Sistemik ve Kalp Sağlığı
  const RedFlagQuestion(id: 1, step: 1),
  const RedFlagQuestion(id: 2, step: 1),
  const RedFlagQuestion(id: 3, step: 1),
  const RedFlagQuestion(id: 4, step: 1),
  const RedFlagQuestion(id: 5, step: 1),
  const RedFlagQuestion(id: 6, step: 1),

  // Step 2: Kas-İskelet ve Travma
  const RedFlagQuestion(id: 7, step: 2),
  const RedFlagQuestion(id: 8, step: 2),
  const RedFlagQuestion(id: 9, step: 2),
  const RedFlagQuestion(id: 10, step: 2),
  const RedFlagQuestion(id: 11, step: 2),
  const RedFlagQuestion(id: 12, step: 2),

  // Step 3: Kırmızı Bayraklar
  const RedFlagQuestion(id: 13, step: 3),
  const RedFlagQuestion(id: 14, step: 3),
  const RedFlagQuestion(id: 15, step: 3),
  const RedFlagQuestion(id: 16, step: 3),
  const RedFlagQuestion(id: 17, step: 3),
  const RedFlagQuestion(id: 18, step: 3),
];
