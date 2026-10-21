import 'package:flutter/material.dart';

import '../../data/copy_house_chart_data.dart';
import '../../widgets/copy_house_chart_layout.dart';

class MutationChartScreen extends StatelessWidget {
  const MutationChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CopyHouseChartLayout(
      chart: mutationChart,
    );
  }
}