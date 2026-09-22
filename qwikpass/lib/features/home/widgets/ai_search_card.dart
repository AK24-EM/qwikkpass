import 'package:flutter/material.dart';
import 'package:qwikpass/core/theme/app_theme.dart';

class AISearchCard extends StatelessWidget {
  const AISearchCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAISearchModal(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.accentPurple.withOpacity(0.2),
              AppTheme.cardDark,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.accentPurple.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // AI Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.accentPurple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.auto_awesome,
                color: AppTheme.accentPurple,
                size: 20,
              ),
            ),

            const SizedBox(width: 16),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TELL ME WHAT YOU\'RE IN THE MOOD FOR',
                    style: AppTheme.monospaceSmall(context).copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'AI-powered event discovery',
                    style: AppTheme.monospaceXSmall(context).copyWith(
                      color: AppTheme.textTertiary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(
              Icons.arrow_forward,
              size: 20,
              color: AppTheme.accentPurple,
            ),
          ],
        ),
      ),
    );
  }

  void _showAISearchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AISearchModal(),
    );
  }
}

class AISearchModal extends StatefulWidget {
  const AISearchModal({Key? key}) : super(key: key);

  @override
  State<AISearchModal> createState() => _AISearchModalState();
}

class _AISearchModalState extends State<AISearchModal> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _suggestions = [
    'Heavy metal show this weekend',
    'Stand-up comedy near me',
    'Bollywood movies tonight',
    'Cricket match next week',
    'Acoustic night with food',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.borderGray,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: AppTheme.accentPurple,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'AI SEARCH',
                          style: AppTheme.monospaceSmall(context).copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      color: AppTheme.textSecondary,
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Text(
                  'Describe what you\'re looking for in plain English',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                ),

                const SizedBox(height: 16),

                // Search input
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.cardDark,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.accentPurple.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'e.g., "Progressive rock bands with good mosh pits"',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppTheme.textTertiary,
                          ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Search button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Perform AI search
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentPurple,
                      foregroundColor: AppTheme.textPrimary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 18),
                        const SizedBox(width: 8),
                        Text('SEARCH'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Suggestions
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TRY THESE',
                    style: AppTheme.monospaceXSmall(context).copyWith(
                      color: AppTheme.textTertiary,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ..._suggestions.map((suggestion) => _buildSuggestionTile(suggestion)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionTile(String text) {
    return GestureDetector(
      onTap: () {
        _searchController.text = text;
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardDark,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.borderGray,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.lightbulb_outline,
              size: 18,
              color: AppTheme.textTertiary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              size: 16,
              color: AppTheme.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
