
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/lawyer_onboarding_provider.dart';
import '../widgets/basic/basic_info_profile_photo.dart';
import '../widgets/basic/basic_info_text_field.dart';
import '../widgets/basic/basic_info_gender_selector.dart';
import '../widgets/basic/basic_info_city_field.dart';
import 'lawyer_professional_info_screen.dart';

class LawyerBasicInfoScreen extends ConsumerStatefulWidget {
  const LawyerBasicInfoScreen({super.key});

  @override
  ConsumerState<LawyerBasicInfoScreen> createState() =>
      _LawyerBasicInfoScreenState();
}

class _LawyerBasicInfoScreenState
    extends ConsumerState<LawyerBasicInfoScreen> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  String? _selectedGender;
  String? _selectedCity;
  String? _profileImagePath;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // ============================================================
  // PROFILE PHOTO
  // ============================================================

  Future<void> _pickProfilePhoto() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return;

    setState(() {
      _profileImagePath = image.path;
    });

    ref
        .read(lawyerOnboardingProvider.notifier)
        .updateProfileImage(image.path);
  }

  // ============================================================
  // VALIDATION + SAVE
  // ============================================================

  void _continue() {
  final fullName = _fullNameController.text.trim();
  final phone = _phoneController.text.trim();
  final email = _emailController.text.trim();

  if (fullName.isEmpty) {
    _showMessage('Please enter your full name.');
    return;
  }

  if (fullName.length < 3) {
    _showMessage('Please enter a valid full name.');
    return;
  }

  if (phone.isEmpty) {
    _showMessage('Please enter your phone number.');
    return;
  }

  if (email.isEmpty) {
    _showMessage('Please enter your email address.');
    return;
  }

  if (!email.contains('@')) {
    _showMessage('Please enter a valid email address.');
    return;
  }

  if (_selectedGender == null) {
    _showMessage('Please select your gender.');
    return;
  }

  if (_selectedCity == null) {
    _showMessage('Please select your city.');
    return;
  }

  final notifier =
      ref.read(lawyerOnboardingProvider.notifier);

  // Save basic information.
  notifier.updateFullName(fullName);
  notifier.updatePhoneNumber(phone);
  notifier.updateEmail(email);
  notifier.updateGender(_selectedGender!);
  notifier.updateCity(_selectedCity!);

  // Move to Professional Information.
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const LawyerProfessionalInfoScreen(),
    ),
  );
}

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF13294B);
    const gold = Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Basic Information',
          style: TextStyle(
            color: navy,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: navy,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================================================
              // PROGRESS
              // ==================================================

              const Text(
                'Step 1 of 5',
                style: TextStyle(
                  color: gold,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Tell us about yourself',
                style: TextStyle(
                  color: navy,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Provide your basic information to create your '
                'professional lawyer profile.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 28),

              // ==================================================
              // PROFILE PHOTO
              // ==================================================

              BasicInfoProfilePhoto(
                imagePath: _profileImagePath,
                onTap: _pickProfilePhoto,
              ),

              const SizedBox(height: 30),

              // ==================================================
              // BASIC INFORMATION
              // ==================================================

              BasicInfoTextField(
                controller: _fullNameController,
                label: 'Full Name',
                hint: 'Enter your full name',
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 20),

              BasicInfoTextField(
                controller: _phoneController,
                label: 'Phone Number',
                hint: 'Enter your phone number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 20),

              BasicInfoTextField(
                controller: _emailController,
                label: 'Email Address',
                hint: 'Enter your email address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              // ==================================================
              // GENDER
              // ==================================================

              BasicInfoGenderSelector(
                selectedGender: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // ==================================================
              // CITY
              // ==================================================

              BasicInfoCityField(
                selectedCity: _selectedCity,
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                  });
                },
              ),

              const SizedBox(height: 35),

              // ==================================================
              // CONTINUE BUTTON
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Center(
                child: Text(
                  'You can update your profile information later.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
