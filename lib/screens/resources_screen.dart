import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/roles_data.dart';
import '../models/role_model.dart';
import '../theme.dart';

class ResourcesScreen extends StatefulWidget {
  final RoleModel? initialRole;
  const ResourcesScreen({super.key, this.initialRole});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  RoleModel? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole;
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not launch $urlString')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgSurface,
      appBar: AppBar(
        backgroundColor: AppTheme.bgSurface,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.bgLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.borderDim),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppTheme.textSecondary, size: 16),
          ),
        ),
        title: Text('Learning Resources',
            style: GoogleFonts.syne(
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
                fontSize: 17)),
      ),
      body: Column(
        children: [
          // Horizontal Role Selector
          Container(
            height: 120, // Increased height to prevent bottom overflow
            decoration: const BoxDecoration(
              color: AppTheme.bgCard,
              border: Border(bottom: BorderSide(color: AppTheme.borderDim)),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: RolesData.roles.length,
              itemBuilder: (context, index) {
                final role = RolesData.roles[index];
                final isSelected = _selectedRole?.id == role.id;
                final accentColor = AppTheme.roleColors[index % AppTheme.roleColors.length];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRole = role;
                    });
                  },
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? accentColor.withValues(alpha: 0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isSelected ? accentColor : AppTheme.borderDim, width: isSelected ? 2 : 1),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(role.icon, style: const TextStyle(fontSize: 24)),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Center(
                            child: Text(
                              role.title,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.dmSans(
                                fontSize: 10,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? accentColor : AppTheme.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          Expanded(
            child: _selectedRole == null 
              ? Center(
                  child: Text('Select a role to view resources',
                    style: GoogleFonts.dmSans(color: AppTheme.textHint, fontSize: 16)),
                )
              : _buildResourcesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesList() {
    final role = _selectedRole!;
    final index = RolesData.roles.indexOf(role);
    final accentColor = AppTheme.roleColors[index % AppTheme.roleColors.length];

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(role.icon, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role.title,
                    style: GoogleFonts.syne(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
                  ),
                  Text(
                    'Curated learning path',
                    style: GoogleFonts.dmSans(fontSize: 13, color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text('Recommended Materials', style: GoogleFonts.syne(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
        const SizedBox(height: 16),
        ...role.resources.entries.map((entry) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppTheme.bgCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.borderDim),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.bgSurface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  entry.key.toLowerCase().contains('youtube') ? Icons.play_circle_fill_rounded : Icons.menu_book_rounded,
                  color: accentColor,
                ),
              ),
              title: Text(entry.key, style: GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 15, color: AppTheme.textPrimary)),
              subtitle: Text(entry.value, style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.textHint), maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: const Icon(Icons.open_in_new_rounded, color: AppTheme.textHint, size: 20),
              onTap: () => _launchUrl(entry.value),
            ),
          );
        }),
      ],
    );
  }
}
