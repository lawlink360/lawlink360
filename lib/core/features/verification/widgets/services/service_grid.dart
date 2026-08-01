import 'package:flutter/material.dart';

import '../../models/verification_service.dart';
import '../../services/verification_data_service.dart';
import '../../screens/verification_webview_screen.dart';
import 'service_card.dart';

class ServiceGrid extends StatelessWidget {
  final String institutionId;

  const ServiceGrid({
    super.key,
    required this.institutionId,
  });

  @override
  Widget build(BuildContext context) {
    final List<VerificationService> services =
        VerificationDataService.getServices(institutionId);

    if (services.isEmpty) {
      return const Center(
        child: Text(
          'No services available',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 30,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ServiceCard(
            icon: service.icon,
            color: service.color,
            title: service.title,
            description: service.description,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VerificationWebViewScreen(
                    title: service.title,
                    url: service.websiteUrl,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}