import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/user/domain/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoleculePersonnalInformation extends ConsumerWidget {
  final UserProfile userProfile;

  const MoleculePersonnalInformation({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: Size.infinite.width,
      child: AtomCard(
        child: Column(
          children: [
            AtomText(data: userProfile.name, fontSize: 20),
            //AtomText(data: this.userProfile.phone!),
          ],
        ),
      ),
    );
  }
}
