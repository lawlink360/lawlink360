import 'package:flutter/material.dart';

class AdminLawyerFilterSheet extends StatelessWidget {
  final String? selectedStatus;
  final String? selectedSpecialization;
  final String? selectedCity;

  final ValueChanged<String?> onStatusChanged;
  final ValueChanged<String?> onSpecializationChanged;
  final ValueChanged<String?> onCityChanged;
  final VoidCallback onClear;

  const AdminLawyerFilterSheet({
    super.key,
    required this.selectedStatus,
    required this.selectedSpecialization,
    required this.selectedCity,
    required this.onStatusChanged,
    required this.onSpecializationChanged,
    required this.onCityChanged,
    required this.onClear,
  });

  static Future<void> show({
    required BuildContext context,
    required String? selectedStatus,
    required String? selectedSpecialization,
    required String? selectedCity,
    required ValueChanged<String?> onStatusChanged,
    required ValueChanged<String?> onSpecializationChanged,
    required ValueChanged<String?> onCityChanged,
    required VoidCallback onClear,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AdminLawyerFilterSheet(
          selectedStatus: selectedStatus,
          selectedSpecialization: selectedSpecialization,
          selectedCity: selectedCity,
          onStatusChanged: onStatusChanged,
          onSpecializationChanged: onSpecializationChanged,
          onCityChanged: onCityChanged,
          onClear: onClear,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const specializations = [
      'Criminal Law',
      'Family Law',
      'Civil Law',
      'Corporate Law',
      'Property Law',
      'Constitutional Law',
      'Labour Law',
      'Immigration Law',
      'Banking Law',
      'Cyber Law',
      'Tax Law',
      'Human Rights Law',
    ];

    const cities = [
      'Lahore',
      'Islamabad',
      'Karachi',
      'Rawalpindi',
      'Faisalabad',
      'Multan',
      'Peshawar',
    ];

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Lawyers',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Divider(),

              const SizedBox(height: 8),

              const Text(
                'Status',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              RadioGroup<String?>(
                groupValue: selectedStatus,
                onChanged: onStatusChanged,
                child: Column(
                  children: [
                    RadioListTile<String?>(
                      value: null,
                      title: const Text('All Lawyers'),
                      contentPadding: EdgeInsets.zero,
                    ),

                    RadioListTile<String?>(
                      value: 'active',
                      title: const Text('Active'),
                      contentPadding: EdgeInsets.zero,
                    ),

                    RadioListTile<String?>(
                      value: 'inactive',
                      title: const Text('Inactive'),
                      contentPadding: EdgeInsets.zero,
                    ),

                    RadioListTile<String?>(
                      value: 'suspended',
                      title: const Text('Suspended'),
                      contentPadding: EdgeInsets.zero,
                    ),

                    RadioListTile<String?>(
                      value: 'pending',
                      title: const Text('Pending'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              const Text(
                'Specialization',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                initialValue: selectedSpecialization,
                decoration: const InputDecoration(
                  labelText: 'Select specialization',
                  border: OutlineInputBorder(),
                ),
                items: specializations.map((specialization) {
                  return DropdownMenuItem<String>(
                    value: specialization,
                    child: Text(specialization),
                  );
                }).toList(),
                onChanged: onSpecializationChanged,
              ),

              const SizedBox(height: 16),

              const Text(
                'City',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                initialValue: selectedCity,
                decoration: const InputDecoration(
                  labelText: 'Select city',
                  border: OutlineInputBorder(),
                ),
                items: cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: onCityChanged,
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onClear,
                  child: const Text('Clear Filters'),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
