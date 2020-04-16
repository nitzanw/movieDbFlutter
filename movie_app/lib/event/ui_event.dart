import 'package:flutter/material.dart';

abstract class UiEvent{
  final BuildContext context;

  UiEvent(this.context);
}