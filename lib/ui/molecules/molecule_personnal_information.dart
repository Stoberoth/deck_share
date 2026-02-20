import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_icon_button.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/atom/atom_text_field.dart';
import 'package:deck_share/user/domain/user_model.dart';
import 'package:deck_share/user/presentation/providers/user_providers.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoleculePersonnalInformation extends ConsumerStatefulWidget {
  final UserProfile userProfile;

  const MoleculePersonnalInformation({super.key, required this.userProfile});

  @override
  ConsumerState<MoleculePersonnalInformation> createState() {
    return MoleculePersonnalInformationState();
  }
}

class MoleculePersonnalInformationState
    extends ConsumerState<MoleculePersonnalInformation> {
  bool editName = false;
  bool editPhone = false;
  late final TextEditingController nameController = TextEditingController(
    text: widget.userProfile.name,
  );
  late final TextEditingController phoneController = TextEditingController(
    text: widget.userProfile.phone,
  );

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Size.infinite.width,
      child: AtomCard(
        color: AppColors.primaryLight,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AtomText(data: "Nom du profil : ", fontSize: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: AtomTextField(
                          controller: nameController,
                          textColor: editName ? AppColors.textPrimary : AppColors.textSecondary,
                          hintText: "Entrez un nouveau nom",
                          enabled: editName,
                          onSubmitted: (value) {
                            ref
                                .read(userControllerProvider.notifier)
                                .saveUser(
                                  widget.userProfile.copyWith(name: value),
                                );
                            setState(() {
                              nameController.text = value;
                              editName = false;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      AtomIconButton(
                        icon: Icon(Icons.edit, color: Colors.black),
                        onPressed: () => setState(() {
                          editName = !editName;
                        }),
                      ),
                    ],
                  ),
                  AtomText(data: "Numero de téléphone : ", fontSize: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: AtomTextField(
                          controller: phoneController,
                          textColor: editPhone ? AppColors.textPrimary : AppColors.textSecondary,
                          keyboardInput: TextInputType.phone,
                          hintText: "Entrez votre numéro de téléphone",
                          enabled: editPhone,
                          onSubmitted: (value) {
                            ref
                                .read(userControllerProvider.notifier)
                                .saveUser(
                                  widget.userProfile.copyWith(phone: value),
                                );
                            setState(() {
                              phoneController.text = value;
                              editPhone = false;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      AtomIconButton(
                        icon: Icon(Icons.edit, color: Colors.black),
                        onPressed: () => setState(() {
                          editPhone = !editPhone;
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

