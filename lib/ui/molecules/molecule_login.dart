import 'package:deck_share/home/application/providers/auth_services_providers.dart';
import 'package:deck_share/home/presentation/page/providers/login_providers.dart';
import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:deck_share/utils/auth_error_handling.dart';
import 'package:deck_share/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoleculeLogin extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MoleculeLoginState();
  }
}

class MoleculeLoginState extends ConsumerState {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            enabled: !_isLoading,
            style: TextStyle(color: AppColors.textPrimary),
            controller: ref.read(emailControllerProvider.notifier).state,
            decoration: InputDecoration(
              hintText: "Saisissez votre email",
              hintStyle: TextStyle(color: AppColors.textSecondary),
            ),
            validator: Validators.validateEmail,
          ),
          TextFormField(
            enabled: !_isLoading,
            obscureText: true,
            style: TextStyle(color: AppColors.textPrimary),
            controller: ref.read(passwordControllerProvider.notifier).state,
            decoration: InputDecoration(
              hintText: "Saisissez votre mot de passe",
              hintStyle: TextStyle(color: AppColors.textSecondary),
            ),
            validator: Validators.validatePassword,
          ),
          _isLoading
              ? CircularProgressIndicator()
              : AtomButton(
                  label: "Log In",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        await ref
                            .read(authServiceProvider)
                            .login(
                              ref.watch(emailControllerProvider).text,
                              ref.watch(passwordControllerProvider).text,
                            );
                      } catch (e) {
                        if (mounted) {
                          setState(() {
                            _isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                AuthErrorHandling.getErrorMessage(e),
                              ),
                              backgroundColor: AppColors.error,
                              duration: Duration(seconds: 4),
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
        ],
      ),
    );
  }
}
