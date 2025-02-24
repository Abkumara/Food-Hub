import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';

OutlineInputBorder kAuthInputBorder({Color? color}) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color ?? borderColor, width: 0.5));
