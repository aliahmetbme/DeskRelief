import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../viewmodels/auth_view_model.dart';
import '../../domain/models/user_model.dart';
import '../../../../core/widgets/custom_primary_button.dart';

class ClinicalBlockPage extends StatelessWidget {
  const ClinicalBlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final authVM = context.watch<AuthViewModel>();
    final user = authVM.currentUser;

    if (user == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final reason = user.banReason;
    
    // Ban nedenine göre ikon, başlık ve açıklama belirle
    final reasonData = _getReasonData(reason, loc);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Arka Plan Dekoru
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withValues(alpha: 0.05),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  
                  // Üst İkon (Tıbbi Güven Sembolü)
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLowest,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.medical_services_rounded,
                      size: 64,
                      color: theme.colorScheme.primary,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Ana Başlıklar
                  Text(
                    loc.clinicalBlockTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    loc.clinicalBlockSubtitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Dinamik Bilgi Kartı (Ban Sebebi)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(reasonData.icon, size: 24, color: theme.colorScheme.error),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                reasonData.title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          reasonData.description,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Ek Bilgi
                  Text(
                    loc.clinicalBlockDescription,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Aksiyon Butonları
                  CustomPrimaryButton(
                    text: loc.clinicalBlockContactBtn,
                    icon: Icons.picture_as_pdf_rounded,
                    onPressed: () {
                      // Gelecekte PDF Rapor Oluşturma
                    },
                  ),
                  
                  const SizedBox(height: 12),

                  CustomPrimaryButton(
                    text: loc.btnReevaluate,
                    icon: Icons.refresh_rounded,
                    onPressed: () => authVM.checkClinicalStatus(context, user),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  TextButton.icon(
                    onPressed: () => authVM.signOut(),
                    icon: const Icon(Icons.logout_rounded),
                    label: Text(loc.clinicalBlockLogoutBtn),
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.error,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _ClinicalReasonInfo _getReasonData(BanReason? reason, AppLocalizations loc) {
    switch (reason) {
      case BanReason.redFlag:
        return _ClinicalReasonInfo(
          title: loc.reasonRedFlag,
          description: loc.descRedFlag,
          icon: Icons.warning_amber_rounded,
        );
      case BanReason.centralSensitization:
        return _ClinicalReasonInfo(
          title: loc.reasonCentralSensitization,
          description: loc.descCentralSensitization,
          icon: Icons.psychology_rounded,
        );
      case BanReason.extremePain:
        return _ClinicalReasonInfo(
          title: loc.reasonExtremePain,
          description: loc.descExtremePain,
          icon: Icons.bolt_rounded,
        );
      case BanReason.maxFlareUpStrike:
        return _ClinicalReasonInfo(
          title: loc.reasonMaxFlareUpStrike,
          description: loc.descMaxFlareUpStrike,
          icon: Icons.history_rounded,
        );
      case BanReason.therapeuticResistance:
        return _ClinicalReasonInfo(
          title: loc.reasonTherapeuticResistance,
          description: loc.descTherapeuticResistance,
          icon: Icons.trending_up_rounded,
        );
      case BanReason.chronicLimit:
        return _ClinicalReasonInfo(
          title: loc.reasonChronicLimit,
          description: loc.descChronicLimit,
          icon: Icons.hourglass_empty_rounded,
        );
      case BanReason.persistentFlareUp:
        return _ClinicalReasonInfo(
          title: loc.reasonPersistentFlareUp,
          description: loc.descPersistentFlareUp,
          icon: Icons.timer_off_rounded,
        );
      default:
        return _ClinicalReasonInfo(
          title: loc.clinicalWarningTitle,
          description: loc.clinicalBlockDescription,
          icon: Icons.info_outline_rounded,
        );
    }
  }
}

class _ClinicalReasonInfo {
  final String title;
  final String description;
  final IconData icon;

  _ClinicalReasonInfo({
    required this.title,
    required this.description,
    required this.icon,
  });
}
