import 'package:deck_share/share_cards/presentation/providers/share_cards_providers.dart';
import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoleculeLoanResume extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final lentAsync = ref.watch(lentNumberProvider);
    final borrowAsync = ref.watch(borrowNumberProvider);

    return SizedBox(
      width: double.infinity,
      child: AtomCard(
        color: AppColors.primaryLight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            lentAsync.when(
              data: (count) => AtomText(data: "Total number of lent : $count", fontSize: 20,),
              error: (e, _) => AtomText(data: "Erreur", fontSize: 20,),
              loading: () => const CircularProgressIndicator(),
            ),
            borrowAsync.when(
              data: (count) => AtomText(data: "Total number of borrow : $count", fontSize: 20,),
              error: (e, _) => AtomText(data: "Erreur", fontSize: 20,),
              loading: () => const CircularProgressIndicator(),
            ),

          ],
        ),
      ),
    );
  }
}
