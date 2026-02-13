import 'package:deck_share/home/application/providers/auth_services_providers.dart';
import 'package:deck_share/home/presentation/page/providers/login_providers.dart';
import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:deck_share/utils/auth_error_handling.dart';
import 'package:deck_share/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoleculeRegister extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return MoleculeRegisterState();
  }
}

class MoleculeRegisterState extends ConsumerState {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
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
              hintText: "Nouveau mot de passe",
              hintStyle: TextStyle(color: AppColors.textSecondary),
            ),
            validator: Validators.validatePassword,
          ),
          TextFormField(
            enabled: !_isLoading,
            obscureText: true,
            style: TextStyle(color: AppColors.textPrimary),
            controller: ref
                .read(confirmPasswordControllerProvider.notifier)
                .state,
            decoration: InputDecoration(
              hintText: "Confirmez nouveau mot de passe",
              hintStyle: TextStyle(color: AppColors.textSecondary),
            ),
            validator: (value) => Validators.validateConfirmPassword(
              value,
              ref.read(passwordControllerProvider.notifier).state.text,
            ),
          ),
          _isLoading
              ? CircularProgressIndicator()
              : AtomButton(
                  label: "Register",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        await ref
                            .read(authServiceProvider)
                            .register(
                              ref.watch(emailControllerProvider).text,
                              ref.watch(passwordControllerProvider).text,
                            );
                      } catch (e) {
                        setState(() {
                          _isLoading = false;
                        });
                        if (mounted) {
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


/*

class MoleculeRegister extends ConsumerWidget {
  const MoleculeRegister({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
  }
}
*/