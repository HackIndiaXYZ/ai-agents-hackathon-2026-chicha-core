import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bhashalens_app/features/history_saved/data/models/saved_translation.dart';
import 'package:bhashalens_app/core/theme/app_colors.dart';

class SavedTranslationsProvider extends ChangeNotifier {
  final List<SavedTranslation> _translations = [];
  List<SavedTranslation> get translations => _translations;

  void add(SavedTranslation t) {
    _translations.insert(0, t);
    notifyListeners();
  }

  void remove(SavedTranslation t) {
    _translations.remove(t);
    notifyListeners();
  }

  void toggleStar(SavedTranslation t) {
    t.isStarred = !t.isStarred;
    notifyListeners();
  }
}

class SavedTranslationsPage extends StatefulWidget {
  const SavedTranslationsPage({super.key});

  @override
  State<SavedTranslationsPage> createState() => _SavedTranslationsPageState();
}

class _SavedTranslationsPageState extends State<SavedTranslationsPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SavedTranslationsProvider>(context);
    final grouped = _groupByDate(provider.translations);
    return Scaffold(
      backgroundColor: AppColors.voidBg, // Branded Void main background
      appBar: AppBar(
        backgroundColor: AppColors.voidBg,
        elevation: 0,
        title: const Text(
          'Saved Translations',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle:
            false, // Left aligned as per iOS style often, or keep center? Mock usually has large title or inline. Let's stick to standard AppBar for now but clean.
        // Actually mock shows "Saved Translations" large below a header or just as title.
        // Let's use clean title.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surfaceDark, // Branded slate card color
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search saved translations...',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.violetAccent,
                    width: 1,
                  ),
                ),
              ),
              onChanged: (q) => setState(() => searchQuery = q),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: grouped.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date header is inside the card in the mock?
                    // Actually the mock shows "Oct 26, 2024" inside the card at the bottom.
                    // But if we want to separate by day, we can keep the header or remove it.
                    // The mock image shows individual cards with date inside.
                    // I will remove the section header if the date is in the card, to match the "list of cards" look.
                    // But grouping helps organization. I'll keep the grouping logic but maybe not show the header if it's redundant?
                    // Let's show the cards directly.
                    ...entry.value
                        .where(_matchesSearch)
                        .map((t) => _buildTranslationCard(context, t)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  bool _matchesSearch(SavedTranslation t) {
    if (searchQuery.isEmpty) return true;
    return t.originalText.toLowerCase().contains(searchQuery.toLowerCase()) ||
        t.translatedText.toLowerCase().contains(searchQuery.toLowerCase());
  }

  Map<String, List<SavedTranslation>> _groupByDate(
    List<SavedTranslation> list,
  ) {
    // We still group to sort or order, but maybe we don't need the map for sections if we don't show headers.
    // For now, let's just return the list sorted.
    // Actually, keeping the existing logic is fine, just the build method above ignored the keys mostly or we can iterate the values.
    // The previous code iterated entries and showed a header. I removed the header text from the build above.
    // So this is fine.

    // For safety, let's keep the sorting naturally by index (insertion order usually).
    // But grouping by date is good practice.
    final now = DateTime.now();
    final Map<String, List<SavedTranslation>> map = {};
    for (var t in list) {
      String label;
      if (_isSameDay(t.dateTime, now)) {
        label = 'Today';
      } else if (_isSameDay(
        t.dateTime,
        now.subtract(const Duration(days: 1)),
      )) {
        label = 'Yesterday';
      } else {
        label = DateFormat('MMM d, yyyy').format(t.dateTime);
      }
      map.putIfAbsent(label, () => []).add(t);
    }
    return map;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Widget _buildTranslationCard(BuildContext context, SavedTranslation t) {
    final provider = Provider.of<SavedTranslationsProvider>(
      context,
      listen: false,
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark, // Card color
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.borderDark,
          width: 1,
        ), // Thin border
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Language > Language and Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      t.fromLanguage,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      t.toLanguage,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => provider.toggleStar(t),
                      child: Icon(
                        Icons.bookmark,
                        color: t.isStarred
                            ? AppColors.violetAccent
                            : Colors.grey, // Blue when starred
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      // Trash
                      onTap: () => provider.remove(t),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Text Content
            Text(
              t.originalText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            // Mock indicates translated text might be the main one or secondary.
            // Usually Input -> Output.
            // Let's show Translated text with slightly different style or same.
            // If this is a history item, usually we want to see the result clearly.
            // Let's make translated text white too, maybe bold? Or just distinct.
            Text(
              t.translatedText,
              style: const TextStyle(
                color: AppColors.slate400, // Lighter grey
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Detail / Date
            Text(
              DateFormat('MMM d, yyyy').format(t.dateTime),
              style: const TextStyle(
                color: AppColors.slate500, // Dimmed date
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: AppColors.voidBg,
      selectedItemColor: AppColors.violetAccent,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_camera),
          label: 'Camera',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Voice'),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark, color: AppColors.violetAccent),
          label: 'Saved',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      currentIndex: 3,
      onTap: (i) {
        switch (i) {
          case 0:
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case 1:
            Navigator.of(context).pushReplacementNamed('/camera_translate');
            break;
          case 2:
            Navigator.of(context).pushReplacementNamed('/voice_translate');
            break;
          case 3:
            // Already on Saved
            break;
          case 4:
            Navigator.of(context).pushReplacementNamed('/settings');
            break;
        }
      },
    );
  }
}
