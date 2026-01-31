import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/ui/atom/atom_image.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/organisms/organism_loan_card.dart';
import 'package:flutter/material.dart';

class LoanList extends StatefulWidget {
  final List<ShareCards> loanList;

  const LoanList({super.key, required this.loanList});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoanListState();
  }
}

class _LoanListState extends State<LoanList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw ListView.builder(
      itemBuilder: (context, index) {
        ShareCards currentShareCards = widget.loanList[index];
        return BaseLoanCard(
          leadingImage: BaseImage(
            url: currentShareCards.lendingCards[0].imageUris!.png.toString(),
          ),
          loanTitle: BaseText(data: currentShareCards.title!),
          loanSubtitle: BaseText(data: "loanSubtitle"),
          status: ShareCardsStatus.active,
        );
      },
    );
  }
}
