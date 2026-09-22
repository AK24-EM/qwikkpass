import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Colour tokens ─────────────────────────────────────────────────────────
class _C {
  static const bg = Color(0xFF090B0E);
  static const surface = Color(0xFF131722);
  static const surfaceDeep = Color(0xFF0B0D14);
  static const border = Color(0xFF1E2535);
  static const borderMid = Color(0xFF2B3248);
  static const gold = Color(0xFFFFBE1A);
  static const teal = Color(0xFF2DD4BF);
  static const green = Color(0xFF10B981);
  static const textPrimary = Color(0xFFEAEEF4);
  static const textSecondary = Color(0xFF8B96A8);
  static const textMuted = Color(0xFF4F5A6E);
}

// ─── Verification step enum ─────────────────────────────────────────────────
enum _VerifyStep { phone, otp, digilocker, done }

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  // ── Step state ─────────────────────────────────────────────────────────────
  _VerifyStep _step = _VerifyStep.phone;

  // ── City ───────────────────────────────────────────────────────────────────
  String _selectedCity = 'MUMBAI';
  final _cities = ['MUMBAI', 'BENGALURU', 'DELHI-NCR', 'HYDERABAD', 'PUNE', 'CHENNAI'];

  // ── Phone ─────────────────────────────────────────────────────────────────
  final _phoneController = TextEditingController();
  final _phoneFocus = FocusNode();

  // ── OTP ───────────────────────────────────────────────────────────────────
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());
  int _timerSeconds = 60;
  Timer? _otpTimer;

  // ── Misc ──────────────────────────────────────────────────────────────────
  int _scalpersBanned = 42810;
  Timer? _scalperTimer;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  // ─── Lifecycle ─────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );

    // Scalper counter ticks up randomly
    _scalperTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (mounted) {
        setState(() {
          _scalpersBanned += (1 + (DateTime.now().millisecond % 4));
        });
      }
    });
  }

  @override
  void dispose() {
    _otpTimer?.cancel();
    _scalperTimer?.cancel();
    _pulseCtrl.dispose();
    _phoneController.dispose();
    _phoneFocus.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  // ─── OTP Timer ─────────────────────────────────────────────────────────────
  void _startOtpTimer() {
    _otpTimer?.cancel();
    setState(() => _timerSeconds = 60);
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        t.cancel();
      }
    });
  }

  // ─── Step helpers ──────────────────────────────────────────────────────────
  void _sendOtp() {
    if (_phoneController.text.length < 10) return;
    _startOtpTimer();
    setState(() => _step = _VerifyStep.otp);
    Future.delayed(const Duration(milliseconds: 250), () {
      _otpFocusNodes.first.requestFocus();
    });
  }

  void _verifyOtp() {
    final code = _otpControllers.map((c) => c.text).join();
    if (code.length < 6) return;
    setState(() => _step = _VerifyStep.digilocker);
  }

  void _linkDigilocker() {
    setState(() => _step = _VerifyStep.done);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    });
  }

  // ─── BUILD ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 32),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildHeroBanner(),
                    const SizedBox(height: 14),
                    _buildManifestCard(),
                    const SizedBox(height: 16),
                    _buildStepProgressBar(),
                    const SizedBox(height: 16),
                    // ── Step cards ─────────────────────────────────────────
                    if (_step == _VerifyStep.phone) _buildPhoneCard(),
                    if (_step == _VerifyStep.otp) _buildOtpCard(),
                    if (_step == _VerifyStep.digilocker) _buildDigiLockerCard(),
                    if (_step == _VerifyStep.done) _buildDoneCard(),
                    const SizedBox(height: 16),
                    // ── Always visible below step card ─────────────────────
                    _buildCitySection(),
                    const SizedBox(height: 16),
                    _buildAntiBotStubCard(),
                    const SizedBox(height: 18),
                    _buildSessionPersistenceCard(),
                    const SizedBox(height: 18),
                    _buildVerifyCtaButton(),
                    const SizedBox(height: 10),
                    _buildSecurityCaption(),
                    const SizedBox(height: 16),
                    _buildLiveStatusBar(),
                    const SizedBox(height: 20),
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

  // ═══════════════════════════════════════════════════════════════════════════
  // APP BAR
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          // Stub wordmark
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF1A2030),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _C.borderMid),
            ),
            child: const Icon(Icons.confirmation_number, color: _C.gold, size: 14),
          ),
          const SizedBox(width: 8),
          Text(
            'Stub',
            style: GoogleFonts.bebasNeue(color: _C.textPrimary, fontSize: 20, letterSpacing: 1),
          ),
          const SizedBox(width: 10),
          // City pill
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/city-selector'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF141A26),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _C.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('BOM', style: GoogleFonts.robotoMono(color: _C.gold, fontSize: 10, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 4),
                  Text('Mumbai', style: GoogleFonts.inter(color: _C.textPrimary, fontSize: 11, fontWeight: FontWeight.w500)),
                  const Icon(Icons.arrow_drop_down, color: Colors.white54, size: 15),
                ],
              ),
            ),
          ),
          const Spacer(),
          // Verified badge pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _C.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _C.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.shield_outlined, color: Color(0xFF7A90B0), size: 12),
                const SizedBox(width: 5),
                Text(
                  'VERIFIED 1-ID-1-TICKET',
                  style: GoogleFonts.robotoMono(color: const Color(0xFF8DA5BF), fontSize: 8.5, fontWeight: FontWeight.w700, letterSpacing: 0.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HERO BANNER
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeroBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _C.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?q=80&w=900&auto=format&fit=crop',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) { return Container(color: const Color(0xFF151C2A)); },
            ),
            // Dual gradient: top-down dark + left amber tint
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xCC000000), Color(0x55000000), Color(0xEE000000)],
                  stops: [0.0, 0.35, 1.0],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [_C.gold.withValues(alpha: 0.08), Colors.transparent],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tag row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: _C.gold.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: _C.gold.withValues(alpha: 0.35)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.verified_outlined, color: _C.gold, size: 11),
                            const SizedBox(width: 4),
                            Text('STUB FAIR TICKETING INITIATIVE',
                                style: GoogleFonts.robotoMono(color: _C.gold, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FAIR ACCESS TO EVERY\nLIVE EXPERIENCE.',
                        style: GoogleFonts.bebasNeue(color: Colors.white, fontSize: 30, height: 1.05, letterSpacing: 0.8),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'One verified identity. One ticket. No scalpers.',
                        style: GoogleFonts.inter(color: _C.textSecondary, fontSize: 11, height: 1.3),
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

  // ═══════════════════════════════════════════════════════════════════════════
  // MANIFEST CARD
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildManifestCard() {
    final points = [
      ('No dynamic pricing — face-value tickets only.', Icons.price_check_outlined),
      ('Verified identity; 1:1 ticket allocation per Aadhaar.', Icons.fingerprint),
      ('Fair queue that bots cannot skip or game.', Icons.queue_outlined),
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _C.border),
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.bolt, color: _C.gold, size: 16),
              const SizedBox(width: 8),
              Text('WHY THIS SCREEN EXISTS',
                  style: GoogleFonts.robotoMono(color: _C.textSecondary, fontSize: 9.5, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
            ],
          ),
          const SizedBox(height: 10),
          ...points.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: _C.gold.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(p.$2, color: _C.gold, size: 14),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(p.$1,
                          style: GoogleFonts.inter(color: _C.textSecondary, fontSize: 12, height: 1.4)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // STEP PROGRESS BAR  (Phone → OTP → DigiLocker → Done)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildStepProgressBar() {
    final steps = ['MOBILE', 'OTP', 'ID LINK', 'DONE'];
    final current = _step.index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('IDENTITY VERIFICATION',
                  style: GoogleFonts.robotoMono(color: _C.textMuted, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
              const Spacer(),
              Text('STEP ${current + 1} / 4',
                  style: GoogleFonts.robotoMono(color: _C.gold, fontSize: 9, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(steps.length, (i) {
              final done = i < current;
              final active = i == current;
              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            height: 3,
                            decoration: BoxDecoration(
                              color: done
                                  ? _C.green
                                  : active
                                      ? _C.gold
                                      : _C.border,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            steps[i],
                            style: GoogleFonts.robotoMono(
                              color: done ? _C.green : active ? _C.gold : _C.textMuted,
                              fontSize: 7.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (i < steps.length - 1) const SizedBox(width: 4),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // STEP 01 – PHONE
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPhoneCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _C.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              _stepChip('01'),
              const SizedBox(width: 8),
              Text('INDIAN MOBILE PASSPORT',
                  style: GoogleFonts.robotoMono(color: _C.textPrimary, fontSize: 11, fontWeight: FontWeight.w700)),
              const Spacer(),
              _tagPill('INSTANT OTP', _C.teal, const Color(0xFF0C2420), const Color(0xFF114E46)),
            ],
          ),
          const SizedBox(height: 14),
          // Input
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: _C.surfaceDeep,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _C.border),
            ),
            child: Row(
              children: [
                Text('🇮🇳  +91', style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                Container(width: 1, height: 22, color: _C.borderMid, margin: const EdgeInsets.symmetric(horizontal: 12)),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    focusNode: _phoneFocus,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 1.5),
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: '9876543210',
                      hintStyle: GoogleFonts.robotoMono(color: _C.textMuted, fontSize: 15, letterSpacing: 1.5),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _sendOtp,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(color: _C.gold, shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_forward, color: Colors.black, size: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.lock_outline, color: _C.textMuted, size: 11),
              const SizedBox(width: 5),
              Text('End-to-end encrypted • No number stored on servers',
                  style: GoogleFonts.inter(color: _C.textMuted, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 14),
          // Send OTP button
          GestureDetector(
            onTap: _sendOtp,
            child: Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: _C.gold,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text('SEND OTP',
                    style: GoogleFonts.inter(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 0.4)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // STEP 02 – OTP
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildOtpCard() {
    final expired = _timerSeconds == 0;
    final timerStr = '00:${_timerSeconds.toString().padLeft(2, '0')} SEC';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _C.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _stepChip('02'),
              const SizedBox(width: 8),
              Text('THERMAL 6-DIGIT TOTP',
                  style: GoogleFonts.robotoMono(color: _C.textPrimary, fontSize: 11, fontWeight: FontWeight.w700)),
              const Spacer(),
              AnimatedOpacity(
                opacity: expired ? 0.5 : 1.0,
                duration: const Duration(milliseconds: 400),
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: expired ? _C.textMuted : _C.gold,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(expired ? 'EXPIRED' : timerStr,
                        style: GoogleFonts.robotoMono(
                          color: expired ? _C.textMuted : _C.gold,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Sent to +91 ${_phoneController.text}',
            style: GoogleFonts.inter(color: _C.textSecondary, fontSize: 11),
          ),
          const SizedBox(height: 16),
          // 6 boxes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (i) {
              return SizedBox(
                width: 44,
                height: 50,
                child: TextField(
                  controller: _otpControllers[i],
                  focusNode: _otpFocusNodes[i],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: _C.surfaceDeep,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: _C.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: _C.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: _C.gold, width: 1.5),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (v) {
                    if (v.isNotEmpty && i < 5) {
                      _otpFocusNodes[i + 1].requestFocus();
                    } else if (v.isEmpty && i > 0) {
                      _otpFocusNodes[i - 1].requestFocus();
                    }
                    setState(() {});
                  },
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('VIA ENCRYPTED SMS GATEWAY',
                  style: GoogleFonts.robotoMono(color: _C.textMuted, fontSize: 8, letterSpacing: 0.3, fontWeight: FontWeight.w600)),
              GestureDetector(
                onTap: expired ? () => setState(() { _startOtpTimer(); }) : null,
                child: Text(
                  expired ? 'RESEND CODE' : 'RESEND IN ${_timerSeconds}s',
                  style: GoogleFonts.robotoMono(
                    color: expired ? _C.textPrimary : _C.textMuted,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: _verifyOtp,
            child: Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: _C.gold,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text('VERIFY CODE',
                    style: GoogleFonts.inter(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 0.4)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // STEP 03 – DIGILOCKER IDENTITY LINK
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDigiLockerCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _C.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _stepChip('03'),
              const SizedBox(width: 8),
              Text('LINK GOVT ID VAULT',
                  style: GoogleFonts.robotoMono(color: _C.textPrimary, fontSize: 11, fontWeight: FontWeight.w700)),
              const Spacer(),
              _tagPill('ONE-TIME', _C.teal, const Color(0xFF0C2420), const Color(0xFF114E46)),
            ],
          ),
          const SizedBox(height: 12),

          // Aadhaar / DigiLocker info card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _C.surfaceDeep,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _C.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B1D2A),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF144060)),
                  ),
                  child: const Icon(Icons.verified_user_outlined, color: _C.teal, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Government DigiLocker / Govt ID Vault',
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 3),
                      Text('Aadhaar-backed cryptographic handshake via Setu & UIDAI',
                          style: GoogleFonts.inter(color: _C.textSecondary, fontSize: 10.5, height: 1.3)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // What this does
          _infoRow(Icons.lock_person_outlined, 'Ticket cryptographically bound to your Aadhaar identity'),
          _infoRow(Icons.no_photography_outlined, 'No Aadhaar number stored — only a one-way hash'),
          _infoRow(Icons.sync_outlined, 'ID session persists across all bookings, queues, and resale'),
          const SizedBox(height: 14),

          // Feature badges
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _featureBadge('0% SCALPER MARKUP'),
              _featureBadge('DIRECT GATE ENTRY'),
              _featureBadge('1:1 VERIFIED'),
              _featureBadge('FACE-VALUE ONLY'),
            ],
          ),
          const SizedBox(height: 16),

          GestureDetector(
            onTap: _linkDigilocker,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: _C.gold,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('LINK DIGILOCKER & VERIFY',
                      style: GoogleFonts.inter(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 0.4)),
                  const SizedBox(height: 1),
                  Text('ZERO BOTS ALLOWED',
                      style: GoogleFonts.robotoMono(color: Colors.black87, fontSize: 8.5, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // STEP 04 – DONE
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDoneCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1E16),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF134028)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: _C.green.withValues(alpha: 0.18), shape: BoxShape.circle),
            child: const Icon(Icons.check_circle_rounded, color: _C.green, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('IDENTITY VERIFIED', style: GoogleFonts.bebasNeue(color: _C.green, fontSize: 22, letterSpacing: 0.8)),
                Text('Entering the fair zone…', style: GoogleFonts.inter(color: _C.textSecondary, fontSize: 11.5)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(_C.green)),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CITY HUB SELECTOR
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCitySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SELECT HOME BASE HUB',
                  style: GoogleFonts.robotoMono(color: _C.textMuted, fontSize: 9.5, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              Text('INDIA (METRO)',
                  style: GoogleFonts.robotoMono(color: _C.textMuted, fontSize: 9.5, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _cities.map((city) {
              final sel = city == _selectedCity;
              return GestureDetector(
                onTap: () => setState(() => _selectedCity = city),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: sel ? _C.gold : const Color(0xFF131822),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: sel ? _C.gold : _C.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (sel) ...[
                        Container(width: 5, height: 5, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle)),
                        const SizedBox(width: 5),
                      ],
                      Text(city,
                          style: GoogleFonts.robotoMono(
                            color: sel ? Colors.black : _C.textSecondary,
                            fontSize: 10.5,
                            fontWeight: sel ? FontWeight.w800 : FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ANTI-BOT STUB CARD  (ticket-shape with notch & dashed perforation)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildAntiBotStubCard() {
    const punchPos = 110.0;
    const punchR = 10.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomPaint(
        foregroundPainter: _TicketBorderPainter(punchR, punchPos, _C.border),
        child: ClipPath(
          clipper: _TicketClipper(punchR, punchPos),
          child: Container(
            color: _C.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── UPPER section ─────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.security_outlined, color: Colors.white, size: 15),
                          const SizedBox(width: 7),
                          Text('ANTI-BOT SECURITY PROTOCOL',
                              style: GoogleFonts.robotoMono(color: _C.textPrimary, fontSize: 10.5, fontWeight: FontWeight.w700, letterSpacing: 0.3)),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A2030),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: _C.borderMid),
                            ),
                            child: Text('V2.4', style: GoogleFonts.robotoMono(color: _C.textSecondary, fontSize: 9, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _C.surfaceDeep,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _C.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('1 VERIFIED AADHAAR/DIGILOCKER ID = MAX 1–2 TICKETS PER SHOW',
                                style: GoogleFonts.robotoMono(
                                  color: _C.gold, fontSize: 9.5, fontWeight: FontWeight.w800, height: 1.3)),
                            const SizedBox(height: 3),
                            Text('No secondary-market inflation. Strict face-value resale only.',
                                style: GoogleFonts.inter(color: _C.textSecondary, fontSize: 10.5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ── LOWER section (below perforation) ─────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0B1D2A),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFF144060)),
                            ),
                            child: const Icon(Icons.verified_user_outlined, color: _C.teal, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Government DigiLocker / Govt ID Vault',
                                    style: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 2),
                                Text('Secured via Setu & UIDAI Cryptographic Handshake',
                                    style: GoogleFonts.robotoMono(color: _C.textSecondary, fontSize: 9.5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _featureBadge('0% SCALPER MARKUP'),
                          _featureBadge('DIRECT GATE ENTRY'),
                        ],
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

  // ═══════════════════════════════════════════════════════════════════════════
  // SESSION PERSISTENCE CARD
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSessionPersistenceCard() {
    final items = [
      (Icons.confirmation_number_outlined, 'BOOKING', 'Skip re-verify mid-checkout'),
      (Icons.queue_outlined, 'QUEUEING', 'Position locked to your identity'),
      (Icons.group_outlined, 'GROUP SPLIT', 'Each member verified separately'),
      (Icons.swap_horiz_outlined, 'RESALE', 'Face-value transfer, bot-proof'),
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _C.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.cached_rounded, color: _C.teal, size: 15),
              const SizedBox(width: 7),
              Text('ID SESSION PERSISTS ACROSS',
                  style: GoogleFonts.robotoMono(color: _C.textSecondary, fontSize: 9.5, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: items.map((it) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: it.$1 == items.last.$1 ? 0 : 8),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                  decoration: BoxDecoration(
                    color: _C.surfaceDeep,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _C.border),
                  ),
                  child: Column(
                    children: [
                      Icon(it.$1, color: _C.teal, size: 18),
                      const SizedBox(height: 5),
                      Text(it.$2,
                          style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 3),
                      Text(it.$3,
                          style: GoogleFonts.inter(color: _C.textMuted, fontSize: 8.5, height: 1.2),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // VERIFY CTA BUTTON  (visible only on non-phone step cards, but always shown)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildVerifyCtaButton() {
    // On digilocker/done step, use the step card's own button; here it's a contextual nudge.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          if (_step == _VerifyStep.phone) {
            _sendOtp();
          } else if (_step == _VerifyStep.otp) {
            _verifyOtp();
          } else if (_step == _VerifyStep.digilocker) {
            _linkDigilocker();
          } else {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            color: _C.gold,
            borderRadius: BorderRadius.circular(27),
            boxShadow: [
              BoxShadow(color: _C.gold.withValues(alpha: 0.35), blurRadius: 16, offset: const Offset(0, 6)),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('VERIFY & ENTER',
                  style: GoogleFonts.inter(color: Colors.black, fontSize: 14.5, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
              const SizedBox(height: 1),
              Text('ZERO BOTS ALLOWED',
                  style: GoogleFonts.robotoMono(color: Colors.black87, fontSize: 8.5, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECURITY CAPTION
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSecurityCaption() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.info_outline, color: _C.textMuted, size: 11),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                'Tap to link DigiLocker securely. No Aadhaar number stored.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(color: _C.textMuted, fontSize: 10, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LIVE SYSTEM STATUS BAR
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildLiveStatusBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _C.border),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _pulseAnim,
            builder: (context, _) => Opacity(
              opacity: _pulseAnim.value,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: _C.green,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: _C.green.withValues(alpha: 0.7), blurRadius: 5, spreadRadius: 1)],
                ),
              ),
            ),
          ),
          const SizedBox(width: 7),
          Text('SYS_STATUS: ', style: GoogleFonts.robotoMono(color: _C.textMuted, fontSize: 9, fontWeight: FontWeight.w600)),
          Text('100% BOT-FREE  ', style: GoogleFonts.robotoMono(color: _C.green, fontSize: 9, fontWeight: FontWeight.w700)),
          Text('•  ', style: TextStyle(color: _C.textMuted, fontSize: 9)),
          Expanded(
            child: Text(
              '${_formatCount(_scalpersBanned)} SCALPERS BANNED',
              style: GoogleFonts.robotoMono(color: _C.gold, fontSize: 9, fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BOTTOM NAV
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBottomNav() {
    final items = [
      (Icons.explore, 'DISCOVER', 0),
      (Icons.confirmation_number_outlined, 'STUBS', 1),
      (Icons.sync_alt_rounded, 'EXCHANGE', 2),
      (Icons.shield_outlined, 'VAULT', 3),
    ];
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: const Color(0xFF0B0D12),
        border: Border(top: BorderSide(color: _C.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((it) {
            final active = it.$3 == 0; // DISCOVER is active on this screen
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (it.$3 == 0) Navigator.pushReplacementNamed(context, '/home');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(it.$1, color: active ? _C.gold : _C.textMuted, size: 22),
                        if (it.$3 == 1)
                          Positioned(
                            top: -3,
                            right: -7,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: const BoxDecoration(color: _C.gold, shape: BoxShape.circle),
                              child: const Center(
                                child: Text('2', style: TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.w900)),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(it.$2,
                        style: GoogleFonts.robotoMono(
                          color: active ? _C.gold : _C.textMuted,
                          fontSize: 9,
                          fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                        )),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SMALL HELPERS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _stepChip(String num) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _C.gold.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: _C.gold.withValues(alpha: 0.4)),
        ),
        child: Text('STEP $num', style: GoogleFonts.robotoMono(color: _C.gold, fontSize: 9, fontWeight: FontWeight.w800)),
      );

  Widget _tagPill(String label, Color fg, Color bg, Color border) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4), border: Border.all(color: border)),
        child: Text(label, style: GoogleFonts.robotoMono(color: fg, fontSize: 8.5, fontWeight: FontWeight.w700)),
      );

  Widget _featureBadge(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: _C.surfaceDeep,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: _C.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline, color: _C.teal, size: 11),
            const SizedBox(width: 5),
            Text(label, style: GoogleFonts.robotoMono(color: _C.teal, fontSize: 8.5, fontWeight: FontWeight.w700)),
          ],
        ),
      );

  Widget _infoRow(IconData icon, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: _C.teal, size: 14),
            const SizedBox(width: 8),
            Expanded(child: Text(text, style: GoogleFonts.inter(color: _C.textSecondary, fontSize: 11.5, height: 1.35))),
          ],
        ),
      );

  String _formatCount(int n) {
    if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(1)}K';
    }
    return n.toString();
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// TICKET CLIP SHAPES
// ══════════════════════════════════════════════════════════════════════════════
class _TicketClipper extends CustomClipper<Path> {
  final double punchRadius;
  final double punchPosition;
  _TicketClipper(this.punchRadius, this.punchPosition);

  @override
  Path getClip(Size size) {
    const r = 10.0;
    final p = Path()
      ..moveTo(r, 0)
      ..lineTo(size.width - r, 0)
      ..arcToPoint(Offset(size.width, r), radius: const Radius.circular(r))
      ..lineTo(size.width, punchPosition - punchRadius)
      ..arcToPoint(Offset(size.width, punchPosition + punchRadius),
          radius: Radius.circular(punchRadius), clockwise: false)
      ..lineTo(size.width, size.height - r)
      ..arcToPoint(Offset(size.width - r, size.height), radius: const Radius.circular(r))
      ..lineTo(r, size.height)
      ..arcToPoint(Offset(0, size.height - r), radius: const Radius.circular(r))
      ..lineTo(0, punchPosition + punchRadius)
      ..arcToPoint(Offset(0, punchPosition - punchRadius),
          radius: Radius.circular(punchRadius), clockwise: false)
      ..lineTo(0, r)
      ..arcToPoint(const Offset(r, 0), radius: const Radius.circular(r))
      ..close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> old) => false;
}

class _TicketBorderPainter extends CustomPainter {
  final double punchRadius;
  final double punchPosition;
  final Color borderColor;
  _TicketBorderPainter(this.punchRadius, this.punchPosition, this.borderColor);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      _TicketClipper(punchRadius, punchPosition).getClip(size),
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
    // Dashed perforation
    final dashPaint = Paint()
      ..color = borderColor.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    double x = punchRadius + 4;
    final endX = size.width - punchRadius - 4;
    while (x < endX) {
      canvas.drawLine(Offset(x, punchPosition), Offset(x + 4, punchPosition), dashPaint);
      x += 8;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
