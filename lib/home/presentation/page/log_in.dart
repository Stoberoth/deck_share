import 'package:deck_share/home/presentation/page/providers/login_providers.dart';
import 'package:deck_share/ui/molecules/molecule_login.dart';
import 'package:deck_share/ui/molecules/molecule_register.dart';
import 'package:deck_share/ui/molecules/molecule_slider_segmented_button.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogInPage extends ConsumerWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TemplateBase(
      baseAppBar: OrganismAppBar(title: "Log In"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          MoleculeSliderSegmentedButton(
            indexReference: logInOrRegisterProvider,
            firstLabel: "LogIn",
            secondLabel: "Register",
          ),
          ref.watch(logInOrRegisterProvider) == 0
              ? MoleculeLogin()
              : MoleculeRegister(),
        ],
      ),
    );
  }
}
