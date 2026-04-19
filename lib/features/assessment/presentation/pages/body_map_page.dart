import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_primary_button.dart';
import '../viewmodels/body_map_view_model.dart';
import '../widgets/region_card.dart';

// Yeni Hassas Koordinatlar
final Map<String, List<Offset>> backOffsets = {
  // --- ARKA GÖRÜNÜM (Arka planda vücudun merkezine odaklı) ---
  'Boyun': [const Offset(0.50, 0.12)],
  'Omuz': [const Offset(0.35, 0.22), const Offset(0.65, 0.22)], // Sol ve Sağ omuz
  'Bel': [const Offset(0.50, 0.36)], // Yukarı çekilmiş bel noktası
  'Kalça': [const Offset(0.42, 0.52), const Offset(0.58, 0.52)], 
  'Sağ El/Dirsek/Bilek': [const Offset(0.68, 0.44)], // Biraz merkeze (0.70 -> 0.68)
  'Sol El/Dirsek/Bilek': [const Offset(0.32, 0.44)], // Biraz merkeze (0.30 -> 0.32)
  'Sağ Diz': [const Offset(0.59, 0.72)], // Çok az daha sola (0.60 -> 0.59)
  'Sol Diz': [const Offset(0.41, 0.72)], // Çok az daha sağa (0.40 -> 0.41)
  'Sağ Ayak Bileği': [const Offset(0.58, 0.93)], 
  'Sol Ayak Bileği': [const Offset(0.42, 0.93)], 
};

final Map<String, List<Offset>> frontOffsets = {
  // --- ÖN GÖRÜNÜM (Ön planda vücudun merkezine odaklı) ---
  'Boyun': [const Offset(0.50, 0.12)],
  'Omuz': [const Offset(0.35, 0.22), const Offset(0.65, 0.22)],
  'Bel': [const Offset(0.50, 0.40)], // Karın bölgesi (Ön bel)
  'Kalça': [const Offset(0.42, 0.52), const Offset(0.58, 0.52)], 
  'Sağ El/Dirsek/Bilek': [const Offset(0.27, 0.44)], // Biraz merkeze (0.25 -> 0.27)
  'Sol El/Dirsek/Bilek': [const Offset(0.73, 0.44)], // Biraz merkeze (0.75 -> 0.73)
  'Sağ Diz': [const Offset(0.41, 0.72)], // Çok az daha sağa (0.40 -> 0.41)
  'Sol Diz': [const Offset(0.59, 0.72)], // Çok az daha sola (0.60 -> 0.59)
  'Sağ Ayak Bileği': [const Offset(0.42, 0.93)],
  'Sol Ayak Bileği': [const Offset(0.58, 0.93)],
};

class BodyMapPage extends StatelessWidget {
  const BodyMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      // SafeArea ve üst boşluk sorunu için resmi Status bar altında kalmaktan kurtarıyoruz:
      // extendBodyBehindAppBar ayarını kaldırıp AppBar'a solid beyaz veriyoruz.
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
            color: AppColors.primary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Consumer<BodyMapViewModel>(
          builder: (context, viewModel, child) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 160),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Son 3 ayda kronik ağrı yaşadığınız bölgeleri işaretleyiniz. (Birden fazla seçebilirsiniz)',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      AspectRatio(
                        aspectRatio: 0.8,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24.0),
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
                                  Image.asset(
                                    viewModel.currentStep == 1
                                        ? 'assets/images/bodyImageBackMan.png'
                                        : 'assets/images/bodyImageFrontMan.png',
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 16,
                                    left: 16,
                                    child: GestureDetector(
                                      onTap: viewModel.toggleStep,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.95),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          border: Border.all(
                                            color: AppColors.primary
                                                .withOpacity(0.3),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.08,
                                              ),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.flip, // Çevirme ikonu
                                              color: AppColors.primary,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              viewModel.currentStep == 1
                                                  ? 'ÖN GÖRÜNÜME GEÇ'
                                                  : 'ARKA GÖRÜNÜME GEÇ',
                                              style: const TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  ...viewModel.selectedRegions
                                      .expand((region) {
                                        // Hangi görünümdeysek onun offset map'ini kullanıyoruz
                                        final currentMap = viewModel.currentStep == 1 ? backOffsets : frontOffsets;
                                        final offsets = currentMap[region] ?? <Offset>[];
                                        
                                        return offsets.map((offset) {
                                          const double pointSize = 20.0;

                                          return Positioned(
                                            left: constraints.maxWidth * offset.dx - (pointSize / 2),
                                            top: constraints.maxHeight * offset.dy - (pointSize / 2),
                                            child: TweenAnimationBuilder<double>(
                                              tween: Tween<double>(begin: 0, end: 1),
                                              duration: const Duration(milliseconds: 300),
                                              curve: Curves.elasticOut,
                                              builder: (context, value, child) {
                                                return Transform.scale(
                                                  scale: value,
                                                  child: Container(
                                                    width: pointSize,
                                                    height: pointSize,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.secondary.withOpacity(0.4),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(color: AppColors.secondary, width: 2),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: AppColors.secondary.withOpacity(0.6),
                                                          blurRadius: 10,
                                                          spreadRadius: 2,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: Container(
                                                        width: pointSize * 0.4,
                                                        height: pointSize * 0.4,
                                                        decoration: const BoxDecoration(
                                                          color: AppColors.secondary,
                                                          shape: BoxShape.circle,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
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

                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.3,
                            ),
                        itemCount: viewModel.allRegions.length,
                        itemBuilder: (context, index) {
                          final region = viewModel.allRegions[index];
                          final isSelected = viewModel.selectedRegions.contains(
                            region,
                          );

                          return RegionCard(
                            title: region,
                            isSelected: isSelected,
                            onTap: () => viewModel.toggleRegion(region),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          offset: const Offset(0, -10),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: CustomPrimaryButton(
                      text: 'SEÇİMLERİ KAYDET',
                      icon: Icons.check_circle,
                      onPressed: viewModel.nextStep,
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
