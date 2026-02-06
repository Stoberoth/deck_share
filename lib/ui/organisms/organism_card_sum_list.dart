import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/ui/molecules/molecule_card_sum.dart';
import 'package:deck_share/ui/templates/template_loan_list.dart';
import 'package:deck_share/utils/card_image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrganismCardSumList extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrganismCardSumListState();
}

class _OrganismCardSumListState extends ConsumerState<OrganismCardSumList> {
  @override
  Widget build(BuildContext context) {
    ShareCards loanToSum = ref.read(selectLoan);
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: loanToSum.lendingCards.length,
        itemBuilder: (context, index) {
          return MoleculeCardSum(
            image: getCardImageUrl(loanToSum.lendingCards[index]),
            cardExtension: loanToSum.lendingCards[index].setName,
            cardName: loanToSum.lendingCards[index].name,
          );
        },
      ),
    );
  }
}
