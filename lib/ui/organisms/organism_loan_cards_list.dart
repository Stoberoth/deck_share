import 'package:deck_share/scryfall_searcher/presentation/page/scryfall_card_picker.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_card_tile.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';



class OrganismLoanCardList extends ConsumerStatefulWidget {
  List<MtgCard>? pickCardList;

  OrganismLoanCardList({super.key, this.pickCardList = const []});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _OrganismLoanCardListState();
  }
}

class _OrganismLoanCardListState extends ConsumerState<OrganismLoanCardList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AtomText(data: "Liste des cartes", fontSize: 20),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 300),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: ref.watch(pickcards).length,
            itemBuilder: (context, index) {
              return MoleculeCardTile(
                card: ref.watch(pickcards)[index],
                onPressed: () {
                  setState(() {
                    ref.read(pickcards.notifier).state.removeAt(index);
                  });
                },
              );
            },
          ),
        ),
        AtomButton(
          label: "Ajouter des cartes",
          buttonColor: AppColors.surface,
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScryfallCardPicker()),
            );
            setState(() {});
          },
        ),
      ],
    );
  }
}
