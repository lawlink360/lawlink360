import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/client_model.dart';
import '../providers/clerk_providers.dart';
import 'add_client_screen.dart';

class ClientDetailsScreen extends ConsumerWidget {
  const ClientDetailsScreen({
    super.key,
    required this.client,
  });

  final ClientModel client;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Always get the latest version of this client from Riverpod.
    final clients = ref.watch(clerkClientsProvider);

    final currentClient = clients.cast<ClientModel?>().firstWhere(
          (item) => item?.id == client.id,
          orElse: () => null,
        );

    // Client may have been deleted.
    if (currentClient == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        appBar: AppBar(
          backgroundColor: const Color(0xFF13294B),
          foregroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Client Details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: const Center(
          child: Text('Client no longer exists.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Client Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Edit Client',
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddClientScreen(
                    clientToEdit: currentClient,
                  ),
                ),
              );

              // No manual refresh is required.
              // Riverpod will rebuild this screen automatically.
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileHeader(currentClient),

            const SizedBox(height: 16),

            _sectionTitle(
              icon: Icons.contact_page_outlined,
              title: 'Contact Information',
            ),

            const SizedBox(height: 10),

            _infoCard(
              children: [
                _infoRow(
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: currentClient.phone,
                ),

                if (currentClient.email.isNotEmpty)
                  _infoRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: currentClient.email,
                  ),

                if (currentClient.cnic != null &&
                    currentClient.cnic!.isNotEmpty)
                  _infoRow(
                    icon: Icons.badge_outlined,
                    label: 'CNIC',
                    value: currentClient.cnic!,
                  ),

                if (currentClient.address.isNotEmpty)
                  _infoRow(
                    icon: Icons.location_on_outlined,
                    label: 'Address',
                    value: currentClient.address,
                  ),
              ],
            ),

            const SizedBox(height: 16),

            _sectionTitle(
              icon: Icons.folder_outlined,
              title: 'Client Cases',
            ),

            const SizedBox(height: 10),

            _emptyCasesCard(),

            const SizedBox(height: 16),

            if (currentClient.notes.isNotEmpty) ...[
              _sectionTitle(
                icon: Icons.notes_outlined,
                title: 'Notes',
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE6EAF0),
                  ),
                ),
                child: Text(
                  currentClient.notes,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _deleteClient(
                    context,
                    ref,
                    currentClient.id,
                  );
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFFD32F2F),
                ),
                label: const Text(
                  'Delete Client',
                  style: TextStyle(
                    color: Color(0xFFD32F2F),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  side: const BorderSide(
                    color: Color(0xFFD32F2F),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _profileHeader(ClientModel client) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF13294B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline,
              color: Color(0xFFD4AF37),
              size: 32,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  client.phone,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
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

  Widget _infoCard({
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE6EAF0),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(0xFF13294B),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF13294B),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyCasesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 22,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE6EAF0),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 36,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Text(
            'No cases linked yet',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteClient(
    BuildContext context,
    WidgetRef ref,
    String clientId,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Delete Client?',
            style: TextStyle(
              color: Color(0xFF13294B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this client? '
            'This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF13294B),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    ref
        .read(clerkClientsProvider.notifier)
        .deleteClient(clientId);

    if (context.mounted) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Client deleted successfully.',
          ),
        ),
      );
    }
  }
}