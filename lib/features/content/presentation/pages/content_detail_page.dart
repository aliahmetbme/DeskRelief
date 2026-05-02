import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deskrelief/features/content/domain/models/content_models.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentDetailPage extends StatelessWidget {
  final BlogPostModel blog;

  const ContentDetailPage({super.key, required this.blog});

  int _estimateReadingTime(String content) {
    final words = content.split(' ').length;
    return (words / 75).ceil(); // Average 75 words per minute
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final localeCode = Localizations.localeOf(context).languageCode;
    final loc = AppLocalizations.of(context)!;
    final readingTime = _estimateReadingTime(
      blog.getLocalizedContent(localeCode),
    );

    return Scaffold(
      body: Stack(
        children: [
          // Hero Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 400,
            child: Container(
              color: isDark ? const Color(0xFF1E293B) : Colors.grey.shade200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    blog.imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 48,
                        color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black26],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 370)),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  ),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 40,
                        offset: const Offset(0, -10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category & Reading Time
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              blog
                                  .getLocalizedCategory(localeCode)
                                  .toUpperCase(),
                              style: GoogleFonts.manrope(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: theme.colorScheme.primary,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            loc.readingTime(readingTime),
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Title
                      Text(
                        blog.getLocalizedTitle(localeCode),
                        style: GoogleFonts.manrope(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Content Body
                      Text(
                        blog.getLocalizedContent(localeCode),
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          height: 1.8,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),

                      // Citations
                      if (blog.citations != null &&
                          blog.citations!.isNotEmpty) ...[
                        const SizedBox(height: 64),
                        Text(
                          loc.references,
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...blog.citations!.map(
                          (citation) => _CitationCard(citation: citation),
                        ),
                      ],
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (isDark ? Colors.black : Colors.white).withValues(
                      alpha: 0.7,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: (isDark ? Colors.white : Colors.black).withValues(
                        alpha: 0.05,
                      ),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: isDark ? Colors.white : Colors.black,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CitationCard extends StatelessWidget {
  final BlogCitation citation;

  const _CitationCard({required this.citation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            final url = Uri.parse(citation.url);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.08),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.link_rounded,
                    size: 22,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        citation.title,
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        citation.url,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
