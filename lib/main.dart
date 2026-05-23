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
            fontSize: isCompact ? 28 : 42,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.0,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.3),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          ),
          child: Text(
            'Software Developer & Technical Consultant',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Flutter  ·  React  ·  Angular  ·  Java  ·  Spring Boot  ·  NetSuite',
          textAlign: isCompact ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
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
              icon: Icons.link,
              label: 'LinkedIn',
              url: 'https://www.linkedin.com/in/aishwarya-suvarna/',
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
              url: "assets/assets/files/resume.pdf",
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
    return Column(
      children: [
        ResumeSection(
          title: 'About Me',
          icon: Icons.person_outline,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'Full-Stack Software Developer and Technical Consultant with 2+ years of experience building production-grade web and mobile applications. Proficient in Flutter, Angular, React, Java, and NetSuite (SuiteScript 2.0). Proven track record of designing scalable systems, automating business workflows, and integrating third-party APIs. Experienced in the full software development lifecycle — from requirements and architecture to deployment and optimization.',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                  height: 1.6,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        ResumeSection(
          title: 'Work Experience',
          icon: Icons.work_outline,
          children: [
            TimelineItem(
              title: 'Jr. Software Developer / Technical Consultant',
              subtitle: 'Ventus Infotech Pvt. Ltd. (Softype Inc.)',
              trailing: 'Nov 2023 – Aug 2025',
              logo: 'assets/image/softype.jfif',
              url:
              'https://drive.google.com/file/d/1CGcgDiPQQkOILzCozoC6IT7_SeFHbRlq/view?usp=sharing',
              bullets: [
                BulletItem(text: 'Developed 10+ custom NetSuite SuiteScript 2.0 modules (Client Scripts, User Event Scripts, Suitelets, and Map/Reduce) to automate core business processes.'),
                BulletItem(text: 'Engineered dynamic PDF/HTML invoice and PO templates with structured tax breakdowns, adopted across multiple client accounts.'),
                BulletItem(text: 'Reduced manual data entry by building automated field-level validation workflows and record-update triggers.'),
                BulletItem(text: 'Integrated NetSuite with third-party platforms using RESTful APIs, enabling real-time bidirectional data sync.'),
                BulletItem(text: 'Designed and deployed a cross-platform Flutter mobile app integrated with NetSuite via secure RESTful APIs.'),
                BulletItem(text: 'Refactored legacy SuiteScript codebase, improving page load performance and long-term maintainability.'),
              ],
            ),
            TimelineItem(
              title: 'Software Developer Intern',
              subtitle: 'CRISIL Ltd.',
              trailing: 'Jan 2023 – Jul 2023',
              logo: 'assets/image/crisil.png',
              url:
              'https://drive.google.com/file/d/1NNl_C7G10-yATlLtc5SNPkZ-Yk1jxV0B/view?usp=sharing',
              bullets: [
                BulletItem(text: 'Built 5+ Angular data visualization screens from wireframes, including drill-down reports with dynamic filters.'),
                BulletItem(text: 'Reduced data processing time by 20% by streamlining ETL procedures in the BI platform.'),
                BulletItem(text: 'Deployed and validated reports in the validated UAT environment, resolving critical frontend defects pre-release.'),
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
                BulletItem(text: 'Built a full-stack search engine using Python (Flask) and ReactJS with a custom web crawler, indexer, and ranked retrieval system.'),
                BulletItem(text: 'Led a team of 3 through full SDLC — from architecture design to final deployment.'),
              ],
            ),
            TimelineItem(
              title: 'APT — Your Personal Trainer',
              subtitle: 'Dart · Android Studio · Machine Learning',
              trailing: 'Jun – Aug 2022',
              url: 'https://github.com/Aish12s/Apt',
              bullets: [
                BulletItem(text: 'Developed a Flutter/Dart mobile app using TensorFlow Lite pose estimation to provide real-time exercise feedback.'),
                BulletItem(text: 'Implemented ML model integration with on-device inference for low-latency performance.'),
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
                Skill('Python', logo: 'assets/image/Python.png'),
                Skill('JavaScript', logo: 'assets/image/images.png'),
                Skill('Node.js', logo: 'assets/image/Node.js_logo.svg.png'),
                Skill('Java', logo: 'assets/image/java.png'),
                Skill('Dart', logo: 'assets/image/dart.png'),
                Skill('HTML', logo: 'assets/image/html.png'),
                Skill('CSS', logo: 'assets/image/css.png'),
                Skill('C#', logo: 'assets/image/csharp.png'),
              ],
            ),
            SkillGroup(
              title: 'Frameworks',
              skills: [
                Skill('Angular', logo: 'assets/image/angular.png'),
                Skill('React', logo: 'assets/image/react.png'),
                Skill('Flutter', logo: 'assets/image/flutter.png'),
                Skill('Spring Boot', logo: 'assets/image/spring.png'),
                Skill('ASP.NET', logo: 'assets/image/asp.png'),
              ],
            ),
            SkillGroup(
              title: 'Databases',
              skills: [
                Skill('SQL Server', logo: 'assets/image/sqlserver.png'),
                Skill('MySQL', logo: 'assets/image/mysql.png'),
                Skill('MongoDB', logo: 'assets/image/mongodb.png'),
                Skill('Stored Procedures', logo: 'assets/image/storedprocedure.png'),
              ],
            ),
            SkillGroup(
              title: 'Tools',
              skills: [
                Skill('Git', logo: 'assets/image/git.png'),
                Skill('Bitbucket', logo: 'assets/image/bitbucket.png'),
                Skill('NetSuite', logo: 'assets/image/netsuite.png'),
                Skill('Pentaho', logo: 'assets/image/pentaho.png'),
                Skill('REST API', logo: 'assets/image/postman.png'),
                Skill('Jira', logo: 'assets/image/jira.png'),
              ],
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
    this.logo,
  });

  final String title;
  final String subtitle;
  final String trailing;
  final List<BulletItem> bullets;
  final String? url;
  final String? logo;

  @override
  State<TimelineItem> createState() => _TimelineItemState();
}

class _PortfolioTimelineLogo extends StatelessWidget {
  const _PortfolioTimelineLogo({required this.logo, required this.isHovered});
  final String logo;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: isHovered ? 1.1 : 1.0,
      child: Container(
        width: 48,
        height: 48,
        margin: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(6),
        child: Image.asset(
          logo,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.business, size: 24, color: Colors.grey),
        ),
      ),
    );
  }
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.logo != null) ...[
              _PortfolioTimelineLogo(logo: widget.logo!, isHovered: _isHovered),
              const SizedBox(width: 16),
            ],
            Expanded(
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          decoration: hovered
                                              ? TextDecoration.underline
                                              : TextDecoration.none,
                                          decorationColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                  const SizedBox(width: 4),
                                  AnimatedOpacity(
                                    opacity: hovered ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 150),
                                    child: Icon(Icons.open_in_new,
                                        size: 13,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              widget.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                      AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: _isHovered ? 1.05 : 1.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            widget.trailing,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
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
  final List<Skill> skills;

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
            children: skills.map((s) => SkillChip(skill: s)).toList(),
          ),
        ],
      ),
    );
  }
}

class Skill {
  final String label;
  final String? logo;
  const Skill(this.label, {this.logo});
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
          transform: Matrix4.diagonal3Values(
            _pressed ? 0.95 : 1.0,
            _pressed ? 0.95 : 1.0,
            1.0,
          ),
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
  const SkillChip({super.key, required this.skill});
  final Skill skill;

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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.skill.logo != null) ...[
              Image.asset(
                widget.skill.logo!,
                width: 16,
                height: 16,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              widget.skill.label,
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
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