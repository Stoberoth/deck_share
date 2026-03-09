import 'package:deck_share/contact/application/providers/contact_providers.dart';
import 'package:deck_share/share_cards/domain/loan_list_filter.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _ContactName extends ConsumerWidget {
  final String contactId;
  final bool isLent;

  const _ContactName({required this.contactId, required this.isLent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return FutureBuilder(
      future: ref.read(contactServiceProvider).getContactById(contactId),
      builder: (context, snapshot) {
        return AtomText(
          data: snapshot.hasData
              ? isLent
                    ? "Prêtés à : ${snapshot.data!.name}"
                    : "Prêtés par : ${snapshot.data!.name}"
              : "Chargement ...",
          fontSize: 10,
        );
      },
    );
  }
}



class MoleculeLoanSubtitle extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.card_giftcard),
              AtomText(
                data: " " + cardNumber.toString() + " cards",
                fontSize: 10,
              ),
              SizedBox(width: 20),
              Icon(Icons.contact_phone),
              Flexible(
                child: _ContactName(contactId: contact, isLent: filter == LoanListFilter.lent)
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.lock_clock),
              AtomText(
                data: "Depuis " + days.toString() + " jours",
                fontSize: 10,
              ),
              SizedBox(width: 20),
              AtomText(
                data:
                    "Retour prévu : " +
                    DateFormatter.formatDateDayMounth(returnDate),
                fontSize: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
