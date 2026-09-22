import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveQueueScreen extends StatefulWidget {
  const LiveQueueScreen({super.key});

  @override
  State<LiveQueueScreen> createState() => _LiveQueueScreenState();
}

class _LiveQueueScreenState extends State<LiveQueueScreen> {
  int _secondsRemaining = 10;
  int _queuePosition = 42;
  double _progress = 0.72;
  Timer? _countdownTimer;
  bool _pingSent = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
          _progress = 0.72 + (0.28 * (10 - _secondsRemaining) / 10);
          if (_secondsRemaining <= 3 && _queuePosition > 1) {
            _queuePosition = 1;
          }
        });
      } else {
        _countdownTimer?.cancel();
        _onQueueTurnReached();
      }
    });
  }

  void _onQueueTurnReached() {
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF141822),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFFFBE1A), width: 1.5),
          ),
          title: Row(
            children: [
              const Icon(Icons.verified, color: Color(0xFF10B981), size: 24),
              const SizedBox(width: 8),
              Text(
                "IT'S YOUR TURN!",
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          content: Text(
            'Your cryptographic queue token has cleared. You have 10 minutes to allocate and lock your seats before the session expires.',
            style: GoogleFonts.inter(color: const Color(0xFFB5BDCA), fontSize: 13),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/seat-selection');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFBE1A),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(
                'PROCEED TO SEAT SELECTION →',
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _testPing() {
    HapticFeedback.vibrate();
    setState(() {
      _pingSent = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF1A2230),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            const Icon(Icons.phonelink_ring, color: Color(0xFF00E5FF), size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Test Ping Sent: Vibration triggered & SMS gateway verified for +91 98201 •••••',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 10.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090B0E),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            _buildTopAppBar(),

            // Scrollable Queue Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),

                      // Event Header Banner Pill
                      _buildEventHeaderBanner(),

                      const SizedBox(height: 12),

                      // Encrypted Queue Session Line
                      _buildEncryptedSessionLine(),

                      const SizedBox(height: 16),

                      // Verified Position In Line Card (The Main Counter)
                      _buildPositionCounter(),

                      const SizedBox(height: 16),

                      // Estimated Wait Time & Progress Bar
                      _buildWaitTimeBar(),

                      const SizedBox(height: 18),

                      // Verified Concertgoers Advancing (Live Avatars)
                      _buildAdvancingAvatars(),

                      const SizedBox(height: 18),

                      // Queue Integrity Protocol Box
                      _buildQueueIntegrityBox(),

                      const SizedBox(height: 16),

                      // Notification & Vibration Ping Alert Box
                      _buildKeepScreenOpenBox(),

                      const SizedBox(height: 14),

                      // Leave Queue Button
                      _buildLeaveQueueButton(),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
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

  // 2. Event Header Banner Pill
  Widget _buildEventHeaderBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF12151D),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF202634),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.confirmation_number_outlined,
            color: Color(0xFFFFBE1A),
            size: 16,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BLOODYWOOD // RAKSHAK ...',
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'NSCI DOME, MUMBAI • 08 NOV 2025',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF7E8896),
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.12),
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
                const SizedBox(width: 4),
                Text(
                  'LIVE',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF10B981),
                    fontSize: 8.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. Encrypted Queue Session Line
  Widget _buildEncryptedSessionLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
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
                'ENCRYPTED QUEUE SESSION',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF10B981),
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.lock_outline,
                size: 11,
                color: Color(0xFF7E8896),
              ),
              const SizedBox(width: 4),
              Text(
                'SHA-256',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF7E8896),
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 4. Verified Position In Line Display (Counter)
  Widget _buildPositionCounter() {
    // Format queue position as 3-digit string e.g. "042"
    final posStr = _queuePosition.toString().padLeft(3, '0');
    final chars = ['#', posStr[0], posStr[1], posStr[2]];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1219),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF1E2432),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Subtitle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.verified_user_outlined,
                size: 14,
                color: Color(0xFFFFBE1A),
              ),
              const SizedBox(width: 6),
              Text(
                'YOUR VERIFIED POSITION IN LINE',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFFFFBE1A),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // 4 Numeral Boxes: # 0 4 2
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: chars.map((char) {
              return Container(
                width: 52,
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF161A24),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF262F42),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    char,
                    style: GoogleFonts.robotoMono(
                      color: char == '#'
                          ? const Color(0xFF7E8896)
                          : const Color(0xFFFFBE1A),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // Sub-pill: 3 FANS AHEAD OF YOU
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF161B26),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF262F40),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.people_outline,
                  size: 13,
                  color: Color(0xFF00E5FF),
                ),
                const SizedBox(width: 6),
                Text(
                  '3 FANS AHEAD OF YOU',
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'GATE ENTRANCE CAPACITY: 15 / MINUTE',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF6B7280),
              fontSize: 8.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  // 5. Estimated Wait Time & Progress Bar
  Widget _buildWaitTimeBar() {
    final secondsStr = _secondsRemaining.toString().padLeft(2, '0');

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1219),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1E2432),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header: ESTIMATED WAIT TIME & 00m 10s
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 13,
                    color: Color(0xFF8E99AA),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'ESTIMATED WAIT TIME',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFF8E99AA),
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
              Text(
                '00m ${secondsStr}s',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFFFFBE1A),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Yellow Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _progress.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: const Color(0xFF1E2432),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFBE1A)),
            ),
          ),

          const SizedBox(height: 8),

          // Footnote: DISPATCH VELOCITY: FAST / 72% CLEARED
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DISPATCH VELOCITY: FAST',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF6B7280),
                  fontSize: 8.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(_progress * 100).toInt()}% CLEARED',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF8E99AA),
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 6. Verified Concertgoers Advancing (Live Stream of Avatars)
  Widget _buildAdvancingAvatars() {
    final attendees = [
      {
        'id': '#039',
        'status': 'CHOOSING',
        'statusColor': const Color(0xFF10B981),
        'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=150&auto=format&fit=crop',
        'isYou': false,
      },
      {
        'id': '#040',
        'status': 'CHOOSING',
        'statusColor': const Color(0xFF10B981),
        'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=150&auto=format&fit=crop',
        'isYou': false,
      },
      {
        'id': '#041',
        'status': 'NEXT UP',
        'statusColor': const Color(0xFF00E5FF),
        'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=150&auto=format&fit=crop',
        'isYou': false,
      },
      {
        'id': 'YOU #042',
        'status': 'HOLDING',
        'statusColor': const Color(0xFFFFBE1A),
        'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=150&auto=format&fit=crop',
        'isYou': true,
      },
      {
        'id': '#043',
        'status': 'WAITING',
        'statusColor': const Color(0xFF6B7280),
        'avatar': 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?q=80&w=150&auto=format&fit=crop',
        'isYou': false,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1219),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1E2432),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'VERIFIED CONCERTGOERS ADVANCING',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF8E99AA),
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                ),
              ),
              Text(
                'ADMITTING TO SEATING',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF00E5FF),
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Avatars Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: attendees.map((person) {
              final isYou = person['isYou'] as bool;
              return Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isYou
                            ? const Color(0xFFFFBE1A)
                            : (person['statusColor'] as Color).withValues(alpha: 0.6),
                        width: isYou ? 2.2 : 1.2,
                      ),
                      boxShadow: isYou
                          ? [
                              BoxShadow(
                                color: const Color(0xFFFFBE1A).withValues(alpha: 0.4),
                                blurRadius: 8,
                                spreadRadius: 1,
                              )
                            ]
                          : null,
                      image: DecorationImage(
                        image: NetworkImage(person['avatar'] as String),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    person['id'] as String,
                    style: GoogleFonts.robotoMono(
                      color: isYou ? const Color(0xFFFFBE1A) : Colors.white,
                      fontSize: 8.5,
                      fontWeight: isYou ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                  Text(
                    person['status'] as String,
                    style: GoogleFonts.robotoMono(
                      color: person['statusColor'] as Color,
                      fontSize: 7.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // 7. Queue Integrity Protocol Box
  Widget _buildQueueIntegrityBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1218),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1E2430),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    size: 13,
                    color: Color(0xFF00E5FF),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'QUEUE INTEGRITY PROTOCOL',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFF00E5FF),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
              Text(
                'STUB::V3',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF6B7280),
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Bullet 1: Hardware-fingerprinted
          _buildProtocolBullet(
            icon: Icons.check_circle_outline,
            iconColor: const Color(0xFF10B981),
            text:
                'This queue cannot be bypassed, paid into, or expedited with bot scripts. All traffic is hardware-fingerprinted.',
          ),

          const SizedBox(height: 8),

          // Bullet 2: Cryptographically signed to Aadhaar
          _buildProtocolBullet(
            icon: Icons.fingerprint,
            iconColor: const Color(0xFF00E5FF),
            text:
                'Your position is cryptographically signed to your Aadhaar-linked phone (+91 98201 •••••).',
          ),

          const SizedBox(height: 8),

          // Bullet 3: Session timeout warning
          _buildProtocolBullet(
            icon: Icons.timer_outlined,
            iconColor: const Color(0xFFFFBE1A),
            text:
                'Session timeout warning: You will have exactly 10 minutes to complete seat selection once through.',
            highlight: true,
          ),

          const SizedBox(height: 12),

          // Hash line
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'HASH: 7f8a9...b401e_STUB_MU_',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF4B5565),
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'VERIFIED SAFE',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF10B981),
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProtocolBullet({
    required IconData icon,
    required Color iconColor,
    required String text,
    bool highlight = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 13, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: highlight ? const Color(0xFFE2E8F0) : const Color(0xFF9AA4B2),
              fontSize: 10.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  // 8. Keep This Screen Open & Test Instant SMS Ping Box
  Widget _buildKeepScreenOpenBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF121620),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF222B3C),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.notifications_active_outlined,
                size: 16,
                color: Color(0xFFFFBE1A),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keep this screen open',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Please keep this window open or enable push alerts. You will receive an instant SMS token if your turn approaches.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9AA4B2),
                        fontSize: 10.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Test Instant SMS & Vibration Ping Button
          GestureDetector(
            onTap: _testPing,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(
                color: const Color(0xFF1B2230),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _pingSent
                      ? const Color(0xFF10B981)
                      : const Color(0xFF2E3A50),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sensors,
                    size: 15,
                    color: _pingSent
                        ? const Color(0xFF10B981)
                        : const Color(0xFF00E5FF),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _pingSent
                        ? 'Ping Sent Successfully!'
                        : 'Test Instant SMS & Vibration Ping',
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
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

  // 9. Leave Queue Button
  Widget _buildLeaveQueueButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF141822),
            title: Text(
              'LEAVE QUEUE?',
              style: GoogleFonts.bebasNeue(color: Colors.white, fontSize: 20),
            ),
            content: Text(
              'Your position #042 will be forfeited and given to the next verified fan.',
              style: GoogleFonts.inter(color: const Color(0xFF9AA4B2), fontSize: 12),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('STAY IN LINE'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  foregroundColor: Colors.white,
                ),
                child: const Text('FORFEIT POSITION'),
              ),
            ],
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cancel_outlined,
            size: 12,
            color: Color(0xFF6B7280),
          ),
          const SizedBox(width: 5),
          Text(
            'Leave Queue (Position will be forfeited)',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF6B7280),
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
