import 'package:flutter/material.dart';
import 'package:nutrido/screens/signin_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Initial values
  final String _initialName = "Dhiraj Sinha";
  final String _initialEmail = "dhirajsinha525@gmail.com";
  final String _initialAbout = "I am a nutrition enthusiast who loves tracking my food intake and maintaining a healthy lifestyle.";
  
  // Controllers for text fields
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _aboutController;
  
  // Track if changes have been made
  bool _hasChanges = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _initialName);
    _emailController = TextEditingController(text: _initialEmail);
    _aboutController = TextEditingController(text: _initialAbout);
    
    // Add listeners to detect changes
    _nameController.addListener(_checkForChanges);
    _emailController.addListener(_checkForChanges);
    _aboutController.addListener(_checkForChanges);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  void _checkForChanges() {
    setState(() {
      _hasChanges = _nameController.text != _initialName ||
                   _emailController.text != _initialEmail ||
                   _aboutController.text != _initialAbout;
    });
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing && !_hasChanges) {
        // Reset to initial values if canceled without changes
        _nameController.text = _initialName;
        _emailController.text = _initialEmail;
        _aboutController.text = _initialAbout;
      }
    });
  }

  void _saveChanges() {
    // Here you would typically save to a database or shared preferences
    // For this example, we'll just update the "initial" values
    setState(() {
      // In a real app, you would save these values to persistent storage
      _hasChanges = false;
      _isEditing = false;
      
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Color(0xFFACC8A2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.close : Icons.edit,
              color: Colors.white,
            ),
            onPressed: _toggleEditing,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Profile Image
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[800],
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white70,
                      ),
                    ),
                    if (_isEditing)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFACC8A2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                
                // Name
                _isEditing
                    ? _buildTextField(_nameController, "Name", Icons.person)
                    : Text(
                        _nameController.text,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                const SizedBox(height: 10),
                
                // Email
                _isEditing
                    ? _buildTextField(_emailController, "Email", Icons.email)
                    : Text(
                        _emailController.text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                        ),
                      ),
                const SizedBox(height: 30),
                
                // About section
                if (_isEditing || _aboutController.text.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: Text(
                          "About",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      _isEditing
                          ? _buildTextField(
                              _aboutController,
                              "Tell us about yourself",
                              Icons.info_outline,
                              maxLines: 4,
                            )
                          : Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _aboutController.text,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                    ],
                  ),
                
                const SizedBox(height: 40),
                
                // Save button (only shows when editing and changes made)
                if (_isEditing && _hasChanges)
                  SizedBox(
                    width: 240,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _saveChanges,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFACC8A2),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                
                const SizedBox(height: 20),
                
                // Logout Button
                SizedBox(
                  width: 240,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SigninScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFACC8A2),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
        ),
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontFamily: 'Poppins',
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.grey[500],
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}

