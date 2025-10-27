import 'package:flutter/material.dart';

import '../../core/widgets/cxfvxc.dart';

class CongratulationDialogScreen extends StatelessWidget {
  const CongratulationDialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CongratulationsDialog(
      courseName: '',
      imagePath: '',
      onContinue: () {},
    );
  }
}
