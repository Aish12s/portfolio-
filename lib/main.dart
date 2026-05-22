import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'footer.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aishwarya Suvarna Portfolio',
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.w800),
          headlineSmall: TextStyle(fontWeight: FontWeight.w700),
          titleMedium: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
          headlineSmall: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
          titleMedium: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      home: PortfolioHomePage(
        onToggleTheme: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  // For web relative paths or specific schemes, we try to launch
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    // Fallback for relative asset paths (common in Flutter Web)
    try {
      await launchUrl(uri);
    } catch (e) {
      debugPrint('Could not launch $url');
    }
  }
}

class PortfolioHomePage extends StatelessWidget {
  const PortfolioHomePage({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 900;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 48 : 18,
            vertical: 24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderSection(),
                  const SizedBox(height: 24),
                  if (isWide)
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: MainColumn()),
                        SizedBox(width: 20),
                        Expanded(flex: 2, child: SideColumn()),
                      ],
                    )
                  else ...[
                    const MainColumn(),
                    const SizedBox(height: 16),
                    const SideColumn(),
                  ],
                  const SizedBox(height: 24),
                  FooterSection(
                    onToggleTheme: onToggleTheme,
                    isDarkMode: isDarkMode,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HEADER
// ─────────────────────────────────────────────

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 700;

    final intro = Column(
      crossAxisAlignment:
      isCompact ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Aishwarya Subhash Suvarna',
          textAlign: isCompact ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.white,
            fontSize: isCompact ? 26 : 38,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Technical Consultant  ·  Flutter · NetSuite · Angular · React',
          textAlign: isCompact ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          alignment: isCompact ? WrapAlignment.center : WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          children: const [
            ContactChip(
              icon: Icons.phone,
              label: '+91 9930391895',
              url: 'tel:+919930391895',
            ),
            ContactChip(
              icon: Icons.email,
              label: 'aishwaryasuvarna16@gmail.com',
              url: 'mailto:aishwaryasuvarna16@gmail.com',
            ),
            ContactChip(
              icon: Icons.code,
              label: 'GitHub',
              url: 'https://github.com/Aish12s',
            ),
            ContactChip(
              icon: Icons.insights,
              label: 'LeetCode',
              url: 'https://leetcode.com/u/aishs12/',
            ),
            ContactChip(
              icon: Icons.workspace_premium,
              label: 'HackerRank',
              url: 'https://www.hackerrank.com/profile/aishwaryasuvarn1',
            ),
            ContactChip(
              icon: Icons.description,
              label: 'Resume',
              url: "assets/files/resume.pdf",
            ),
          ],
        ),
      ],
    );

    final avatar = Container(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/image/Aishwarya_Suvarna-photo_.jpeg',
          width: 128,
          height: 128,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.white.withValues(alpha: 0.15),
            child: const Icon(Icons.person, size: 64, color: Colors.white),
          ),
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E40AF), Color(0xFF2563EB), Color(0xFF3B82F6)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x402563EB),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: EdgeInsets.all(isCompact ? 20 : 28),
      child: isCompact
          ? Column(children: [avatar, const SizedBox(height: 18), intro])
          : Row(
        children: [
          Expanded(child: intro),
          const SizedBox(width: 24),
          avatar,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MAIN COLUMN
// ─────────────────────────────────────────────

class MainColumn extends StatelessWidget {
  const MainColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ResumeSection(
          title: 'Work Experience',
          icon: Icons.work_outline,
          children: [
            TimelineItem(
              title: 'Jr. Technical Consultant',
              subtitle: 'Ventus Infotech Pvt. Ltd. (Softype Inc.)',
              trailing: 'Nov 2023 – Aug 2025',
              url:
              'https://drive.google.com/file/d/1CGcgDiPQQkOILzCozoC6IT7_SeFHbRlq/view?usp=sharing',
              bullets: [
                BulletItem(text: 'Customized NetSuite using SuiteScript 2.0 — Client Scripts, User Event Scripts, Suitelets, and Map/Reduce scripts.'),
                BulletItem(text: 'Designed advanced PDF/HTML templates for invoices, purchase orders, and receipts with structured tax breakdowns.'),
                BulletItem(text: 'Built workflows and field-level scripts to automate record updates, validations, and business processes.'),
                BulletItem(text: 'Integrated NetSuite with third-party systems using RESTful APIs for real-time synchronization.'),
                BulletItem(text: 'Implemented a Flutter mobile app that connects to NetSuite through secure POST requests.'),
                BulletItem(text: 'Optimized legacy scripts and Suitelets for faster load times and improved maintainability.'),
              ],
            ),
            TimelineItem(
              title: 'SDE Intern',
              subtitle: 'CRISIL Ltd.',
              trailing: 'Jan 2023 – Jul 2023',
              url:
              'https://drive.google.com/file/d/1NNl_C7G10-yATlLtc5SNPkZ-Yk1jxV0B/view?usp=sharing',
              bullets: [
                BulletItem(text: 'Registered and deployed reports in the frontend BI platform for UAT.'),
                BulletItem(text: 'Streamlined data analysis procedures, reducing processing time by 20%.'),
                BulletItem(text: 'Developed Angular screens from wireframes with drill-down data visualization flows.'),
                BulletItem(text: 'Created report tables with filters, validation, and clear visualization techniques.'),
                BulletItem(text: 'Identified and resolved complex frontend issues in the UAT platform.'),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        ResumeSection(
          title: 'Projects',
          icon: Icons.rocket_launch_outlined,
          children: [
            TimelineItem(
              title: 'Seeker — Search Engine',
              subtitle: 'Python · Flask · ReactJS · HTML · CSS',
              trailing: 'Sep – Dec 2022',
              url: 'https://github.com/Aish12s/retrival',
              bullets: [
                BulletItem(text: 'Developed a comprehensive web scraping strategy to collect structured website data for easy search and retrieval.'),
                BulletItem(text: 'Led a team of 3 members from planning through implementation.'),
              ],
            ),
            TimelineItem(
              title: 'APT — Your Personal Trainer',
              subtitle: 'Dart · Android Studio · Machine Learning',
              trailing: 'Jun – Aug 2022',
              url: 'https://github.com/Aish12s/Apt',
              bullets: [
                BulletItem(text: 'Built an app using single-person pose estimation to assess exercise effectiveness.'),
                BulletItem(text: 'Collaborated in a team of 3 to design, develop, and test the mobile experience.'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// SIDE COLUMN
// ─────────────────────────────────────────────

class SideColumn extends StatelessWidget {
  const SideColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ResumeSection(
          title: 'Education',
          icon: Icons.school_outlined,
          children: [
            InfoBlock(
              title: 'SIES College of Management Studies',
              detail: 'M.C.A. – Computer Applications\nCGPA: 7.75 / 10.00',
              meta: '2021 – 2023  ·  Navi Mumbai',
              logo: 'assets/image/siescoms.png',
            ),
            InfoBlock(
              title: 'Vidyalankar School of Information Technology',
              detail: 'B.Sc. – Information Technology\nCGPA: 7.43 / 10.00',
              meta: '2018 – 2021  ·  Mumbai',
              logo: 'assets/image/vsit.png',
            ),
          ],
        ),
        SizedBox(height: 16),
        ResumeSection(
          title: 'Technical Skills',
          icon: Icons.memory_outlined,
          children: [
            SkillGroup(
              title: 'Languages',
              skills: [
                'Python', 'JavaScript', 'Node.js', 'Java',
                'Dart', 'HTML', 'CSS', 'C#',
              ],
            ),
            SkillGroup(
              title: 'Frameworks',
              skills: ['Angular', 'React', 'Flutter', 'Spring Boot', 'ASP.NET'],
            ),
            SkillGroup(
              title: 'Databases',
              skills: ['SQL Server', 'MySQL', 'MongoDB', 'Stored Procedures'],
            ),
            SkillGroup(
              title: 'Tools',
              skills: ['Git', 'Bitbucket', 'NetSuite', 'Pentaho', 'RESTful APIs'],
            ),
          ],
        ),
        SizedBox(height: 16),
        ResumeSection(
          title: 'Certifications',
          icon: Icons.verified_outlined,
          children: [
            InfoBlock(
              title: 'Foundations: Data, Data, Everywhere',
              detail: 'Google  ·  97.28 / 100',
              meta: '28 Sep 2021',
              url: 'https://coursera.org/share/7bfcbdd62c96008ee5c3f1a5bd3e492b',
            ),
            InfoBlock(
              title: 'The Complete 2023 Web Development Bootcamp',
              detail: 'Udemy  ·  HTML · CSS · JS · Node.js · React · MongoDB',
              meta: '30 Aug 2023',
              url: 'https://www.udemy.com/certificate/UC-2954f305-e7cc-4a26-bafc-50c4fe17367d/',
            ),
            InfoBlock(
              title: 'Introduction to Programming in Python',
              detail: 'Microsoft Technology Associate',
              meta: '20 Jan 2020',
            ),
            InfoBlock(
              title: 'NPTEL Cloud Computing',
              detail: 'Elite  ·  68%',
              meta: 'Jul – Oct 2022',
              url: 'https://drive.google.com/file/d/1noDZiZ_baMPzf7dIrufvUO0bbSHdp-Xg/view',
            ),
          ],
        ),
        SizedBox(height: 16),
        ResumeSection(
          title: 'Extracurricular',
          icon: Icons.volunteer_activism_outlined,
          children: [
            InfoBlock(
              title: 'Deepshika — A Trust for Cancer Care',
              detail: "Participated in a Cancer Patients' Support Walkathon",
              meta: '4 Feb 2023',
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// SECTION CARD
// ─────────────────────────────────────────────

class ResumeSection extends StatelessWidget {
  const ResumeSection({
    super.key,
    required this.title,
    required this.children,
    this.icon,
  });

  final String title;
  final List<Widget> children;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon,
                      size: 18, color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 10),
              ],
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Divider(color: Theme.of(context).dividerColor, height: 20),
          ...children,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TIMELINE ITEM (ANIMATED ON HOVER)
// ─────────────────────────────────────────────

class BulletItem {
  final String text;
  final String? url;
  const BulletItem({required this.text, this.url});
}

class TimelineItem extends StatefulWidget {
  const TimelineItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.bullets,
    this.url,
  });

  final String title;
  final String subtitle;
  final String trailing;
  final List<BulletItem> bullets;
  final String? url;

  @override
  State<TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<TimelineItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.only(
          bottom: 20,
          left: _isHovered ? 6 : 0, // Gentle nudge effect
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 12,
              runSpacing: 4,
              children: [
                widget.url != null
                    ? _HoverableLink(
                  onTap: () => openUrl(widget.url!),
                  child: (hovered) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: hovered
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor:
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      AnimatedOpacity(
                        opacity: hovered ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 150),
                        child: Icon(Icons.open_in_new,
                            size: 13,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                )
                    : Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: _isHovered ? 1.05 : 1.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      widget.trailing,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.subtitle,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.color
                    ?.withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            ...widget.bullets.map((b) => BulletText(item: b)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// INFO BLOCK (ANIMATED ON HOVER)
// ─────────────────────────────────────────────

class InfoBlock extends StatefulWidget {
  const InfoBlock({
    super.key,
    required this.title,
    required this.detail,
    required this.meta,
    this.url,
    this.logo,
  });

  final String title;
  final String detail;
  final String meta;
  final String? url;
  final String? logo;

  @override
  State<InfoBlock> createState() => _InfoBlockState();
}

class _InfoBlockState extends State<InfoBlock> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.only(
          bottom: 14,
          left: _isHovered ? 6 : 0, // Identical clean slide-in effect
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.logo != null) ...[
              AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: _isHovered ? 1.05 : 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    widget.logo!,
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 52,
                      height: 52,
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.school_outlined, size: 24),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.url != null
                      ? _HoverableLink(
                    onTap: () => openUrl(widget.url!),
                    child: (hovered) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            widget.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              decoration: hovered
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                              decorationColor:
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        AnimatedOpacity(
                          opacity: hovered ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 150),
                          child: Icon(Icons.open_in_new,
                              size: 13,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  )
                      : Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.detail,
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withValues(alpha: 0.8),
                      height: 1.45,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.meta,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SKILL GROUP
// ─────────────────────────────────────────────

class SkillGroup extends StatelessWidget {
  const SkillGroup({super.key, required this.title, required this.skills});

  final String title;
  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.color
                  ?.withValues(alpha: 0.7),
              fontWeight: FontWeight.w700,
              fontSize: 13,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: skills.map((s) => SkillChip(label: s)).toList(),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BULLET TEXT
// ─────────────────────────────────────────────

class BulletText extends StatelessWidget {
  const BulletText({super.key, required this.item});
  final BulletItem item;

  @override
  Widget build(BuildContext context) {
    final isLink = item.url != null;
    if (isLink) {
      return _HoverableLink(
        onTap: () => openUrl(item.url!),
        child: (hovered) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Icon(
                  Icons.circle,
                  size: 5,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item.text,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    height: 1.45,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    decoration: hovered
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    decorationColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Icon(
              Icons.circle,
              size: 5,
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.text,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color
                    ?.withValues(alpha: 0.8),
                height: 1.45,
                fontSize: 14.5,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HOVERABLE LINK HELPER
// ─────────────────────────────────────────────

class _HoverableLink extends StatefulWidget {
  const _HoverableLink({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget Function(bool hovered) child;

  @override
  State<_HoverableLink> createState() => _HoverableLinkState();
}

class _HoverableLinkState extends State<_HoverableLink> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedOpacity(
          opacity: _pressed ? 0.6 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: widget.child(_hovered),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CONTACT CHIP
// ─────────────────────────────────────────────

class ContactChip extends StatefulWidget {
  const ContactChip({
    super.key,
    required this.icon,
    required this.label,
    required this.url,
  });

  final IconData icon;
  final String label;
  final String url;

  @override
  State<ContactChip> createState() => _ContactChipState();
}

class _ContactChipState extends State<ContactChip> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => openUrl(widget.url),
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.identity()
            ..scale(_pressed ? 0.95 : 1.0, _pressed ? 0.95 : 1.0),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: _hovered
                ? Colors.white.withValues(alpha: 0.30)
                : Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered
                  ? Colors.white.withValues(alpha: 0.7)
                  : Colors.white.withValues(alpha: 0.35),
              width: _hovered ? 1.5 : 1.0,
            ),
            boxShadow: _hovered
                ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              )
            ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 16, color: Colors.white),
              const SizedBox(width: 7),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SKILL CHIP (ANIMATED BACKGROUND ON HOVER)
// ─────────────────────────────────────────────

class SkillChip extends StatefulWidget {
  const SkillChip({super.key, required this.label});
  final String label;

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final primaryContainer = Theme.of(context).colorScheme.primaryContainer;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          // Smooth color transition from faded to solid container background
          color: _isHovered
              ? primaryContainer.withValues(alpha: 0.9)
              : primaryContainer.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? primaryColor.withValues(alpha: 0.5)
                : primaryColor.withValues(alpha: 0.15),
          ),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SECTION CARD (ANIMATED LIFT & GLOW EFFECT)
// ─────────────────────────────────────────────

class SectionCard extends StatefulWidget {
  const SectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  State<SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<SectionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.08 : 0.04),
              blurRadius: _isHovered ? 28 : 16, // Lift effect
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}