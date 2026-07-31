import 'package:flutter/material.dart';
import 'signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true; // Track password visibility state
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1,
            vertical: size.height * 0.1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "nutriDO",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFFACC8A2), // Mint green color
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Full Name",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Password field with visibility toggle
              TextField(
                obscureText: _obscurePassword,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  // Add password visibility toggle icon
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Fixed Sign Up button - centered with constrained width
              Center(
                child: Container(
                  width: 200, // Fixed width to match the image
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFACC8A2).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SigninScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFACC8A2), // Mint green
                      foregroundColor: Colors.black,
                      elevation: 0, // No default elevation since we're using custom shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Improved Sign In text with animation
              _AnimatedSignInText(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SigninScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedSignInText extends StatefulWidget {
  final VoidCallback onTap;

  const _AnimatedSignInText({required this.onTap});

  @override
  State<_AnimatedSignInText> createState() => _AnimatedSignInTextState();
}

class _AnimatedSignInTextState extends State<_AnimatedSignInText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: _isHovered ? 24 : 16,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: const Color(0xFFACC8A2).withOpacity(_isHovered ? 0.8 : 0),
                width: 2,
              ),
            ),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
              children: [
                const TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                TextSpan(
                  text: "Sign In",
                  style: TextStyle(
                    color: const Color(0xFFACC8A2),
                    fontWeight: FontWeight.bold,
                    fontSize: _isHovered ? 16 : 14,
                    letterSpacing: _isHovered ? 0.5 : 0,
                    shadows: _isHovered
                        ? [
                            BoxShadow(
                              color: const Color(0xFFACC8A2).withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            )
                          ]
                        : [],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}