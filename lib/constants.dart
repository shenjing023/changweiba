import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF562484);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const bool inProduction = kReleaseMode;

const double defaultPadding = 16.0;

const Map<int, String> bull = {
  -2: "卖出",
  -1: "减持",
  0: "观望",
  1: "增持",
  2: "买入",
};
