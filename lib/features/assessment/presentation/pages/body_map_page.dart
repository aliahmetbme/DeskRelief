import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../viewmodels/body_map_view_model.dart';

// Senin Kusursuz Oturan Koordinatların
final Map<String, List<Offset>> backOffsets = {
  'Boyun': [const Offset(0.50, 0.12)],
  'Sol Omuz': [const Offset(0.35, 0.22)], 
  'Sağ Omuz': [const Offset(0.65, 0.22)], 
  'Bel': [const Offset(0.50, 0.36)], 
  'Kalça': [const Offset(0.42, 0.52), const Offset(0.58, 0.52)], 
  'Sağ El/Dirsek/Bilek': [const Offset(0.68, 0.44)], 
  'Sol El/Dirsek/Bilek': [const Offset(0.32, 0.44)], 
  'Sağ Diz': [const Offset(0.59, 0.72)], 
  'Sol Diz': [const Offset(0.41, 0.72)], 
  'Sağ Ayak Bileği': [const Offset(0.58, 0.93)], 
  'Sol Ayak Bileği': [const Offset(0.42, 0.93)], 
};

final Map<String, List<Offset>> frontOffsets = {
  'Boyun': [const Offset(0.50, 0.12)],
  'Sağ Omuz': [const Offset(0.35, 0.22)],
  'Sol Omuz': [const Offset(0.65, 0.22)],
  'Bel': [const Offset(0.50, 0.40)], 
  'Kalça': [const Offset(0.42, 0.52), const Offset(0.58, 0.52)], 
  'Sağ El/Dirsek/Bilek': [const Offset(0.31, 0.44)], 
  'Sol El/Dirsek/Bilek': [const Offset(0.69, 0.44)], 
  'Sağ Diz': [const Offset(0.41, 0.72)], 
  'Sol Diz': [const Offset(0.59, 0.72)], 
  'Sağ Ayak Bileği': [const Offset(0.42, 0.93)],
  'Sol Ayak Bileği': [const Offset(0.58, 0.93)],
};

class BodyMapPage extends StatelessWidget {
  const BodyMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Ağrı Bölgesi Seçimi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryLight, // Veya AppColors.primary
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimaryLight, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Consumer<BodyMapViewModel>(
          builder: (context, viewModel, child) {
            final bool hasSelection = viewModel.selectedRegions.isNotEmpty;

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 160),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Modern Switcher (Buton yerine)
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoSlidingSegmentedControl<int>(
                          backgroundColor: Colors.black.withOpacity(0.05),
                          padding: const EdgeInsets.all(4),
                          thumbColor: Colors.white,
                          groupValue: viewModel.currentStep - 1,
                          children: const {
                            0: Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Text('Arka Görünüm', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                            1: Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Text('Ön Görünüm', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                          },
                          onValueChanged: (value) {
                            if (value != null && value + 1 != viewModel.currentStep) {
                              HapticFeedback.mediumImpact();
                              viewModel.toggleStep();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ESKİ ÇALIŞAN KUSURSUZ LAYOUT YAPISI
                      AspectRatio(
                        aspectRatio: 0.8,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.black.withOpacity(0.05),
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  // BoxFit.cover ile resim çerçeveye sıfıra sıfır oturur
                                  Image.asset(
                                    viewModel.currentStep == 1
                                        ? 'assets/images/bodyImageBackMan.png'
                                        : 'assets/images/bodyImageFrontMan.png',
                                    fit: BoxFit.cover,
                                  ),
                                  
                                  // TÜM BÖLGELER İÇİN TIKLANABİLİR NOKTALAR (YENİ UX)
                                  ...viewModel.allRegions.expand((region) {
                                    final currentMap = viewModel.currentStep == 1 ? backOffsets : frontOffsets;
                                    final offsets = currentMap[region] ?? <Offset>[];
                                    final isSelected = viewModel.selectedRegions.contains(region);

                                    return offsets.map((offset) {
                                      const double touchSize = 48.0; // Tıklama alanı büyük
                                      const double visualSize = 18.0; // Görsel nokta boyutu

                                      return Positioned(
                                        left: constraints.maxWidth * offset.dx - (touchSize / 2),
                                        top: constraints.maxHeight * offset.dy - (touchSize / 2),
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            HapticFeedback.lightImpact();
                                            viewModel.toggleRegion(region);
                                          },
                                          child: SizedBox(
                                            width: touchSize,
                                            height: touchSize,
                                            child: Center(
                                              child: AnimatedContainer(
                                                duration: const Duration(milliseconds: 200),
                                                width: isSelected ? visualSize * 1.2 : visualSize,
                                                height: isSelected ? visualSize * 1.2 : visualSize,
                                                decoration: BoxDecoration(
                                                  color: isSelected ? AppColors.primary.withOpacity(0.8) : Colors.white.withOpacity(0.8),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: isSelected ? Colors.white : AppColors.primary.withOpacity(0.5), 
                                                    width: 2
                                                  ),
                                                  boxShadow: isSelected ? [
                                                    BoxShadow(
                                                      color: AppColors.primary.withOpacity(0.5),
                                                      blurRadius: 10,
                                                      spreadRadius: 2,
                                                    )
                                                  ] : [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.1),
                                                      blurRadius: 4,
                                                    )
                                                  ],
                                                ),
                                                child: isSelected ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  }).toList(),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ALT KISIM: YENİ CHIP LİSTESİ (Grid yerine)
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: hasSelection
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Seçilen Bölgeler',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimaryLight),
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: viewModel.selectedRegions.map((region) {
                                      return InputChip(
                                        label: Text(region, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                                        deleteIcon: const Icon(Icons.close, size: 16),
                                        onDeleted: () {
                                          HapticFeedback.lightImpact();
                                          viewModel.toggleRegion(region);
                                        },
                                        backgroundColor: Colors.white,
                                        selectedColor: AppColors.primary.withOpacity(0.1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          side: BorderSide(color: AppColors.primary.withOpacity(0.2)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )
                            : const Center(
                                child: Text(
                                  'Ağrı hissettiğiniz bölgeleri harita üzerinden dokunarak seçiniz.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, color: AppColors.textSecondary, fontStyle: FontStyle.italic),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),

                // SABİT ALT BUTON
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: CustomPrimaryButton(
                      text: 'AĞRI ŞİDDETİNİ BELİRLE',
                      icon: Icons.chevron_right,
                      onPressed: hasSelection ? viewModel.nextStep : null,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
