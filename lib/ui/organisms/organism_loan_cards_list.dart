import 'package:deck_share/scryfall_searcher/presentation/page/scryfall_card_picker.dart';
import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_card_tile.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

final pickcards = StateProvider<List<MtgCard>>(
  (ref) => List<MtgCard>.empty(growable: true),
);

class BaseLoanCardList extends ConsumerStatefulWidget {
  List<MtgCard>? pickCardList;

  BaseLoanCardList({super.key, this.pickCardList = const []});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _BaseLoanCardListState();
  }
}

class _BaseLoanCardListState extends ConsumerState<BaseLoanCardList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BaseText(data: "Liste des cartes", fontSize: 20),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 300),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: ref.watch(pickcards).length,
            itemBuilder: (context, index) {
              return BaseCardTile(
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
        BaseButton(
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
