import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/molecules/molecule_personnal_information.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:deck_share/user/data/providers/user_providers.dart';
import 'package:deck_share/user/domain/user_model.dart';
import 'package:deck_share/user/presentation/providers/user_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInformationPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return UserInformationPageState();
  }
}

class UserInformationPageState extends ConsumerState {
  UserProfile? user;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userControllerProvider.notifier).getUserInformation();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    user = ref.watch(userControllerProvider).value;
    return TemplateBase(
      baseAppBar: OrganismAppBar(title: "Informations Personnelles"),
      body: Column(
        children: [user != null ? MoleculePersonnalInformation(userProfile: user!):Container()],
      ),
    );
  }
}
