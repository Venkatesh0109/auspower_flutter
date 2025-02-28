import 'package:auspower_flutter/providers/analysis_provider.dart';
import 'package:auspower_flutter/repositories/analysis_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeterResetReportScreen extends StatefulWidget {
  const MeterResetReportScreen({super.key});

  @override
  State<MeterResetReportScreen> createState() => _MeterResetReportScreenState();
}

class _MeterResetReportScreenState extends State<MeterResetReportScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      AnalysisRepository().getMeterResetReport(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnalysisProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Meter Reset Report"),
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
      );
    });
  }
}
