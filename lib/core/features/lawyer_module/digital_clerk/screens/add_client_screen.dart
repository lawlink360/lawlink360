import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/client_model.dart';
import '../providers/clerk_providers.dart';

class AddClientScreen extends ConsumerStatefulWidget {
  const AddClientScreen({
    super.key,
    this.clientToEdit,
  });

  final ClientModel? clientToEdit;

  @override
  ConsumerState<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends ConsumerState<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cnicController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final client = widget.clientToEdit;

    if (client != null) {
      _nameController.text = client.name;
      _phoneController.text = client.phone;
      _emailController.text = client.email;
      _addressController.text = client.address;
      _cnicController.text = client.cnic ?? '';
      _notesController.text = client.notes;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cnicController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveClient() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final now = DateTime.now();
    final existingClient = widget.clientToEdit;

    final client = ClientModel(
      id: existingClient?.id ??
          'client_${now.microsecondsSinceEpoch}',
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      address: _addressController.text.trim(),
      cnic: _cnicController.text.trim().isEmpty
          ? null
          : _cnicController.text.trim(),
      notes: _notesController.text.trim(),
      createdAt: existingClient?.createdAt ?? now,
      updatedAt: now,
    );

    if (existingClient == null) {
      ref.read(clerkClientsProvider.notifier).addClient(client);
    } else {
      ref.read(clerkClientsProvider.notifier).updateClient(client);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          existingClient == null
              ? 'Client added successfully.'
              : 'Client updated successfully.',
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.clientToEdit != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          isEditing ? 'Edit Client' : 'Add Client',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(
                icon: Icons.person_outline,
                title: 'Client Information',
              ),

              const SizedBox(height: 12),

              _textField(
                controller: _nameController,
                label: 'Client Name',
                hint: 'Enter client name',
                icon: Icons.person_outline,
                required: true,
              ),

              _textField(
                controller: _phoneController,
                label: 'Phone Number',
                hint: 'Enter phone number',
                icon: Icons.phone_outlined,
                required: true,
                keyboardType: TextInputType.phone,
              ),

              _textField(
                controller: _emailController,
                label: 'Email Address',
                hint: 'Enter email address',
                icon: Icons.email_outlined,
                required: false,
                keyboardType: TextInputType.emailAddress,
              ),

              _textField(
                controller: _cnicController,
                label: 'CNIC',
                hint: 'Enter CNIC number',
                icon: Icons.badge_outlined,
                required: false,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 8),

              _sectionTitle(
                icon: Icons.location_on_outlined,
                title: 'Address',
              ),

              const SizedBox(height: 12),

              _textField(
                controller: _addressController,
                label: 'Client Address',
                hint: 'Enter client address',
                icon: Icons.home_outlined,
                required: false,
                maxLines: 3,
              ),

              const SizedBox(height: 8),

              _sectionTitle(
                icon: Icons.notes_outlined,
                title: 'Notes',
              ),

              const SizedBox(height: 12),

              _textField(
                controller: _notesController,
                label: 'Client Notes',
                hint: 'Add any useful notes about this client',
                icon: Icons.notes_outlined,
                required: false,
                maxLines: 4,
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveClient,
                  icon: Icon(
                    isEditing
                        ? Icons.save_outlined
                        : Icons.person_add_alt_1_outlined,
                  ),
                  label: Text(
                    isEditing ? 'Update Client' : 'Save Client',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF13294B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF13294B),
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF13294B),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool required,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF13294B),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE6EAF0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE6EAF0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFD4AF37),
              width: 1.5,
            ),
          ),
        ),
        validator: required
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return '$label is required';
                }
                return null;
              }
            : null,
      ),
    );
  }
}