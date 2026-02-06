import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_card_sum.dart';
import 'package:deck_share/ui/organisms/organism_card_sum_list.dart';
import 'package:deck_share/ui/templates/template_loan_list.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:deck_share/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoleculeLoanSum extends ConsumerWidget {
  const MoleculeLoanSum({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ShareCards loanToSum = ref.read(selectLoan);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 300),
          child: Container(
            padding: EdgeInsets.all(12),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color.lerp(Colors.white, AppColors.surface, 0.75)!,
                  //Color.lerp(Colors.white, AppColors.surface, 0.9)!,
                  AppColors.surface,
                ],
                stops: [0.0, 0.5],
                center: Alignment.topRight,
                radius: 1.5,
                tileMode: TileMode.clamp,
              ),
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AtomText(data: loanToSum.title!, fontSize: 30),
                Spacer(),
                AtomCard(
                  color: loanToSum.isOverdue
                      ? AppColors.warning
                      : AppColors.success,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(5),
                    child: AtomText(data: loanToSum.status.name != ShareCardsStatus.returned ? "En cours" : "Returned", fontSize: 20),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.man, color: Colors.white),
                    AtomText(
                      data: loanToSum.lender == "Me"
                          ? " Prêté à ${loanToSum.applicant}"
                          : " Emprunté à ${loanToSum.lender}",
                      fontSize: 20,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white),
                    AtomText(
                      data:
                          " Depuis : ${DateFormatter.formatDateDayMounthYear(loanToSum.lendingDate!)}",
                      fontSize: 20,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.lock_clock, color: Colors.white),
                    AtomText(
                      data:
                          " Retour prévu : ${DateFormatter.formatDateDayMounthYear(loanToSum.expectedReturnDate!)}",
                      fontSize: 20,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.hourglass_empty_outlined, color: Colors.white),
                    AtomText(
                      data:
                          " Depuis ${DateTime.now().difference(loanToSum.lendingDate!).inDays} jours",
                      fontSize: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
