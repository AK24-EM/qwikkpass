import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qwikpass/core/theme/app_theme.dart';
import 'package:qwikpass/core/widgets/custom_button.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  void _sendOTP() {
    if (_phoneController.text.length == 10) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        Navigator.pushNamed(
          context,
          '/otp-verification',
          arguments: _phoneController.text,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'SECURE LOGIN',
          style: AppTheme.monospaceSmall(context).copyWith(
            fontSize: 11,
            letterSpacing: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Title
              Text(
                'ENTER YOUR\nPHONE NUMBER',
                style: Theme.of(context).textTheme.displaySmall,
              ),

              const SizedBox(height: 16),

              // Subtitle
              Text(
                'We\'ll send you a one-time code to verify your identity. Your number stays private.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.5,
                    ),
              ),

              const SizedBox(height: 40),

              // Phone input
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.cardDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.borderGray,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Country code
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceDark,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '🇮🇳',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '+91',
                            style: AppTheme.monospaceMedium(context),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Phone number input
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: AppTheme.monospaceLarge(context),
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: '98765 43210',
                          hintStyle: AppTheme.monospaceLarge(context).copyWith(
                            color: AppTheme.textTertiary,
                          ),
                          border: InputBorder.none,
                          counterText: '',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Privacy note
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.accentPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.accentPurple.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: 20,
                      color: AppTheme.accentPurple,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'ANTI-BOT SECURITY PROTOCOL',
                        style: AppTheme.monospaceXSmall(context).copyWith(
                          color: AppTheme.accentPurple,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Continue button
              PrimaryButton(
                text: 'Send OTP',
                icon: Icons.arrow_forward,
                onPressed: _phoneController.text.length == 10 ? _sendOTP : null,
                isLoading: _isLoading,
              ),

              const SizedBox(height: 16),

              // Terms
              Center(
                child: Text(
                  'By continuing, you agree to our Terms & Privacy Policy',
                  style: AppTheme.monospaceXSmall(context).copyWith(
                    color: AppTheme.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
