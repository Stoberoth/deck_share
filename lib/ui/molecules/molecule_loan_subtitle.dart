import 'package:deck_share/share_cards/domain/loan_list_filter.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/utils/date_formatter.dart';
import 'package:flutter/material.dart';


class MoleculeLoanSubtitle extends StatelessWidget {
  final int cardNumber;
  final String contact;
  final int days;
  final DateTime returnDate;
  final LoanListFilter filter;

  const MoleculeLoanSubtitle({
    super.key,
    required this.cardNumber,
    required this.contact,
    required this.days,
    required this.returnDate,
    required this.filter,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(children: [Icon(Icons.card_giftcard), AtomText(data: " " + cardNumber.toString() + " cards", fontSize: 10,), SizedBox(width: 20,), Icon(Icons.contact_phone), Flexible(child: AtomText(data: filter == LoanListFilter.lent ? " Prêtés à : " + contact : "Prêtés par :" + contact, fontSize: 10),) ]),
          Row(children: [Icon(Icons.lock_clock), AtomText(data: "Depuis " + days.toString() + " jours", fontSize: 10),SizedBox(width: 20,), AtomText(data: "Retour prévu : " + DateFormatter.formatDateDayMounth(returnDate), fontSize: 10)]),
        ],
      ),
    );
  }
}
