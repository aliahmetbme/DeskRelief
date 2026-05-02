class RedFlagQuestion {
  final int id;
  final int step;

  const RedFlagQuestion({
    required this.id,
    required this.step,
  });

  String getCategoryTitleKey() {
    if (step == 1) return 'qCat1';
    if (step == 2) return 'qCat2';
    return 'qCat3';
  }

  String getQuestionTextKey() {
    return 'q$id';
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
