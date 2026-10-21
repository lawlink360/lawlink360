import 'package:flutter/material.dart';

import '../../data/copy_house_chart_data.dart';
import '../../widgets/copy_house_chart_layout.dart';

class DistrictCourtChartScreen extends StatelessWidget {
  const DistrictCourtChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CopyHouseChartLayout(
      chart: districtCourtChart,
    );
  }
}