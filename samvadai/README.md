# SamvadAI 🚀

SamvadAI is a complete, production-ready, clean-architecture multilingual AI-powered mobile application designed specifically for India's diverse linguistic ecosystem. It features low-latency translations, context-aware AI assistants, offline communication capabilities, and custom-tailored accessibility-first layouts.

---

## 🎨 Visual Identity & Theme System

SamvadAI leverages a stunning AI-native dark-mode first design inspired by advanced neural interfaces:

*   **Background Void:** `#020318` (The deep space theme backdrop)
*   **Indigo Primary:** `#1A1654` (Deep rich navy blue for layout structures)
*   **Violet Accent:** `#818CF8` (Electric glow for primary interactions)
*   **Amber AI Highlight:** `#F59E0B` (Glowing warm gold for active AI states and microphones)
*   **Teal Translation Accent:** `#0D9488` (Vibrant teal for translation indicators)
*   **Warm White:** `#F5F4F5` (High readability soft headings text)

---

## 🏗️ Folder Structure (Clean Architecture)

```
lib/
│
├── core/                        # Central configurations, routes, and services
│   ├── accessibility/           # Screen-readers and text scaling services
│   ├── constants/               # Global assets, strings, and keys
│   ├── network/                 # Dio client API wrappers
│   ├── routes/                  # GoRouter navigation controllers
│   ├── storage/                 # Hive local database cache configuration
│   └── theme/                   # AppColors and AppTheme definitions
│
├── agents/                      # AI Multi-Agent logic definitions
│   ├── translation_agent/       # Multilingual and Code-Mixed translations
│   ├── speech_agent/            # Audio processing and TTS/STT hooks
│   ├── context_agent/           # Healthcare, Education, Governance modes
│   ├── feedback_agent/          # Dynamic reinforcement alignment correction logs
│   ├── offline_agent/           # Local language pack status databases
│   └── accessibility_agent/     # Readability layout and touch area scales
│
├── shared/                      # Global reusable components and widgets
│   ├── widgets/                 # Glowing buttons, chips, waveforms, mic buttons
│   └── components/              # Shell routing navigation scaffolding
│
└── features/                    # Independent modules with custom views
    ├── splash/                  # Animated canvas entry logo
    ├── onboarding/              # Multi-slide onboarding instructions
    ├── authentication/          # Mobile OTP and Google SSO access
    ├── home/                    # Central active agents dashboard
    ├── translation/             # Precise text translator cards
    ├── voice_translation/       # Dual-language live spoken wave boards
    ├── ai_assistant/            # Domain context cognitive chatbot
    ├── offline_mode/            # Offline packs installer dictionaries
    ├── adaptive_learning/       # Alignment submission dashboards
    ├── accessibility_center/    # Touch size and ElderMode configuration toggles
    └── profile/                 # Conversation graphs and settings logs
```

---

## 🛠️ Technology Stack

1.  **State Management:** `hooks_riverpod` + `flutter_hooks` (Modern reactive states)
2.  **Navigation:** `go_router` (Clean declaration-first routes)
3.  **Local Storage:** `hive_flutter` + `hive` (High performance binary caching)
4.  **Network Client:** `dio` (Scale-ready interceptors and timeouts)
5.  **Typography:** `google_fonts` (Sora display headings & Georgia body serif)
6.  **Animations:** `flutter_animate` (Super-smooth neural glowing widgets and waves)
7.  **Voice Systems:** `speech_to_text` + `flutter_tts` (Interactive voice synthesis)
8.  **Adaptive Scaling:** `responsive_framework` (Flawless tablet and phone responsiveness)

---

## 🤖 Multi-Agent AI System

SamvadAI divides operations across six dedicated AI agents running asynchronously:

1.  **Translation Agent:** Direct translation interface with auto-language detection and code-mixed (Hinglish/Tanglish) parsing.
2.  **Speech Agent:** Speech signal-to-noise cleaner, live acoustic transcripts, and natural-sounding synthesis.
3.  **Context Agent:** Swaps application prompt context dynamically depending on topic detection (Healthcare vs Education vs Governance).
4.  **Feedback Agent:** Local storage loop enabling direct alignment corrections based on user corrections.
5.  **Offline Agent:** Install manager controlling local language dictionary packs and fallback emergency dictionaries.
6.  **Accessibility Agent:** Automates button region scales, speech-first guides, and elderly cognitive interface simplifications.

---

## 🚀 Execution & Verification

To run or analyze the codebase:

```bash
# Get pub dependencies
flutter pub get

# Run strict Dart analyzer checks
flutter analyze

# Run unit tests
flutter test

# Start the application on a connected device
flutter run
```
