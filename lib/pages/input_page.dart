import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmr_calculator/components/icon_card.dart';
import 'package:bmr_calculator/components/custom_card.dart';
import 'package:bmr_calculator/constants.dart';
import 'package:bmr_calculator/pages/result_page.dart';
import 'package:bmr_calculator/components/bottom_button.dart';
import 'package:bmr_calculator/components/round_icon_button.dart';
import 'package:bmr_calculator/calculator.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  // 1. Variabel Data Input
  Gender selectedGender = Gender.male;
  int height = 180;
  int weight = 60;
  int age = 20;

  // 2. Variabel Tambahan
  BMRMethod selectedMethod = BMRMethod.mifflin;
  int bodyFat = 20; // Digunakan khusus untuk rumus Katch-McArdle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMR CALCULATOR')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Dropdown untuk memilih rumus
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: kActiveCardColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DropdownButton<BMRMethod>(
              isExpanded: true,
              value: selectedMethod,
              dropdownColor: kActiveCardColor,
              underline: SizedBox(), 
              items: [
                DropdownMenuItem(
                  value: BMRMethod.mifflin,
                  child: Text("Metode: Mifflin-St Jeor"),
                ),
                DropdownMenuItem(
                  value: BMRMethod.harris,
                  child: Text("Metode: Harris-Benedict"),
                ),
                DropdownMenuItem(
                  value: BMRMethod.katch,
                  child: Text("Metode: Katch-McArdle"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
            ),
          ),

          // BARIS 1: Pilih Kelamin
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CustomCard(
                    onPress: () => setState(() => selectedGender = Gender.male),
                    color: selectedGender == Gender.male
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: IconCard(
                      cardIcon: FontAwesomeIcons.mars,
                      caption: 'MALE',
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    onPress: () =>
                        setState(() => selectedGender = Gender.female),
                    color: selectedGender == Gender.female
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: IconCard(
                      cardIcon: FontAwesomeIcons.venus,
                      caption: 'FEMALE',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // BARIS 2: Slider Tinggi Badan
          Expanded(
            child: CustomCard(
              color: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('HEIGHT', style: kLabelTextStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(height.toString(), style: kNumberTextStyle),
                      Text('cm', style: kLabelTextStyle),
                    ],
                  ),
                  Slider(
                    value: height.toDouble(),
                    min: 100.0,
                    max: 220.0,
                    activeColor: Color(0xFFEB1555),
                    inactiveColor: Color(0xFF8D8E98),
                    onChanged: (double newValue) {
                      setState(() {
                        height = newValue.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // BARIS 3: Berat & Input Dinamis (Age atau Body Fat)
          Expanded(
            child: Row(
              children: [
                // Kolom Berat Badan
                Expanded(
                  child: CustomCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('WEIGHT', style: kLabelTextStyle),
                        Text(weight.toString(), style: kNumberTextStyle),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () => setState(() => weight--),
                            ),
                            SizedBox(width: 10.0),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () => setState(() => weight++),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Kolom Dinamis: Kalau pilih Katch munculin Body Fat, selain itu munculin Age
                Expanded(
                  child: CustomCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedMethod == BMRMethod.katch
                              ? 'BODY FAT %'
                              : 'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          selectedMethod == BMRMethod.katch
                              ? bodyFat.toString()
                              : age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () => setState(() {
                                if (selectedMethod == BMRMethod.katch) {
                                  if (bodyFat > 1) bodyFat--;
                                } else {
                                  if (age > 1) age--;
                                }
                              }),
                            ),
                            SizedBox(width: 10.0),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () => setState(() {
                                selectedMethod == BMRMethod.katch
                                    ? bodyFat++
                                    : age++;
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // TOMBOL CALCULATE: Mengirim data ke Result Page
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: () {
              // Menghubungkan ke "Otak" Kalkulator
              Calculator calc = Calculator(
                height: height,
                weight: weight,
                gender: selectedGender,
                age: age,
                method: selectedMethod,
                bodyFat: bodyFat,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    bmrResult: calc.calculateBMR(),
                    resultText: calc.getResult(),
                    interpretation: calc.getInterpretation(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
