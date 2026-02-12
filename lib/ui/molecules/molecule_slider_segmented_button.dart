import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoleculeSliderSegmentedButton extends ConsumerStatefulWidget {
  final StateProvider indexReference;
  final String firstLabel;
  final String secondLabel;

  const MoleculeSliderSegmentedButton({super.key, required this.indexReference, required this.firstLabel, required this.secondLabel});
  @override
  ConsumerState<MoleculeSliderSegmentedButton> createState() =>
      _OrganismSliderSegmentedButtonState();
}

class _OrganismSliderSegmentedButtonState
    extends ConsumerState<MoleculeSliderSegmentedButton> {
  @override
  Widget build(BuildContext context) {
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
            alignment: ref.watch(widget.indexReference) == 0
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
                    child: AtomText(data: widget.firstLabel, fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      ref.read(widget.indexReference.notifier).state = 0;
                    });
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Center(
                    child: AtomText(data: widget.secondLabel, fontSize: 15),
                  ),
                  onTap: () {
                    setState(() {
                      ref.read(widget.indexReference.notifier).state = 1;
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
