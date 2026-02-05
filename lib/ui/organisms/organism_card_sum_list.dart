import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/ui/molecules/molecule_card_sum.dart';
import 'package:deck_share/ui/templates/template_loan_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseCardSumList extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BaseCardSumListState();
}

class _BaseCardSumListState extends ConsumerState<BaseCardSumList> {
  @override
  Widget build(BuildContext context) {
    ShareCards loanToSum = ref.read(selectLoan);
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: loanToSum.lendingCards.length,
        itemBuilder: (context, index) {
          return BaseCardSum(
            image: loanToSum.lendingCards[index].cardFaces != null
                ? loanToSum.lendingCards[index].cardFaces![0].imageUris!.normal
                      .toString()
                : loanToSum.lendingCards[index].imageUris!.normal.toString(),
            cardExtension: loanToSum.lendingCards[index].setName,
            cardName: loanToSum.lendingCards[index].name,
          );
        },
      ),
    );
  }
}
