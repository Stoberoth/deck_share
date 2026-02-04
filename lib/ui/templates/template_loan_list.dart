import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/share_cards/presentation/page/loan_details_page.dart';
import 'package:deck_share/ui/atom/atom_image.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_loan_subtitle.dart';
import 'package:deck_share/ui/organisms/organism_loan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LoanListFilter {
  all, // see all loan
  lent, // see lent loan
  borrow, // see borrowed loan
}

final selectLoan = StateProvider<ShareCards>(
  (ref) => ShareCards(lender: "", applicant: "", lendingCards: []),
);

class LoanList extends ConsumerStatefulWidget {
  final List<ShareCards> loanList;
  final LoanListFilter filter;

  const LoanList({
    super.key,
    required this.loanList,
    this.filter = LoanListFilter.all,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _LoanListState();
  }
}

class _LoanListState extends ConsumerState<LoanList> {
  List<ShareCards> filterLoan() {
    if (widget.filter == LoanListFilter.all) {
      return widget.loanList;
    } else if (widget.filter == LoanListFilter.lent) {
      List<ShareCards> list = widget.loanList
          .where((sc) => sc.lender == "Me" && sc.returnedAt == null)
          .toList();
      return list;
    } else {
      return widget.loanList
          .where((sc) => sc.applicant == "Me" && sc.returnedAt == null)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ShareCards> tmp = filterLoan();
    return Expanded(
      child: ListView.builder(
        itemCount: tmp.length,
        itemBuilder: (context, index) {
          ShareCards currentShareCards = tmp[index];
          return BaseLoanCard(
            leadingImage: BaseImage(
              //url: currentShareCards.lendingCards[0].imageUris!.png.toString(),
              url: currentShareCards.lendingCards.isNotEmpty
                  ? currentShareCards.lendingCards[0].imageUris!.normal
                        .toString()
                  : "",
            ),
            loanTitle: BaseText(data: currentShareCards.title!, fontSize: 20),
            loanSubtitle: BaseLoanSubtitle(
              cardNumber: currentShareCards.lendingCards.length,
              contact: widget.filter == LoanListFilter.lent
                  ? currentShareCards.applicant
                  : currentShareCards.lender,
              days: DateTime.now()
                  .difference(
                    currentShareCards.lendingDate != null
                        ? currentShareCards.lendingDate!
                        : DateTime.now(),
                  )
                  .inDays,
              returnDate: currentShareCards.expectedReturnDate == null
                  ? DateTime.now()
                  : currentShareCards.expectedReturnDate!,
              filter: widget.filter,
            ),
            isOverdue: currentShareCards.isOverdue,
            onTap: () async {
              setState(() {
                ref.read(selectLoan.notifier).state = currentShareCards;
              });
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoanDetailsPage();
                  },
                ),
              );
            },
            onLongPress: () => ref
                .read(shareCardsControllerProvider.notifier)
                .deleteShareCards(currentShareCards.id!),
          );
        },
      ),
    );
  }
}
