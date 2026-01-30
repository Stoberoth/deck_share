import 'package:deck_share/ui/atom/base_button.dart';
import 'package:flutter/material.dart';

class BaseDismissible extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final Key dismissibleKey;
  final Widget child;

  const BaseDismissible({
    super.key,
    required this.dismissibleKey,
    required this.onDismissed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: dismissibleKey,
      background: Container(color: Colors.red),
      onDismissed: onDismissed,
      confirmDismiss: (direction) async => showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure you want to delete ?"),
            actions: [
              BaseButton(
                label: "Confirm",
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              BaseButton(
                label: "Cancel",
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        },
      ),
      child: child,
    );
  }
}
