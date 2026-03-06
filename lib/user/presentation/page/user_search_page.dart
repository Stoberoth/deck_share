import 'package:deck_share/ui/atom/atom_text_field.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/organisms/organism_user_list_view.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:deck_share/user/presentation/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSearchPage extends ConsumerStatefulWidget {
  const UserSearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return UserSearchPageState();
  }
}

class UserSearchPageState extends ConsumerState {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Page qui retrounera l'utilisateur selectionné.
    return TemplateBase(
      baseAppBar: OrganismAppBar(title: "Recherche d'utilisateurs"),
      body: Column(
        children: [
          AtomTextField(
            controller: nameController,
            hintText: "Entrez le nom d'utilisateur",
            onSubmitted: (value) => ref.read(userListControllerProvider.notifier).getAllUserProfile(),
          ),
          AtomTextField(
            controller: phoneController,
            hintText: "Entrez le numéro d'utilisateur",
            keyboardInput: TextInputType.phone,
            onSubmitted: (value) => ref.read(userListControllerProvider.notifier).getAllUserProfile(),
          ),
          OrganismUserListView(),
          // TODO: create a dynamic list which will take a stateProvider
          // from a controller to see which userprofile get our from the search
        ],
      ),
    );
  }
}
