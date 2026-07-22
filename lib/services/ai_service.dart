import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiService {
  static Future<Map<String, dynamic>> analyzeResume({
    required String resumeText,
    required String selectedRole,
  }) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-lite:generateContent?key=$apiKey',
    );

    final prompt = '''
You are a career skill gap analyzer.

Analyze the resume text for the selected job role.

Selected role:
$selectedRole

Tasks:
1. Extract technical skills from the resume.
2. Identify important skills required for this job role.
3. Compare resume skills with required job role skills.
4. Return only valid JSON. Do not include markdown, explanation, or extra text.

JSON format:
{
  "extractedSkills": [],
  "requiredSkills": [],
  "matchedSkills": [],
  "missingSkills": [],
  "matchPercentage": 0,
  "suggestions": []
}

Resume text:
$resumeText
''';

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ],
        "generationConfig": {
          "responseMimeType": "application/json"
        }
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('AI API failed: \${response.body}');
    }

    final data = jsonDecode(response.body);

    final text = data['candidates'][0]['content']['parts'][0]['text'];

    return jsonDecode(text);
  }
}
