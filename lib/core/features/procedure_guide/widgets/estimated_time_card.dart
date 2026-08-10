import 'package:flutter/material.dart';

class EstimatedTimeCard extends StatelessWidget {
  final String fee;
  final String time;

  const EstimatedTimeCard({
    super.key,
    required this.fee,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.schedule,
                color: Colors.blue,
              ),
              title: const Text("Estimated Time"),
              subtitle: Text(time),
            ),

            const Divider(),

            ListTile(
              leading: const Icon(
                Icons.account_balance_wallet,
                color: Colors.green,
              ),
              title: const Text("Estimated Fee"),
              subtitle: Text(fee),
            ),
          ],
        ),
      ),
    );
  }
}