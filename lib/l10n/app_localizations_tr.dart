// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'DeskRelief';

  @override
  String get language => 'Dil';

  @override
  String get turkish => 'Türkçe';

  @override
  String get english => 'İngilizce';

  @override
  String greetingKeepGoing(String name) {
    return 'Devam Et, $name';
  }

  @override
  String welcome_user(String name) {
    return 'Hoş Geldin, $name';
  }

  @override
  String get feedbackStart =>
      'Güne başlamak için harika bir an! İlk seansını tamamla.';

  @override
  String get feedbackStep => 'Başlangıç için güzel bir adım! Devam et.';

  @override
  String get feedbackHalfway => 'Yolun yarısına geldin, harika gidiyorsun!';

  @override
  String get feedbackAlmostDone =>
      'Neredeyse bitmek üzere! Sadece birkaç seans kaldı.';

  @override
  String get feedbackDone => 'Tebrikler! Bugünkü planını başarıyla tamamladın.';

  @override
  String get planCompleted => 'Plan Tamamlandı';

  @override
  String feedbackRemainingSessions(String feedback, int remaining) {
    return '$feedback Bugünlük $remaining seans kaldı.';
  }

  @override
  String get clinicalWarningTitle => 'KLİNİK UYARI';

  @override
  String get clinicalWarningDesc =>
      'Bu program tıbbi bir tanı veya tedavi aracı değildir. Ağrı hissederseniz hemen durun ve doktora danışın.';

  @override
  String get clinicalReminderTitle => 'Klinik Hatırlatıcı';

  @override
  String get clinicalReminderDesc => 'Bugün seansa hazır mısınız?';

  @override
  String get spinalHealthTipsTitle => 'Omurga Sağlığı Tavsiyeleri';

  @override
  String get seeAll => 'Tümünü Gör';

  @override
  String get tipErgonomicsTitle => 'Ergonomi';

  @override
  String get tipErgonomicsDesc =>
      'Masa yüksekliğini dirsek açınıza göre ayarlayın.';

  @override
  String get tipMobilityTitle => 'Hareketlilik';

  @override
  String get tipMobilityDesc =>
      'Her 30 dakikada bir omuzlarınızı dairesel hareketlerle çevirin.';

  @override
  String get tipLowerBackTitle => 'Bel Sağlığı';

  @override
  String get tipLowerBackDesc =>
      'Koltuk bel kavisini destekleyen yastık kullanın.';

  @override
  String get dailyProgramTitle => 'GÜNLÜK PROGRAM';

  @override
  String get dailyProgramDesc => 'Kas-iskelet odaklı iyileşme';

  @override
  String get statusActive => 'AKTİF';

  @override
  String get statusSuccess => 'BAŞARI';

  @override
  String get weeklyProgress => '4 Haftalık Gelişim';

  @override
  String get restDayTitle => 'Bugün Senin Gününe Ara Ver.';

  @override
  String get restDayClinicalLabel => 'KLİNİK İSTİRAHAT';

  @override
  String get restDayClinicalNote =>
      'Kas liflerinizin onarımı ve postür gelişimi için bugün dinlenme gününüzdür.';

  @override
  String get nextSession => 'SIRADAKİ SEANS';

  @override
  String get tomorrow => 'Yarın';

  @override
  String restDayRemainingSessions(int count) {
    return 'Hedefine ulaşmana $count seans kaldı.';
  }

  @override
  String get didntReceiveEmail => 'Mail gelmedi mi?';

  @override
  String get resendLink => 'Tekrar Gönder';

  @override
  String get cancelAndExit => 'İptal ve Çıkış';

  @override
  String get verificationTitle => 'Doğrulama';

  @override
  String get verificationLinkSent => 'Doğrulama Linki Gönderildi!';

  @override
  String get verificationBody =>
      'adresine bir link gönderdik. Lütfen gelen kutunuzu kontrol edip linke tıklayın. Doğruladığınızda bu ekran otomatik olarak kapanacaktır.';

  @override
  String get waitingForVerification => 'Doğrulama Bekleniyor';

  @override
  String get verificationEmailSent => 'Doğrulama e-postası tekrar gönderildi.';

  @override
  String get forgotPasswordTitle => 'Şifrenizi mi Unuttunuz?';

  @override
  String get forgotPasswordSubtitle =>
      'Endişelenmeyin! Kayıtlı e-posta adresinizi girin, size şifrenizi sıfırlamanız için bir bağlantı göndereceğiz.';

  @override
  String get sendResetLink => 'Sıfırlama Linki Gönder';

  @override
  String get backToSignIn => 'Giriş sayfasına dönmek mi istiyorsunuz? ';

  @override
  String get secureDataInfra => 'Güvenli Veri Altyapısı';

  @override
  String get supportTeam247 => '7/24 Destek Ekibi';

  @override
  String get passwordResetEmailSent =>
      'Şifre sıfırlama bağlantısı e-postanıza gönderildi. Lütfen spam kutunuzu da kontrol edin.';

  @override
  String get regionNeck => 'Boyun';

  @override
  String get regionLabel1 => 'BÖLGE 1';

  @override
  String get regionLowerBack => 'Alt Sırt';

  @override
  String get regionUpperBack => 'Üst Sırt';

  @override
  String get regionLabel2 => 'BÖLGE 2';

  @override
  String get startWorkout => 'Antrenmana Başla';

  @override
  String userAge(String age) {
    return '$age Yaşında';
  }

  @override
  String get sedentaryWorker => 'Sedanter Çalışan';

  @override
  String get dailyAverageSitting => 'Günlük Ortalama Oturma';

  @override
  String hoursValue(String hours) {
    return '$hours Saat';
  }

  @override
  String get exerciseStreak => 'Egzersiz Serisi';

  @override
  String daysValue(String days) {
    return '$days GÜN';
  }

  @override
  String get accountSettings => 'HESAP AYARLARI';

  @override
  String get personalInfo => 'Kişisel Bilgiler';

  @override
  String get gdprConsent => 'KVKK / GDPR Onayı';

  @override
  String get eula => 'EULA';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get exclusionCriteria => 'Dışlama Kriterleri';

  @override
  String get clinicalBlockTitle => 'Tıbbi Yönlendirme';

  @override
  String get clinicalBlockSubtitle =>
      'Güvenliğiniz bizim için her şeyden önemli.';

  @override
  String get clinicalBlockDescription =>
      'Girdiğiniz veriler algoritmamız tarafından analiz edildi ve devam etmeden önce bir uzmana danışmanızın daha sağlıklı olacağı belirlendi.';

  @override
  String get reasonRedFlag => 'Kritik Klinik Bulgular';

  @override
  String get descRedFlag =>
      'Girdiğiniz yanıtlarda acil tıbbi değerlendirme gerektirebilecek belirtiler saptandı. Lütfen bir fizik tedavi uzmanına veya hekime danışın.';

  @override
  String get reasonCentralSensitization => 'Yaygın Hassasiyet Bulguları';

  @override
  String get descCentralSensitization =>
      'Vücudunuzun çok sayıda bölgesinde yüksek hassasiyet saptandı. Bu durum \'Merkezi Duyarlılaşma\' şüphesi uyandırabilir ve egzersiz öncesi tıbbi muayene gerektirir.';

  @override
  String get reasonExtremePain => 'Şiddetli Ağrı Sınırı';

  @override
  String get descExtremePain =>
      'Belirttiğiniz ağrı seviyesi (NPRS 10/10), egzersiz toleransınızın çok üzerindedir. Akut durumunuzun kontrolü için bir uzmana başvurmalısınız.';

  @override
  String get reasonMaxFlareUpStrike => 'Dirençli Krizler (Flare-Up)';

  @override
  String get descMaxFlareUpStrike =>
      'Aynı bölgede tekrarlayan krizler yaşanması, durumun sadece egzersizle çözülemeyecek bir doku hasarı veya inflamasyon olabileceğini gösterir.';

  @override
  String get reasonTherapeuticResistance => 'Tedaviye Direnç';

  @override
  String get descTherapeuticResistance =>
      'Süreç boyunca ağrı seviyenizin düşmek yerine artması, altta yatan yapısal bir patoloji olabileceğini gösterir. Klinik değerlendirme önerilir.';

  @override
  String get reasonChronicLimit => 'Mekanik Limit';

  @override
  String get descChronicLimit =>
      '56 günlük süreç sonunda ağrınızda anlamlı bir düşüş saptanmadı. Bu durum mekanik müdahalenin (egzersiz) şu aşamada yetersiz kaldığını gösterir.';

  @override
  String get reasonPersistentFlareUp => 'İnatçı Akutluk';

  @override
  String get descPersistentFlareUp =>
      'Uzun süreli dinlenme ve modifikasyonlara rağmen bölgedeki akut tablo iyileşmedi. Lütfen tıbbi destek alın.';

  @override
  String get clinicalBlockContactBtn => 'Raporumu Hazırla (PDF)';

  @override
  String get clinicalBlockLogoutBtn => 'Oturumu Kapat';

  @override
  String get darkTheme => 'Koyu Tema';

  @override
  String get logout => 'Oturumu Kapat';

  @override
  String get calendarClinicalProgram => 'KLİNİK PROGRAM';

  @override
  String get calendarExerciseSchedule => 'Egzersiz Takvimi';

  @override
  String get calendarDesc =>
      'Fizyoterapi ilkelerine göre hazırlanan programınız sabittir. Maksimum verim için planlanan saatlere uyunuz.';

  @override
  String get physioNoteTitle => 'Fizyoterapist Notu';

  @override
  String get physioNoteDesc =>
      'Belirlenen saatlerdeki egzersizler omurga adaptasyonu için kritiktir. Mon-Wed-Fri döngüsü idealdir.';

  @override
  String get dayDetailTitle => 'Gün Detayı';

  @override
  String get startTime => 'BAŞLANGIÇ';

  @override
  String get totalDuration => 'TOPLAM SÜRE';

  @override
  String get focusRegions => 'ODAK BÖLGELERİ';

  @override
  String get regionCervicalSpine => 'Servikal Omurga';

  @override
  String get regionTrapezius => 'Trapez Kasları';

  @override
  String get regionScapularStability => 'Skapular Stabilite';

  @override
  String get programContent => 'Program İçeriği';

  @override
  String exerciseCount(int count) {
    return '$count HAREKET';
  }

  @override
  String get exerciseNeckIsometric => 'Boyun İzometrik Güçlendirme';

  @override
  String get exerciseScapularRetraction => 'Skapular Retraksiyon';

  @override
  String get schedulingTitle => 'Program Planlaması';

  @override
  String get schedulingStart => 'Programımı Başlat';

  @override
  String get clinicalAdviceTitle => 'Klinik Tavsiye';

  @override
  String get clinicalAdviceDesc =>
      'Kas liflerinizin kendini onarması ve postür gelişiminin kalıcı olması için antrenmanlar arasında en az 24 saat dinlenme bırakılması önerilir.';

  @override
  String get daySelectionTitle => 'Gün Seçimi';

  @override
  String maxDaysError(int max) {
    return 'En fazla $max gün seçebilirsiniz.';
  }

  @override
  String get timingDetailsTitle => 'Zamanlama Detayları';

  @override
  String get save => 'Kaydet';

  @override
  String get confirm => 'Onayla';

  @override
  String get back => 'Arka';

  @override
  String get finish => 'Bitir';

  @override
  String get error_generic => 'Bir hata oluştu';

  @override
  String get and_conjunction => 've';

  @override
  String get cancel => 'İptal';

  @override
  String get workoutTimeTitle => 'Antrenman Saati';

  @override
  String get done => 'Bitti';

  @override
  String get readyToStart => 'Hazır olduğunda başlayalım.';

  @override
  String get month1 => 'Ocak';

  @override
  String get month2 => 'Şubat';

  @override
  String get month3 => 'Mart';

  @override
  String get month4 => 'Nisan';

  @override
  String get month5 => 'Mayıs';

  @override
  String get month6 => 'Haziran';

  @override
  String get month7 => 'Temmuz';

  @override
  String get month8 => 'Ağustos';

  @override
  String get month9 => 'Eylül';

  @override
  String get month10 => 'Ekim';

  @override
  String get month11 => 'Kasım';

  @override
  String get month12 => 'Aralık';

  @override
  String get day1 => 'PT';

  @override
  String get day2 => 'SA';

  @override
  String get day3 => 'ÇA';

  @override
  String get day4 => 'PE';

  @override
  String get day5 => 'CU';

  @override
  String get day6 => 'CT';

  @override
  String get day7 => 'PA';

  @override
  String get bodyMapTitle => 'Ağrı Haritası';

  @override
  String get bodyMapDesc =>
      'Son üç aydır kronik ağrı yaşadığınız bölgeleri haritadan belirleyin.';

  @override
  String get front => 'Ön';

  @override
  String get selectedRegionsTitle => 'Seçilen Bölgeler';

  @override
  String get bodyMapEmptyState =>
      'Ağrı hissettiğiniz bölgeleri harita üzerinden dokunarak seçiniz.';

  @override
  String get determinePainIntensity => 'AĞRI ŞİDDETİNİ BELİRLE';

  @override
  String get regionShoulderRight => 'Sağ Omuz';

  @override
  String get regionShoulderLeft => 'Sol Omuz';

  @override
  String get regionHipPelvis => 'Kalça';

  @override
  String get regionArmRight => 'Sağ El/Dirsek/Bilek';

  @override
  String get regionArmLeft => 'Sol El/Dirsek/Bilek';

  @override
  String get regionKneeRight => 'Sağ Diz';

  @override
  String get regionKneeLeft => 'Sol Diz';

  @override
  String get regionAnkleRight => 'Sağ Ayak Bileği';

  @override
  String get regionAnkleLeft => 'Sol Ayak Bileği';

  @override
  String get leftShoulder => 'Sol Omuz';

  @override
  String get rightShoulder => 'Sağ Omuz';

  @override
  String get leftArm => 'Sol Kol';

  @override
  String get rightArm => 'Sağ Kol';

  @override
  String get leftKnee => 'Sol Diz';

  @override
  String get rightKnee => 'Sağ Diz';

  @override
  String get leftAnkle => 'Sol Ayak Bileği';

  @override
  String get rightAnkle => 'Sağ Ayak Bileği';

  @override
  String get noRegionSelected => 'Seçili bölge bulunamadı.';

  @override
  String get goBack => 'Geri Dön';

  @override
  String regionLabel(String region) {
    return '$region Bölgesi';
  }

  @override
  String get assessmentPurposeTitle => 'Değerlendirme Amacı';

  @override
  String get assessmentPurposeDesc =>
      'Ağrı şiddeti değerlendirmesi, mevcut durumunuzu objektif bir şekilde takip etmemize ve size en uygun egzersiz yoğunluğunu belirlememize yardımcı olur.';

  @override
  String get painAnalysisTitle => 'Ağrı Analizi';

  @override
  String get finishAssessment => 'DEĞERLENDİRMEYİ BİTİR';

  @override
  String get nextRegion => 'SONRAKİ BÖLGE';

  @override
  String get focusRegionsTitle => 'Odak Bölgeler\nBelirlendi';

  @override
  String get focusRegionsDescP1 =>
      'Algoritmamız en yüksek ağrı skoruna sahip bölgelere öncelik vermiştir: ';

  @override
  String get focusRegionsDescP2 =>
      '.\n\nDiğer bölgeleriniz için, mevcut programı tamamladıktan sonra yeni bir değerlendirme yapabilirsiniz.';

  @override
  String get focusRegionsBtn => 'Tamam, Devam Et';

  @override
  String get medicalConsultationTitle => 'Tıbbi Danışmanlık\nÖnerisi';

  @override
  String get medicalConsultationDesc =>
      'Vücudunuzun çok sayıda farklı bölgesinde yaygın ve şiddetli ağrılar belirttiğinizi fark ettik.\n\nBu durum \"Merkezi Duyarlılaşma\" veya benzeri bir sendromun belirtisi olabilir. Herhangi bir egzersiz programına başlamadan önce bir hekime danışmanızı önemle tavsiye ederiz.';

  @override
  String get medicalConsultationBtn => 'Anladım';

  @override
  String get painLevelLight => 'Hafif';

  @override
  String get painLevelMild => 'Hafif-Orta';

  @override
  String get painLevelModerate => 'Orta Şiddetli';

  @override
  String get painLevelSevere => 'Şiddetli';

  @override
  String get painLevelVerySevere => 'Çok Şiddetli';

  @override
  String painAnalysisLight(int val) {
    return 'Seviye $val, günlük hayatı pek etkilemeyen hafif bir ağrıdır. Hareketlilikle düzelebilir.';
  }

  @override
  String painAnalysisMild(int val) {
    return 'Seviye $val, hissedilen ancak katlanılabilir bir ağrıdır. Esneme hareketleri faydalı olacaktır.';
  }

  @override
  String painAnalysisModerate(int val) {
    return 'Seviye $val, dikkat edilmesi gereken orta şiddetli bir ağrıdır. Kuvvet ve esneklik dengesi hedeflenecektir.';
  }

  @override
  String painAnalysisSevere(int val) {
    return 'Seviye $val, aktiviteleri kısıtlayan şiddetli bir ağrıdır. Kontrollü ve nazik egzersizler gereklidir.';
  }

  @override
  String painAnalysisVerySevere(int val) {
    return 'Seviye $val, çok şiddetli bir ağrıdır. Uzman kontrolünde ilerlemek ve dinlenmek önemlidir.';
  }

  @override
  String get medicalScreeningTitle => 'Tıbbi Tarama';

  @override
  String get medicalScreeningExclusionCriteria =>
      'Dışlama Kriterleri: Bu uygulama genel sağlıklı bireyler içindir. Herhangi bir soruyu \"Evet\" olarak yanıtlarsanız, egzersiz programına başlamadan önce mutlaka doktorunuza danışmalısınız.';

  @override
  String stepTracker(int step) {
    return 'Adım $step/3';
  }

  @override
  String get saveProgress => 'İlerlemeyi\nKaydet';

  @override
  String get completeBtn => 'Tamamla';

  @override
  String get continueBtn => 'Devam Et';

  @override
  String get pleaseAnswerAllQuestions => 'Lütfen tüm soruları yanıtlayın.';

  @override
  String get progressSaved => 'İlerleme kaydedildi.';

  @override
  String get medicalWarningTitle => 'Tıbbi Uyarı';

  @override
  String get screeningCompletedTitle => 'Tarama Tamamlandı';

  @override
  String get medicalWarningDescP1 =>
      'Güvenliğiniz bizim için önemli. Verdiğiniz yanıtlara göre, bu egzersiz programına başlamadan önce bir sağlık profesyoneline danışmanız gerekmektedir. ';

  @override
  String get deskRelief => 'DeskRelief';

  @override
  String get medicalWarningDescP2 =>
      ', tıbbi bir tanı veya tedavi aracı değildir.';

  @override
  String get screeningSuccessDesc =>
      'Harika! Egzersiz programına başlamak için herhangi bir tıbbi engeliniz bulunmuyor. Şimdi ağrı bölgelerinizi seçerek size özel programınızı oluşturabiliriz.';

  @override
  String get understood => 'Anladım';

  @override
  String get qCat1 => 'Sistemik ve Kalp Sağlığı';

  @override
  String get qCat2 => 'Kas-İskelet ve Travma';

  @override
  String get qCat3 => 'Kırmızı Bayraklar';

  @override
  String get q1 =>
      'Daha önce size tanı konmuş inme (beyin kanaması/felç) öykünüz var mı?';

  @override
  String get q2 =>
      'Kalp yetmezliği, kalp krizi, kalp ritm bozukluğu veya ciddi bir kalp-damar hastalığınız var mı?';

  @override
  String get q3 =>
      'Doktorunuz size egzersiz yapmamanız gerektiğini söyledi mi?';

  @override
  String get q4 =>
      'İstirahatte veya hafif aktivite sırasında göğüs ağrısı, nefes darlığı, baş dönmesi ya da bayılma yaşıyor musunuz?';

  @override
  String get q5 =>
      'Tanı konmuş ciddi bir solunum hastalığınız var mı? (örn: Astım, KOAH)';

  @override
  String get q6 =>
      'Tanı konmuş bir nörolojik hastalığınız var mı? (örn: Parkinson hastalığı, Multipl skleroz)';

  @override
  String get q7 => 'Aktif kanser tedavisi görüyor musunuz?';

  @override
  String get q8 => 'Son 6 ay içinde ameliyat geçirdiniz mi?';

  @override
  String get q9 =>
      'Son 6 ayda ciddi bir kas-iskelet sistemi yaralanması yaşadınız mı?';

  @override
  String get q10 =>
      'Son dönemde hastanede yatış gerektiren bir sağlık sorunu yaşadınız mı?';

  @override
  String get q11 => 'Tanı konmuş yüksek tansiyonunuz var mı (Hipertansiyon)?';

  @override
  String get q12 =>
      'Doktor tarafından tanı konmuş bel fıtığı, boyun fıtığı veya diz probleminiz var mı?';

  @override
  String get q13 => 'Gece uykudan uyandıran ağrınız var mı?';

  @override
  String get q14 => 'Açıklanamayan kilo kaybınız oldu mu?';

  @override
  String get q15 =>
      'Yakın zamanda düşme, çarpma gibi bir travma sonrası başlayan ağrınız var mı?';

  @override
  String get q16 =>
      'İlerleyici kas güçsüzlüğü, uyuşma veya his kaybı yaşıyor musunuz?';

  @override
  String get q17 => 'Hamile misiniz veya hamile olma ihtimaliniz var mı?';

  @override
  String get q18 =>
      'Daha önce egzersiz yaptıktan sonra uzun süren (24-48 saatten fazla) aşırı ağrı veya kötüleşme yaşadınız mı?';

  @override
  String get yes => 'Evet';

  @override
  String get no => 'Hayır';

  @override
  String get profileWelcomeTitle1 => 'Kinetic';

  @override
  String get profileWelcomeTitle2 => 'Equilibrium';

  @override
  String get profileWelcomeSubtitle =>
      'Kusursuz duruş ve zahmetsiz hareket yolculuğunuza başlayalım.';

  @override
  String get genderLabel => 'CİNSİYET';

  @override
  String get genderMale => 'Erkek';

  @override
  String get genderFemale => 'Kadın';

  @override
  String get professionLabel => 'MESLEK';

  @override
  String get professionHint => 'örn. Yazılım Mühendisi';

  @override
  String get heightLabel => 'BOY (CM)';

  @override
  String get heightHint => '180';

  @override
  String get weightLabel => 'KİLO (KG)';

  @override
  String get weightHint => '75';

  @override
  String get sedentaryWorkerDesc => 'Günde 6 saatten fazla oturuyor musunuz?';

  @override
  String get medicalDisclaimerTitle => 'Tıbbi Uyarı';

  @override
  String get medicalDisclaimerDesc =>
      'Bu uygulama duruş rehberliği sağlar ve profesyonel tıbbi tavsiye, teşhis veya tedavinin yerini tutmaz. Her zaman doktorunuzun tavsiyesini alın.';

  @override
  String get agreePrivacyPolicyP1 => '';

  @override
  String get agreePrivacyPolicyP2 =>
      'Gizlilik Politikası\'nı okudum, kabul ediyorum ve sağlık profilim için veri işlenmesine onay veriyorum.';

  @override
  String get confirmMedicalDisclaimer =>
      'Yukarıda sunulan Tıbbi Uyarıyı okuduğumu ve anladığımı onaylıyorum.';

  @override
  String get getStarted => 'Başla';

  @override
  String get dataSecurityLabel => 'VERİLERİNİZ GÜVENDE • KVKK UYUMLU';

  @override
  String get fillAllFieldsError =>
      'Lütfen tüm profil alanlarını doldurun (cinsiyet ve meslek dahil).';

  @override
  String get acceptAgreementsError =>
      'Devam etmek için lütfen tüm sözleşmeleri kabul edin.';

  @override
  String get onboardingTitle1 => 'Oturmak Size Ağrı mı Veriyor?';

  @override
  String get onboardingDesc1 =>
      'Modern ofis yaşam tarzı genellikle uzun süreli oturmaya neden olur, bu da boyun, sırt ve omuz ağrılarına yol açabilir.';

  @override
  String get onboardingTitle2 => 'Meet DeskRelief, Your Digital Solution';

  @override
  String get onboardingDesc2 =>
      'DeskRelief offers expert-curated, personalized exercise protocols designed to interrupt sitting intervals and minimize pain.';

  @override
  String get onboardingTitle3 => 'Take Control of Your Musculoskeletal Health';

  @override
  String get onboardingDesc3 =>
      'Start your personalized journey towards a pain-free life. It\'s easy and clinically-based.';

  @override
  String get next => 'İleri';

  @override
  String get skip => 'Atla';

  @override
  String get signInTitle => 'Hoş Geldiniz';

  @override
  String get signInSubtitle => 'Yolculuğunuza devam etmek için giriş yapın.';

  @override
  String get emailLabel => 'E-posta';

  @override
  String get emailHint => 'ad@sirket.com';

  @override
  String get passwordLabel => 'Şifre';

  @override
  String get passwordHint => '••••••••';

  @override
  String get forgotPassword => 'Şifremi Unuttum';

  @override
  String get signInButton => 'Giriş Yap';

  @override
  String get dontHaveAccount => 'Hesabınız yok mu? ';

  @override
  String get signUpLink => 'Kayıt Ol';

  @override
  String get signUpTitle => 'Hesap Oluştur';

  @override
  String get signUpSubtitle =>
      'Daha sağlıklı bir çalışma hayatı için bize katılın.';

  @override
  String get fullNameLabel => 'Ad Soyad';

  @override
  String get fullNameHint => 'Ahmet Yılmaz';

  @override
  String get confirmPasswordLabel => 'Şifreyi Onayla';

  @override
  String get haveAccount => 'Zaten hesabınız var mı? ';

  @override
  String get signInLink => 'Giriş Yap';

  @override
  String get welcomeTo => 'Hoş Geldiniz';

  @override
  String get signInTagline =>
      'Duruşunuzu düzeltin, daha derin nefes alın ve daha iyi çalışın.';

  @override
  String get orContinueWith => 'VEYA ŞUNUNLA DEVAM ET';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get signUpButton => 'Kayıt Ol';

  @override
  String get invalidEmailError => 'Geçerli bir e-posta girin';

  @override
  String get invalidPasswordError => 'En az 6 karakter';

  @override
  String get signInSuccess => 'Giriş Başarılı!';

  @override
  String get enterNameError => 'Adınızı girin';

  @override
  String get passwordsDoNotMatchError => 'Şifreler eşleşmiyor';

  @override
  String get termsOfService => 'Hizmet Şartları';

  @override
  String get acceptTermsError => 'Devam etmek için lütfen şartları kabul edin.';

  @override
  String get agreeTermsP1 => '';

  @override
  String get agreeTermsP2 => ', ';

  @override
  String get agreeTermsP3 => ' ve ';

  @override
  String get agreeTermsP4 => ' şartlarını kabul ediyorum.';

  @override
  String get flareUp => 'Flare Up';

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navCalendar => 'Takvim';

  @override
  String get navProfile => 'Profil';

  @override
  String get exclusionCriteriaHeader =>
      'Güvenli bir deneyim için sağlık durumunuz kritiktir. Mevcut durumunuzda bir değişiklik olduysa lütfen aşağıyı güncelleyiniz.';

  @override
  String get errorInvalidEmail => 'Geçersiz e-postası adresi.';

  @override
  String get errorUserDisabled => 'Bu kullanıcı hesabı devre dışı bırakılmış.';

  @override
  String get errorUserNotFound =>
      'Bu e-posta adresiyle kayıtlı kullanıcı bulunamadı.';

  @override
  String get errorWrongPassword => 'Hatalı şifre.';

  @override
  String get errorEmailAlreadyInUse => 'Bu e-posta adresi zaten kullanımda.';

  @override
  String get errorOperationNotAllowed => 'Bu işlem şu an için izinli değil.';

  @override
  String get errorWeakPassword => 'Şifre çok zayıf.';

  @override
  String get errorNetworkRequestFailed => 'Ağ bağlantısı hatası oluştu.';

  @override
  String get errorUnknown =>
      'Beklenmedik bir hata oluştu. Lütfen tekrar deneyin.';

  @override
  String get routineTitle => 'Boyun ve Alt Sırt Rutini';

  @override
  String get duration15Min => '15 Dakika';

  @override
  String get exercises10 => '10 Hareket';

  @override
  String get intensityMedium => 'Orta Yoğunluk';

  @override
  String get motivationTagline => 'GAZA GETİREN';

  @override
  String get motivationQuote => '\"Duruşunu düzelt, hayatını değiştir!\"';

  @override
  String get workoutFlow => 'Antrenman Akışı';

  @override
  String remainingExercises(int count) {
    return 'Kalan: $count Hareket';
  }

  @override
  String get phase1 => 'FAZ 1: MOBİLİZASYON (ROM)';

  @override
  String get phase2 => 'FAZ 2: GÜÇLENDİRME';

  @override
  String get phase3 => 'FAZ 3: ESNEME';

  @override
  String get phase4 => 'FAZ 4: SOĞUMA';

  @override
  String get priority => 'Öncelikli';

  @override
  String get mobility => 'Mobilite';

  @override
  String get warmup => 'Isınma';

  @override
  String get strength => 'Güç';

  @override
  String get stretching => 'Esneme';

  @override
  String get cooldown => 'Soğuma';

  @override
  String get locked => 'Kilitli';

  @override
  String get waitingWarmup => 'Isınma bekleniyor';

  @override
  String get markAsCompleted => 'Tamamlandı olarak İşaretle';

  @override
  String get howToDo => 'Nasıl Yapılır?';

  @override
  String get importantWarnings => 'Önemli Uyarılar';

  @override
  String get generalTips => 'Genel İpuçları';

  @override
  String get focusArea => 'Odak Bölgesi';

  @override
  String get watchVideo => 'Videoyu İzle';

  @override
  String get videoLoading => 'Video yükleniyor...';

  @override
  String get videoError => 'Video yüklenirken bir hata oluştu.';

  @override
  String get videoRetry => 'Tekrar Dene';

  @override
  String get dialogClinicalAlertTitle => 'Klinik Güvenlik Uyarısı';

  @override
  String get dialogRedFlagMessage =>
      'Tıbbi risk (Red Flag) bulguları nedeniyle sisteminiz kilitlenmişti. Semptomlarınızda hekim gözetiminde bir değişim olduysa, güvenlik taramasını yeniden çözmek ister misiniz?';

  @override
  String get dialogGeneralVetoMessage =>
      'Uygulama, klinik protokoller gereği programınızı durdurmuştu. Tamamen iyileştiniz mi ve bir fizyoterapist/hekimden bu uygulamayı kullanmaya devam etmek için onay aldınız mı?';

  @override
  String get btnUpdateSymptoms => 'Semptomları Güncelle';

  @override
  String get btnDoctorApproved => 'Doktor Onaylı';

  @override
  String get btnCancel => 'İptal';

  @override
  String get btnReevaluate => 'Durumumu Tekrar Değerlendir';

  @override
  String get toastSafetyWarning =>
      'Güvenliğiniz bizim için önemli. Lütfen hekim onayı olmadan egzersiz yapmayınız.';

  @override
  String get schedulingInstructionEmpty =>
      'Lütfen çalışma günlerinizi belirleyin.';

  @override
  String get schedulingInstructionSingle =>
      'Odak bölgeniz için haftada 2 veya 3 gün belirleyin.';

  @override
  String schedulingInstructionMulti(Object count) {
    return 'Belirlediğiniz $count bölge için sürdürülebilir bir program adına haftada tam 4 gün belirleyin.';
  }

  @override
  String get monday => 'Pazartesi';

  @override
  String get tuesday => 'Salı';

  @override
  String get wednesday => 'Çarşamba';

  @override
  String get thursday => 'Perşembe';

  @override
  String get friday => 'Cuma';

  @override
  String get saturday => 'Cumartesi';

  @override
  String get sunday => 'Pazar';

  @override
  String get offset_15m => '15 dk önce';

  @override
  String get offset_30m => '30 dk önce';

  @override
  String get offset_1h => '1 saat önce';

  @override
  String get offset_1_5h => '1.5 saat önce';

  @override
  String get offset_2h => '2 saat önce';

  @override
  String get notification => 'Bildirim';

  @override
  String get notificationTimeTitle => 'Bildirim Zamanı';

  @override
  String get notificationTimeDesc =>
      'Antrenman başlamadan kaç dakika önce hatırlatılsın?';
}
