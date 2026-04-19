class RedFlagQuestion {
  final int id;
  final int step;
  final String categoryTitle;
  final String questionText;

  const RedFlagQuestion({
    required this.id,
    required this.step,
    required this.categoryTitle,
    required this.questionText,
  });
}

final List<RedFlagQuestion> redFlagsMockData = [
  // Step 1: Sistemik ve Kalp Sağlığı
  const RedFlagQuestion(
    id: 1,
    step: 1,
    categoryTitle: "Sistemik ve Kalp Sağlığı",
    questionText: "Daha önce size tanı konmuş inme (beyin kanaması/felç) öykünüz var mı?",
  ),
  const RedFlagQuestion(
    id: 2,
    step: 1,
    categoryTitle: "Sistemik ve Kalp Sağlığı",
    questionText: "Kalp yetmezliği, kalp krizi, kalp ritm bozukluğu veya ciddi bir kalp-damar hastalığınız var mı?",
  ),
  const RedFlagQuestion(
    id: 3,
    step: 1,
    categoryTitle: "Sistemik ve Kalp Sağlığı",
    questionText: "Doktorunuz size egzersiz yapmamanız gerektiğini söyledi mi?",
  ),
  const RedFlagQuestion(
    id: 4,
    step: 1,
    categoryTitle: "Sistemik ve Kalp Sağlığı",
    questionText: "İstirahatte veya hafif aktivite sırasında göğüs ağrısı, nefes darlığı, baş dönmesi ya da bayılma yaşıyor musunuz?",
  ),
  const RedFlagQuestion(
    id: 5,
    step: 1,
    categoryTitle: "Sistemik ve Kalp Sağlığı",
    questionText: "Tanı konmuş ciddi bir solunum hastalığınız var mı? (örn: Astım, KOAH)",
  ),
  const RedFlagQuestion(
    id: 6,
    step: 1,
    categoryTitle: "Sistemik ve Kalp Sağlığı",
    questionText: "Tanı konmuş bir nörolojik hastalığınız var mı? (örn: Parkinson hastalığı, Multipl skleroz)",
  ),

  // Step 2: Kas-İskelet ve Travma
  const RedFlagQuestion(
    id: 7,
    step: 2,
    categoryTitle: "Kas-İskelet ve Travma",
    questionText: "Aktif kanser tedavisi görüyor musunuz?",
  ),
  const RedFlagQuestion(
    id: 8,
    step: 2,
    categoryTitle: "Kas-İskelet ve Travma",
    questionText: "Son 6 ay içinde ameliyat geçirdiniz mi?",
  ),
  const RedFlagQuestion(
    id: 9,
    step: 2,
    categoryTitle: "Kas-İskelet ve Travma",
    questionText: "Son 6 ayda ciddi bir kas-iskelet sistemi yaralanması yaşadınız mı?",
  ),
  const RedFlagQuestion(
    id: 10,
    step: 2,
    categoryTitle: "Kas-İskelet ve Travma",
    questionText: "Son dönemde hastanede yatış gerektiren bir sağlık sorunu yaşadınız mı?",
  ),
  const RedFlagQuestion(
    id: 11,
    step: 2,
    categoryTitle: "Kas-İskelet ve Travma",
    questionText: "Tanı konmuş yüksek tansiyonunuz var mı (Hipertansiyon)?",
  ),
  const RedFlagQuestion(
    id: 12,
    step: 2,
    categoryTitle: "Kas-İskelet ve Travma",
    questionText: "Doktor tarafından tanı konmuş bel fıtığı, boyun fıtığı veya diz probleminiz var mı?",
  ),

  // Step 3: Kırmızı Bayraklar
  const RedFlagQuestion(
    id: 13,
    step: 3,
    categoryTitle: "Kırmızı Bayraklar",
    questionText: "Gece uykudan uyandıran ağrınız var mı?",
  ),
  const RedFlagQuestion(
    id: 14,
    step: 3,
    categoryTitle: "Kırmızı Bayraklar",
    questionText: "Açıklanamayan kilo kaybınız oldu mu?",
  ),
  const RedFlagQuestion(
    id: 15,
    step: 3,
    categoryTitle: "Kırmızı Bayraklar",
    questionText: "Yakın zamanda düşme, çarpma gibi bir travma sonrası başlayan ağrınız var mı?",
  ),
  const RedFlagQuestion(
    id: 16,
    step: 3,
    categoryTitle: "Kırmızı Bayraklar",
    questionText: "İlerleyici kas güçsüzlüğü, uyuşma veya his kaybı yaşıyor musunuz?",
  ),
  const RedFlagQuestion(
    id: 17,
    step: 3,
    categoryTitle: "Kırmızı Bayraklar",
    questionText: "Hamile misiniz veya hamile olma ihtimaliniz var mı?",
  ),
  const RedFlagQuestion(
    id: 18,
    step: 3,
    categoryTitle: "Kırmızı Bayraklar",
    questionText: "Daha önce egzersiz yaptıktan sonra uzun süren (24-48 saatten fazla) aşırı ağrı veya kötüleşme yaşadınız mı?",
  ),
];
