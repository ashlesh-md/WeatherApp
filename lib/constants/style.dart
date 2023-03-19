import 'package:flutter/material.dart';

Decoration unSelectedDecoration({required bool isLeft}) => BoxDecoration(
    borderRadius: !isLeft
        ? const BorderRadius.only(
            bottomRight: Radius.circular(5), topRight: Radius.circular(5))
        : const BorderRadius.only(
            bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
    border: Border.all(
      color: Colors.white,
    ));
Decoration selectedDecoration({required bool isLeft}) => BoxDecoration(
    color: Colors.white,
    borderRadius: isLeft
        ? const BorderRadius.only(
            bottomLeft: Radius.circular(5), topLeft: Radius.circular(5))
        : const BorderRadius.only(
            bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
    border: Border.all(color: Colors.white));
