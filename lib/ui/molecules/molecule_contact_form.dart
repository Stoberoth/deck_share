import 'package:deck_share/contact/application/providers/contact_providers.dart';
import 'package:deck_share/contact/domain/contact_model.dart';
import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:deck_share/user/presentation/page/user_search_page.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:deck_share/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoleculeContactForm extends ConsumerStatefulWidget {
  const MoleculeContactForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MoleculeContactFormState();
  }
}

class MoleculeContactFormState extends ConsumerState {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 50,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: nameController,
            style: TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: "Entrez le nom de votre contact",
              hintStyle: TextStyle(color: AppColors.textSecondary),
            ),
            validator: Validators.validateName,
            keyboardType: TextInputType.name,
          ),
          TextFormField(
            controller: phoneController,
            style: TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: "Entrez le numéro de téléphone de votre contact",
              hintStyle: TextStyle(color: AppColors.textSecondary),
            ),
            validator: Validators.validatePhone,
            keyboardType: TextInputType.phone,
          ),
          // voir pour passer par un dialog ou autre pour avoir un meilleur affichage
          AtomButton(label: "Ajoutez depuis la base de données", onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> UserSearchPage()));
          }),
          //AtomDropdownmenu<UserProfile>(list: userListProvider, labelBuilder: (item) => "${item.name} ${item.phone}", ),
          AtomButton(
            label: "Créer contact",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                bool isAlreadyIn = await ref.read(contactServiceProvider).isAlreadyInContact(phoneController.text);
                if(isAlreadyIn){
                  return;
                }
                await ref
                    .read(contactServiceProvider)
                    .saveContact(
                      Contact(
                        name: nameController.text,
                        phone: phoneController.text,
                      ),
                    );
                    ref.invalidate(contactListProvider);
              }
            },
          ),
        ],
      ),
    );
  }
}

