import 'package:calculadora/common/constants/colors.dart';
import 'package:calculadora/common/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    'AC',
    'C',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    '±',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: AppTextStyle.medium40px300w
                        .apply(color: AppColors.white.withOpacity(0.8)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style:
                        AppTextStyle.big48px300w.apply(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: buttonList.length,
                clipBehavior: Clip.none,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return CustomButton(
                    buttonList[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: AppColors.lightGrey,
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        decoration: BoxDecoration(
          color: getColor(text),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.small32px400w.apply(color: AppColors.white),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == 'C' || text == 'AC' || text == '%') {
      return AppColors.extraLightGrey;
    }

    if (text == '/' ||
        text == '*' ||
        text == '-' ||
        text == '+' ||
        text == '=') {
      return AppColors.purple;
    }

    return AppColors.lightGrey;
  }

  handleButtons(String text) {
    if (text == 'AC') {
      userInput = '';
      result = '0';
      return;
    }

    if (text == 'C') {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == '=') {
      result = calculate();
      userInput = result;

      if (userInput.endsWith('.0')) {
        userInput = userInput.replaceAll('.0', '');
        return;
      }

      if (result.endsWith('.0')) {
        result = result.replaceAll('.0', '');
        return;
      }
    }

    if (text == '±' && text.isNotEmpty) {
      if (!userInput.startsWith('-')) {
        userInput = '-$userInput';
        return;
      }

      if (userInput.startsWith('-')) {
        userInput = userInput.substring(1);
        return;
      }

      return;
    }

    userInput = userInput + text;
  }

  String calculate() {
    try {
      Expression exp = Parser().parse(userInput);
      double evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return 'Error';
    }
  }
}
