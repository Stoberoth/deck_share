import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/ui/atom/atom_image.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_loan_subtitle.dart';
import 'package:deck_share/ui/organisms/organism_loan_card.dart';
import 'package:flutter/material.dart';

enum LoanListFilter {
  all, // see all loan
  lent, // see lent loan
  borrow, // see borrowed loan
}

class LoanList extends StatefulWidget {
  final List<ShareCards> loanList;
  final LoanListFilter filter;

  const LoanList({super.key, required this.loanList, this.filter = LoanListFilter.all});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoanListState();
  }
}

class _LoanListState extends State<LoanList> {
  List<ShareCards> filterLoan()
  {
    if(widget.filter == LoanListFilter.all)
    {
      return widget.loanList;
    }
    else if(widget.filter == LoanListFilter.lent)
    {
      return widget.loanList.where((sc) => sc.lender == "Me").toList();
    }
    else
    {
      return widget.loanList.where((sc) => sc.applicant == "Me").toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ShareCards> tmp = filterLoan();
    // TODO: implement build
    return Expanded(
      child: ListView.builder(
        itemCount: tmp.length,
        itemBuilder: (context, index) {
          ShareCards currentShareCards = tmp[index];
          return BaseLoanCard(
            leadingImage: BaseImage(
              //url: currentShareCards.lendingCards[0].imageUris!.png.toString(),
              url:
                  "https://assets.moxfield.net/cards/card-7RMxd-normal.webp?269928852",
            ),
            loanTitle: BaseText(data: currentShareCards.title!, fontSize: 20,),
            loanSubtitle: BaseLoanSubtitle(cardNumber: currentShareCards.lendingCards.length, contact: widget.filter == LoanListFilter.lent ? currentShareCards.applicant : currentShareCards.lender, days: 8, returnDate: DateTime.now(), filter: widget.filter,),
            status: currentShareCards.status,
          );
        },
      ),
    );
  }
}
