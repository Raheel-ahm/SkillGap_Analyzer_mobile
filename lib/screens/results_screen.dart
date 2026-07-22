import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/role_model.dart';
import '../theme.dart';
import 'resources_screen.dart';

class ResultsScreen extends StatelessWidget {
  final RoleModel role;
  final Map<String, dynamic> aiResult;

  const ResultsScreen({super.key, required this.role, required this.aiResult});

  @override
  Widget build(BuildContext context) {
    final requiredSkills = List<String>.from(aiResult['requiredSkills'] ?? []);
    final matched = List<String>.from(aiResult['matchedSkills'] ?? []);
    final missing = List<String>.from(aiResult['missingSkills'] ?? []);
    final num matchPercentRaw = aiResult['matchPercentage'] ?? 0;
    final matchPercent = matchPercentRaw / 100.0;
    final suggestions = List<String>.from(aiResult['suggestions'] ?? []);

    final required = requiredSkills;

    final roleIndex = [
      'web_dev',
      'flutter_dev',
      'data_analyst',
      'ui_ux',
      'backend_dev',
      'ml_engineer'
    ].indexOf(role.id);
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
        title: Text('Skill Gap Results',
            style: GoogleFonts.syne(
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
                fontSize: 17)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Role banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.bgCard,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: accentColor.withValues(alpha: 0.25)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child:
                        Text(role.icon, style: const TextStyle(fontSize: 26)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(role.title,
                            style: GoogleFonts.syne(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textPrimary,
                                fontSize: 16)),
                        Text(
                            '${matched.length} of ${required.length} skills matched',
                            style: GoogleFonts.dmSans(
                                color: AppTheme.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                  // Score badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: accentColor.withValues(alpha: 0.3)),
                    ),
                    child: Text('${(matchPercent * 100).toInt()}%',
                        style: GoogleFonts.syne(
                            color: accentColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Match Score Alternative
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.bgCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.borderDim),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Skill Match Score',
                          style: GoogleFonts.syne(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                              fontSize: 16)),
                      Text('${(matchPercent * 100).toInt()}%',
                          style: GoogleFonts.syne(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: accentColor)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: matchPercent.toDouble(),
                      minHeight: 12,
                      backgroundColor: AppTheme.bgSurface,
                      valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _legend(accentColor, 'Acquired: ${matched.length}'),
                      _legend(AppTheme.bgSurface, 'Missing: ${missing.length}',
                          border: AppTheme.borderDim),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Skill Matrix Alternative
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.bgCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.borderDim),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Core Required Skills',
                      style: GoogleFonts.syne(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                          fontSize: 16)),
                  const SizedBox(height: 6),
                  Text('Quick overview of what the role demands',
                      style: GoogleFonts.dmSans(
                          fontSize: 12, color: AppTheme.textSecondary)),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: required.map((skill) {
                      final has = matched.contains(skill);
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: has
                              ? accentColor.withValues(alpha: 0.12)
                              : AppTheme.bgSurface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: has
                                ? accentColor.withValues(alpha: 0.3)
                                : AppTheme.borderDim,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              has
                                  ? Icons.check_circle_rounded
                                  : Icons.cancel_rounded,
                              color: has ? accentColor : AppTheme.textHint,
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(skill,
                                style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    color: has
                                        ? accentColor
                                        : AppTheme.textSecondary,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Missing skills
            if (missing.isNotEmpty) ...[
              Text('Skills to Learn',
                  style: GoogleFonts.syne(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary)),
              const SizedBox(height: 4),
              Text('Focus on these to close your gap',
                  style: GoogleFonts.dmSans(
                      fontSize: 12, color: AppTheme.textSecondary)),
              const SizedBox(height: 12),
              ...missing.asMap().entries.map((e) {
                final priority = e.key < 3
                    ? 'High'
                    : e.key < 6
                        ? 'Medium'
                        : 'Low';
                final pColor = e.key < 3
                    ? AppTheme.danger
                    : e.key < 6
                        ? AppTheme.warning
                        : AppTheme.purple;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.bgCard,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppTheme.borderDim),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: pColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text('${e.key + 1}',
                            style: GoogleFonts.syne(
                                color: pColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.value,
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                    fontSize: 14)),
                            Text('Recommended to learn',
                                style: GoogleFonts.dmSans(
                                    fontSize: 11,
                                    color: AppTheme.textSecondary)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: pColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(priority,
                            style: GoogleFonts.dmSans(
                                color: pColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                );
              }),
            ],

            // Matched skills
            if (matched.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text('Skills You Have ✓',
                  style: GoogleFonts.syne(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.bgCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: accentColor.withValues(alpha: 0.2)),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: matched
                      .map((s) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: accentColor.withValues(alpha: 0.25)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_rounded,
                                    color: accentColor, size: 13),
                                const SizedBox(width: 5),
                                Text(s,
                                    style: GoogleFonts.dmSans(
                                        fontSize: 12,
                                        color: accentColor,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],

            if (matched.isEmpty && missing.isEmpty) ...[
              const SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    const Icon(Icons.search_off_rounded,
                        size: 52, color: AppTheme.textHint),
                    const SizedBox(height: 10),
                    Text(
                      'No skills detected in your resume.\nMake sure skills are listed as plain text.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                          color: AppTheme.textSecondary,
                          fontSize: 13,
                          height: 1.6),
                    ),
                  ],
                ),
              ),
            ],

            if (suggestions.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text('AI Suggestions 💡',
                  style: GoogleFonts.syne(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.bgCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: accentColor.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: suggestions
                      .map((s) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.arrow_right_rounded,
                                    color: accentColor, size: 20),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(s,
                                      style: GoogleFonts.dmSans(
                                          fontSize: 13,
                                          color: AppTheme.textSecondary,
                                          height: 1.5)),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResourcesScreen(initialRole: role),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.success,
                  foregroundColor: AppTheme.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                  shadowColor: AppTheme.success.withValues(alpha: 0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.menu_book_rounded, size: 20),
                    const SizedBox(width: 8),
                    Text('View Learning Resources',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _legend(Color color, String label, {Color? border}) => Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: border != null ? Border.all(color: border) : null,
            ),
          ),
          const SizedBox(width: 6),
          Text(label,
              style: GoogleFonts.dmSans(
                  fontSize: 12, color: AppTheme.textSecondary)),
        ],
      );
}
