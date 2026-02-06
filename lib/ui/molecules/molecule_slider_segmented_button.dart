import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO passer par un controller


class MoleculeSliderSegmentedButton extends ConsumerStatefulWidget {
  const MoleculeSliderSegmentedButton({super.key});
  final int selectionindex = 1;
  @override
  ConsumerState<MoleculeSliderSegmentedButton> createState() =>
      _OrganismSliderSegmentedButtonState();
}

class _OrganismSliderSegmentedButtonState
    extends ConsumerState<MoleculeSliderSegmentedButton> {
  @override
  Widget build(BuildContext context) {
    // le premier container contient le thumb (l'objet qui va slide) et les different item

    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.primaryLight,
      ),
      padding: EdgeInsets.all(5),
      child: Stack(
        children: [
          AnimatedAlign(
            curve: Curves.easeInOut,
            alignment: ref.watch(indexProvider) == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            duration: Duration(milliseconds: 200),
            child: Container(
              width: 150,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.primary,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  child: Center(
                    heightFactor: 1.2,
                    child: AtomText(data: "Prêtés", fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      ref.read(indexProvider.notifier).state = 0;
                    });
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Center(
                    child: AtomText(data: "Empruntés", fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      ref.read(indexProvider.notifier).state = 1;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
