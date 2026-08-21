
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/lawyer_client_model.dart';
import '../providers/lawyer_clients_provider.dart';


class ClientProfileUpdateScreen extends ConsumerStatefulWidget {
  final String clientId;

  const ClientProfileUpdateScreen({
    super.key,
    required this.clientId,
  });

  @override
  ConsumerState<ClientProfileUpdateScreen> createState() =>
      _ClientProfileUpdateScreenState();
}

class _ClientProfileUpdateScreenState
    extends ConsumerState<ClientProfileUpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _cityController;
  late TextEditingController _caseTitleController;
  late TextEditingController _caseStatusController;
  late TextEditingController _activeCasesController;
  late TextEditingController _totalCasesController;

  LawyerClientModel? _client;

  @override
  void initState() {
    super.initState();

    final client = ref
        .read(lawyerClientsProvider.notifier)
        .getClientById(widget.clientId);

    _client = client;

    _nameController = TextEditingController(
      text: client?.name ?? '',
    );

    _phoneController = TextEditingController(
      text: client?.phone ?? '',
    );

    _emailController = TextEditingController(
      text: client?.email ?? '',
    );

    _cityController = TextEditingController(
      text: client?.city ?? '',
    );

    _caseTitleController = TextEditingController(
      text: client?.caseTitle ?? '',
    );

    _caseStatusController = TextEditingController(
      text: client?.caseStatus ?? '',
    );

    _activeCasesController = TextEditingController(
      text: client?.activeCases.toString() ?? '0',
    );

    _totalCasesController = TextEditingController(
      text: client?.totalCases.toString() ?? '0',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _caseTitleController.dispose();
    _caseStatusController.dispose();
    _activeCasesController.dispose();
    _totalCasesController.dispose();

    super.dispose();
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final client = _client;

    if (client == null) {
      return;
    }

    final activeCases =
        int.tryParse(_activeCasesController.text.trim()) ?? 0;

    final totalCases =
        int.tryParse(_totalCasesController.text.trim()) ?? 0;

    final updatedClient = client.copyWith(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      city: _cityController.text.trim(),
      caseTitle: _caseTitleController.text.trim(),
      caseStatus: _caseStatusController.text.trim(),
      activeCases: activeCases,
      totalCases: totalCases,
    );

    ref
        .read(lawyerClientsProvider.notifier)
        .updateClient(updatedClient);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Client profile updated successfully.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF13294B);
    const gold = Color(0xFFD4AF37);
    const background = Color(0xFFF5F7FB);

    if (_client == null) {
      return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Update Client Profile',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const Center(
          child: Text(
            'Client not found.',
            style: TextStyle(
              color: navy,
              fontSize: 15,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Update Client Profile',
          style: TextStyle(
            color: navy,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              40,
            ),
            children: [
              // ==================================================
              // PROFILE HEADER
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 82,
                      height: 82,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: gold,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 42,
                        color: gold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Edit Client Information',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Update the client information maintained in your records.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // PERSONAL INFORMATION
              // ==================================================

              _SectionCard(
                title: 'Personal Information',
                icon: Icons.person_outline_rounded,
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Client Name',
                    icon: Icons.person_outline_rounded,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter client name.';
                      }

                      return null;
                    },
                  ),

                  _buildTextField(
                    controller: _phoneController,
                    label: 'Phone',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter phone number.';
                      }

                      return null;
                    },
                  ),

                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  _buildTextField(
                    controller: _cityController,
                    label: 'City',
                    icon: Icons.location_on_outlined,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter city.';
                      }

                      return null;
                    },
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ==================================================
              // CASE INFORMATION
              // ==================================================

              _SectionCard(
                title: 'Case Information',
                icon: Icons.gavel_outlined,
                children: [
                  _buildTextField(
                    controller: _caseTitleController,
                    label: 'Current Case',
                    icon: Icons.description_outlined,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter case title.';
                      }

                      return null;
                    },
                  ),

                  _buildTextField(
                    controller: _caseStatusController,
                    label: 'Case Status',
                    icon: Icons.flag_outlined,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter case status.';
                      }

                      return null;
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _activeCasesController,
                          label: 'Active Cases',
                          icon: Icons.folder_open_outlined,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            final number =
                                int.tryParse(value?.trim() ?? '');

                            if (number == null || number < 0) {
                              return 'Invalid number';
                            }

                            return null;
                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _buildTextField(
                          controller: _totalCasesController,
                          label: 'Total Cases',
                          icon: Icons.folder_copy_outlined,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            final number =
                                int.tryParse(value?.trim() ?? '');

                            if (number == null || number < 0) {
                              return 'Invalid number';
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ==================================================
              // SAVE BUTTON
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _saveChanges,
                  icon: const Icon(
                    Icons.check_rounded,
                    size: 20,
                  ),
                  label: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ==================================================
              // CANCEL BUTTON
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: navy,
                    side: const BorderSide(
                      color: Color(0xFFD9DEE7),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(
          color: Color(0xFF13294B),
          fontSize: 13.5,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12.5,
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFFD4AF37),
            size: 21,
          ),
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFD4AF37),
              width: 1.4,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.redAccent,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SECTION CARD
// ============================================================

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.edit_outlined,
                color: Color(0xFFD4AF37),
                size: 21,
              ),
              const SizedBox(width: 9),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF13294B),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ...children,
        ],
      ),
    );
  }
}
