// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DeskRelief';

  @override
  String get language => 'Language';

  @override
  String get turkish => 'Turkish';

  @override
  String get english => 'English';

  @override
  String greetingKeepGoing(String name) {
    return 'Keep Going, $name';
  }

  @override
  String get feedbackStart =>
      'Great time to start the day! Complete your first session.';

  @override
  String get feedbackStep => 'Good step for a start! Keep going.';

  @override
  String get feedbackHalfway => 'You\'re halfway there, doing great!';

  @override
  String get feedbackAlmostDone => 'Almost finished! Just a few sessions left.';

  @override
  String get feedbackDone =>
      'Congratulations! You successfully completed today\'s plan.';

  @override
  String get planCompleted => 'Plan Completed';

  @override
  String feedbackRemainingSessions(String feedback, int remaining) {
    return '$feedback $remaining sessions left for today.';
  }

  @override
  String get clinicalWarningTitle => 'CLINICAL WARNING';

  @override
  String get clinicalWarningDesc =>
      'This program is not a medical diagnostic or treatment tool. If you feel pain, stop immediately and consult a doctor.';

  @override
  String get clinicalReminderTitle => 'Clinical Reminder';

  @override
  String get clinicalReminderDesc => 'Are you ready for the session today?';

  @override
  String get spinalHealthTipsTitle => 'Spinal Health Tips';

  @override
  String get seeAll => 'See All';

  @override
  String get tipErgonomicsTitle => 'Ergonomics';

  @override
  String get tipErgonomicsDesc =>
      'Adjust your desk height according to your elbow angle.';

  @override
  String get tipMobilityTitle => 'Mobility';

  @override
  String get tipMobilityDesc =>
      'Rotate your shoulders in circular motions every 30 minutes.';

  @override
  String get tipLowerBackTitle => 'Lower Back Health';

  @override
  String get tipLowerBackDesc =>
      'Use a cushion that supports your lower back curve.';

  @override
  String get dailyProgramTitle => 'DAILY PROGRAM';

  @override
  String get dailyProgramDesc => 'Musculoskeletal focused recovery';

  @override
  String get statusActive => 'ACTIVE';

  @override
  String get statusSuccess => 'SUCCESS';

  @override
  String get regionNeck => 'Neck';

  @override
  String get regionLabel1 => 'REGION 1';

  @override
  String get regionLowerBack => 'Lower Back';

  @override
  String get regionLabel2 => 'REGION 2';

  @override
  String get startWorkout => 'Start Workout';

  @override
  String userAge(String age) {
    return '$age Years Old';
  }

  @override
  String get sedentaryWorker => 'Sedentary Worker';

  @override
  String get dailyAverageSitting => 'Daily Avg Sitting';

  @override
  String hoursValue(String hours) {
    return '$hours Hours';
  }

  @override
  String get exerciseStreak => 'Exercise Streak';

  @override
  String daysValue(String days) {
    return '$days DAYS';
  }

  @override
  String get accountSettings => 'ACCOUNT SETTINGS';

  @override
  String get personalInfo => 'Personal Information';

  @override
  String get gdprConsent => 'GDPR Consent';

  @override
  String get eula => 'EULA';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get exclusionCriteria => 'Exclusion Criteria';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get logout => 'Log Out';

  @override
  String get calendarClinicalProgram => 'CLINICAL PROGRAM';

  @override
  String get calendarExerciseSchedule => 'Exercise Schedule';

  @override
  String get calendarDesc =>
      'Your program prepared according to physiotherapy principles is fixed. Please follow the scheduled times for maximum efficiency.';

  @override
  String get physioNoteTitle => 'Physiotherapist Note';

  @override
  String get physioNoteDesc =>
      'Exercises at scheduled times are critical for spinal adaptation. Mon-Wed-Fri cycle is ideal.';

  @override
  String get dayDetailTitle => 'Day Details';

  @override
  String get startTime => 'START TIME';

  @override
  String get totalDuration => 'TOTAL DURATION';

  @override
  String get focusRegions => 'FOCUS REGIONS';

  @override
  String get regionCervicalSpine => 'Cervical Spine';

  @override
  String get regionTrapezius => 'Trapezius Muscles';

  @override
  String get regionScapularStability => 'Scapular Stability';

  @override
  String get programContent => 'Program Content';

  @override
  String exerciseCount(int count) {
    return '$count EXERCISES';
  }

  @override
  String get exerciseNeckIsometric => 'Neck Isometric Strengthening';

  @override
  String get exerciseScapularRetraction => 'Scapular Retraction';

  @override
  String get schedulingTitle => 'Program Scheduling';

  @override
  String get schedulingStart => 'Start My Program';

  @override
  String get clinicalAdviceTitle => 'Clinical Advice';

  @override
  String get clinicalAdviceDesc =>
      'It is recommended to leave at least 24 hours of rest between workouts for your muscle fibers to repair themselves and for posture development to be permanent.';

  @override
  String get daySelectionTitle => 'Day Selection';

  @override
  String maxDaysError(int max) {
    return 'You can select up to $max days.';
  }

  @override
  String get timingDetailsTitle => 'Timing Details';

  @override
  String get cancel => 'Cancel';

  @override
  String get workoutTimeTitle => 'Workout Time';

  @override
  String get done => 'Done';

  @override
  String get readyToStart => 'Let\'s start when you\'re ready.';

  @override
  String get month1 => 'January';

  @override
  String get month2 => 'February';

  @override
  String get month3 => 'March';

  @override
  String get month4 => 'April';

  @override
  String get month5 => 'May';

  @override
  String get month6 => 'June';

  @override
  String get month7 => 'July';

  @override
  String get month8 => 'August';

  @override
  String get month9 => 'September';

  @override
  String get month10 => 'October';

  @override
  String get month11 => 'November';

  @override
  String get month12 => 'December';

  @override
  String get day1 => 'MO';

  @override
  String get day2 => 'TU';

  @override
  String get day3 => 'WE';

  @override
  String get day4 => 'TH';

  @override
  String get day5 => 'FR';

  @override
  String get day6 => 'SA';

  @override
  String get day7 => 'SU';

  @override
  String get bodyMapTitle => 'Pain Map';

  @override
  String get bodyMapDesc =>
      'Identify the regions where you have experienced chronic pain for the last three months on the map.';

  @override
  String get front => 'Front';

  @override
  String get back => 'Back';

  @override
  String get selectedRegionsTitle => 'Selected Regions';

  @override
  String get bodyMapEmptyState =>
      'Select the regions where you feel pain by tapping on the map.';

  @override
  String get determinePainIntensity => 'DETERMINE PAIN INTENSITY';

  @override
  String get regionShoulderRight => 'Right Shoulder';

  @override
  String get regionShoulderLeft => 'Left Shoulder';

  @override
  String get regionHipPelvis => 'Hip';

  @override
  String get regionArmRight => 'Right Hand/Elbow/Wrist';

  @override
  String get regionArmLeft => 'Left Hand/Elbow/Wrist';

  @override
  String get regionKneeRight => 'Right Knee';

  @override
  String get regionKneeLeft => 'Left Knee';

  @override
  String get regionAnkleRight => 'Right Ankle';

  @override
  String get regionAnkleLeft => 'Left Ankle';

  @override
  String get noRegionSelected => 'No selected region found.';

  @override
  String get goBack => 'Go Back';

  @override
  String regionLabel(String region) {
    return '$region Region';
  }

  @override
  String get assessmentPurposeTitle => 'Assessment Purpose';

  @override
  String get assessmentPurposeDesc =>
      'Pain intensity assessment helps us objectively track your current condition and determine the most appropriate exercise intensity for you.';

  @override
  String get painAnalysisTitle => 'Pain Analysis';

  @override
  String get finishAssessment => 'FINISH ASSESSMENT';

  @override
  String get nextRegion => 'NEXT REGION';

  @override
  String get focusRegionsTitle => 'Focus Regions\nDetermined';

  @override
  String get focusRegionsDescP1 =>
      'Our algorithm has prioritized the regions with the highest pain scores: ';

  @override
  String get focusRegionsDescP2 =>
      '.\n\nFor your other regions, you can make a new assessment after completing the current program.';

  @override
  String get focusRegionsBtn => 'Okay, Continue';

  @override
  String get medicalConsultationTitle => 'Medical Consultation\nRecommendation';

  @override
  String get medicalConsultationDesc =>
      'We noticed that you reported widespread and severe pain in many different areas of your body.\n\nThis may be a symptom of \"Central Sensitization\" or a similar syndrome. We strongly advise you to consult a physician before starting any exercise program.';

  @override
  String get medicalConsultationBtn => 'I Understand';

  @override
  String get painLevelLight => 'Mild';

  @override
  String get painLevelMild => 'Mild-Moderate';

  @override
  String get painLevelModerate => 'Moderate';

  @override
  String get painLevelSevere => 'Severe';

  @override
  String get painLevelVerySevere => 'Very Severe';

  @override
  String painAnalysisLight(int val) {
    return 'Level $val is a mild pain that does not significantly affect daily life. It can improve with mobility.';
  }

  @override
  String painAnalysisMild(int val) {
    return 'Level $val is a noticeable but tolerable pain. Stretching exercises will be beneficial.';
  }

  @override
  String painAnalysisModerate(int val) {
    return 'Level $val is a moderate pain that requires attention. Strength and flexibility balance will be targeted.';
  }

  @override
  String painAnalysisSevere(int val) {
    return 'Level $val is a severe pain that restricts activities. Controlled and gentle exercises are necessary.';
  }

  @override
  String painAnalysisVerySevere(int val) {
    return 'Level $val is a very severe pain. It is important to proceed under expert supervision and rest.';
  }

  @override
  String get medicalScreeningTitle => 'Medical Screening';

  @override
  String get medicalScreeningExclusionCriteria =>
      'Exclusion Criteria: This app is for generally healthy individuals. If you answer \"Yes\" to any question, you must consult your doctor before starting an exercise program.';

  @override
  String stepTracker(int step) {
    return 'Step $step/3';
  }

  @override
  String get saveProgress => 'Save\nProgress';

  @override
  String get completeBtn => 'Complete';

  @override
  String get continueBtn => 'Continue';

  @override
  String get pleaseAnswerAllQuestions => 'Please answer all questions.';

  @override
  String get progressSaved => 'Progress saved.';

  @override
  String get medicalWarningTitle => 'Medical Warning';

  @override
  String get screeningCompletedTitle => 'Screening Completed';

  @override
  String get medicalWarningDescP1 =>
      'Your safety is important to us. Based on your answers, you should consult a healthcare professional before starting this exercise program. ';

  @override
  String get deskRelief => 'DeskRelief';

  @override
  String get medicalWarningDescP2 =>
      ' is not a medical diagnosis or treatment tool.';

  @override
  String get screeningSuccessDesc =>
      'Great! You have no medical barriers to starting the exercise program. Now we can create your customized program by selecting your pain regions.';

  @override
  String get understood => 'I Understand';

  @override
  String get qCat1 => 'Systemic and Heart Health';

  @override
  String get qCat2 => 'Musculoskeletal and Trauma';

  @override
  String get qCat3 => 'Red Flags';

  @override
  String get q1 =>
      'Do you have a history of a diagnosed stroke (brain hemorrhage/paralysis)?';

  @override
  String get q2 =>
      'Do you have heart failure, heart attack, arrhythmia, or a serious cardiovascular disease?';

  @override
  String get q3 => 'Has your doctor told you that you should not exercise?';

  @override
  String get q4 =>
      'Do you experience chest pain, shortness of breath, dizziness, or fainting at rest or during light activity?';

  @override
  String get q5 =>
      'Do you have a diagnosed serious respiratory disease? (e.g., Asthma, COPD)';

  @override
  String get q6 =>
      'Do you have a diagnosed neurological disease? (e.g., Parkinson\'s disease, Multiple sclerosis)';

  @override
  String get q7 => 'Are you currently receiving active cancer treatment?';

  @override
  String get q8 => 'Have you had surgery in the last 6 months?';

  @override
  String get q9 =>
      'Have you experienced a serious musculoskeletal injury in the last 6 months?';

  @override
  String get q10 =>
      'Have you recently experienced a health issue that required hospitalization?';

  @override
  String get q11 => 'Do you have diagnosed high blood pressure (Hypertension)?';

  @override
  String get q12 =>
      'Do you have a doctor-diagnosed herniated disc in your lower back or neck, or a knee problem?';

  @override
  String get q13 => 'Do you have pain that wakes you up from sleep at night?';

  @override
  String get q14 => 'Have you experienced unexplained weight loss?';

  @override
  String get q15 =>
      'Do you have pain that started after a recent trauma such as a fall or impact?';

  @override
  String get q16 =>
      'Are you experiencing progressive muscle weakness, numbness, or loss of sensation?';

  @override
  String get q17 =>
      'Are you pregnant or is there a possibility that you might be pregnant?';

  @override
  String get q18 =>
      'Have you previously experienced excessive pain or worsening that lasted long (more than 24-48 hours) after exercising?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get profileWelcomeTitle1 => 'Kinetic';

  @override
  String get profileWelcomeTitle2 => 'Equilibrium';

  @override
  String get profileWelcomeSubtitle =>
      'Let\'s begin your journey toward perfect alignment and effortless movement.';

  @override
  String get genderLabel => 'GENDER';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get professionLabel => 'PROFESSION';

  @override
  String get professionHint => 'e.g. Software Engineer';

  @override
  String get heightLabel => 'HEIGHT (CM)';

  @override
  String get heightHint => '180';

  @override
  String get weightLabel => 'WEIGHT (KG)';

  @override
  String get weightHint => '75';

  @override
  String get sedentaryWorkerDesc =>
      'Do you spend more than 6 hours sitting daily?';

  @override
  String get medicalDisclaimerTitle => 'Medical Disclaimer';

  @override
  String get medicalDisclaimerDesc =>
      'This app provides postural guidance and is not a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician.';

  @override
  String get agreePrivacyPolicyP1 => 'I agree to the ';

  @override
  String get agreePrivacyPolicyP2 =>
      ' and consent to data processing for my health profile.';

  @override
  String get confirmMedicalDisclaimer =>
      'I confirm that I have read and understood the Medical Disclaimer provided above.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get dataSecurityLabel => 'YOUR DATA IS SECURE • GDPR COMPLIANT';

  @override
  String get fillAllFieldsError =>
      'Please fill in all profile fields (including gender and profession).';

  @override
  String get acceptAgreementsError =>
      'Please accept all agreements to continue.';

  @override
  String get onboardingTitle1 => 'Is Sitting Causing You Pain?';

  @override
  String get onboardingDesc1 =>
      'The modern office lifestyle often leads to prolonged sitting, which can cause significant neck, back, and shoulder pain.';

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
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get signInTitle => 'Welcome Back';

  @override
  String get signInSubtitle => 'Sign in to continue your journey.';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'name@company.com';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => '••••••••';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get signInButton => 'Sign In';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get signUpLink => 'Sign Up';

  @override
  String get signUpTitle => 'Create Account';

  @override
  String get signUpSubtitle => 'Join us for a healthier work life.';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get fullNameHint => 'John Doe';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get haveAccount => 'Already have an account? ';

  @override
  String get signInLink => 'Sign In';

  @override
  String get welcomeTo => 'Welcome to';

  @override
  String get signInTagline =>
      'Align your posture, breathe deeper, and work better.';

  @override
  String get orContinueWith => 'OR CONTINUE WITH';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get signUpButton => 'Sign Up';

  @override
  String get invalidEmailError => 'Enter a valid email';

  @override
  String get invalidPasswordError => 'Minimum 6 characters';

  @override
  String get signInSuccess => 'Sign In Successful!';

  @override
  String get enterNameError => 'Enter your name';

  @override
  String get passwordsDoNotMatchError => 'Passwords do not match';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get acceptTermsError => 'Please accept terms to continue.';

  @override
  String get agreeTermsP1 => 'I agree to the ';

  @override
  String get agreeTermsP2 => ', ';

  @override
  String get agreeTermsP3 => ', and ';

  @override
  String get agreeTermsP4 => '.';

  @override
  String get flareUp => 'Flare Up';

  @override
  String get navHome => 'Home';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get navProfile => 'Profile';

  @override
  String get exclusionCriteriaHeader =>
      'Your health status is critical for a safe experience. If there have been any changes in your current status, please update below.';
}
