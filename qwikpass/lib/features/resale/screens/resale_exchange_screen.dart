import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResaleExchangeScreen extends StatefulWidget {
  const ResaleExchangeScreen({super.key});

  @override
  State<ResaleExchangeScreen> createState() => _ResaleExchangeScreenState();
}

class _ResaleExchangeScreenState extends State<ResaleExchangeScreen> {
  int _selectedCategoryIndex = 1; // 1 = CONCERTS (ACTIVE)
  final List<String> _categories = [
    'ALL CATEGORIES',
    'CONCERTS (ACTIVE)',
    'TODAY',
  ];

  void _showListTicketModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _buildListTicketBottomSheet(),
    );
  }

  void _showLockTicketModal(String eventName, String seat, String price) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _buildLockTicketBottomSheet(eventName, seat, price),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090B0E),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top App Bar
            _buildTopAppBar(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),

                    // Title Row: FAIR RESALE & VERIFIED 1-ID-1-TICKET
                    _buildTitleRow(),

                    const SizedBox(height: 12),

                    // Fair Resale Exchange Info Banner
                    _buildExchangeInfoBanner(),

                    const SizedBox(height: 14),

                    // Primary Action: (+) LIST MY TICKET [INSTANT INVALIDATION]
                    _buildListMyTicketButton(),

                    const SizedBox(height: 14),

                    // Category Filter Chips
                    _buildCategoryFilterChips(),

                    const SizedBox(height: 14),

                    // Resale Card 1: THE LOCAL TRAIN
                    _buildLocalTrainCard(),

                    const SizedBox(height: 16),

                    // Resale Card 2: COLDPLAY
                    _buildColdplayCard(),

                    const SizedBox(height: 16),

                    // HOW SELLING WORKS Explainer Card
                    _buildHowSellingWorksCard(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  // 1. Top App Bar
  Widget _buildTopAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // App Logo
          Row(
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
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                'StubApp',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),

          // City Selector Pill (BOM Mumbai ▾)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/city-selector');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF141822),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF232A3B),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'BOM',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFFFBE1A),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Mumbai',
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 3),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xFF8E99AA),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),

          // Profile Avatar
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

  // 2. Title Row (FAIR RESALE & VERIFIED 1-ID-1-TICKET)
  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'FAIR RESALE',
          style: GoogleFonts.bebasNeue(
            color: Colors.white,
            fontSize: 26,
            letterSpacing: 1.2,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF081C1A),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFF10B981).withValues(alpha: 0.6),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 11,
                color: Color(0xFF10B981),
              ),
              const SizedBox(width: 4),
              Text(
                'VERIFIED 1-ID-1-TICKET',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF10B981),
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 3. Fair Resale Exchange Info Banner
  Widget _buildExchangeInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0E131C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1E2638),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fair Resale Exchange',
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Strict zero-scalping zone: all passes locked at original face value. Secondary bot speculation is banned; dynamic processing fees capped at strictly 5%.',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF8E99AA),
              fontSize: 9.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),

          // 3 Stat Metrics
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF090C12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF1A2233),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                _buildStatCell('MARKUP', '0%', valueColor: const Color(0xFF10B981)),
                Container(height: 24, width: 1, color: const Color(0xFF1E273A)),
                _buildStatCell('MAX FEE', '5%'),
                Container(height: 24, width: 1, color: const Color(0xFF1E273A)),
                _buildStatCell('LOCK PERIOD', '5:00', valueColor: const Color(0xFFFFBE1A)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCell(String label, String value, {Color valueColor = Colors.white}) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF6B7280),
              fontSize: 8,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.robotoMono(
              color: valueColor,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // 4. Primary Action: (+) LIST MY TICKET [INSTANT INVALIDATION]
  Widget _buildListMyTicketButton() {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: _showListTicketModal,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFBE1A),
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.add_circle_outline,
                  color: Colors.black,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'LIST MY TICKET',
                  style: GoogleFonts.robotoMono(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'INSTANT INVALIDATION',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFFFFBE1A),
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 5. Category Filter Chips
  Widget _buildCategoryFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_categories.length, (index) {
          final isSelected = _selectedCategoryIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFFBE1A) : const Color(0xFF121620),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? const Color(0xFFFFBE1A) : const Color(0xFF232A3B),
                    width: 1,
                  ),
                ),
                child: Text(
                  _categories[index],
                  style: GoogleFonts.robotoMono(
                    color: isSelected ? Colors.black : const Color(0xFF8E99AA),
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // 6. Resale Card 1: THE LOCAL TRAIN
  Widget _buildLocalTrainCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F131C),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF1E2638),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Tags
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF052B33),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: const Color(0xFF00E5FF).withValues(alpha: 0.6),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.shield_outlined, size: 10, color: Color(0xFF00E5FF)),
                      const SizedBox(width: 4),
                      Text(
                        'BOT-PROOF 1-ID-1-TICKET',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFF00E5FF),
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161C28),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: const Color(0xFF28344A),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'ORIGINAL BUYER VERIFIED',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFB5BDCA),
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Concert Header with Image
          ClipRRect(
            child: Stack(
              children: [
                Container(
                  height: 110,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=700&auto=format&fit=crop',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          const Color(0xFF0F131C),
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'THE LOCAL TRAIN',
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: 24,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        'REUNION SPECIAL • MUMBAI',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFF8E99AA),
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Date & Seat Coordinates Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DATE & TIME',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF6B7280),
                        fontSize: 7.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'SAT 02 DEC • 20:00 IST',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'SEAT COORDINATES',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF6B7280),
                        fontSize: 7.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'West Stand • Row D • Seat 12',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Verified Fan Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF081C1A),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xFF10B981).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 12, color: Color(0xFF10B981)),
                      const SizedBox(width: 4),
                      Text(
                        'VERIFIED FAN: PRIYA S. • 100% RELIABILITY SCORE',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFF10B981),
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'AUTH #489-TX',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFF6B7280),
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Price Breakdown Box
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0D14),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF1C2436),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _buildPriceLine('ORIGINAL FACE VALUE', '₹1,800.00'),
                  const SizedBox(height: 4),
                  _buildPriceLine('TRANSFER & VERIFICATION (5%)', '₹90.00'),
                  const SizedBox(height: 4),
                  _buildPriceLine(
                    'SECONDARY SPECULATION MARKUP',
                    '₹0.00 [BLOCKED]',
                    valueColor: const Color(0xFF10B981),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Divider(color: Color(0xFF1E273A), height: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TOTAL SETTLEMENT',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFF8E99AA),
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '₹1,890.00',
                        style: GoogleFonts.robotoMono(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Action Button: BUY TICKET (LOCK 5 MIN)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                onPressed: () => _showLockTicketModal(
                  'The Local Train',
                  'West Stand • Row D • Seat 12',
                  '₹1,890.00',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFBE1A),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_outline, size: 14, color: Colors.black),
                    const SizedBox(width: 6),
                    Text(
                      'BUY TICKET (LOCK 5 MIN)',
                      style: GoogleFonts.robotoMono(
                        color: Colors.black,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 7. Resale Card 2: COLDPLAY
  Widget _buildColdplayCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F131C),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF1E2638),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Tags
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF081C1A),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: const Color(0xFF10B981).withValues(alpha: 0.6),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.verified_user_outlined, size: 10, color: Color(0xFF10B981)),
                      const SizedBox(width: 4),
                      Text(
                        'GOVT ID REQUIRED AT GATE',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFF10B981),
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161C28),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: const Color(0xFF28344A),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'DIRECT UPI RE-ISSUE',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFB5BDCA),
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Concert Header with Image
          ClipRRect(
            child: Stack(
              children: [
                Container(
                  height: 110,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?q=80&w=700&auto=format&fit=crop',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          const Color(0xFF0F131C),
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'COLDPLAY',
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: 24,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        'MUSIC OF THE SPHERES • AHMEDABAD',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFF8E99AA),
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Date & Transfer Protocol Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DATE & SECTOR',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF6B7280),
                        fontSize: 7.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '25 JAN 2025 • STANDING',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'TRANSFER PROTOCOL',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF6B7280),
                        fontSize: 7.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '1 ID Required for Transfer',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Verified Fan Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF081C1A),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xFF10B981).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 12, color: Color(0xFF10B981)),
                      const SizedBox(width: 4),
                      Text(
                        'VERIFIED FAN: AMIT K. • REGISTERED NATIONAL FAN ID',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFF10B981),
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'PASS #88-ST',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFF6B7280),
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Price Breakdown Box
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0D14),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF1C2436),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _buildPriceLine('ORIGINAL FACE VALUE', '₹3,500.00'),
                  const SizedBox(height: 4),
                  _buildPriceLine('PLATFORM AUDIT FEE (5%)', '₹175.00'),
                  const SizedBox(height: 4),
                  _buildPriceLine(
                    'SCALPING PROTECTION DISCOUNT',
                    '₹0.00 ZERO PREMIUM',
                    valueColor: const Color(0xFF10B981),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Divider(color: Color(0xFF1E273A), height: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TOTAL SETTLEMENT',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFF8E99AA),
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '₹3,675.00',
                        style: GoogleFonts.robotoMono(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Action Button: BUY TICKET
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                onPressed: () => _showLockTicketModal(
                  'Coldplay: Spheres',
                  'General Standing • Zone A',
                  '₹3,675.00',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFBE1A),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_cart_outlined, size: 14, color: Colors.black),
                    const SizedBox(width: 6),
                    Text(
                      'BUY TICKET',
                      style: GoogleFonts.robotoMono(
                        color: Colors.black,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceLine(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.robotoMono(
            color: const Color(0xFF6B7280),
            fontSize: 8.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.robotoMono(
            color: valueColor ?? Colors.white,
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // 8. HOW SELLING WORKS Explainer Card
  Widget _buildHowSellingWorksCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0E131C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1E2638),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.radar, size: 15, color: Color(0xFFFFBE1A)),
              const SizedBox(width: 6),
              Text(
                'HOW SELLING WORKS',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFFFFBE1A),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'List your ticket in 1-tap. Once another verified fan purchases it, your original digital barcode is invalidated instantly and funds are credited directly to your registered UPI ID within 15 minutes.',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF8E99AA),
              fontSize: 9.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),

          // 3 Step Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStepIcon(Icons.link, '1-Tap Post'),
              Container(width: 30, height: 1, color: const Color(0xFF222B3D)),
              _buildStepIcon(Icons.qr_code_scanner, 'Auto Void'),
              Container(width: 30, height: 1, color: const Color(0xFF222B3D)),
              _buildStepIcon(Icons.bolt, '15m UPI Pay'),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(color: Color(0xFF1E2638), height: 1),
          const SizedBox(height: 10),

          Center(
            child: Text(
              'HASH: STUB::EXCHANGE-IN-96812-TX • GATE ONLINE',
              style: GoogleFonts.robotoMono(
                color: const Color(0xFF5A6475),
                fontSize: 8,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF141924),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF222B3D),
              width: 1,
            ),
          ),
          child: Icon(icon, size: 16, color: const Color(0xFF00E5FF)),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.robotoMono(
            color: const Color(0xFFB5BDCA),
            fontSize: 8.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // List Ticket Bottom Sheet
  Widget _buildListTicketBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF0F131C),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border(
          top: BorderSide(color: Color(0xFFFFBE1A), width: 2),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF2E384D),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'SELECT TICKET TO RELIST',
            style: GoogleFonts.bebasNeue(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Only verified tickets from your Vault can be relisted. Your original entry barcode will be locked immediately upon publishing.',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF8E99AA),
              fontSize: 9.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),

          // Ticket Option
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF141924),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFFBE1A)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BLOODYWOOD: RAJ METAL ARENA',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'FAN PIT • ROW B • SEAT 14',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFFFFBE1A),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  '₹2,499.00',
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF141A24),
                    content: Text(
                      'Ticket relisted on Fair Exchange at face value (₹2,499.00)',
                      style: GoogleFonts.robotoMono(color: const Color(0xFF10B981)),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFBE1A),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'CONFIRM 1-TAP RELISTING',
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Lock Ticket Bottom Sheet
  Widget _buildLockTicketBottomSheet(String event, String seat, String price) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF0F131C),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border(
          top: BorderSide(color: Color(0xFF10B981), width: 2),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF2E384D),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LOCK TICKET (5:00 HOLD)',
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 1.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF081C1A),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFF10B981)),
                ),
                child: Text(
                  '0% MARKUP',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF10B981),
                    fontSize: 8.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Event: $event\nSector: $seat\nTotal: $price',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFFB5BDCA),
              fontSize: 10.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/checkout');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFBE1A),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'PROCEED TO UPI CHECKOUT',
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // 9. Bottom Navigation Bar
  Widget _buildBottomNavBar() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xFF090B0E),
        border: Border(
          top: BorderSide(color: Color(0xFF1A2130), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.explore_outlined,
            label: 'DISCOVER',
            onTap: () {
              Navigator.pushNamed(context, '/events');
            },
          ),
          _buildNavItem(
            icon: Icons.confirmation_number_outlined,
            label: 'STUBS',
            badgeCount: 2,
            onTap: () {
              Navigator.pushNamed(context, '/digital-ticket');
            },
          ),
          _buildNavItem(
            icon: Icons.swap_horiz,
            label: 'EXCHANGE',
            isActive: true,
            onTap: () {},
          ),
          _buildNavItem(
            icon: Icons.person_outline,
            label: 'VAULT',
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    int? badgeCount,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    final activeColor = const Color(0xFFFFBE1A);
    final inactiveColor = const Color(0xFF6B7280);
    final color = isActive ? activeColor : inactiveColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, size: 20, color: color),
              if (badgeCount != null)
                Positioned(
                  top: -4,
                  right: -8,
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
                        '$badgeCount',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 8,
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
              color: color,
              fontSize: 8.5,
              fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
