
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logInOrRegisterProvider = StateProvider<int>((ref) => 0);
final emailControllerProvider = StateProvider((ref) => TextEditingController());
final passwordControllerProvider = StateProvider((ref) => TextEditingController());
final confirmPasswordControllerProvider = StateProvider((ref) => TextEditingController());
