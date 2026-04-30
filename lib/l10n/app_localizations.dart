import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In tr, this message translates to:
  /// **'DeskRelief'**
  String get appTitle;

  /// No description provided for @language.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get language;

  /// No description provided for @turkish.
  ///
  /// In tr, this message translates to:
  /// **'Türkçe'**
  String get turkish;

  /// No description provided for @english.
  ///
  /// In tr, this message translates to:
  /// **'İngilizce'**
  String get english;

  /// No description provided for @greetingKeepGoing.
  ///
  /// In tr, this message translates to:
  /// **'Devam Et, {name}'**
  String greetingKeepGoing(String name);

  /// No description provided for @feedbackStart.
  ///
  /// In tr, this message translates to:
  /// **'Güne başlamak için harika bir an! İlk seansını tamamla.'**
  String get feedbackStart;

  /// No description provided for @feedbackStep.
  ///
  /// In tr, this message translates to:
  /// **'Başlangıç için güzel bir adım! Devam et.'**
  String get feedbackStep;

  /// No description provided for @feedbackHalfway.
  ///
  /// In tr, this message translates to:
  /// **'Yolun yarısına geldin, harika gidiyorsun!'**
  String get feedbackHalfway;

  /// No description provided for @feedbackAlmostDone.
  ///
  /// In tr, this message translates to:
  /// **'Neredeyse bitmek üzere! Sadece birkaç seans kaldı.'**
  String get feedbackAlmostDone;

  /// No description provided for @feedbackDone.
  ///
  /// In tr, this message translates to:
  /// **'Tebrikler! Bugünkü planını başarıyla tamamladın.'**
  String get feedbackDone;

  /// No description provided for @planCompleted.
  ///
  /// In tr, this message translates to:
  /// **'Plan Tamamlandı'**
  String get planCompleted;

  /// No description provided for @feedbackRemainingSessions.
  ///
  /// In tr, this message translates to:
  /// **'{feedback} Bugünlük {remaining} seans kaldı.'**
  String feedbackRemainingSessions(String feedback, int remaining);

  /// No description provided for @clinicalWarningTitle.
  ///
  /// In tr, this message translates to:
  /// **'KLİNİK UYARI'**
  String get clinicalWarningTitle;

  /// No description provided for @clinicalWarningDesc.
  ///
  /// In tr, this message translates to:
  /// **'Bu program tıbbi bir tanı veya tedavi aracı değildir. Ağrı hissederseniz hemen durun ve doktora danışın.'**
  String get clinicalWarningDesc;

  /// No description provided for @clinicalReminderTitle.
  ///
  /// In tr, this message translates to:
  /// **'Klinik Hatırlatıcı'**
  String get clinicalReminderTitle;

  /// No description provided for @clinicalReminderDesc.
  ///
  /// In tr, this message translates to:
  /// **'Bugün seansa hazır mısınız?'**
  String get clinicalReminderDesc;

  /// No description provided for @spinalHealthTipsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Omurga Sağlığı Tavsiyeleri'**
  String get spinalHealthTipsTitle;

  /// No description provided for @seeAll.
  ///
  /// In tr, this message translates to:
  /// **'Tümünü Gör'**
  String get seeAll;

  /// No description provided for @tipErgonomicsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ergonomi'**
  String get tipErgonomicsTitle;

  /// No description provided for @tipErgonomicsDesc.
  ///
  /// In tr, this message translates to:
  /// **'Masa yüksekliğini dirsek açınıza göre ayarlayın.'**
  String get tipErgonomicsDesc;

  /// No description provided for @tipMobilityTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hareketlilik'**
  String get tipMobilityTitle;

  /// No description provided for @tipMobilityDesc.
  ///
  /// In tr, this message translates to:
  /// **'Her 30 dakikada bir omuzlarınızı dairesel hareketlerle çevirin.'**
  String get tipMobilityDesc;

  /// No description provided for @tipLowerBackTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bel Sağlığı'**
  String get tipLowerBackTitle;

  /// No description provided for @tipLowerBackDesc.
  ///
  /// In tr, this message translates to:
  /// **'Koltuk bel kavisini destekleyen yastık kullanın.'**
  String get tipLowerBackDesc;

  /// No description provided for @dailyProgramTitle.
  ///
  /// In tr, this message translates to:
  /// **'GÜNLÜK PROGRAM'**
  String get dailyProgramTitle;

  /// No description provided for @dailyProgramDesc.
  ///
  /// In tr, this message translates to:
  /// **'Kas-iskelet odaklı iyileşme'**
  String get dailyProgramDesc;

  /// No description provided for @statusActive.
  ///
  /// In tr, this message translates to:
  /// **'AKTİF'**
  String get statusActive;

  /// No description provided for @statusSuccess.
  ///
  /// In tr, this message translates to:
  /// **'BAŞARI'**
  String get statusSuccess;

  /// No description provided for @weeklyProgress.
  ///
  /// In tr, this message translates to:
  /// **'4 Haftalık Gelişim'**
  String get weeklyProgress;

  /// No description provided for @restDayTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bugün Senin Gününe Ara Ver.'**
  String get restDayTitle;

  /// No description provided for @restDayClinicalLabel.
  ///
  /// In tr, this message translates to:
  /// **'KLİNİK İSTİRAHAT'**
  String get restDayClinicalLabel;

  /// No description provided for @restDayClinicalNote.
  ///
  /// In tr, this message translates to:
  /// **'Kas liflerinizin onarımı ve postür gelişimi için bugün dinlenme gününüzdür.'**
  String get restDayClinicalNote;

  /// No description provided for @nextSession.
  ///
  /// In tr, this message translates to:
  /// **'SIRADAKİ SEANS'**
  String get nextSession;

  /// No description provided for @tomorrow.
  ///
  /// In tr, this message translates to:
  /// **'Yarın'**
  String get tomorrow;

  /// No description provided for @restDayRemainingSessions.
  ///
  /// In tr, this message translates to:
  /// **'Hedefine ulaşmana {count} seans kaldı.'**
  String restDayRemainingSessions(int count);

  /// No description provided for @regionNeck.
  ///
  /// In tr, this message translates to:
  /// **'Boyun'**
  String get regionNeck;

  /// No description provided for @regionLabel1.
  ///
  /// In tr, this message translates to:
  /// **'BÖLGE 1'**
  String get regionLabel1;

  /// No description provided for @regionLowerBack.
  ///
  /// In tr, this message translates to:
  /// **'Alt Sırt'**
  String get regionLowerBack;

  /// No description provided for @regionLabel2.
  ///
  /// In tr, this message translates to:
  /// **'BÖLGE 2'**
  String get regionLabel2;

  /// No description provided for @startWorkout.
  ///
  /// In tr, this message translates to:
  /// **'Antrenmana Başla'**
  String get startWorkout;

  /// No description provided for @userAge.
  ///
  /// In tr, this message translates to:
  /// **'{age} Yaşında'**
  String userAge(String age);

  /// No description provided for @sedentaryWorker.
  ///
  /// In tr, this message translates to:
  /// **'Sedanter Çalışan'**
  String get sedentaryWorker;

  /// No description provided for @dailyAverageSitting.
  ///
  /// In tr, this message translates to:
  /// **'Günlük Ortalama Oturma'**
  String get dailyAverageSitting;

  /// No description provided for @hoursValue.
  ///
  /// In tr, this message translates to:
  /// **'{hours} Saat'**
  String hoursValue(String hours);

  /// No description provided for @exerciseStreak.
  ///
  /// In tr, this message translates to:
  /// **'Egzersiz Serisi'**
  String get exerciseStreak;

  /// No description provided for @daysValue.
  ///
  /// In tr, this message translates to:
  /// **'{days} GÜN'**
  String daysValue(String days);

  /// No description provided for @accountSettings.
  ///
  /// In tr, this message translates to:
  /// **'HESAP AYARLARI'**
  String get accountSettings;

  /// No description provided for @personalInfo.
  ///
  /// In tr, this message translates to:
  /// **'Kişisel Bilgiler'**
  String get personalInfo;

  /// No description provided for @gdprConsent.
  ///
  /// In tr, this message translates to:
  /// **'KVKK / GDPR Onayı'**
  String get gdprConsent;

  /// No description provided for @eula.
  ///
  /// In tr, this message translates to:
  /// **'EULA'**
  String get eula;

  /// No description provided for @privacyPolicy.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik Politikası'**
  String get privacyPolicy;

  /// No description provided for @exclusionCriteria.
  ///
  /// In tr, this message translates to:
  /// **'Dışlama Kriterleri'**
  String get exclusionCriteria;

  /// No description provided for @darkTheme.
  ///
  /// In tr, this message translates to:
  /// **'Koyu Tema'**
  String get darkTheme;

  /// No description provided for @logout.
  ///
  /// In tr, this message translates to:
  /// **'Oturumu Kapat'**
  String get logout;

  /// No description provided for @calendarClinicalProgram.
  ///
  /// In tr, this message translates to:
  /// **'KLİNİK PROGRAM'**
  String get calendarClinicalProgram;

  /// No description provided for @calendarExerciseSchedule.
  ///
  /// In tr, this message translates to:
  /// **'Egzersiz Takvimi'**
  String get calendarExerciseSchedule;

  /// No description provided for @calendarDesc.
  ///
  /// In tr, this message translates to:
  /// **'Fizyoterapi ilkelerine göre hazırlanan programınız sabittir. Maksimum verim için planlanan saatlere uyunuz.'**
  String get calendarDesc;

  /// No description provided for @physioNoteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Fizyoterapist Notu'**
  String get physioNoteTitle;

  /// No description provided for @physioNoteDesc.
  ///
  /// In tr, this message translates to:
  /// **'Belirlenen saatlerdeki egzersizler omurga adaptasyonu için kritiktir. Mon-Wed-Fri döngüsü idealdir.'**
  String get physioNoteDesc;

  /// No description provided for @dayDetailTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gün Detayı'**
  String get dayDetailTitle;

  /// No description provided for @startTime.
  ///
  /// In tr, this message translates to:
  /// **'BAŞLANGIÇ'**
  String get startTime;

  /// No description provided for @totalDuration.
  ///
  /// In tr, this message translates to:
  /// **'TOPLAM SÜRE'**
  String get totalDuration;

  /// No description provided for @focusRegions.
  ///
  /// In tr, this message translates to:
  /// **'ODAK BÖLGELERİ'**
  String get focusRegions;

  /// No description provided for @regionCervicalSpine.
  ///
  /// In tr, this message translates to:
  /// **'Servikal Omurga'**
  String get regionCervicalSpine;

  /// No description provided for @regionTrapezius.
  ///
  /// In tr, this message translates to:
  /// **'Trapez Kasları'**
  String get regionTrapezius;

  /// No description provided for @regionScapularStability.
  ///
  /// In tr, this message translates to:
  /// **'Skapular Stabilite'**
  String get regionScapularStability;

  /// No description provided for @programContent.
  ///
  /// In tr, this message translates to:
  /// **'Program İçeriği'**
  String get programContent;

  /// No description provided for @exerciseCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} HAREKET'**
  String exerciseCount(int count);

  /// No description provided for @exerciseNeckIsometric.
  ///
  /// In tr, this message translates to:
  /// **'Boyun İzometrik Güçlendirme'**
  String get exerciseNeckIsometric;

  /// No description provided for @exerciseScapularRetraction.
  ///
  /// In tr, this message translates to:
  /// **'Skapular Retraksiyon'**
  String get exerciseScapularRetraction;

  /// No description provided for @schedulingTitle.
  ///
  /// In tr, this message translates to:
  /// **'Program Planlaması'**
  String get schedulingTitle;

  /// No description provided for @schedulingStart.
  ///
  /// In tr, this message translates to:
  /// **'Programımı Başlat'**
  String get schedulingStart;

  /// No description provided for @clinicalAdviceTitle.
  ///
  /// In tr, this message translates to:
  /// **'Klinik Tavsiye'**
  String get clinicalAdviceTitle;

  /// No description provided for @clinicalAdviceDesc.
  ///
  /// In tr, this message translates to:
  /// **'Kas liflerinizin kendini onarması ve postür gelişiminin kalıcı olması için antrenmanlar arasında en az 24 saat dinlenme bırakılması önerilir.'**
  String get clinicalAdviceDesc;

  /// No description provided for @daySelectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gün Seçimi'**
  String get daySelectionTitle;

  /// No description provided for @maxDaysError.
  ///
  /// In tr, this message translates to:
  /// **'En fazla {max} gün seçebilirsiniz.'**
  String maxDaysError(int max);

  /// No description provided for @timingDetailsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Zamanlama Detayları'**
  String get timingDetailsTitle;

  /// No description provided for @cancel.
  ///
  /// In tr, this message translates to:
  /// **'İptal'**
  String get cancel;

  /// No description provided for @workoutTimeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Antrenman Saati'**
  String get workoutTimeTitle;

  /// No description provided for @done.
  ///
  /// In tr, this message translates to:
  /// **'Bitti'**
  String get done;

  /// No description provided for @readyToStart.
  ///
  /// In tr, this message translates to:
  /// **'Hazır olduğunda başlayalım.'**
  String get readyToStart;

  /// No description provided for @month1.
  ///
  /// In tr, this message translates to:
  /// **'Ocak'**
  String get month1;

  /// No description provided for @month2.
  ///
  /// In tr, this message translates to:
  /// **'Şubat'**
  String get month2;

  /// No description provided for @month3.
  ///
  /// In tr, this message translates to:
  /// **'Mart'**
  String get month3;

  /// No description provided for @month4.
  ///
  /// In tr, this message translates to:
  /// **'Nisan'**
  String get month4;

  /// No description provided for @month5.
  ///
  /// In tr, this message translates to:
  /// **'Mayıs'**
  String get month5;

  /// No description provided for @month6.
  ///
  /// In tr, this message translates to:
  /// **'Haziran'**
  String get month6;

  /// No description provided for @month7.
  ///
  /// In tr, this message translates to:
  /// **'Temmuz'**
  String get month7;

  /// No description provided for @month8.
  ///
  /// In tr, this message translates to:
  /// **'Ağustos'**
  String get month8;

  /// No description provided for @month9.
  ///
  /// In tr, this message translates to:
  /// **'Eylül'**
  String get month9;

  /// No description provided for @month10.
  ///
  /// In tr, this message translates to:
  /// **'Ekim'**
  String get month10;

  /// No description provided for @month11.
  ///
  /// In tr, this message translates to:
  /// **'Kasım'**
  String get month11;

  /// No description provided for @month12.
  ///
  /// In tr, this message translates to:
  /// **'Aralık'**
  String get month12;

  /// No description provided for @day1.
  ///
  /// In tr, this message translates to:
  /// **'PT'**
  String get day1;

  /// No description provided for @day2.
  ///
  /// In tr, this message translates to:
  /// **'SA'**
  String get day2;

  /// No description provided for @day3.
  ///
  /// In tr, this message translates to:
  /// **'ÇA'**
  String get day3;

  /// No description provided for @day4.
  ///
  /// In tr, this message translates to:
  /// **'PE'**
  String get day4;

  /// No description provided for @day5.
  ///
  /// In tr, this message translates to:
  /// **'CU'**
  String get day5;

  /// No description provided for @day6.
  ///
  /// In tr, this message translates to:
  /// **'CT'**
  String get day6;

  /// No description provided for @day7.
  ///
  /// In tr, this message translates to:
  /// **'PA'**
  String get day7;

  /// No description provided for @bodyMapTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ağrı Haritası'**
  String get bodyMapTitle;

  /// No description provided for @bodyMapDesc.
  ///
  /// In tr, this message translates to:
  /// **'Son üç aydır kronik ağrı yaşadığınız bölgeleri haritadan belirleyin.'**
  String get bodyMapDesc;

  /// No description provided for @front.
  ///
  /// In tr, this message translates to:
  /// **'Ön'**
  String get front;

  /// No description provided for @back.
  ///
  /// In tr, this message translates to:
  /// **'Arka'**
  String get back;

  /// No description provided for @selectedRegionsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Seçilen Bölgeler'**
  String get selectedRegionsTitle;

  /// No description provided for @bodyMapEmptyState.
  ///
  /// In tr, this message translates to:
  /// **'Ağrı hissettiğiniz bölgeleri harita üzerinden dokunarak seçiniz.'**
  String get bodyMapEmptyState;

  /// No description provided for @determinePainIntensity.
  ///
  /// In tr, this message translates to:
  /// **'AĞRI ŞİDDETİNİ BELİRLE'**
  String get determinePainIntensity;

  /// No description provided for @regionShoulderRight.
  ///
  /// In tr, this message translates to:
  /// **'Sağ Omuz'**
  String get regionShoulderRight;

  /// No description provided for @regionShoulderLeft.
  ///
  /// In tr, this message translates to:
  /// **'Sol Omuz'**
  String get regionShoulderLeft;

  /// No description provided for @regionHipPelvis.
  ///
  /// In tr, this message translates to:
  /// **'Kalça'**
  String get regionHipPelvis;

  /// No description provided for @regionArmRight.
  ///
  /// In tr, this message translates to:
  /// **'Sağ El/Dirsek/Bilek'**
  String get regionArmRight;

  /// No description provided for @regionArmLeft.
  ///
  /// In tr, this message translates to:
  /// **'Sol El/Dirsek/Bilek'**
  String get regionArmLeft;

  /// No description provided for @regionKneeRight.
  ///
  /// In tr, this message translates to:
  /// **'Sağ Diz'**
  String get regionKneeRight;

  /// No description provided for @regionKneeLeft.
  ///
  /// In tr, this message translates to:
  /// **'Sol Diz'**
  String get regionKneeLeft;

  /// No description provided for @regionAnkleRight.
  ///
  /// In tr, this message translates to:
  /// **'Sağ Ayak Bileği'**
  String get regionAnkleRight;

  /// No description provided for @regionAnkleLeft.
  ///
  /// In tr, this message translates to:
  /// **'Sol Ayak Bileği'**
  String get regionAnkleLeft;

  /// No description provided for @noRegionSelected.
  ///
  /// In tr, this message translates to:
  /// **'Seçili bölge bulunamadı.'**
  String get noRegionSelected;

  /// No description provided for @goBack.
  ///
  /// In tr, this message translates to:
  /// **'Geri Dön'**
  String get goBack;

  /// No description provided for @regionLabel.
  ///
  /// In tr, this message translates to:
  /// **'{region} Bölgesi'**
  String regionLabel(String region);

  /// No description provided for @assessmentPurposeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Değerlendirme Amacı'**
  String get assessmentPurposeTitle;

  /// No description provided for @assessmentPurposeDesc.
  ///
  /// In tr, this message translates to:
  /// **'Ağrı şiddeti değerlendirmesi, mevcut durumunuzu objektif bir şekilde takip etmemize ve size en uygun egzersiz yoğunluğunu belirlememize yardımcı olur.'**
  String get assessmentPurposeDesc;

  /// No description provided for @painAnalysisTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ağrı Analizi'**
  String get painAnalysisTitle;

  /// No description provided for @finishAssessment.
  ///
  /// In tr, this message translates to:
  /// **'DEĞERLENDİRMEYİ BİTİR'**
  String get finishAssessment;

  /// No description provided for @nextRegion.
  ///
  /// In tr, this message translates to:
  /// **'SONRAKİ BÖLGE'**
  String get nextRegion;

  /// No description provided for @focusRegionsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Odak Bölgeler\nBelirlendi'**
  String get focusRegionsTitle;

  /// No description provided for @focusRegionsDescP1.
  ///
  /// In tr, this message translates to:
  /// **'Algoritmamız en yüksek ağrı skoruna sahip bölgelere öncelik vermiştir: '**
  String get focusRegionsDescP1;

  /// No description provided for @focusRegionsDescP2.
  ///
  /// In tr, this message translates to:
  /// **'.\n\nDiğer bölgeleriniz için, mevcut programı tamamladıktan sonra yeni bir değerlendirme yapabilirsiniz.'**
  String get focusRegionsDescP2;

  /// No description provided for @focusRegionsBtn.
  ///
  /// In tr, this message translates to:
  /// **'Tamam, Devam Et'**
  String get focusRegionsBtn;

  /// No description provided for @medicalConsultationTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tıbbi Danışmanlık\nÖnerisi'**
  String get medicalConsultationTitle;

  /// No description provided for @medicalConsultationDesc.
  ///
  /// In tr, this message translates to:
  /// **'Vücudunuzun çok sayıda farklı bölgesinde yaygın ve şiddetli ağrılar belirttiğinizi fark ettik.\n\nBu durum \"Merkezi Duyarlılaşma\" veya benzeri bir sendromun belirtisi olabilir. Herhangi bir egzersiz programına başlamadan önce bir hekime danışmanızı önemle tavsiye ederiz.'**
  String get medicalConsultationDesc;

  /// No description provided for @medicalConsultationBtn.
  ///
  /// In tr, this message translates to:
  /// **'Anladım'**
  String get medicalConsultationBtn;

  /// No description provided for @painLevelLight.
  ///
  /// In tr, this message translates to:
  /// **'Hafif'**
  String get painLevelLight;

  /// No description provided for @painLevelMild.
  ///
  /// In tr, this message translates to:
  /// **'Hafif-Orta'**
  String get painLevelMild;

  /// No description provided for @painLevelModerate.
  ///
  /// In tr, this message translates to:
  /// **'Orta Şiddetli'**
  String get painLevelModerate;

  /// No description provided for @painLevelSevere.
  ///
  /// In tr, this message translates to:
  /// **'Şiddetli'**
  String get painLevelSevere;

  /// No description provided for @painLevelVerySevere.
  ///
  /// In tr, this message translates to:
  /// **'Çok Şiddetli'**
  String get painLevelVerySevere;

  /// No description provided for @painAnalysisLight.
  ///
  /// In tr, this message translates to:
  /// **'Seviye {val}, günlük hayatı pek etkilemeyen hafif bir ağrıdır. Hareketlilikle düzelebilir.'**
  String painAnalysisLight(int val);

  /// No description provided for @painAnalysisMild.
  ///
  /// In tr, this message translates to:
  /// **'Seviye {val}, hissedilen ancak katlanılabilir bir ağrıdır. Esneme hareketleri faydalı olacaktır.'**
  String painAnalysisMild(int val);

  /// No description provided for @painAnalysisModerate.
  ///
  /// In tr, this message translates to:
  /// **'Seviye {val}, dikkat edilmesi gereken orta şiddetli bir ağrıdır. Kuvvet ve esneklik dengesi hedeflenecektir.'**
  String painAnalysisModerate(int val);

  /// No description provided for @painAnalysisSevere.
  ///
  /// In tr, this message translates to:
  /// **'Seviye {val}, aktiviteleri kısıtlayan şiddetli bir ağrıdır. Kontrollü ve nazik egzersizler gereklidir.'**
  String painAnalysisSevere(int val);

  /// No description provided for @painAnalysisVerySevere.
  ///
  /// In tr, this message translates to:
  /// **'Seviye {val}, çok şiddetli bir ağrıdır. Uzman kontrolünde ilerlemek ve dinlenmek önemlidir.'**
  String painAnalysisVerySevere(int val);

  /// No description provided for @medicalScreeningTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tıbbi Tarama'**
  String get medicalScreeningTitle;

  /// No description provided for @medicalScreeningExclusionCriteria.
  ///
  /// In tr, this message translates to:
  /// **'Dışlama Kriterleri: Bu uygulama genel sağlıklı bireyler içindir. Herhangi bir soruyu \"Evet\" olarak yanıtlarsanız, egzersiz programına başlamadan önce mutlaka doktorunuza danışmalısınız.'**
  String get medicalScreeningExclusionCriteria;

  /// No description provided for @stepTracker.
  ///
  /// In tr, this message translates to:
  /// **'Adım {step}/3'**
  String stepTracker(int step);

  /// No description provided for @saveProgress.
  ///
  /// In tr, this message translates to:
  /// **'İlerlemeyi\nKaydet'**
  String get saveProgress;

  /// No description provided for @completeBtn.
  ///
  /// In tr, this message translates to:
  /// **'Tamamla'**
  String get completeBtn;

  /// No description provided for @continueBtn.
  ///
  /// In tr, this message translates to:
  /// **'Devam Et'**
  String get continueBtn;

  /// No description provided for @pleaseAnswerAllQuestions.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen tüm soruları yanıtlayın.'**
  String get pleaseAnswerAllQuestions;

  /// No description provided for @progressSaved.
  ///
  /// In tr, this message translates to:
  /// **'İlerleme kaydedildi.'**
  String get progressSaved;

  /// No description provided for @medicalWarningTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tıbbi Uyarı'**
  String get medicalWarningTitle;

  /// No description provided for @screeningCompletedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tarama Tamamlandı'**
  String get screeningCompletedTitle;

  /// No description provided for @medicalWarningDescP1.
  ///
  /// In tr, this message translates to:
  /// **'Güvenliğiniz bizim için önemli. Verdiğiniz yanıtlara göre, bu egzersiz programına başlamadan önce bir sağlık profesyoneline danışmanız gerekmektedir. '**
  String get medicalWarningDescP1;

  /// No description provided for @deskRelief.
  ///
  /// In tr, this message translates to:
  /// **'DeskRelief'**
  String get deskRelief;

  /// No description provided for @medicalWarningDescP2.
  ///
  /// In tr, this message translates to:
  /// **', tıbbi bir tanı veya tedavi aracı değildir.'**
  String get medicalWarningDescP2;

  /// No description provided for @screeningSuccessDesc.
  ///
  /// In tr, this message translates to:
  /// **'Harika! Egzersiz programına başlamak için herhangi bir tıbbi engeliniz bulunmuyor. Şimdi ağrı bölgelerinizi seçerek size özel programınızı oluşturabiliriz.'**
  String get screeningSuccessDesc;

  /// No description provided for @understood.
  ///
  /// In tr, this message translates to:
  /// **'Anladım'**
  String get understood;

  /// No description provided for @qCat1.
  ///
  /// In tr, this message translates to:
  /// **'Sistemik ve Kalp Sağlığı'**
  String get qCat1;

  /// No description provided for @qCat2.
  ///
  /// In tr, this message translates to:
  /// **'Kas-İskelet ve Travma'**
  String get qCat2;

  /// No description provided for @qCat3.
  ///
  /// In tr, this message translates to:
  /// **'Kırmızı Bayraklar'**
  String get qCat3;

  /// No description provided for @q1.
  ///
  /// In tr, this message translates to:
  /// **'Daha önce size tanı konmuş inme (beyin kanaması/felç) öykünüz var mı?'**
  String get q1;

  /// No description provided for @q2.
  ///
  /// In tr, this message translates to:
  /// **'Kalp yetmezliği, kalp krizi, kalp ritm bozukluğu veya ciddi bir kalp-damar hastalığınız var mı?'**
  String get q2;

  /// No description provided for @q3.
  ///
  /// In tr, this message translates to:
  /// **'Doktorunuz size egzersiz yapmamanız gerektiğini söyledi mi?'**
  String get q3;

  /// No description provided for @q4.
  ///
  /// In tr, this message translates to:
  /// **'İstirahatte veya hafif aktivite sırasında göğüs ağrısı, nefes darlığı, baş dönmesi ya da bayılma yaşıyor musunuz?'**
  String get q4;

  /// No description provided for @q5.
  ///
  /// In tr, this message translates to:
  /// **'Tanı konmuş ciddi bir solunum hastalığınız var mı? (örn: Astım, KOAH)'**
  String get q5;

  /// No description provided for @q6.
  ///
  /// In tr, this message translates to:
  /// **'Tanı konmuş bir nörolojik hastalığınız var mı? (örn: Parkinson hastalığı, Multipl skleroz)'**
  String get q6;

  /// No description provided for @q7.
  ///
  /// In tr, this message translates to:
  /// **'Aktif kanser tedavisi görüyor musunuz?'**
  String get q7;

  /// No description provided for @q8.
  ///
  /// In tr, this message translates to:
  /// **'Son 6 ay içinde ameliyat geçirdiniz mi?'**
  String get q8;

  /// No description provided for @q9.
  ///
  /// In tr, this message translates to:
  /// **'Son 6 ayda ciddi bir kas-iskelet sistemi yaralanması yaşadınız mı?'**
  String get q9;

  /// No description provided for @q10.
  ///
  /// In tr, this message translates to:
  /// **'Son dönemde hastanede yatış gerektiren bir sağlık sorunu yaşadınız mı?'**
  String get q10;

  /// No description provided for @q11.
  ///
  /// In tr, this message translates to:
  /// **'Tanı konmuş yüksek tansiyonunuz var mı (Hipertansiyon)?'**
  String get q11;

  /// No description provided for @q12.
  ///
  /// In tr, this message translates to:
  /// **'Doktor tarafından tanı konmuş bel fıtığı, boyun fıtığı veya diz probleminiz var mı?'**
  String get q12;

  /// No description provided for @q13.
  ///
  /// In tr, this message translates to:
  /// **'Gece uykudan uyandıran ağrınız var mı?'**
  String get q13;

  /// No description provided for @q14.
  ///
  /// In tr, this message translates to:
  /// **'Açıklanamayan kilo kaybınız oldu mu?'**
  String get q14;

  /// No description provided for @q15.
  ///
  /// In tr, this message translates to:
  /// **'Yakın zamanda düşme, çarpma gibi bir travma sonrası başlayan ağrınız var mı?'**
  String get q15;

  /// No description provided for @q16.
  ///
  /// In tr, this message translates to:
  /// **'İlerleyici kas güçsüzlüğü, uyuşma veya his kaybı yaşıyor musunuz?'**
  String get q16;

  /// No description provided for @q17.
  ///
  /// In tr, this message translates to:
  /// **'Hamile misiniz veya hamile olma ihtimaliniz var mı?'**
  String get q17;

  /// No description provided for @q18.
  ///
  /// In tr, this message translates to:
  /// **'Daha önce egzersiz yaptıktan sonra uzun süren (24-48 saatten fazla) aşırı ağrı veya kötüleşme yaşadınız mı?'**
  String get q18;

  /// No description provided for @yes.
  ///
  /// In tr, this message translates to:
  /// **'Evet'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In tr, this message translates to:
  /// **'Hayır'**
  String get no;

  /// No description provided for @profileWelcomeTitle1.
  ///
  /// In tr, this message translates to:
  /// **'Kinetic'**
  String get profileWelcomeTitle1;

  /// No description provided for @profileWelcomeTitle2.
  ///
  /// In tr, this message translates to:
  /// **'Equilibrium'**
  String get profileWelcomeTitle2;

  /// No description provided for @profileWelcomeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Kusursuz duruş ve zahmetsiz hareket yolculuğunuza başlayalım.'**
  String get profileWelcomeSubtitle;

  /// No description provided for @genderLabel.
  ///
  /// In tr, this message translates to:
  /// **'CİNSİYET'**
  String get genderLabel;

  /// No description provided for @genderMale.
  ///
  /// In tr, this message translates to:
  /// **'Erkek'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In tr, this message translates to:
  /// **'Kadın'**
  String get genderFemale;

  /// No description provided for @professionLabel.
  ///
  /// In tr, this message translates to:
  /// **'MESLEK'**
  String get professionLabel;

  /// No description provided for @professionHint.
  ///
  /// In tr, this message translates to:
  /// **'örn. Yazılım Mühendisi'**
  String get professionHint;

  /// No description provided for @heightLabel.
  ///
  /// In tr, this message translates to:
  /// **'BOY (CM)'**
  String get heightLabel;

  /// No description provided for @heightHint.
  ///
  /// In tr, this message translates to:
  /// **'180'**
  String get heightHint;

  /// No description provided for @weightLabel.
  ///
  /// In tr, this message translates to:
  /// **'KİLO (KG)'**
  String get weightLabel;

  /// No description provided for @weightHint.
  ///
  /// In tr, this message translates to:
  /// **'75'**
  String get weightHint;

  /// No description provided for @sedentaryWorkerDesc.
  ///
  /// In tr, this message translates to:
  /// **'Günde 6 saatten fazla oturuyor musunuz?'**
  String get sedentaryWorkerDesc;

  /// No description provided for @medicalDisclaimerTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tıbbi Uyarı'**
  String get medicalDisclaimerTitle;

  /// No description provided for @medicalDisclaimerDesc.
  ///
  /// In tr, this message translates to:
  /// **'Bu uygulama duruş rehberliği sağlar ve profesyonel tıbbi tavsiye, teşhis veya tedavinin yerini tutmaz. Her zaman doktorunuzun tavsiyesini alın.'**
  String get medicalDisclaimerDesc;

  /// No description provided for @agreePrivacyPolicyP1.
  ///
  /// In tr, this message translates to:
  /// **''**
  String get agreePrivacyPolicyP1;

  /// No description provided for @agreePrivacyPolicyP2.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik Politikası\'nı okudum, kabul ediyorum ve sağlık profilim için veri işlenmesine onay veriyorum.'**
  String get agreePrivacyPolicyP2;

  /// No description provided for @confirmMedicalDisclaimer.
  ///
  /// In tr, this message translates to:
  /// **'Yukarıda sunulan Tıbbi Uyarıyı okuduğumu ve anladığımı onaylıyorum.'**
  String get confirmMedicalDisclaimer;

  /// No description provided for @getStarted.
  ///
  /// In tr, this message translates to:
  /// **'Başla'**
  String get getStarted;

  /// No description provided for @dataSecurityLabel.
  ///
  /// In tr, this message translates to:
  /// **'VERİLERİNİZ GÜVENDE • KVKK UYUMLU'**
  String get dataSecurityLabel;

  /// No description provided for @fillAllFieldsError.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen tüm profil alanlarını doldurun (cinsiyet ve meslek dahil).'**
  String get fillAllFieldsError;

  /// No description provided for @acceptAgreementsError.
  ///
  /// In tr, this message translates to:
  /// **'Devam etmek için lütfen tüm sözleşmeleri kabul edin.'**
  String get acceptAgreementsError;

  /// No description provided for @onboardingTitle1.
  ///
  /// In tr, this message translates to:
  /// **'Oturmak Size Ağrı mı Veriyor?'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In tr, this message translates to:
  /// **'Modern ofis yaşam tarzı genellikle uzun süreli oturmaya neden olur, bu da boyun, sırt ve omuz ağrılarına yol açabilir.'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In tr, this message translates to:
  /// **'DeskRelief ile Tanışın, Dijital Çözümünüz'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In tr, this message translates to:
  /// **'DeskRelief, oturma aralarını bölmek ve ağrıyı en aza indirmek için tasarlanmış, uzmanlarca hazırlanmış kişiselleştirilmiş egzersiz protokolleri sunar.'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In tr, this message translates to:
  /// **'Kas-İskelet Sağlığınızın Kontrolünü Elinize Alın'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In tr, this message translates to:
  /// **'Ağrısız bir hayata doğru kişiselleştirilmiş yolculuğunuza başlayın. Kolay ve klinik tabanlıdır.'**
  String get onboardingDesc3;

  /// No description provided for @next.
  ///
  /// In tr, this message translates to:
  /// **'İleri'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In tr, this message translates to:
  /// **'Atla'**
  String get skip;

  /// No description provided for @signInTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hoş Geldiniz'**
  String get signInTitle;

  /// No description provided for @signInSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Yolculuğunuza devam etmek için giriş yapın.'**
  String get signInSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In tr, this message translates to:
  /// **'ad@sirket.com'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In tr, this message translates to:
  /// **'Şifre'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In tr, this message translates to:
  /// **'••••••••'**
  String get passwordHint;

  /// No description provided for @forgotPassword.
  ///
  /// In tr, this message translates to:
  /// **'Şifremi Unuttum'**
  String get forgotPassword;

  /// No description provided for @signInButton.
  ///
  /// In tr, this message translates to:
  /// **'Giriş Yap'**
  String get signInButton;

  /// No description provided for @dontHaveAccount.
  ///
  /// In tr, this message translates to:
  /// **'Hesabınız yok mu? '**
  String get dontHaveAccount;

  /// No description provided for @signUpLink.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt Ol'**
  String get signUpLink;

  /// No description provided for @signUpTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hesap Oluştur'**
  String get signUpTitle;

  /// No description provided for @signUpSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Daha sağlıklı bir çalışma hayatı için bize katılın.'**
  String get signUpSubtitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ad Soyad'**
  String get fullNameLabel;

  /// No description provided for @fullNameHint.
  ///
  /// In tr, this message translates to:
  /// **'Ahmet Yılmaz'**
  String get fullNameHint;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In tr, this message translates to:
  /// **'Şifreyi Onayla'**
  String get confirmPasswordLabel;

  /// No description provided for @haveAccount.
  ///
  /// In tr, this message translates to:
  /// **'Zaten hesabınız var mı? '**
  String get haveAccount;

  /// No description provided for @signInLink.
  ///
  /// In tr, this message translates to:
  /// **'Giriş Yap'**
  String get signInLink;

  /// No description provided for @welcomeTo.
  ///
  /// In tr, this message translates to:
  /// **'Hoş Geldiniz'**
  String get welcomeTo;

  /// No description provided for @signInTagline.
  ///
  /// In tr, this message translates to:
  /// **'Duruşunuzu düzeltin, daha derin nefes alın ve daha iyi çalışın.'**
  String get signInTagline;

  /// No description provided for @orContinueWith.
  ///
  /// In tr, this message translates to:
  /// **'VEYA ŞUNUNLA DEVAM ET'**
  String get orContinueWith;

  /// No description provided for @google.
  ///
  /// In tr, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @apple.
  ///
  /// In tr, this message translates to:
  /// **'Apple'**
  String get apple;

  /// No description provided for @signUpButton.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt Ol'**
  String get signUpButton;

  /// No description provided for @invalidEmailError.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir e-posta girin'**
  String get invalidEmailError;

  /// No description provided for @invalidPasswordError.
  ///
  /// In tr, this message translates to:
  /// **'En az 6 karakter'**
  String get invalidPasswordError;

  /// No description provided for @signInSuccess.
  ///
  /// In tr, this message translates to:
  /// **'Giriş Başarılı!'**
  String get signInSuccess;

  /// No description provided for @enterNameError.
  ///
  /// In tr, this message translates to:
  /// **'Adınızı girin'**
  String get enterNameError;

  /// No description provided for @passwordsDoNotMatchError.
  ///
  /// In tr, this message translates to:
  /// **'Şifreler eşleşmiyor'**
  String get passwordsDoNotMatchError;

  /// No description provided for @termsOfService.
  ///
  /// In tr, this message translates to:
  /// **'Hizmet Şartları'**
  String get termsOfService;

  /// No description provided for @acceptTermsError.
  ///
  /// In tr, this message translates to:
  /// **'Devam etmek için lütfen şartları kabul edin.'**
  String get acceptTermsError;

  /// No description provided for @agreeTermsP1.
  ///
  /// In tr, this message translates to:
  /// **''**
  String get agreeTermsP1;

  /// No description provided for @agreeTermsP2.
  ///
  /// In tr, this message translates to:
  /// **', '**
  String get agreeTermsP2;

  /// No description provided for @agreeTermsP3.
  ///
  /// In tr, this message translates to:
  /// **' ve '**
  String get agreeTermsP3;

  /// No description provided for @agreeTermsP4.
  ///
  /// In tr, this message translates to:
  /// **' şartlarını kabul ediyorum.'**
  String get agreeTermsP4;

  /// No description provided for @flareUp.
  ///
  /// In tr, this message translates to:
  /// **'Flare Up'**
  String get flareUp;

  /// No description provided for @navHome.
  ///
  /// In tr, this message translates to:
  /// **'Ana Sayfa'**
  String get navHome;

  /// No description provided for @navCalendar.
  ///
  /// In tr, this message translates to:
  /// **'Takvim'**
  String get navCalendar;

  /// No description provided for @navProfile.
  ///
  /// In tr, this message translates to:
  /// **'Profil'**
  String get navProfile;

  /// No description provided for @exclusionCriteriaHeader.
  ///
  /// In tr, this message translates to:
  /// **'Güvenli bir deneyim için sağlık durumunuz kritiktir. Mevcut durumunuzda bir değişiklik olduysa lütfen aşağıyı güncelleyiniz.'**
  String get exclusionCriteriaHeader;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In tr, this message translates to:
  /// **'Geçersiz e-posta adresi.'**
  String get errorInvalidEmail;

  /// No description provided for @errorUserDisabled.
  ///
  /// In tr, this message translates to:
  /// **'Bu kullanıcı hesabı devre dışı bırakılmış.'**
  String get errorUserDisabled;

  /// No description provided for @errorUserNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Bu e-posta adresiyle kayıtlı kullanıcı bulunamadı.'**
  String get errorUserNotFound;

  /// No description provided for @errorWrongPassword.
  ///
  /// In tr, this message translates to:
  /// **'Hatalı şifre.'**
  String get errorWrongPassword;

  /// No description provided for @errorEmailAlreadyInUse.
  ///
  /// In tr, this message translates to:
  /// **'Bu e-posta adresi zaten kullanımda.'**
  String get errorEmailAlreadyInUse;

  /// No description provided for @errorOperationNotAllowed.
  ///
  /// In tr, this message translates to:
  /// **'Bu işlem şu an için izinli değil.'**
  String get errorOperationNotAllowed;

  /// No description provided for @errorWeakPassword.
  ///
  /// In tr, this message translates to:
  /// **'Şifre çok zayıf.'**
  String get errorWeakPassword;

  /// No description provided for @errorNetworkRequestFailed.
  ///
  /// In tr, this message translates to:
  /// **'Ağ bağlantısı hatası oluştu.'**
  String get errorNetworkRequestFailed;

  /// No description provided for @errorUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Beklenmedik bir hata oluştu. Lütfen tekrar deneyin.'**
  String get errorUnknown;

  /// No description provided for @routineTitle.
  ///
  /// In tr, this message translates to:
  /// **'Boyun ve Alt Sırt Rutini'**
  String get routineTitle;

  /// No description provided for @duration15Min.
  ///
  /// In tr, this message translates to:
  /// **'15 Dakika'**
  String get duration15Min;

  /// No description provided for @exercises10.
  ///
  /// In tr, this message translates to:
  /// **'10 Hareket'**
  String get exercises10;

  /// No description provided for @intensityMedium.
  ///
  /// In tr, this message translates to:
  /// **'Orta Yoğunluk'**
  String get intensityMedium;

  /// No description provided for @motivationTagline.
  ///
  /// In tr, this message translates to:
  /// **'GAZA GETİREN'**
  String get motivationTagline;

  /// No description provided for @motivationQuote.
  ///
  /// In tr, this message translates to:
  /// **'\"Duruşunu düzelt, hayatını değiştir!\"'**
  String get motivationQuote;

  /// No description provided for @workoutFlow.
  ///
  /// In tr, this message translates to:
  /// **'Antrenman Akışı'**
  String get workoutFlow;

  /// No description provided for @remainingExercises.
  ///
  /// In tr, this message translates to:
  /// **'Kalan: {count} Hareket'**
  String remainingExercises(int count);

  /// No description provided for @phase1.
  ///
  /// In tr, this message translates to:
  /// **'FAZ 1: MOBİLİZASYON (ROM)'**
  String get phase1;

  /// No description provided for @phase2.
  ///
  /// In tr, this message translates to:
  /// **'FAZ 2: GÜÇLENDİRME'**
  String get phase2;

  /// No description provided for @phase3.
  ///
  /// In tr, this message translates to:
  /// **'FAZ 3: ESNEME'**
  String get phase3;

  /// No description provided for @phase4.
  ///
  /// In tr, this message translates to:
  /// **'FAZ 4: SOĞUMA'**
  String get phase4;

  /// No description provided for @priority.
  ///
  /// In tr, this message translates to:
  /// **'Öncelikli'**
  String get priority;

  /// No description provided for @mobility.
  ///
  /// In tr, this message translates to:
  /// **'Mobilite'**
  String get mobility;

  /// No description provided for @warmup.
  ///
  /// In tr, this message translates to:
  /// **'Isınma'**
  String get warmup;

  /// No description provided for @strength.
  ///
  /// In tr, this message translates to:
  /// **'Güç'**
  String get strength;

  /// No description provided for @stretching.
  ///
  /// In tr, this message translates to:
  /// **'Esneme'**
  String get stretching;

  /// No description provided for @cooldown.
  ///
  /// In tr, this message translates to:
  /// **'Soğuma'**
  String get cooldown;

  /// No description provided for @locked.
  ///
  /// In tr, this message translates to:
  /// **'Kilitli'**
  String get locked;

  /// No description provided for @waitingWarmup.
  ///
  /// In tr, this message translates to:
  /// **'Isınma bekleniyor'**
  String get waitingWarmup;

  /// No description provided for @markAsCompleted.
  ///
  /// In tr, this message translates to:
  /// **'Tamamlandı olarak İşaretle'**
  String get markAsCompleted;

  /// No description provided for @howToDo.
  ///
  /// In tr, this message translates to:
  /// **'Nasıl Yapılır?'**
  String get howToDo;

  /// No description provided for @importantWarnings.
  ///
  /// In tr, this message translates to:
  /// **'Önemli Uyarılar'**
  String get importantWarnings;

  /// No description provided for @generalTips.
  ///
  /// In tr, this message translates to:
  /// **'Genel İpuçları'**
  String get generalTips;

  /// No description provided for @focusArea.
  ///
  /// In tr, this message translates to:
  /// **'Odak Bölgesi'**
  String get focusArea;

  /// No description provided for @watchVideo.
  ///
  /// In tr, this message translates to:
  /// **'Videoyu İzle'**
  String get watchVideo;

  /// No description provided for @videoLoading.
  ///
  /// In tr, this message translates to:
  /// **'Video yükleniyor...'**
  String get videoLoading;

  /// No description provided for @videoError.
  ///
  /// In tr, this message translates to:
  /// **'Video yüklenirken bir hata oluştu.'**
  String get videoError;

  /// No description provided for @videoRetry.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Dene'**
  String get videoRetry;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
