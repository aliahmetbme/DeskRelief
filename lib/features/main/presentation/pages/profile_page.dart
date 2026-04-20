import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ProfilePage — High-fidelity User Profile based on premium mockup
// Header removed as per user request
// ─────────────────────────────────────────────────────────────────────────────
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                // 1. User Hero Section
                const _UserHeroSection(),
                const SizedBox(height: 32),

                // 2. Stats Grid
                const _StatsGrid(),
                const SizedBox(height: 40),

                // 3. Settings List
                const _SettingsHeader(),
                const SizedBox(height: 16),
                const _SettingsList(),
                
                // 4. Logout Button
                const SizedBox(height: 32),
                const _LogoutButton(),
                
                // version
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'DeskRelief v2.4.1',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                
                // Footer spacing
                const SizedBox(height: 140),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// Sub-widgets removed since header is gone
// ─────────────────────────────────────────────────────────────────────────────

class _UserHeroSection extends StatelessWidget {
  const _UserHeroSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 110,
                height: 110,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [primary, const Color(0xFF10B981).withValues(alpha: 0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBHKIY-lZhG0TXhBQfE32FgR2VBOWf59pdUYxsF5cF3Ar2u7EFADR3m1qoGoged9-NPLacRVuQOpEwdJZF6IjvMx_CEWToTGy2G9pOSJKqC8cGr4O3mhcjiigiR7B9vJ-bhm6EYcnlgC_PRWfqHXMO55C2SaxHuwGXPbfuCvVbKL1gNjIT_rYqUYFE6qeDhHQa0W37OFylpkq98vy-64FJ_nSbkRSiDmzoJI1s44qMvdm4NIZpFAOB8XRxvS2ujkEc2jO0TNxTB8zY'
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
                    child: const Icon(Icons.verified_rounded, color: Colors.white, size: 14),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Can Yılmaz',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _UserTag(label: '32 Yaşında'),
              SizedBox(width: 8),
              _UserTag(label: 'Sedanter Çalışan', icon: Icons.desktop_windows_rounded),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserTag extends StatelessWidget {
  final String label;
  final IconData? icon;
  const _UserTag({required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.timer_rounded,
            color: Colors.blue,
            value: '4.2 Saat',
            label: 'Günlük Ortalama Oturma',
            status: 'AKTİF',
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            icon: Icons.bolt_rounded,
            color: Colors.orange,
            value: '12 GÜN',
            label: 'Egzersiz Serisi',
            status: 'BAŞARI',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;
  final String status;

  const _StatCard({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
    required this.status,
  });

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
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 22),
              Text(
                status,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: color,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        'HESAP AYARLARI',
        style: theme.textTheme.labelSmall?.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}

class _SettingsList extends StatelessWidget {
  const _SettingsList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          _SettingsItem(icon: Icons.person_rounded, title: 'Kişisel Bilgiler', color: theme.colorScheme.primary),
          _Separator(),
          const _SettingsItem(icon: Icons.gavel_rounded, title: 'KVKK / GDPR Onayı', color: Color(0xFF10B981)),
          _Separator(),
          const _SettingsItem(icon: Icons.description_rounded, title: 'EULA (Kullanım Sözleşmesi)', color: Colors.orange),
          _Separator(),
          const _SettingsItem(icon: Icons.lock_rounded, title: 'Gizlilik Politikası', color: Colors.grey),
          _Separator(),
          _SettingsItem(icon: Icons.assignment_ind_rounded, title: 'Dışlama Kriterleri', color: theme.colorScheme.primary),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.2)),
          ],
        ),
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Divider(height: 1, thickness: 1, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.03)),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          backgroundColor: theme.colorScheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: theme.colorScheme.error, size: 20),
            const SizedBox(width: 12),
            Text(
              'Oturumu Kapat',
              style: TextStyle(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
