import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_list_tile.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectDate = StateProvider<DateTime>((ref) => DateTime.now());

class BaseDatePicker extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _BaseDatePickerState();
  }
}

class _BaseDatePickerState extends ConsumerState {
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
    return BaseCard(
      color: Colors.grey,
      child: BaseListTile(
        padding: 0.0,
        leading: Icon(Icons.calendar_today),
        title: BaseText(data: "Return Date", color: Colors.black, fontSize: 15,),
        subtitle: BaseText(data: DateFormatter.formatDateDayMounthYear(ref.watch(selectDate))  , color: Colors.black, fontSize: 15,),
        tileColor: Colors.white,
        onTap: selectReturnedDate,
      ),
    );
  }
}
