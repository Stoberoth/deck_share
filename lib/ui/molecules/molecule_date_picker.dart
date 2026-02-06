import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_list_tile.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectDate = StateProvider<DateTime>((ref) => DateTime.now());

class MoleculeDatePicker extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _OrganismDatePickerState();
  }
}

class _OrganismDatePickerState extends ConsumerState {
  void selectReturnedDate() async {
    DateTime? newReturnDate = await showDatePicker(
      context: context,
      initialDate: ref.watch(selectDate),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (newReturnDate != null) {
      setState(() {
        ref.read(selectDate.notifier).state = newReturnDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AtomCard(
      color: Colors.grey,
      child: AtomListTile(
        padding: 0.0,
        leading: Icon(Icons.calendar_today),
        title: AtomText(data: "Return Date", color: Colors.black, fontSize: 15,),
        subtitle: AtomText(data: DateFormatter.formatDateDayMounthYear(ref.watch(selectDate))  , color: Colors.black, fontSize: 15,),
        tileColor: Colors.white,
        onTap: selectReturnedDate,
      ),
    );
  }
}
