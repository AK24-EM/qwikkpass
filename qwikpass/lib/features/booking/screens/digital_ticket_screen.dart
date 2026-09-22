import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_widget/barcode_widget.dart';

class DigitalTicketScreen extends StatefulWidget {
  const DigitalTicketScreen({super.key});

  @override
  State<DigitalTicketScreen> createState() => _DigitalTicketScreenState();
}

class _DigitalTicketScreenState extends State<DigitalTicketScreen>
    with SingleTickerProviderStateMixin {
  int _secondsRemaining = 9;
  Timer? _tokenTimer;
  String _currentToken = 'STUB::8F92A-C901-BWD';
  int _tokenCycle = 1;

  final List<String> _tokenList = [
    'STUB::8F92A-C901-BWD',
    'STUB::4D11E-F702-BWD',
    'STUB::9C33B-E804-BWD',
    'STUB::2A77K-L109-BWD',
  ];

  @override
  void initState() {
    super.initState();
    _startRotatingTokenTimer();
  }

  @override
  void dispose() {
    _tokenTimer?.cancel();
    super.dispose();
  }

  void _startRotatingTokenTimer() {
    _tokenTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_secondsRemaining > 1) {
          _secondsRemaining--;
        } else {
          _secondsRemaining = 15;
          _tokenCycle = (_tokenCycle + 1) % _tokenList.length;
          _currentToken = _tokenList[_tokenCycle];
        }
      });
    });
  }

  void _copyTokenToClipboard() {
    Clipboard.setData(ClipboardData(text: _currentToken));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF141A24),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFF00E5FF), width: 1),
        ),
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Color(0xFF00E5FF), size: 18),
            const SizedBox(width: 8),
            Text(
              'Dynamic Token Copied to Clipboard',
              style: GoogleFonts.robotoMono(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOnDemandAuditSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _buildAuditModalSheet(),
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

            // Scrollable Ticket & Actions
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 6),

                    // Section Title Row: BOOKINGS & VERIFIED 1-ID-1-TICKET
                    _buildTitleRow(),

                    const SizedBox(height: 12),

                    // The Industrial Digital Pass / Ticket Card
                    _buildDigitalTicketPass(),

                    const SizedBox(height: 16),

                    // Primary Button: VERIFY BEFORE ENTRY (ON-DEMAND AUDIT)
                    _buildVerifyButton(),

                    const SizedBox(height: 12),

                    // Resale Guarantee Link
                    _buildResaleLink(),

                    const SizedBox(height: 16),

                    // Offline Enclave Security Notice Box
                    _buildOfflineEnclaveBox(),

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
          // Left: App Logo
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

          // Center: City Selector Pill (BOM Mumbai ▾)
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

  // 2. Section Title Row (BOOKINGS & VERIFIED 1-ID-1-TICKET)
  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'BOOKINGS',
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

  // 3. Digital Ticket & Access Pass Container
  Widget _buildDigitalTicketPass() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0E121A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF1F2637),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // A. Hero Concert Header Image
          _buildPassHeroImage(),

          // B. Gate, Zone, Row, Seat Grid (4 boxes)
          _buildPassSeatGrid(),

          const SizedBox(height: 12),

          // C. Date, Gates Open, Tier Row
          _buildPassMetadataRow(),

          const SizedBox(height: 12),

          // D. Identity Attestation Badge (Aditya Sharma • Govt ID Verified)
          _buildIdentityAttestationPill(),

          const SizedBox(height: 14),

          // E. Ticket Perforation Tear Notch Divider
          _buildPerforationDivider(),

          const SizedBox(height: 12),

          // F. Rotating Token Status (9s remaining)
          _buildRotatingTokenStatus(),

          const SizedBox(height: 12),

          // G. Dynamic QR Code with Glowing HUD Brackets
          _buildDynamicQrCodeBox(),

          const SizedBox(height: 10),

          // H. Token Identifier & Copy Button
          _buildTokenCodeRow(),

          const SizedBox(height: 14),

          // I. Barcode & Audit String
          _buildBarcodeSection(),

          const SizedBox(height: 14),
        ],
      ),
    );
  }

  // A. Hero Concert Header Image
  Widget _buildPassHeroImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: Stack(
        children: [
          // Image
          SizedBox(
            height: 155,
            width: double.infinity,
            child: Image.network(
              'https://images.unsplash.com/photo-1524368535928-5b5e00ddc76b?q=80&w=900&auto=format&fit=crop',
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.35),
              colorBlendMode: BlendMode.darken,
            ),
          ),

          // Dark Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.5),
                    Colors.black.withValues(alpha: 0.1),
                    const Color(0xFF0E121A),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),

          // Top Watermark: [FAIR PASS // NON-TRANSFERABLE]
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '[FAIR PASS // NON-TRANSFERABLE]',
                style: GoogleFonts.robotoMono(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 8.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),

          // Artist Info & Badges
          Positioned(
            bottom: 8,
            left: 14,
            right: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFBE1A),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        'METALVERSE TOUR',
                        style: GoogleFonts.robotoMono(
                          color: Colors.black,
                          fontSize: 8.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'LIVE AUDIT PASS',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFFB5BDCA),
                        fontSize: 8.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Bloodywood Title
                Text(
                  'BLOODYWOOD',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 28,
                    letterSpacing: 1.2,
                    height: 1.0,
                  ),
                ),

                const SizedBox(height: 4),

                // Venue
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF00E5FF),
                      size: 13,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'NSCI DOME, WORLI, MUMBAI',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF8E99AA),
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // B. Gate, Zone, Row, Seat Grid (4 boxes)
  Widget _buildPassSeatGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          _buildSeatCell(label: 'GATE', value: '03'),
          const SizedBox(width: 6),
          _buildSeatCell(label: 'ZONE', value: 'FAN PIT'),
          const SizedBox(width: 6),
          _buildSeatCell(label: 'ROW', value: 'B'),
          const SizedBox(width: 6),
          _buildSeatCell(
            label: 'SEAT',
            value: '14',
            valueColor: const Color(0xFF10B981),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatCell({
    required String label,
    required String value,
    Color valueColor = Colors.white,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF141924),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF222B3D),
            width: 1,
          ),
        ),
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
            const SizedBox(height: 3),
            Text(
              value,
              style: GoogleFonts.robotoMono(
                color: valueColor,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // C. Date, Gates Open, Tier Row
  Widget _buildPassMetadataRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DATE',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF6B7280),
                  fontSize: 7.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '18 NOV 2024',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'GATES OPEN',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF6B7280),
                  fontSize: 7.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '18:30 IST',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'TIER',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF6B7280),
                  fontSize: 7.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'PHASE 1',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFFFFBE1A),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // D. Identity Attestation Badge (Aditya Sharma • Govt ID Verified)
  Widget _buildIdentityAttestationPill() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF131822),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF222B3D),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.badge_outlined,
                  size: 14,
                  color: Color(0xFF10B981),
                ),
                const SizedBox(width: 6),
                Text(
                  'ADITYA SHARMA',
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
              decoration: BoxDecoration(
                color: const Color(0xFF0D2820),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: const Color(0xFF10B981).withValues(alpha: 0.6),
                  width: 1,
                ),
              ),
              child: Text(
                'GOVT ID VERIFIED',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF10B981),
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // E. Ticket Perforation Tear Notch Divider
  Widget _buildPerforationDivider() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Left notch
        Positioned(
          left: -12,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFF090B0E),
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Right notch
        Positioned(
          right: -12,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFF090B0E),
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Centered perforation text & dashes
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: const Color(0xFF222B3D),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '• • •   TEAR TO VALIDATE AT GATE   • • •',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF5A6475),
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: const Color(0xFF222B3D),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // F. Rotating Token Status (9s remaining)
  Widget _buildRotatingTokenStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Color(0xFF00E5FF),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'ROTATING TOKEN: ${_secondsRemaining}s REMAINING',
          style: GoogleFonts.robotoMono(
            color: const Color(0xFF00E5FF),
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  // G. Dynamic QR Code with Glowing HUD Brackets
  Widget _buildDynamicQrCodeBox() {
    return Center(
      child: Container(
        width: 180,
        height: 180,
        padding: const EdgeInsets.all(8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Top-Left Bracket
            Positioned(
              top: 0,
              left: 0,
              child: _buildHudBracket(isTop: true, isLeft: true),
            ),
            // Top-Right Bracket
            Positioned(
              top: 0,
              right: 0,
              child: _buildHudBracket(isTop: true, isLeft: false),
            ),
            // Bottom-Left Bracket
            Positioned(
              bottom: 0,
              left: 0,
              child: _buildHudBracket(isTop: false, isLeft: true),
            ),
            // Bottom-Right Bracket
            Positioned(
              bottom: 0,
              right: 0,
              child: _buildHudBracket(isTop: false, isLeft: false),
            ),

            // White QR Code Container
            Container(
              width: 154,
              height: 154,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  QrImageView(
                    data: 'STUB-PASSPORT:$_currentToken:ADITYA_SHARMA:BOM-DOME-7739',
                    version: QrVersions.auto,
                    size: 138,
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Colors.black,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Colors.black,
                    ),
                  ),

                  // Center Gold Shield / Checkmark Badge
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFBE1A),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHudBracket({required bool isTop, required bool isLeft}) {
    const double size = 14;
    const double thickness = 2;
    const Color bracketColor = Color(0xFF00E5FF);

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _BracketPainter(
          isTop: isTop,
          isLeft: isLeft,
          thickness: thickness,
          color: bracketColor,
        ),
      ),
    );
  }

  // H. Token Identifier & Copy Button
  Widget _buildTokenCodeRow() {
    return GestureDetector(
      onTap: _copyTokenToClipboard,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _currentToken,
            style: GoogleFonts.robotoMono(
              color: const Color(0xFFB5BDCA),
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(
            Icons.copy,
            size: 12,
            color: Color(0xFF8E99AA),
          ),
        ],
      ),
    );
  }

  // I. Barcode & Audit String
  Widget _buildBarcodeSection() {
    return Column(
      children: [
        Container(
          width: 260,
          height: 38,
          color: Colors.transparent,
          child: BarcodeWidget(
            barcode: Barcode.code128(),
            data: 'MUM-DOME-7739',
            drawText: false,
            color: const Color(0xFFB5BDCA),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'SECURE ENTRY AUDIT // MUM-DOME-7739',
          style: GoogleFonts.robotoMono(
            color: const Color(0xFF5A6475),
            fontSize: 8.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }

  // 4. Primary Button: VERIFY BEFORE ENTRY (ON-DEMAND AUDIT)
  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: _showOnDemandAuditSheet,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFBE1A),
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.verified_user_outlined,
              color: Colors.black,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              'VERIFY BEFORE ENTRY (ON-DEMAND AUDIT)',
              style: GoogleFonts.robotoMono(
                color: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 5. Resale Guarantee Link
  Widget _buildResaleLink() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/resale');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '₹',
            style: TextStyle(
              color: Color(0xFF10B981),
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            'Relist on Fair Resale Exchange (Face Value Cap: ₹2,499)',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF8E99AA),
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: const Color(0xFF8E99AA),
            ),
          ),
        ],
      ),
    );
  }

  // 6. Offline Enclave Security Notice Box
  Widget _buildOfflineEnclaveBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF10141D),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF1F2738),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.wifi_off,
              color: Color(0xFF8E99AA),
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF8E99AA),
                  fontSize: 9,
                  height: 1.4,
                ),
                children: const [
                  TextSpan(text: 'Pass cached offline in '),
                  TextSpan(
                    text: 'Stub Secure Enclave',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text:
                        '. No cellular network or mobile data required at turnstile gates.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 7. On-Demand Audit Modal Sheet
  Widget _buildAuditModalSheet() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LIVE GATE AUDIT // PROOF',
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 1.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFF10B981)),
                ),
                child: Text(
                  'VALIDATED',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF10B981),
                    fontSize: 8.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildAuditRow('DIGILOCKER TOKEN', '•••• •••• 4920 (Aditya Sharma)'),
          _buildAuditRow('PUBLIC KEY HASH', '0x8F92...C901 (RSA-4096 SHA256)'),
          _buildAuditRow('ACCESS SECTOR', 'FAN PIT • ROW B • SEAT 14'),
          _buildAuditRow('TURNSTILE DOCK', 'GATE 03 • TURNSTILE A2 READY'),
          _buildAuditRow('OFFLINE CERTIFICATE', 'VALID UNTIL 19 NOV 2024 02:00'),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFBE1A),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'DISMISS AUDIT',
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w800,
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

  Widget _buildAuditRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF6B7280),
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // 8. Bottom Navigation Bar
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
            index: 0,
            icon: Icons.explore_outlined,
            label: 'DISCOVER',
            onTap: () {
              Navigator.pushNamed(context, '/events');
            },
          ),
          _buildNavItem(
            index: 1,
            icon: Icons.confirmation_number_outlined,
            label: 'STUBS',
            badgeCount: 2,
            isActive: true,
            onTap: () {},
          ),
          _buildNavItem(
            index: 2,
            icon: Icons.swap_horiz,
            label: 'EXCHANGE',
            onTap: () {
              Navigator.pushNamed(context, '/resale');
            },
          ),
          _buildNavItem(
            index: 3,
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
    required int index,
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

// Custom Painter for HUD Brackets
class _BracketPainter extends CustomPainter {
  final bool isTop;
  final bool isLeft;
  final double thickness;
  final Color color;

  _BracketPainter({
    required this.isTop,
    required this.isLeft,
    required this.thickness,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (isTop && isLeft) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else if (isTop && !isLeft) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (!isTop && isLeft) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
