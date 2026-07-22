import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../theme.dart';
import 'roles_screen.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool _isLoading = true;
  bool _picking = false;
  String? _savedResumeText;

  @override
  void initState() {
    super.initState();
    _fetchResume();
  }

  Future<void> _fetchResume() async {
    if (user == null) return;
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      if (doc.exists) {
        final data = doc.data();
        setState(() {
          _savedResumeText = data?['resumeText'] as String?;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickAndUploadFile() async {
    setState(() => _picking = true);
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'pdf'],
        withData: true,
      );
      if (result == null || result.files.isEmpty) {
        setState(() => _picking = false);
        return;
      }
      final file = result.files.first;
      final bytes = file.bytes;
      if (bytes == null) {
        setState(() => _picking = false);
        return;
      }
      
      String content = '';
      if (file.name.toLowerCase().endsWith('.pdf')) {
        try {
          final PdfDocument document = PdfDocument(inputBytes: bytes);
          final PdfTextExtractor extractor = PdfTextExtractor(document);
          final StringBuffer buffer = StringBuffer();
          for (int i = 0; i < document.pages.count; i++) {
            buffer.write(extractor.extractText(startPageIndex: i, endPageIndex: i));
            buffer.write(' ');
          }
          document.dispose();
          content = buffer.toString();
        } catch (e) {
          content = file.name;
        }
      } else {
        content = String.fromCharCodes(bytes);
      }

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'resumeText': content,
      });

      setState(() {
        _savedResumeText = content;
        _picking = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Resume uploaded successfully!')));
      }

    } catch (e) {
      setState(() => _picking = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _deleteResume() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'resumeText': FieldValue.delete(),
      });
      setState(() {
        _savedResumeText = null;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Resume deleted.')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text('Manage Resume',
            style: GoogleFonts.syne(
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
                fontSize: 17)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.purple))
          : Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Resume Profile',
                    style: GoogleFonts.syne(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Upload your resume to automatically analyze your skills against top job roles without uploading repeatedly.',
                    style: GoogleFonts.dmSans(
                      color: AppTheme.textSecondary,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  if (_savedResumeText == null) ...[
                    GestureDetector(
                      onTap: _picking ? null : _pickAndUploadFile,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                          color: AppTheme.bgCard,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppTheme.purple.withValues(alpha: 0.5), width: 1.5),
                        ),
                        child: _picking
                            ? Column(
                                children: [
                                  const CircularProgressIndicator(color: AppTheme.purple, strokeWidth: 2),
                                  const SizedBox(height: 12),
                                  Text('Uploading and processing...',
                                      style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.textSecondary)),
                                ],
                              )
                            : Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppTheme.purple.withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.upload_file_rounded, color: AppTheme.purple, size: 36),
                                  ),
                                  const SizedBox(height: 16),
                                  Text('Tap to upload your resume',
                                      style: GoogleFonts.dmSans(fontSize: 16, color: AppTheme.purple, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _formatBadge('PDF', AppTheme.danger),
                                      const SizedBox(width: 8),
                                      _formatBadge('TXT', AppTheme.purple),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ] else ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppTheme.bgCard,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppTheme.success.withValues(alpha: 0.4), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.success.withValues(alpha: 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.success.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check_circle_rounded, color: AppTheme.success, size: 36),
                          ),
                          const SizedBox(height: 16),
                          Text('Resume Uploaded!',
                              style: GoogleFonts.syne(fontSize: 20, color: AppTheme.textPrimary, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 8),
                          Text('Your skills are securely stored for analysis.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.textSecondary)),
                          
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: _picking ? null : _pickAndUploadFile,
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    side: const BorderSide(color: AppTheme.purple),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                  ),
                                  child: _picking 
                                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                                    : Text('Update', style: GoogleFonts.dmSans(color: AppTheme.purple, fontWeight: FontWeight.w600, fontSize: 15)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: _deleteResume,
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    side: const BorderSide(color: AppTheme.danger),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                  ),
                                  child: Text('Delete', style: GoogleFonts.dmSans(color: AppTheme.danger, fontWeight: FontWeight.w600, fontSize: 15)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const RolesScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.purple,
                                foregroundColor: AppTheme.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                elevation: 0,
                              ),
                              child: Text('Analyze Roles', style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _formatBadge(String label, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Text(label,
            style: GoogleFonts.dmSans(
                fontSize: 11, color: color, fontWeight: FontWeight.w700)),
      );
}
