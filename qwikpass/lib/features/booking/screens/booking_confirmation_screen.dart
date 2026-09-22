import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090B0E),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // 1. Success Indicator
              _buildSuccessIcon(),

              const SizedBox(height: 12),

              // 2. Cryptographic Security Pill
              _buildOrderPill(),

              const SizedBox(height: 10),

              // 3. Main Headline
              Text(
                "YOU'RE IN. FAIR TICKETS LOCKED.",
                textAlign: TextAlign.center,
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 26,
                  letterSpacing: 1.0,
                ),
              ),

              const SizedBox(height: 6),

              // 4. Subtitle
              Text(
                'Guaranteed anti-scalp allocation tied directly to government ID verification.',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF8E99AA),
                  fontSize: 10.5,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // 5. Official Pass Ticket Card
              _buildPassCard(context),

              const SizedBox(height: 14),

              // 6. Identity Bound Card
              _buildIdentityBoundCard(),

              const SizedBox(height: 18),

              // 7. View Digital Ticket Stub Button (Amber)
              _buildViewTicketButton(context),

              const SizedBox(height: 12),

              // 8. Add to Wallet & Share Pass Secondary Row
              _buildSecondaryActions(context),

              const SizedBox(height: 18),

              // 9. Trust Protocol & Node Hash Footnote
              _buildTrustFootnote(),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // 1. Success Indicator
  Widget _buildSuccessIcon() {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        color: Color(0xFF10B981),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check,
        color: Colors.black,
        size: 22,
      ),
    );
  }

  // 2. Cryptographic Security Pill
  Widget _buildOrderPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF081C1A),
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
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF10B981),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'ORDER CONFIRMED & CRYPTOGRAPHICALLY SECURED',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF10B981),
              fontSize: 8.5,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // 5. Official Pass Ticket Card
  Widget _buildPassCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F131C),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF1E2638),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Tags
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C252F),
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
                        'IMMUTABLE TOKEN',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFF00E5FF),
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '[ OFFICIAL FAN PASS // VERIFIED ]',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFFFFBE1A),
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
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
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1524368535928-5b5e00ddc76b?q=80&w=700&auto=format&fit=crop',
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
                          Colors.black.withValues(alpha: 0.3),
                          const Color(0xFF0F131C),
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  left: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LIVE ARENA TOUR',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFF10B981),
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'BLOODYWOOD: RAJ METAL ARENA',
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Date & Venue Details
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
                      'SAT 18 NOV •\n19:30 IST',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'VENUE LOCATION',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF6B7280),
                        fontSize: 7.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'NSCI Dome, Worli\nMumbai [BOM]',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Divider(color: Color(0xFF1E273A), height: 1),
          ),

          // Assigned Access & Mini QR Code
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ASSIGNED ACCESS',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF6B7280),
                        fontSize: 7.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'ROW B • SEAT B14 &\nB15',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '[FAN PIT ACCESS TIER]',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF10B981),
                        fontSize: 8.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                // Mini QR Code Preview
                Container(
                  width: 44,
                  height: 44,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: QrImageView(
                    data: 'STUB-CONFIRMED:BOM-8921-992D1',
                    version: QrVersions.auto,
                    size: 38,
                    padding: EdgeInsets.zero,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Colors.black,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Telemetry Rows
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF090C12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF1A2233),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _buildTelemetryRow('TXN REF:', 'STUB-DOM-8921-992D1'),
                  const SizedBox(height: 3),
                  _buildTelemetryRow('PAYMENT ROUTE:', 'UPI INSTANT AUTO-SETTLE'),
                  const SizedBox(height: 3),
                  _buildTelemetryRow('TOTAL CHARGE:', '₹6,039.24 PAID'),
                  const SizedBox(height: 3),
                  _buildTelemetryRow(
                    'CONVENIENCE FEE:',
                    '₹0.00 (STUB ZERO MARKUP)',
                    valueColor: const Color(0xFF10B981),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.robotoMono(
            color: const Color(0xFF6B7280),
            fontSize: 8,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.robotoMono(
            color: valueColor ?? Colors.white,
            fontSize: 8.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // 6. Identity Bound Card
  Widget _buildIdentityBoundCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF06333D),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      size: 14,
                      color: Color(0xFF00E5FF),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Identity Bound',
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF081C1A),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.6),
                  ),
                ),
                child: Text(
                  'AUTHENTICATED',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF10B981),
                    fontSize: 7.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Linked to DigiLocker Identity (Ending ••4920). Entry requires scanning dynamic code via Stub app alongside physical Aadhaar or mParivahan pass.',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF8E99AA),
              fontSize: 9,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.lock_outline,
                  color: Color(0xFFFFBE1A),
                  size: 12,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Anti-Fraud Notice: Static screenshots will fail NFC gate check. Dynamic high-entropy QR activates automatically 2 hours prior to doors.',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF6B7280),
                    fontSize: 8.5,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 7. View Digital Ticket Stub Button (Amber)
  Widget _buildViewTicketButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/digital-ticket');
        },
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
            Text(
              'VIEW DIGITAL TICKET STUB',
              style: GoogleFonts.robotoMono(
                color: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.arrow_forward, size: 15, color: Colors.black),
          ],
        ),
      ),
    );
  }

  // 8. Add to Wallet & Share Pass Secondary Row
  Widget _buildSecondaryActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF141A24),
                    content: Text(
                      'Apple / Google Wallet Pass Generated',
                      style: GoogleFonts.robotoMono(color: const Color(0xFF10B981)),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.wallet, size: 14, color: Colors.white),
              label: Text(
                'Add to Wallet',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFF141924),
                side: const BorderSide(color: Color(0xFF242E40)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 40,
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF141A24),
                    content: Text(
                      'Encrypted Guest Link Copied',
                      style: GoogleFonts.robotoMono(color: const Color(0xFF00E5FF)),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.share, size: 14, color: Colors.white),
              label: Text(
                'Share Pass',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFF141924),
                side: const BorderSide(color: Color(0xFF242E40)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 9. Trust Protocol & Node Hash Footnote
  Widget _buildTrustFootnote() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shield_outlined, size: 11, color: Color(0xFF10B981)),
            const SizedBox(width: 4),
            Text(
              'STUB TRUST PROTOCOL • 0% SECONDARY MARKUP ENFORCED',
              style: GoogleFonts.robotoMono(
                color: const Color(0xFF6B7280),
                fontSize: 8,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          'NODE HASH: 0X8F9A2B5C...992D1 // BOMBAY METRO ARENA DOCK',
          style: GoogleFonts.robotoMono(
            color: const Color(0xFF4B5563),
            fontSize: 7.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}
