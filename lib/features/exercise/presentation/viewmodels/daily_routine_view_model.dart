import 'package:flutter/foundation.dart';
import '../../domain/models/exercise_model.dart';

class DailyRoutineViewModel extends ChangeNotifier {
  final List<ExerciseItem> _exercises = [
    ExerciseItem(
      id: '1',
      title: 'Boyun ROM',
      phase: ExercisePhase.mobilization,
      isLocked: false,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAyngluBd2P0xYIDidwesUiOTB4fsGMzyDAzYPbrdomQdOi96vP-oCOQeeVmo0-lAIa8ZTnRptrRXPjI69EQRCLbLFUV-7YTWCihdEsBU1pbsoDbxmKOAH2n6_3Z6HFpiwU_pA4JEoStEKV8SfKDFnCsmwi-dBr_UInJeelESEGVrQdkejz9hqq50BpjiJIsO7EQ09tFXM9ZfzNfjzPqkK7kNxgirE2V4yvHAlQSB2Z0tfWaDdXPcxwCzunHJd3HLcOGPpLXZugMoE',
      reps: 12,
      tags: ['Mobilite', 'Isınma'],
      videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ),
    ExerciseItem(
      id: '5',
      title: 'Kedi-İnek Esnetmesi',
      phase: ExercisePhase.mobilization,
      isLocked: false,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDd1FO4P4g5lzGGhw0dA9c8_b69ZrDW31SRffg8ZWfuiuzQLrCfNpEmnKcWiaRMTnSs7Dj-E7rI6MWzSSwPFkDuiuenG71KxUF7fV8zBn3tMgc2pAA_hF9U4teQhTv6mq_Z8tpCB4uznz6YQw_VomqA4WFUlUqiX4iZgScS2f_Q-q2osFpfNXx2GENgdQYD4q7HwQSy1VTKqodV1t7PC4795i14Nd1Nrfvx7hlbWG8HduabD53UWvCxqMA-Vqv657A8ozpFVo_bF0o',
      duration: '5 Dakika',
      tags: ['ROM'],
      instructions: [
        'Ellerinizi ve dizlerinizi yere koyun.',
        'Nefes alırken sırtınızı çukurlaştırın ve yukarı bakın.',
        'Nefes verirken sırtınızı kamburlaştırın.',
      ],
      warnings: [
        'Hareketi nefesle uyumlu, yavaş ve tam kontrollü bir şekilde gerçekleştirin.',
        'Keskin bir ağrı hissettiğiniz an durun ve asla eklemlerinizi zorlamayın.',
      ],
      tips: [
        'Hareketi yavaş ve kontrollü yapın.',
        'Nefesinizi tutmayın.',
      ],
      focusArea: 'Omurga & Sırt',
      focusDescription: 'Esneklik ve Duruş Düzeltme',
    ),
    ExerciseItem(
      id: '2',
      title: 'Skapular Retraksiyon',
      phase: ExercisePhase.strengthening,
      isLocked: true,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDabggjlM8ZpffCZ2rkDDSQgMEZVLg0LzGUIX4XrFei1R6CmQHpmlpMWQB4ZiGuupG2OkD9UscegBM4ECpsy6tFDi3RgF4PmnTIuZilIULS0QSLdCZh7xIt91TIBupoUKpLJtM0k8CIaygNRQfxYQA2pOoygXAFE4Cc9ImIiiZAZqvwLxMmw-CNRcNxlbFECBEKQOm6sUxGCn5J0n3iu5b3-Cc3giU6Iwfai-S5S8F-EP_KirlIiEfpfL1IoLWAErCAFL4iZ3efAT4',
      tags: ['Güç'],
    ),
    ExerciseItem(
      id: '3',
      title: 'Trapez Germe',
      phase: ExercisePhase.stretching,
      isLocked: true,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDF1gfqK5m7SF7NBFj2x7Gig6lnKvtEf6bcfLC6Rc2KwaK1OJBI1frB75ZHQXJenQEqs63ZBBQ2duSSoS7fLv_3MTDfUeClc7UqcGfoTj9IY42UyZZBlxdD3zYXrnRLZamML98I6qBk8C8ikg1PDCR74XN2S_XWRUO490Vj1rkmbmQ8C5LWofituCTqnSMANE5usN0GeeF5rPqhhPWYErZZ9CN8GANbRnWx4xlZXMJOgnP1OB19ZjUEZsPKyl2XvP09zH_6EBShJno',
      tags: ['Esneme'],
    ),
    ExerciseItem(
      id: '4',
      title: 'Derin Nefes ve Gevşeme',
      phase: ExercisePhase.coolDown,
      isLocked: true,
      imageUrl: '', // Will use icon in UI
      duration: '2 Dakika',
      tags: ['Soğuma'],
    ),
  ];

  List<ExerciseItem> get exercises => _exercises;

  int get remainingExercisesCount => _exercises.where((e) => e.isLocked).length;

  void onExerciseTap(ExerciseItem exercise) {
    if (exercise.isLocked) return;
    // Navigation will be handled in the UI layer using a callback or similar if needed,
    // but typically we can navigate directly if we have context.
    // For MVVM, we might just expose an event.
  }
}
