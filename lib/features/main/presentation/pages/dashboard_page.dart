import 'dart:ui';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DashboardPage — High-fidelity Dashboard based on premium mockup
// ─────────────────────────────────────────────────────────────────────────────
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ─── Header Spacing ──────────────────────────────────────────────
          SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.top + 20)), 


          // ─── Content ──────────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // 1. Welcome Section
                const _WelcomeSection(),
                const SizedBox(height: 28),

                // 2. Progress Section
                const _ProgressSection(),
                const SizedBox(height: 24),

                // 3. Clinical Warning
                const _ClinicalWarningSection(),
                const SizedBox(height: 24),

                // 4. Clinical Info Card
                const _ClinicalInfoCard(),
                const SizedBox(height: 32),

                // 5. Spinal Health Tips
                const _SpinalHealthTipsHeader(),
                const SizedBox(height: 16),
                const _TipsGrid(),
                const SizedBox(height: 32),

                // 6. Daily Program Card
                const _DailyProgramHero(),
                
                // Footer spacing for Bottom Nav Bar
                const SizedBox(height: 120),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-widgets for Dashboard
// ─────────────────────────────────────────────────────────────────────────────

// Header removed as per user request

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GÜNAYDIN',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Merhaba, Ali Ahmet',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _ProgressSection extends StatelessWidget {
  const _ProgressSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '4 HAFTALIK GELİŞİM',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '68% ',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: 'Tamamlandı',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.analytics_rounded,
                color: theme.colorScheme.primary,
                size: 28,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Container(
                  height: 10,
                  width: double.infinity,
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                ),
                FractionallySizedBox(
                  widthFactor: 0.68,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withValues(alpha: 0.7),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ClinicalWarningSection extends StatelessWidget {
  const _ClinicalWarningSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const amber = Color(0xFFFFBF00);
    const amberBg = Color(0xFFFFF8E1);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: amberBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: amber.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: amber.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.warning_rounded,
              color: amber,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KLİNİK UYARI',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: amber,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bu program tıbbi bir tanı veya tedavi aracı değildir. Ağrı hissederseniz hemen durun ve doktora danışın.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: amber.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ClinicalInfoCard extends StatelessWidget {
  const _ClinicalInfoCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primary,
            primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.medical_services_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Klinik Hatırlatıcı',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Bugün seansa hazır mısınız?',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SpinalHealthTipsHeader extends StatelessWidget {
  const _SpinalHealthTipsHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Omurga Sağlığı Tavsiyeleri',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Tümünü Gör',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _TipsGrid extends StatelessWidget {
  const _TipsGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TipItem(
          icon: Icons.chair_rounded,
          color: Colors.blue,
          title: 'Ergonomi',
          subtitle: 'Masa yüksekliğini dirsek açınıza göre ayarlayın.',
        ),
        const SizedBox(height: 12),
        _TipItem(
          icon: Icons.rebase_edit,
          color: Colors.green,
          title: 'Hareketlilik',
          subtitle: 'Her 30 dakikada bir omuzlarınızı dairesel hareketlerle çevirin.',
        ),
        const SizedBox(height: 12),
        _TipItem(
          icon: Icons.self_improvement_rounded,
          color: Colors.purple,
          title: 'Bel Sağlığı',
          subtitle: 'Koltuk bel kavisini destekleyen yastık kullanın.',
        ),
      ],
    );
  }
}

class _TipItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const _TipItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyProgramHero extends StatelessWidget {
  const _DailyProgramHero();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GÜNLÜK PROGRAM',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'Kas-iskelet odaklı iyileşme',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    'AKTİF',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _AnatomicalCard(
                  title: 'Boyun',
                  subtitle: 'BÖLGE 1',
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuB1H5ulPZUOi4hQ4_vfCMwI1kSBkbdD39gmsI_0imvZvY9ajZ6pUNMwGTzu6JGoyvXnbJHcIlixXUD-w6kNVG9rvzz9f5MNk0HXgm_F9EdY1FKL8Uni_9hFrLy6Q5dnhA6xQifDqRNnoC0OxIDJPjGoyr--QiqUHd47Z0gNBY0UHXqY-4diDjhTuZwBB7GvXXRdx0a96ERxqMgJNyocMfhsTwgG9tobS78S8FVouzcOR4NSdMFvqRJ_8zUmh9r3nJAbZIvCzNPAN1s',
                ),
              ),
              Expanded(
                child: _AnatomicalCard(
                  title: 'Alt Sırt',
                  subtitle: 'BÖLGE 2',
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBOOU-gX3r8f79tFTQ_nRO2sIAK2OIyApWXfUssnfslDBA_eQLfKhUCGY6_3IXkCTysVC2BfcXO1LkleLz6RlthsO0OBvQjMcglmxeAfZvw68EKVhX1EkVKCvZmVE7sUpHEWiIiYjDjt_nCMuTZQ_tYvqBXUSJU-m_d59uRqPXE-8alqsaNWF9H1uU2RW3O98_zLPVftwwS7AGLzcHJ7fkFLoEI55kpv-L2V-XUn-jaFEB4V1d1FysX67VESLLYMXXHU-lwSH3dC1o',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primary,
                      primary.withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Antrenmana Başla',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.play_circle_fill_rounded, color: Colors.white, size: 28),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _AnatomicalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const _AnatomicalCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 10,
              letterSpacing: 1.0,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
