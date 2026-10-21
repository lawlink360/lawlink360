import 'package:flutter/material.dart';

import '../../data/copy_house_chart_data.dart';
import '../../widgets/copy_house_chart_layout.dart';

class HighCourtChartScreen extends StatelessWidget {
  const HighCourtChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CopyHouseChartLayout(
      chart: highCourtChart,
    );
  }
}