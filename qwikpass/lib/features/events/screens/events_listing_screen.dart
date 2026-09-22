import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsListingScreen extends StatefulWidget {
  final String category;
  final String city;

  const EventsListingScreen({
    super.key,
    this.category = 'Concerts',
    this.city = 'Mumbai',
  });

  @override
  State<EventsListingScreen> createState() => _EventsListingScreenState();
}

class _EventsListingScreenState extends State<EventsListingScreen> {
  int _selectedNavIndex = 0;
  String _selectedCity = 'Mumbai';
  String _selectedAirportCode = 'BOM';

  // Filter chips state
  bool _filterWeekend = true;
  bool _filterWheelchair = true;
  bool _filterUnder1000 = false;
  bool _filterSellingFast = false;

  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<Map<String, dynamic>> _concerts = [
    {
      'id': 'the-local-train',
      'title': 'THE LOCAL TRAIN • REUNION SPECIAL',
      'genre': 'INDIE ROCK HEADLINER',
      'venue': 'Bayview Lawns, Mazgaon, Mumbai',
      'date': 'SAT 02 DEC • 20:00 IST',
      'price': '₹1,800',
      'tier': '[TIER 1]',
      'imageUrl': 'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=800&auto=format&fit=crop',
      'topLeftBadge': '1 ID : 2 SEATS',
      'topLeftBadgeType': 'id_limit',
      'topRightBadge': 'REUNION TOUR',
      'accessibilityBadges': ['WHEELCHAIR RAMP', 'ISL INTERPRETED'],
      'fairnessStatus': 'CAPPED CAPACITY',
      'auditLabel': 'SECURITY AUDIT',
      'auditCode': 'STUB::BOM-TLT-2023',
      'buttonText': 'View Lineup & Queue',
      'buttonHasChevron': true,
      'isSellingFast': false,
      'wheelchair': true,
      'isWeekend': true,
      'priceVal': 1800,
    },
    {
      'id': 'agam-live',
      'title': 'AGAM LIVE: CARNATIC PROGRESSIVE ROCK',
      'genre': 'CARNATIC PROGRESSIVE ROCK',
      'venue': 'Phoenix Marketcity, Kurla, Mumbai',
      'date': 'SUN 10 DEC • 19:00 IST',
      'price': '₹899',
      'tier': '[GENERAL]',
      'imageUrl': 'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?q=80&w=800&auto=format&fit=crop',
      'topLeftBadge': 'GOVT ID MANDATORY',
      'topLeftBadgeType': 'govt_id',
      'topRightBadge': null,
      'accessibilityBadges': ['ACCESSIBLE SEATING AREA'],
      'fairnessStatus': 'NO SECONDARY MARKUP',
      'auditLabel': 'PASS CODE RAIL',
      'auditCode': 'STUB::BOM-AGM-0192',
      'buttonText': 'Join Fair Queue',
      'buttonIcon': Icons.bolt,
      'isSellingFast': false,
      'wheelchair': true,
      'isWeekend': true,
      'priceVal': 899,
    },
    {
      'id': 'seedhe-maut',
      'title': 'SEEDHE MAUT: LUNCH BREAK ARENA TOUR',
      'genre': 'DESI HIP-HOP TOUR',
      'venue': 'Nesco Grounds, Hall 4, Goregaon, Mumbai',
      'date': 'FRI 22 DEC • 18:30 IST',
      'price': '₹1,299',
      'tier': '[FAN PIT]',
      'imageUrl': 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?q=80&w=800&auto=format&fit=crop',
      'topLeftBadge': 'SELLING FAST: 92% OCCUPIED',
      'topLeftBadgeType': 'urgent',
      'topRightBadge': null,
      'accessibilityBadges': ['ELEVATED VIEWING DECK'],
      'antiBotActive': true,
      'auditLabel': 'QUEUE ESTIMATE',
      'auditCode': 'LESS THAN 180 LEFT',
      'buttonText': 'Reserve Now',
      'buttonIcon': Icons.lock_outline,
      'isSellingFast': true,
      'wheelchair': true,
      'isWeekend': true,
      'priceVal': 1299,
    },
    {
      'id': 'bloodywood',
      'title': 'BLOODYWOOD: RETURN OF THE RAJ',
      'genre': 'INDIAN FOLK METAL',
      'venue': 'NSCI Dome, Worli, Mumbai',
      'date': 'SAT 30 DEC • 19:30 IST',
      'price': '₹1,499',
      'tier': '[EARLY BIRD]',
      'imageUrl': 'https://images.unsplash.com/photo-1524368535928-5b5e00ddc76b?q=80&w=800&auto=format&fit=crop',
      'topLeftBadge': '1 ID : 1 TICKET',
      'topLeftBadgeType': 'id_limit',
      'topRightBadge': 'NEW ADDITION',
      'accessibilityBadges': ['WHEELCHAIR RAMP', 'SENSORY EARPLUGS'],
      'fairnessStatus': 'FAIR AUDIT PASSED',
      'auditLabel': 'SECURITY AUDIT',
      'auditCode': 'STUB::BOM-BLD-2023',
      'buttonText': 'Join Fair Queue',
      'buttonIcon': Icons.bolt,
      'isSellingFast': false,
      'wheelchair': true,
      'isWeekend': true,
      'priceVal': 1499,
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedCity = widget.city;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredConcerts {
    return _concerts.where((item) {
      if (_filterWeekend && item['isWeekend'] != true) return false;
      if (_filterWheelchair && item['wheelchair'] != true) return false;
      if (_filterUnder1000 && (item['priceVal'] as int) > 1000) return false;
      if (_filterSellingFast && item['isSellingFast'] != true) return false;

      if (_isSearching && _searchController.text.trim().isNotEmpty) {
        final q = _searchController.text.trim().toLowerCase();
        final title = (item['title'] as String).toLowerCase();
        final genre = (item['genre'] as String).toLowerCase();
        final venue = (item['venue'] as String).toLowerCase();
        if (!title.contains(q) && !genre.contains(q) && !venue.contains(q)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final listToDisplay = _filteredConcerts;

    return Scaffold(
      backgroundColor: const Color(0xFF090B0E),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top App Header
                    _buildTopHeader(),

                    const SizedBox(height: 12),

                    // Discover Title & Trust Badges
                    _buildDiscoverHeader(),

                    const SizedBox(height: 14),

                    // Horizontal Filter Chips
                    _buildFilterChips(),

                    const SizedBox(height: 16),

                    // Concert Cards Feed
                    if (listToDisplay.isEmpty)
                      _buildEmptyState()
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: listToDisplay.map((concert) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: _buildConcertCard(concert),
                            );
                          }).toList(),
                        ),
                      ),

                    const SizedBox(height: 8),

                    // Transparent Value Code Guarantee Banner
                    _buildTransparentValueCode(),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // 1. Top App Header (Logo, BOM Mumbai dropdown, Avatar)
  Widget _buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Back button if can pop, or Stub Logo
          Row(
            children: [
              if (Navigator.canPop(context)) ...[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141822),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF262C3A)),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              _buildStubLogo(),
            ],
          ),

          // Center-Right: Airport + City Pill
          GestureDetector(
            onTap: _showCitySelectorSheet,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF141822),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF262C3A),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedAirportCode,
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFFFBE1A),
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _selectedCity,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xFF8E99AA),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),

          // Right: User Profile Avatar
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFFBE1A).withOpacity(0.8),
                  width: 1.5,
                ),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Stub Stylized Logo
  Widget _buildStubLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFFFFBE1A),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'STUB',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'ACCESS',
          style: GoogleFonts.robotoMono(
            color: const Color(0xFF8E99AA),
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  // 2. Discover Section Header
  Widget _buildDiscoverHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row: DISCOVER + VERIFIED 1-ID-1-TICKET Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DISCOVER',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF9AA4B2),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.8,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E5FF).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFF00E5FF).withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      color: Color(0xFF00E5FF),
                      size: 11,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'VERIFIED 1-ID-1-TICKET',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF00E5FF),
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Row: MUMBAI + [324 ACTIVE EVENTS] Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                _selectedCity.toUpperCase(),
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 38,
                  letterSpacing: 1.5,
                  height: 1.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFBE1A).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color(0xFFFFBE1A).withOpacity(0.6),
                    width: 1,
                  ),
                ),
                child: Text(
                  '[324 ACTIVE EVENTS]',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFFFFBE1A),
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Sub-stats Row: REAL-TIME ANTI-SCALP QUEUES ACTIVE / FAIR ADMISSION AUDITED
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  'REAL-TIME ANTI-SCALP QUEUES ACTIVE',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF10B981),
                    fontSize: 8.8,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  '/',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF3F4756),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'FAIR ADMISSION AUDITED',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF8E99AA),
                  fontSize: 8.8,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 3. Horizontal Filter Chips (THIS WEEKEND, WHEELCHAIR ACCESS, UNDER ₹1000, etc.)
  Widget _buildFilterChips() {
    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          // Chip 1: THIS WEEKEND ✕ (Yellow active)
          GestureDetector(
            onTap: () {
              setState(() {
                _filterWeekend = !_filterWeekend;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _filterWeekend
                    ? const Color(0xFFFFBE1A)
                    : const Color(0xFF141822),
                borderRadius: BorderRadius.circular(19),
                border: Border.all(
                  color: _filterWeekend
                      ? const Color(0xFFFFBE1A)
                      : const Color(0xFF262C3A),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'THIS WEEKEND',
                    style: GoogleFonts.robotoMono(
                      color: _filterWeekend ? Colors.black : Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  if (_filterWeekend) ...[
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.close,
                      size: 13,
                      color: Colors.black,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Chip 2: WHEELCHAIR ACCESS ✓ (Cyan active)
          GestureDetector(
            onTap: () {
              setState(() {
                _filterWheelchair = !_filterWheelchair;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _filterWheelchair
                    ? const Color(0xFF00E5FF)
                    : const Color(0xFF141822),
                borderRadius: BorderRadius.circular(19),
                border: Border.all(
                  color: _filterWheelchair
                      ? const Color(0xFF00E5FF)
                      : const Color(0xFF262C3A),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.accessible,
                    size: 14,
                    color: _filterWheelchair ? Colors.black : const Color(0xFF00E5FF),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'WHEELCHAIR ACCESS',
                    style: GoogleFonts.robotoMono(
                      color: _filterWheelchair ? Colors.black : Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  if (_filterWheelchair) ...[
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.black,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Chip 3: UNDER ₹1000
          GestureDetector(
            onTap: () {
              setState(() {
                _filterUnder1000 = !_filterUnder1000;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _filterUnder1000
                    ? const Color(0xFFFFBE1A).withOpacity(0.15)
                    : const Color(0xFF141822),
                borderRadius: BorderRadius.circular(19),
                border: Border.all(
                  color: _filterUnder1000
                      ? const Color(0xFFFFBE1A)
                      : const Color(0xFF262C3A),
                  width: 1,
                ),
              ),
              child: Text(
                'UNDER ₹1000',
                style: GoogleFonts.robotoMono(
                  color: _filterUnder1000 ? const Color(0xFFFFBE1A) : const Color(0xFF9AA4B2),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),

          // Chip 4: SELLING FAST
          GestureDetector(
            onTap: () {
              setState(() {
                _filterSellingFast = !_filterSellingFast;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _filterSellingFast
                    ? const Color(0xFFEF4444).withOpacity(0.15)
                    : const Color(0xFF141822),
                borderRadius: BorderRadius.circular(19),
                border: Border.all(
                  color: _filterSellingFast
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF262C3A),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    size: 13,
                    color: Color(0xFFEF4444),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'SELLING FAST',
                    style: GoogleFonts.robotoMono(
                      color: _filterSellingFast ? const Color(0xFFEF4444) : const Color(0xFF9AA4B2),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Chip 5: Search icon toggle
          GestureDetector(
            onTap: () {
              _showSearchDialog();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF141822),
                borderRadius: BorderRadius.circular(19),
                border: Border.all(
                  color: const Color(0xFF262C3A),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.search,
                size: 16,
                color: Color(0xFF8E99AA),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 4. Concert Card Builder (Pixel-perfect matching media_1789406084023.png)
  Widget _buildConcertCard(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF12151D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF202634),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image Area
          _buildCardImageArea(item),

          // Middle Body Area
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Genre & Title + Price Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: Genre kicker + Title
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['genre'] as String,
                            style: GoogleFonts.robotoMono(
                              color: item['genre'] == 'DESI HIP-HOP TOUR'
                                  ? const Color(0xFFFFBE1A)
                                  : const Color(0xFF8E99AA),
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item['title'] as String,
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: 21,
                              letterSpacing: 0.8,
                              height: 1.15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Right: Price & Tier
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item['price'] as String,
                          style: GoogleFonts.robotoMono(
                            color: const Color(0xFFFFBE1A),
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                          ),
                        ),
                        Text(
                          item['tier'] as String,
                          style: GoogleFonts.robotoMono(
                            color: const Color(0xFFFFBE1A).withOpacity(0.75),
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Venue Row
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 13,
                      color: Color(0xFF8E99AA),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        item['venue'] as String,
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFFB5BDCA),
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Accessibility & Features Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    ...(item['accessibilityBadges'] as List<dynamic>).map((badge) {
                      IconData badgeIcon = Icons.accessible;
                      if (badge.toString().contains('ISL')) {
                        badgeIcon = Icons.record_voice_over_outlined;
                      } else if (badge.toString().contains('EARPLUG') || badge.toString().contains('SENSORY')) {
                        badgeIcon = Icons.hearing_outlined;
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF191F2B),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFF2D3748),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              badgeIcon,
                              size: 12,
                              color: const Color(0xFF8E99AA),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              badge.toString(),
                              style: GoogleFonts.robotoMono(
                                color: const Color(0xFFC5CBD5),
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    if (item['antiBotActive'] == true)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E5FF).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFF00E5FF).withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'ANTI-BOT ACTIVE',
                          style: GoogleFonts.robotoMono(
                            color: const Color(0xFF00E5FF),
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                  ],
                ),

                // Fairness status text (CAPPED CAPACITY or NO SECONDARY MARKUP)
                if (item['fairnessStatus'] != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    item['fairnessStatus'] as String,
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFF10B981),
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Dashed Divider Line (Ticket Perforation)
          _buildDashedDivider(),

          // Card Footer Action Row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: Audit Label & Code
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['auditLabel'] as String,
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF6B7280),
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item['auditCode'] as String,
                      style: GoogleFonts.robotoMono(
                        color: (item['auditCode'] as String).startsWith('STUB::')
                            ? const Color(0xFF00E5FF)
                            : const Color(0xFFE2E8F0),
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),

                // Right: Action Button
                GestureDetector(
                  onTap: () {
                    // Navigate to Queue or Detail Screen
                    if ((item['buttonText'] as String).contains('Queue')) {
                      Navigator.pushNamed(context, '/queue');
                    } else {
                      Navigator.pushNamed(context, '/event-detail');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFBE1A),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFBE1A).withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (item['buttonIcon'] != null) ...[
                          Icon(
                            item['buttonIcon'] as IconData,
                            size: 14,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 5),
                        ],
                        Text(
                          item['buttonText'] as String,
                          style: GoogleFonts.robotoMono(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                          ),
                        ),
                        if (item['buttonHasChevron'] == true) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 16,
                            color: Colors.black,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Card Image Area with overlaid tags
  Widget _buildCardImageArea(Map<String, dynamic> item) {
    return Stack(
      children: [
        // Image
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          child: Container(
            height: 175,
            width: double.infinity,
            color: const Color(0xFF1E2430),
            child: Image.network(
              item['imageUrl'] as String,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF1A202C),
                  child: Center(
                    child: Icon(
                      Icons.music_note,
                      size: 48,
                      color: const Color(0xFFFFBE1A).withOpacity(0.5),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Gradient Darkening at the bottom of image
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                  Colors.black.withOpacity(0.85),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),

        // Top Left Badge
        if (item['topLeftBadge'] != null)
          Positioned(
            top: 10,
            left: 10,
            child: _buildTopLeftBadge(
              item['topLeftBadge'] as String,
              item['topLeftBadgeType'] as String?,
            ),
          ),

        // Top Right Badge
        if (item['topRightBadge'] != null)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFBE1A),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item['topRightBadge'] as String,
                style: GoogleFonts.robotoMono(
                  color: Colors.black,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

        // Bottom Left Time Badge
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.75),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.access_time,
                  size: 11,
                  color: Color(0xFFC5CBD5),
                ),
                const SizedBox(width: 5),
                Text(
                  item['date'] as String,
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Top Left Badge Helper
  Widget _buildTopLeftBadge(String text, String? type) {
    if (type == 'urgent') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444).withOpacity(0.85),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFEF4444),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: GoogleFonts.robotoMono(
                color: Colors.white,
                fontSize: 8.5,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      );
    }

    final isGovt = type == 'govt_id';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.75),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isGovt
              ? const Color(0xFF00E5FF).withOpacity(0.6)
              : const Color(0xFF10B981).withOpacity(0.6),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shield_outlined,
            size: 11,
            color: isGovt ? const Color(0xFF00E5FF) : const Color(0xFF10B981),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: GoogleFonts.robotoMono(
              color: isGovt ? const Color(0xFF00E5FF) : const Color(0xFF10B981),
              fontSize: 8.5,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  // Dashed line divider with subtle ticket notch simulation
  Widget _buildDashedDivider() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashSpace = 4.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();

        return SizedBox(
          width: boxWidth,
          height: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return const SizedBox(
                width: dashWidth,
                height: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xFF262C3A)),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  // 5. Transparent Value Code Guarantee Banner
  Widget _buildTransparentValueCode() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1218),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF1E2430),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.verified_outlined,
                size: 13,
                color: Color(0xFF10B981),
              ),
              const SizedBox(width: 6),
              Text(
                'TRANSPARENT VALUE CODE',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF10B981),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'ALL PRICES INCLUSIVE OF TAXES. ZERO HIDDEN CONVENIENCE SURGES.',
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF8E99AA),
              fontSize: 9,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'VERIFIED AUDIT ID: MUM-STUB-PROD-2023-V4',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF4B5565),
              fontSize: 8,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  // 6. Bottom Navigation Bar (DISCOVER, STUBS, EXCHANGE, VAULT)
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF090B0E),
        border: Border(
          top: BorderSide(
            color: Color(0xFF191E28),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 1. DISCOVER
            _buildNavItem(
              index: 0,
              icon: Icons.explore,
              label: 'DISCOVER',
              isSelected: _selectedNavIndex == 0,
              onTap: () {
                setState(() => _selectedNavIndex = 0);
              },
            ),

            // 2. STUBS (with '2' yellow badge)
            _buildNavItem(
              index: 1,
              icon: Icons.confirmation_number_outlined,
              label: 'STUBS',
              badgeCount: '2',
              isSelected: _selectedNavIndex == 1,
              onTap: () {
                setState(() => _selectedNavIndex = 1);
                Navigator.pushNamed(context, '/digital-ticket');
              },
            ),

            // 3. EXCHANGE
            _buildNavItem(
              index: 2,
              icon: Icons.sync_alt,
              label: 'EXCHANGE',
              isSelected: _selectedNavIndex == 2,
              onTap: () {
                setState(() => _selectedNavIndex = 2);
                Navigator.pushNamed(context, '/resale');
              },
            ),

            // 4. VAULT
            _buildNavItem(
              index: 3,
              icon: Icons.shield_outlined,
              label: 'VAULT',
              isSelected: _selectedNavIndex == 3,
              onTap: () {
                setState(() => _selectedNavIndex = 3);
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    String? badgeCount,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                icon,
                size: 21,
                color: isSelected ? const Color(0xFFFFBE1A) : const Color(0xFF6B7280),
              ),
              if (badgeCount != null)
                Positioned(
                  top: -4,
                  right: -7,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFBE1A),
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Center(
                      child: Text(
                        badgeCount,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 8.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.robotoMono(
              color: isSelected ? const Color(0xFFFFBE1A) : const Color(0xFF6B7280),
              fontSize: 9,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.search_off,
              size: 48,
              color: Color(0xFF3F4756),
            ),
            const SizedBox(height: 12),
            Text(
              'NO CONCERTS FOUND FOR CURRENT FILTERS',
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoMono(
                color: const Color(0xFF8E99AA),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _filterWeekend = false;
                  _filterWheelchair = false;
                  _filterUnder1000 = false;
                  _filterSellingFast = false;
                  _searchController.clear();
                  _isSearching = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFBE1A),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('RESET ALL FILTERS'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCitySelectorSheet() {
    final cities = [
      {'code': 'BOM', 'name': 'Mumbai', 'events': '324'},
      {'code': 'DEL', 'name': 'Delhi NCR', 'events': '210'},
      {'code': 'BLR', 'name': 'Bengaluru', 'events': '185'},
      {'code': 'HYD', 'name': 'Hyderabad', 'events': '92'},
      {'code': 'PNQ', 'name': 'Pune', 'events': '78'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF141822),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E3646),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'SELECT AUDITED LOCATION',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 14),
              ...cities.map((city) {
                final isSelected = city['name'] == _selectedCity;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFFFBE1A)
                          : const Color(0xFF1E2430),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      city['code']!,
                      style: GoogleFonts.robotoMono(
                        color: isSelected ? Colors.black : const Color(0xFFFFBE1A),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  title: Text(
                    city['name']!,
                    style: GoogleFonts.inter(
                      color: isSelected ? const Color(0xFFFFBE1A) : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Text(
                    '${city['events']} EVENTS',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFF8E99AA),
                      fontSize: 10,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedCity = city['name']!;
                      _selectedAirportCode = city['code']!;
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF141822),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF262C3A)),
          ),
          title: Text(
            'SEARCH CONCERTS',
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: _searchController,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search artist, genre, or venue...',
              hintStyle: GoogleFonts.robotoMono(
                color: const Color(0xFF6B7280),
                fontSize: 12,
              ),
              prefixIcon: const Icon(Icons.search, color: Color(0xFFFFBE1A)),
              filled: true,
              fillColor: const Color(0xFF090B0E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF262C3A)),
              ),
            ),
            onChanged: (_) {
              setState(() {
                _isSearching = _searchController.text.trim().isNotEmpty;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                _searchController.clear();
                setState(() => _isSearching = false);
                Navigator.pop(context);
              },
              child: const Text('CLEAR'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFBE1A),
                foregroundColor: Colors.black,
              ),
              child: const Text('DONE'),
            ),
          ],
        );
      },
    );
  }
}
