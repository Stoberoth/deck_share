import 'package:deck_share/share_cards/domain/loan_list_filter.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/share_cards/presentation/page/loan_details_page.dart';
import 'package:deck_share/ui/atom/atom_image.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_loan_subtitle.dart';
import 'package:deck_share/ui/organisms/organism_loan_card.dart';
import 'package:deck_share/utils/card_image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplateLoanList extends ConsumerStatefulWidget {
  final List<ShareCards> loanList;
  final LoanListFilter filter;

  const TemplateLoanList({
    super.key,
    required this.loanList,
    this.filter = LoanListFilter.all,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _TemplateLoanListState();
  }
}

class _TemplateLoanListState extends ConsumerState<TemplateLoanList> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shareCardsControllerProvider);
    final list = state.value;

    if (list == null) return Container();

    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          ShareCards currentShareCards = list[index];
          return OrganismLoanCard(
            leadingImage: AtomImage(
              //url: currentShareCards.lendingCards[0].imageUris!.png.toString(),
              url: currentShareCards.lendingCards.isNotEmpty ? getCardImageUrl(currentShareCards.lendingCards[0]) : "",
            ),
            loanTitle: AtomText(data: currentShareCards.title!, fontSize: 20),
            loanSubtitle: MoleculeLoanSubtitle(
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
          );
        },
      ),
    );
  }
}
