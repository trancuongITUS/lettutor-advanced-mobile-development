import 'package:flutter/material.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';

class ConstValue {
  static const descriptionTextScale = 1.5;
  static const courseNameTextScale = 1.75;
}

class DefaultColor {
  late Color fontColor = Colors.black;
  late Color backgroundColor = Colors.transparent;

  DefaultColor(BuildContext context) {
    fontColor = Colors.black;
    backgroundColor = Colors.transparent;
  }
}

TextStyle? bodyLarge(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge?.copyWith(
    fontWeight: FontWeight.w400,
    height: ConstValue.descriptionTextScale,
    color: DefaultColor(context).fontColor,
    backgroundColor: DefaultColor(context).backgroundColor
  );
}

PaginateButtonStyles paginationStyle(BuildContext context) {
  return PaginateButtonStyles(
    backgroundColor: Colors.white,
    activeBackgroundColor: Colors.blue,
    textStyle: bodyLarge(context)?.copyWith(color: Colors.blue),
    activeTextStyle: bodyLarge(context)?.copyWith(color: Colors.white)
  );
}

PaginateSkipButton prevButtonStyles(BuildContext context) {
  return PaginateSkipButton(
    icon: const Icon(
      Icons.navigate_before,
      color: Colors.blue,
    ),
    buttonBackgroundColor: Colors.white,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)
    )
  );
}

PaginateSkipButton nextButtonStyles(BuildContext context) {
  return PaginateSkipButton(
    icon: const Icon(
      Icons.navigate_next,
      color: Colors.blue,
    ),
    buttonBackgroundColor: Colors.white,
    borderRadius: const BorderRadius.only(
      topRight: Radius.circular(16), bottomRight: Radius.circular(16)
    )
  );
}