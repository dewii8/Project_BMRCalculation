import 'package:flutter/material.dart';
import 'package:bmr_calculator/constants.dart';
import 'package:bmr_calculator/components/custom_card.dart';
import 'package:bmr_calculator/components/bottom_button.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.bmrResult, required this.resultText, required this.interpretation});

  final String bmrResult;
  final String resultText;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMR RESULT')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Container(padding: const EdgeInsets.all(15.0), alignment: Alignment.bottomLeft,
            child: const Text('Hasil Anda', style: kTitleTextStyle))),
          Expanded(flex: 5, child: CustomCard(color: kActiveCardColor, cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(resultText, style: kResultTextStyle),
              Text(bmrResult, style: kBMITextStyle),
              const Text('kkal / hari', style: kLabelTextStyle),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(interpretation, textAlign: TextAlign.center, style: kBodyTextStyle),
              ),
            ],
          ))),
          BottomButton(buttonTitle: 'HITUNG ULANG', onTap: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}