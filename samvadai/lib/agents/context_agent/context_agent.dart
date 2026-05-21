import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ContextMode { general, healthcare, education, governance }

class ContextAgent {
  final Map<ContextMode, List<String>> _domainKeywords = {
    ContextMode.healthcare: ['hospital', 'doctor', 'medicine', 'pain', 'illness', 'treatment', 'clinic', 'dawai', 'bukhar'],
    ContextMode.education: ['school', 'teacher', 'class', 'homework', 'syllabus', 'college', 'shiksha', 'pariksha'],
    ContextMode.governance: ['scheme', 'aadhaar', 'pension', 'ration', 'subsidy', 'panchayat', 'yojana', 'sarkari']
  };

  ContextMode detectContext(String text) {
    final lower = text.toLowerCase();
    for (var entry in _domainKeywords.entries) {
      for (var keyword in entry.value) {
        if (lower.contains(keyword)) {
          return entry.key;
        }
      }
    }
    return ContextMode.general;
  }

  String getSystemPrompt(ContextMode mode) {
    switch (mode) {
      case ContextMode.healthcare:
        return 'You are an Indian medical translation assistant. Focus on medical terminologies, symptoms, and clear healthcare instructions.';
      case ContextMode.education:
        return 'You are an academic translation assistant. Focus on high-clarity definitions, curriculum concepts, and regional educational terms.';
      case ContextMode.governance:
        return 'You are a public schemes service assistant. Provide highly accurate information regarding Indian citizen schemes, policies, and documentation.';
      case ContextMode.general:
        return 'You are SamvadAI, a multilingual conversational assistant tailored for regional Indian environments.';
    }
  }
}

final contextAgentProvider = Provider<ContextAgent>((ref) {
  return ContextAgent();
});
