import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/role_model.dart';
import '../services/ai_service.dart';
import '../theme.dart';
import 'results_screen.dart';

class AnalyzerScreen extends StatefulWidget {
  final RoleModel role;
  const AnalyzerScreen({super.key, required this.role});

  @override
  State<AnalyzerScreen> createState() => _AnalyzerScreenState();
}

class _AnalyzerScreenState extends State<AnalyzerScreen> {
  bool _analyzing = false;
  bool _fetching = true;
  String? _fileContent;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchResume();
  }

  Future<void> _fetchResume() async {
    if (user == null) return;
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      if (doc.exists) {
        final data = doc.data();
        setState(() {
          _fileContent = data?['resumeText'] as String?;
          _fetching = false;
        });
      } else {
        setState(() => _fetching = false);
      }
    } catch (e) {
      setState(() => _fetching = false);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to load resume: $e')));
      }
    }
  }

  void _analyze() async {
    if (_fileContent == null) return;
    setState(() => _analyzing = true);

    try {
      final result = await AiService.analyzeResume(
        resumeText: _fileContent!,
        selectedRole: widget.role.title,
      );
      if (!mounted) return;
      setState(() => _analyzing = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultsScreen(role: widget.role, aiResult: result),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _analyzing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to analyze: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final roleIndex = [
      'web_dev',
      'flutter_dev',
      'data_analyst',
      'ui_ux',
      'backend_dev',
      'ml_engineer'
    ].indexOf(widget.role.id);
    final accentColor = AppTheme
        .roleColors[roleIndex < 0 ? 0 : roleIndex % AppTheme.roleColors.length];

    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      appBar: AppBar(
        backgroundColor: AppTheme.bgLight,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.bgSurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.borderDim),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppTheme.textSecondary, size: 16),
          ),
        ),
        title: Text('Analyze Skills',
            style: GoogleFonts.syne(
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
                fontSize: 17)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Role banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.bgCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accentColor.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(
                      color: accentColor.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 6)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(widget.role.icon,
                        style: const TextStyle(fontSize: 28)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.role.title,
                            style: GoogleFonts.syne(
                                color: AppTheme.textPrimary,
                                fontSize: 17,
                                fontWeight: FontWeight.w700)),
                        Text(
                            '${widget.role.requiredSkills.length} required skills',
                            style: GoogleFonts.dmSans(
                                color: AppTheme.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Required skills
            Text('Required Skills',
                style: GoogleFonts.syne(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.bgCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderDim),
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.role.requiredSkills
                    .map((s) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: accentColor.withValues(alpha: 0.25)),
                          ),
                          child: Text(s,
                              style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: accentColor,
                                  fontWeight: FontWeight.w600)),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 32),

            // Resume Status
            Text('Resume Status',
                style: GoogleFonts.syne(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary)),
            const SizedBox(height: 12),

            if (_fetching)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 36),
                decoration: BoxDecoration(
                  color: AppTheme.bgCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderDim),
                ),
                child: const Column(
                  children: [
                    CircularProgressIndicator(
                        color: AppTheme.purple, strokeWidth: 2),
                    SizedBox(height: 12),
                    Text('Checking resume...'),
                  ],
                ),
              )
            else if (_fileContent != null)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                decoration: BoxDecoration(
                    color: AppTheme.bgCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: AppTheme.success.withValues(alpha: 0.5),
                        width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.success.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ]),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.success.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_circle_rounded,
                          color: AppTheme.success, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Resume Ready',
                              style: GoogleFonts.syne(
                                  fontSize: 16,
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text('Your stored resume will be used for analysis.',
                              style: GoogleFonts.dmSans(
                                  fontSize: 12, color: AppTheme.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppTheme.bgCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: AppTheme.danger.withValues(alpha: 0.5),
                      width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.danger.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.error_outline_rounded,
                          color: AppTheme.danger, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('No Resume Found',
                              style: GoogleFonts.syne(
                                  fontSize: 16,
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text(
                              'Please upload your resume in the Manage Resume section first.',
                              style: GoogleFonts.dmSans(
                                  fontSize: 12, color: AppTheme.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 32),

            // Analyze button
            GestureDetector(
              onTap: _fileContent == null || _analyzing || _fetching
                  ? null
                  : _analyze,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: _fileContent == null || _fetching
                      ? AppTheme.bgSurface
                      : accentColor,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: _fileContent != null && !_fetching
                      ? [
                          BoxShadow(
                              color: accentColor.withValues(alpha: 0.35),
                              blurRadius: 20,
                              offset: const Offset(0, 6)),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: _analyzing
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                  color: AppTheme.white, strokeWidth: 2.5)),
                          const SizedBox(width: 10),
                          Text('Analyzing your resume...',
                              style: GoogleFonts.dmSans(
                                  color: AppTheme.white,
                                  fontWeight: FontWeight.w700)),
                        ],
                      )
                    : Text(
                        'Analyze Skill Gap',
                        style: GoogleFonts.dmSans(
                          color: _fileContent == null || _fetching
                              ? AppTheme.textHint
                              : AppTheme.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
