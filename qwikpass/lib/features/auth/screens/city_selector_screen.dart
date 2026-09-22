import 'package:flutter/material.dart';
import 'package:qwikpass/core/theme/app_theme.dart';
import 'package:qwikpass/core/widgets/custom_button.dart';

class CitySelectorScreen extends StatefulWidget {
  const CitySelectorScreen({Key? key}) : super(key: key);

  @override
  State<CitySelectorScreen> createState() => _CitySelectorScreenState();
}

class _CitySelectorScreenState extends State<CitySelectorScreen> {
  String? _selectedCity;
  final TextEditingController _searchController = TextEditingController();
  List<CityOption> _filteredCities = [];

  final List<CityOption> _allCities = [
    CityOption('Mumbai', '🎭', true),
    CityOption('Delhi', '🏛️', true),
    CityOption('Bengaluru', '🎸', true),
    CityOption('Hyderabad', '🎪', true),
    CityOption('Chennai', '🎵', true),
    CityOption('Kolkata', '🎨', true),
    CityOption('Pune', '🎭', true),
    CityOption('Ahmedabad', '🎪', false),
    CityOption('Jaipur', '🎨', false),
    CityOption('Lucknow', '🎵', false),
    CityOption('Chandigarh', '🎭', false),
    CityOption('Goa', '🏖️', false),
    CityOption('Indore', '🎪', false),
    CityOption('Kochi', '🌴', false),
    CityOption('Surat', '💎', false),
    CityOption('Vadodara', '🏛️', false),
  ];

  @override
  void initState() {
    super.initState();
    _filteredCities = _allCities;
  }

  void _filterCities(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCities = _allCities;
      } else {
        _filteredCities = _allCities
            .where((city) =>
                city.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final popularCities = _filteredCities.where((c) => c.isPopular).toList();
    final otherCities = _filteredCities.where((c) => !c.isPopular).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SELECT CITY',
          style: AppTheme.monospaceSmall(context).copyWith(
            fontSize: 11,
            letterSpacing: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WHERE ARE\nYOU BASED?',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'We\'ll show you events happening in your city first.',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 24),

                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.cardDark,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.borderGray,
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: 'Search cities...',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppTheme.textTertiary),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppTheme.textSecondary,
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      onChanged: _filterCities,
                    ),
                  ),
                ],
              ),
            ),

            // Cities list
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Popular cities
                    if (popularCities.isNotEmpty) ...[
                      Text(
                        'POPULAR CITIES',
                        style: AppTheme.monospaceXSmall(context).copyWith(
                          color: AppTheme.textTertiary,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...popularCities.map((city) => _buildCityTile(city)),
                      const SizedBox(height: 24),
                    ],

                    // Other cities
                    if (otherCities.isNotEmpty) ...[
                      Text(
                        'OTHER CITIES',
                        style: AppTheme.monospaceXSmall(context).copyWith(
                          color: AppTheme.textTertiary,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...otherCities.map((city) => _buildCityTile(city)),
                    ],

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // Bottom action
            if (_selectedCity != null)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  border: Border(
                    top: BorderSide(
                      color: AppTheme.borderGray,
                      width: 1,
                    ),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: PrimaryButton(
                    text: 'Continue',
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityTile(CityOption city) {
    final isSelected = _selectedCity == city.name;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCity = city.name;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryYellow.withOpacity(0.1)
              : AppTheme.cardDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primaryYellow : AppTheme.borderGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Emoji icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  city.emoji,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // City name
            Expanded(
              child: Text(
                city.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: isSelected
                          ? AppTheme.primaryYellow
                          : AppTheme.textPrimary,
                    ),
              ),
            ),

            // Selected indicator
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppTheme.primaryYellow,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 16,
                  color: AppTheme.backgroundDark,
                ),
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

class CityOption {
  final String name;
  final String emoji;
  final bool isPopular;

  CityOption(this.name, this.emoji, this.isPopular);
}
