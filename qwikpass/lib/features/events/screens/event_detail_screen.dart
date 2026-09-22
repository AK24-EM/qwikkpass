import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  int _selectedTabIndex = 0;
  String _selectedTier = 'FAN PIT';

  final List<String> _tabs = ['About', 'Venue & Stage', 'Fan Reviews'];

  final List<Map<String, dynamic>> _tiers = [
    {
      'id': 'general-standing',
      'title': 'GENERAL STANDING',
      'tag': 'EAST / WEST',
      'tagType': 'zone',
      'price': '₹1,499',
      'description': 'Includes 1 drink token • Ground floor access',
      'footerLeft': 'FAST-PASS SCAN • GATE 4B',
      'footerRight': 'AVAILABLE',
      'footerRightColor': Color(0xFF10B981),
    },
    {
      'id': 'fan-pit',
      'title': 'FAN PIT',
      'tag': 'HOT SECTOR',
      'tagType': 'hot',
      'price': '₹2,499',
      'description': 'High-energy mosh zone • Limited to 500 fans',
      'footerLeft': 'FRONT ROW BARRIER DIRECT VIEW',
      'footerRight': '94 LEFT',
      'footerRightColor': Color(0xFFFFBE1A),
    },
    {
      'id': 'vip-mezzanine',
      'title': 'VIP MEZZANINE',
      'tag': 'ELEVATED',
      'tagType': 'elevated',
      'price': '₹4,200',
      'description': 'Dedicated bar, private lounge & express check-in',
      'footerLeft': 'SEATED LOUNGE • GATE 1 VIP DOCK',
      'footerRight': 'FILLING FAST',
      'footerRightColor': Color(0xFFF97316),
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
            // Top Navigation Bar
            _buildTopAppBar(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Image with Badges
                    _buildHeroImage(),

                    const SizedBox(height: 14),

                    // Event Header & Metadata
                    _buildEventHeader(),

                    const SizedBox(height: 14),

                    // Tab Selector (About, Venue & Stage, Fan Reviews)
                    _buildTabSelector(),

                    const SizedBox(height: 14),

                    // Tab Content (Description & Compliance Badges)
                    _buildTabContent(),

                    const SizedBox(height: 20),

                    // Ticket Access Tiers
                    _buildTicketAccessTiers(),

                    const SizedBox(height: 18),

                    // Fair Queue Engine Active Status Box
                    _buildFairQueueStatusBox(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Sticky Bottom Bar
            _buildStickyBottomBar(),
          ],
        ),
      ),
    );
  }

  // 1. Top App Bar
  Widget _buildTopAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(6),
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

          // Center: Logo + Title + SECURE badge
          Row(
            children: [
              _buildStubLogo(),
              const SizedBox(width: 8),
              Text(
                'EVENT DETAILS',
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 9,
                      color: Color(0xFF10B981),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      'SECURE',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF10B981),
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Right: User Profile Avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFFBE1A).withValues(alpha: 0.8),
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
        ],
      ),
    );
  }

  // Stub Logo
  Widget _buildStubLogo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFFFBE1A),
        borderRadius: BorderRadius.circular(3),
      ),
      child: const Text(
        'STUB',
        style: TextStyle(
          color: Colors.black,
          fontSize: 10.5,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  // 2. Hero Image with Stage Badges
  Widget _buildHeroImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 200,
              width: double.infinity,
              color: const Color(0xFF1E2430),
              child: Image.network(
                'https://images.unsplash.com/photo-1524368535928-5b5e00ddc76b?q=80&w=900&auto=format&fit=crop',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF1A1F2C),
                    child: const Center(
                      child: Icon(Icons.music_note, color: Color(0xFFFFBE1A), size: 48),
                    ),
                  );
                },
              ),
            ),
          ),

          // Vignette gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.45),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),

          // Top Left: STAGE VERIFIED
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 11,
                    color: Color(0xFF10B981),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'STAGE VERIFIED',
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 8.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top Right: 1-ID-1-TICKET
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFF00E5FF).withValues(alpha: 0.6),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    size: 11,
                    color: Color(0xFF00E5FF),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '1-ID-1-TICKET',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFF00E5FF),
                      fontSize: 8.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Left: BOMBAY MOSH LIVE
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xFFFFBE1A).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.equalizer,
                    size: 12,
                    color: Color(0xFFFFBE1A),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'BOMBAY MOSH LIVE',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFFFBE1A),
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Right: LIVE PREVIEW AUDIO
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.volume_up_outlined,
                    size: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'LIVE PREVIEW AUDIO',
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 8.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
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

  // 3. Event Header & Details
  Widget _buildEventHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event ID & Organizer Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'EVENT_ID: STUB-BWD-8921 • VERIFIED ORGANIZER',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF8E99AA),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF141822),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color(0xFF262C3A),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_user_outlined,
                      size: 11,
                      color: Color(0xFF00E5FF),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'NSCI OFFICIAL',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Main Title
          Text(
            'BLOODYWOOD: RETURN OF THE RAJ\nMETAL ARENA',
            style: GoogleFonts.bebasNeue(
              color: Colors.white,
              fontSize: 27,
              letterSpacing: 1.0,
              height: 1.15,
            ),
          ),

          const SizedBox(height: 10),

          // Venue
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 14,
                color: Color(0xFF8E99AA),
              ),
              const SizedBox(width: 6),
              Text(
                'NSCI Dome, Worli, Mumbai',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFFB5BDCA),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Date & Doors
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 14,
                color: Color(0xFF8E99AA),
              ),
              const SizedBox(width: 6),
              Text(
                'SATURDAY, 18 NOVEMBER 2024 • DOORS OPEN 18:30 IST',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFFB5BDCA),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 4. Tab Selector (About, Venue & Stage, Fan Reviews)
  Widget _buildTabSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFF12151D),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF202634),
            width: 1,
          ),
        ),
        child: Row(
          children: List.generate(_tabs.length, (index) {
            final isSelected = _selectedTabIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF1E2432)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      _tabs[index],
                      style: GoogleFonts.inter(
                        color: isSelected ? Colors.white : const Color(0xFF7E8896),
                        fontSize: 11.5,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // 5. Tab Content: Description & Tags
  Widget _buildTabContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "India's premier folk metal juggernaut returns to Mumbai. Every attendee requires verified identity check at Gate 3. No physical black-market tickets accepted.",
            style: GoogleFonts.inter(
              color: const Color(0xFFB5BDCA),
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Badge 1: 100% MOSHPIT COMPLIANT
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF141822),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFF262C3A),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.bolt,
                      size: 12,
                      color: Color(0xFFFFBE1A),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '100% MOSHPIT COMPLIANT',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFFC5CBD5),
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Badge 2: ANTI-SCALPER LOCK
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF141822),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFF262C3A),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      size: 12,
                      color: Color(0xFF00E5FF),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'ANTI-SCALPER LOCK',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFFC5CBD5),
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 6. Ticket Access Tiers
  Widget _buildTicketAccessTiers() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TICKET ACCESS TIERS',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                'SELECT TO ALLOCATE',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF7E8896),
                  fontSize: 9.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // List of Tier Cards
          ..._tiers.map((tier) {
            final isSelected = _selectedTier == tier['title'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTier = tier['title'] as String;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF12151D),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFFFBE1A)
                        : const Color(0xFF202634),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Title + Tag + Price
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                tier['title'] as String,
                                style: GoogleFonts.bebasNeue(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(width: 8),
                              _buildTierTag(tier['tag'] as String, tier['tagType'] as String),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                tier['price'] as String,
                                style: GoogleFonts.robotoMono(
                                  color: const Color(0xFFFFBE1A),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '+ TAXES',
                                style: GoogleFonts.robotoMono(
                                  color: const Color(0xFF6B7280),
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        tier['description'] as String,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9AA4B2),
                          fontSize: 11,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Dashed separator line
                    _buildDashedLine(),

                    // Bottom Row: Gate info & Availability status
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tier['footerLeft'] as String,
                            style: GoogleFonts.robotoMono(
                              color: const Color(0xFF7E8896),
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                          Text(
                            tier['footerRight'] as String,
                            style: GoogleFonts.robotoMono(
                              color: tier['footerRightColor'] as Color,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTierTag(String tag, String type) {
    Color bg = const Color(0xFF1E2432);
    Color border = const Color(0xFF2D3748);
    Color text = const Color(0xFFC5CBD5);

    if (type == 'hot') {
      bg = const Color(0xFFFFBE1A).withValues(alpha: 0.15);
      border = const Color(0xFFFFBE1A).withValues(alpha: 0.4);
      text = const Color(0xFFFFBE1A);
    } else if (type == 'elevated') {
      bg = const Color(0xFF00E5FF).withValues(alpha: 0.15);
      border = const Color(0xFF00E5FF).withValues(alpha: 0.4);
      text = const Color(0xFF00E5FF);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: border, width: 1),
      ),
      child: Text(
        tag,
        style: GoogleFonts.robotoMono(
          color: text,
          fontSize: 8.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 7. Fair Queue Engine Status Box
  Widget _buildFairQueueStatusBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1218),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF1E2430),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                  Text(
                    '[ FAIR QUEUE ENGINE ACTIVE ]',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFF10B981),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              Text(
                'ISO-27001',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF6B7280),
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Live traffic in gateway
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LIVE TRAFFIC IN GATEWAY',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFF7E8896),
                      fontSize: 8.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'CURRENT CONCURRENT QUEUE: 420 FANS',
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '~45 SEC',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFFFBE1A),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'AVG WAIT',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFF7E8896),
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Anti-Bot Guarantee
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF141822),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFF262C3A),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.shield_outlined,
                  size: 14,
                  color: Color(0xFF10B981),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9AA4B2),
                        fontSize: 10,
                        height: 1.4,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Anti-Bot Guarantee: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Accounts without verified DigiLocker ID are rejected automatically at the queue gate to eliminate black-market scalping.',
                        ),
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

  // Dashed Line
  Widget _buildDashedLine() {
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
                  decoration: BoxDecoration(color: Color(0xFF202634)),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  // 8. Sticky Bottom Action Bar
  Widget _buildStickyBottomBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0E1218),
        border: Border(
          top: BorderSide(
            color: Color(0xFF1E2430),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Price Range
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'OFFICIAL PRICE',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF7E8896),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '₹1,499  -  ₹4,200',
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // Right: Join Fair Queue Button
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/queue');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFBE1A),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFBE1A).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'JOIN THE FAIR QUEUE',
                      style: GoogleFonts.robotoMono(
                        color: Colors.black,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward,
                      size: 15,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
