import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qwikpass/features/home/widgets/ai_search_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;
  String _selectedSubLocation = 'Bandra';
  String _selectedCategory = 'ALL';

  final List<String> _subLocations = [
    'Bandra',
    'BKC',
    'Lower Parel',
    'Andheri West',
    'Colaba',
  ];

  final List<Map<String, dynamic>> _categories = [
    {
      'label': 'ALL',
      'icon': Icons.local_fire_department,
      'iconColor': Colors.black,
    },
    {
      'label': 'CONCERTS',
      'icon': Icons.confirmation_number_outlined,
      'iconColor': Color(0xFF10B981),
    },
    {
      'label': 'MOVIES',
      'icon': Icons.movie_outlined,
      'iconColor': Color(0xFF60A5FA),
    },
    {
      'label': 'SPORTS',
      'icon': Icons.sports_cricket_outlined,
      'iconColor': Color(0xFFE11D48),
    },
    {
      'label': 'THEATRE',
      'icon': Icons.theater_comedy,
      'iconColor': Color(0xFFA855F7),
    },
    {
      'label': 'COMEDY',
      'icon': Icons.sentiment_very_satisfied_outlined,
      'iconColor': Color(0xFFF59E0B),
    },
  ];

  @override
  Widget build(BuildContext context) {
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

                    // Discover Title & 1-ID-1-TICKET Badge
                    _buildDiscoverHeader(),

                    const SizedBox(height: 14),

                    // Location & Sub-location pills
                    _buildLocationSection(),

                    const SizedBox(height: 14),

                    // Search Bar
                    _buildSearchBar(),

                    const SizedBox(height: 14),

                    // Category Chips
                    _buildCategoryChips(),

                    const SizedBox(height: 16),

                    // AI Curator Prompt Card
                    _buildCuratorPromptCard(),

                    const SizedBox(height: 22),

                    // SELLING FAST // LIVE VAULT Section
                    _buildLiveVaultSection(),

                    const SizedBox(height: 16),

                    // Anti-Scalp Protocol Banner
                    _buildAntiScalpBanner(),

                    const SizedBox(height: 22),

                    // BECAUSE YOU'RE INTO ROCK Section
                    _buildRockSection(),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // 1. Top Logo, City Selector, and Profile Avatar
  Widget _buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Stub App Logo
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2330),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF333B4F)),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.confirmation_number,
                        color: Color(0xFFFFBE1A),
                        size: 15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Stub App Logo',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFCBD5E1),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 10),

              // City dropdown selector pill (BOM Mumbai ▾)
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/city-selector');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161A24),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF282F40), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'BOM',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFFFFBE1A),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Mumbai',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white70,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // User Profile Avatar
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF3E475B),
                  width: 1.5,
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF242A38),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFFFFBE1A),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 2. DISCOVER Heading & Verified 1-ID-1-TICKET Badge
  Widget _buildDiscoverHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'DISCOVER',
            style: GoogleFonts.bebasNeue(
              fontSize: 34,
              color: Colors.white,
              letterSpacing: 1.2,
              height: 1.0,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/onboarding');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF131722),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF262D3D), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    color: Color(0xFF819BB8),
                    size: 13,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'VERIFIED 1-ID-1-TICKET',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFF93A7C1),
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Location Dropdown & Sub-Area Chips
  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Location row with 1-ID-1-ENTRY
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFFFFBE1A),
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'MUMBAI, MAHARASHTRA',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white70,
                    size: 16,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF131722),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF262D3D), width: 1),
                ),
                child: Text(
                  '1-ID-1-ENTRY',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFFFFBE1A),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Horizontal chips: Bandra, BKC, Lower Parel, Andheri West, Colaba
        SizedBox(
          height: 32,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _subLocations.length,
            itemBuilder: (context, index) {
              final loc = _subLocations[index];
              final isSelected = loc == _selectedSubLocation;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSubLocation = loc;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFFBE1A) : const Color(0xFF141822),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? const Color(0xFFFFBE1A) : const Color(0xFF262C3A),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      loc,
                      style: GoogleFonts.inter(
                        color: isSelected ? Colors.black : const Color(0xFF8B95A5),
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // 4. Search Bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          _showAISearch(context);
        },
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF12151E),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF252B3A), width: 1),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Color(0xFFFFBE1A),
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Search artists, stadium gigs, indie',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF717A8A),
                    fontSize: 12.5,
                  ),
                ),
              ),
              const Icon(
                Icons.tune,
                color: Color(0xFF818C9D),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 5. Category Filter Chips (ALL, CONCERTS, MOVIES, COMEDY)
  Widget _buildCategoryChips() {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = cat['label'] == _selectedCategory;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = cat['label'] as String;
              });
              if (cat['label'] != 'ALL') {
                Navigator.pushNamed(context, '/events');
              }
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFBE1A) : const Color(0xFF141822),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isSelected ? const Color(0xFFFFBE1A) : const Color(0xFF262C3A),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    cat['icon'] as IconData,
                    color: isSelected ? Colors.black : cat['iconColor'] as Color,
                    size: 15,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    cat['label'] as String,
                    style: GoogleFonts.robotoMono(
                      color: isSelected ? Colors.black : Colors.white,
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 6. AI Curator Prompt Card ("CURATOR PROMPT 2.0")
  Widget _buildCuratorPromptCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131722),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF242A3A), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Sparkles + CURATOR PROMPT 2.0  |  ANTIDOTE TO NOISE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: Color(0xFFFFBE1A),
                    size: 15,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'CURATOR PROMPT 2.0',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFFFBE1A),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C2420),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFF114E46), width: 1),
                ),
                child: Text(
                  'ANTIDOTE TO NOISE',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF2DD4BF),
                    fontSize: 8.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Title
          Text(
            "TELL ME WHAT YOU'RE IN THE MOOD FOR",
            style: GoogleFonts.bebasNeue(
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 0.6,
              height: 1.1,
            ),
          ),

          const SizedBox(height: 10),

          // Sunken prompt box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0C0E14),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF1C2230), width: 1),
            ),
            child: Text(
              '“An energetic weekend rock concert in BKC under ₹2,500 with zero queue markups”',
              style: GoogleFonts.inter(
                color: const Color(0xFF9AA5B6),
                fontSize: 12.5,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Action Button: Find Fair Tickets ⚡
          GestureDetector(
            onTap: () {
              _showAISearch(context);
            },
            child: Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFFBE1A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Find Fair Tickets',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.bolt,
                    color: Colors.black,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 7. SELLING FAST // LIVE VAULT Carousel Section
  Widget _buildLiveVaultSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF10B981).withValues(alpha: 0.6),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'SELLING FAST // LIVE VAULT',
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
              Text(
                'SCALPER_PROOF',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF6B7280),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Carousel of Ticket Stub Cards
        SizedBox(
          height: 345,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              // Card 1: Bloodywood
              _buildTicketStubCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?q=80&w=800&auto=format&fit=crop',
                statusTag: 'FAIR QUEUE ACTIVE',
                rightTag: 'FAST FILLING',
                title: 'BLOODYWOOD: RETURN OF THE\nKARAANTOUR',
                venue: 'NSCI Dome, Worli',
                dateTime: 'SAT 18 NOV • 19:30 IST',
                price: '₹1,499',
                fanVerification: '84% BOUGHT BY FANS',
                onTap: () {
                  Navigator.pushNamed(context, '/queue');
                },
              ),

              const SizedBox(width: 14),

              // Card 2: Prateek Kuhad (peeking)
              _buildTicketStubCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=800&auto=format&fit=crop',
                statusTag: 'GOING FAST',
                rightTag: 'HOT TICKETS',
                title: 'PRATEEK KUHAD: SILHOUETTES\nTOUR 2024',
                venue: 'Jio World Garden, BKC',
                dateTime: 'FRI 24 NOV • 20:00 IST',
                price: '₹1,899',
                fanVerification: '92% BOUGHT BY FANS',
                onTap: () {
                  Navigator.pushNamed(context, '/queue');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper: Custom Ticket Stub Card with Notches & Dashed Perforation
  Widget _buildTicketStubCard({
    required String imageUrl,
    required String statusTag,
    required String rightTag,
    required String title,
    required String venue,
    required String dateTime,
    required String price,
    required String fanVerification,
    required VoidCallback onTap,
  }) {
    const double punchPos = 168.0;
    const double punchRadius = 9.0;
    const double cardWidth = 295.0;

    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        foregroundPainter: _TicketBorderPainter(
          punchRadius: punchRadius,
          punchPosition: punchPos,
          borderColor: const Color(0xFF282E3E),
        ),
        child: ClipPath(
          clipper: _TicketClipper(
            punchRadius: punchRadius,
            punchPosition: punchPos,
          ),
          child: Container(
            width: cardWidth,
            decoration: const BoxDecoration(
              color: Color(0xFF131722),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Image Section (Height: punchPos)
                SizedBox(
                  height: punchPos,
                  width: cardWidth,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Event Image
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFF1B202C),
                          child: const Center(
                            child: Icon(Icons.music_note, color: Colors.white24, size: 40),
                          ),
                        ),
                      ),

                      // Gradient overlay for text contrast
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.65),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.92),
                            ],
                            stops: const [0.0, 0.45, 1.0],
                          ),
                        ),
                      ),

                      // Badges Overlaid at Top
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF10B981).withValues(alpha: 0.5),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                statusTag,
                                style: GoogleFonts.robotoMono(
                                  color: const Color(0xFF10B981),
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFBE1A),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            rightTag,
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),

                      // Event Title at bottom of image
                      Positioned(
                        bottom: 10,
                        left: 14,
                        right: 14,
                        child: Text(
                          title,
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontSize: 22,
                            height: 1.05,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom Ticket Section
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Venue & Date Row
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF7A8496),
                            size: 13,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            venue,
                            style: GoogleFonts.inter(
                              color: const Color(0xFFCBD5E1),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            dateTime,
                            style: GoogleFonts.robotoMono(
                              color: const Color(0xFF8F9BB0),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Metrics: Fair Price & Fan Verification
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left: Fair price
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'FAIR PRICE',
                                style: GoogleFonts.robotoMono(
                                  color: const Color(0xFF657288),
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    'FROM ',
                                    style: GoogleFonts.robotoMono(
                                      color: const Color(0xFFFFBE1A),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    price,
                                    style: GoogleFonts.robotoMono(
                                      color: const Color(0xFFFFBE1A),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Right: Fan verification
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'FAN VERIFICATION',
                                style: GoogleFonts.robotoMono(
                                  color: const Color(0xFF2DD4BF),
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                fanVerification,
                                style: GoogleFonts.robotoMono(
                                  color: const Color(0xFFE2E8F0),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Action Button: ENTER QUEUE & LOCK STUB ➔
                      Container(
                        height: 38,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF202534),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFF2F374C), width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ENTER QUEUE & LOCK STUB',
                              style: GoogleFonts.robotoMono(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 8. The Anti-Scalp Protocol Banner
  Widget _buildAntiScalpBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF131722),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF242A3A), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF231C10),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF5A4416), width: 1),
            ),
            child: const Icon(
              Icons.verified_user_outlined,
              color: Color(0xFFFFBE1A),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Anti-Scalp Protocol',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Gate QR rotates every 15s • Locked to aadhaar/Govt ID',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7E8799),
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'SEC_V4',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFFFFBE1A),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // 9. BECAUSE YOU'RE INTO ROCK Section
  Widget _buildRockSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.bolt,
                    color: Color(0xFFFFBE1A),
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "BECAUSE YOU'RE INTO ROCK",
                    style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: 17,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/events');
                },
                child: Text(
                  'VIEW ALL  (8)',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF8E99AA),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Two Cards Side-by-side
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Card 1: Parvaaz
              Expanded(
                child: _buildSmallRockCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1524368535928-5b5e00ddc76b?q=80&w=600&auto=format&fit=crop',
                  tag: 'ALT-ROCK',
                  tagColor: const Color(0xFFFFBE1A),
                  distance: '3.2 KM AWAY',
                  title: 'Parvaaz • Indiranagar Night',
                  venue: 'AntiSOCIAL, Lower Parel',
                  price: '₹1,200',
                  onTap: () {
                    Navigator.pushNamed(context, '/event-detail');
                  },
                ),
              ),

              const SizedBox(width: 12),

              // Card 2: The Riot Act
              Expanded(
                child: _buildSmallRockCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1465847899084-d164df4dedc6?q=80&w=600&auto=format&fit=crop',
                  tag: 'POST-PUNK',
                  tagColor: const Color(0xFF22D3EE),
                  distance: '1.8 KM AWAY',
                  title: 'The Riot Act: Underg...',
                  venue: 'Bonobo, Bandra West',
                  price: '₹800',
                  onTap: () {
                    Navigator.pushNamed(context, '/event-detail');
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Small Rock Card Widget
  Widget _buildSmallRockCard({
    required String imageUrl,
    required String tag,
    required Color tagColor,
    required String distance,
    required String title,
    required String venue,
    required String price,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF131722),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF242A3A), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with tags
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
              child: SizedBox(
                height: 95,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFF1A1F2C),
                        child: const Icon(Icons.music_note, color: Colors.white24),
                      ),
                    ),
                    Container(
                      color: Colors.black.withValues(alpha: 0.2),
                    ),
                    // Top-left Tag
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: tagColor, width: 1),
                        ),
                        child: Text(
                          tag,
                          style: GoogleFonts.robotoMono(
                            color: tagColor,
                            fontSize: 7.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    // Bottom-right Distance
                    Positioned(
                      bottom: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          distance,
                          style: GoogleFonts.robotoMono(
                            color: Colors.white,
                            fontSize: 7.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Card Body
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    venue,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF7E8799),
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFFFFBE1A),
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F2433),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: const Color(0xFF2C3549), width: 1),
                        ),
                        child: Text(
                          'LOCK',
                          style: GoogleFonts.robotoMono(
                            color: Colors.white,
                            fontSize: 8.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 10. Bottom Navigation Bar (DISCOVER, STUBS (badge 2), EXCHANGE, VAULT)
  Widget _buildBottomNav() {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Color(0xFF0C0E14),
        border: Border(
          top: BorderSide(
            color: Color(0xFF1E2330),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              index: 0,
              icon: Icons.explore,
              label: 'DISCOVER',
              isActive: _selectedNavIndex == 0,
            ),
            _buildNavItem(
              index: 1,
              icon: Icons.confirmation_number_outlined,
              label: 'STUBS',
              badgeText: '2',
              isActive: _selectedNavIndex == 1,
            ),
            _buildNavItem(
              index: 2,
              icon: Icons.sync_alt_rounded,
              label: 'EXCHANGE',
              isActive: _selectedNavIndex == 2,
            ),
            _buildNavItem(
              index: 3,
              icon: Icons.shield_outlined,
              label: 'VAULT',
              isActive: _selectedNavIndex == 3,
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
    String? badgeText,
    required bool isActive,
  }) {
    final activeColor = const Color(0xFFFFBE1A);
    final inactiveColor = const Color(0xFF7E8799);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _selectedNavIndex = index;
        });
        if (index == 1) {
          Navigator.pushNamed(context, '/digital-ticket');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/resale');
        } else if (index == 3) {
          Navigator.pushNamed(context, '/profile');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: isActive ? activeColor : inactiveColor,
                  size: 22,
                ),
                if (badgeText != null)
                  Positioned(
                    top: -3,
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
                          badgeText,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.robotoMono(
                color: isActive ? activeColor : inactiveColor,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                fontSize: 9,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAISearch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AISearchModal(),
    );
  }
}

/// Custom Clipper for ticket notch cutouts on left and right
class _TicketClipper extends CustomClipper<Path> {
  final double punchRadius;
  final double punchPosition;

  _TicketClipper({
    required this.punchRadius,
    required this.punchPosition,
  });

  @override
  Path getClip(Size size) {
    const double radius = 10.0;
    final path = Path();

    // Top-left to top-right
    path.moveTo(radius, 0);
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(Offset(size.width, radius), radius: const Radius.circular(radius));

    // Right edge down to notch
    path.lineTo(size.width, punchPosition - punchRadius);
    // Right inward semi-circle notch
    path.arcToPoint(
      Offset(size.width, punchPosition + punchRadius),
      radius: Radius.circular(punchRadius),
      clockwise: false,
    );
    // Right edge down to bottom-right
    path.lineTo(size.width, size.height - radius);
    path.arcToPoint(Offset(size.width - radius, size.height), radius: const Radius.circular(radius));

    // Bottom-right to bottom-left
    path.lineTo(radius, size.height);
    path.arcToPoint(Offset(0, size.height - radius), radius: const Radius.circular(radius));

    // Left edge up to notch
    path.lineTo(0, punchPosition + punchRadius);
    // Left inward semi-circle notch
    path.arcToPoint(
      Offset(0, punchPosition - punchRadius),
      radius: Radius.circular(punchRadius),
      clockwise: false,
    );
    // Left edge up to top-left
    path.lineTo(0, radius);
    path.arcToPoint(const Offset(radius, 0), radius: const Radius.circular(radius));

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Custom Painter for ticket border and dashed perforation line
class _TicketBorderPainter extends CustomPainter {
  final double punchRadius;
  final double punchPosition;
  final Color borderColor;

  _TicketBorderPainter({
    required this.punchRadius,
    required this.punchPosition,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = _TicketClipper(
      punchRadius: punchRadius,
      punchPosition: punchPosition,
    ).getClip(size);

    canvas.drawPath(path, borderPaint);

    // Draw dashed perforation line across between the notches
    final dashPaint = Paint()
      ..color = borderColor.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    double startX = punchRadius + 3;
    final double endX = size.width - punchRadius - 3;
    const double dashWidth = 4.0;
    const double dashSpace = 4.0;

    while (startX < endX) {
      canvas.drawLine(
        Offset(startX, punchPosition),
        Offset(startX + dashWidth, punchPosition),
        dashPaint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
