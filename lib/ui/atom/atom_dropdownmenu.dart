import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AtomDropdownmenu<T> extends ConsumerStatefulWidget {
  final FutureProvider<List<T>> list;
  final String Function(T) labelBuilder;
  const AtomDropdownmenu({
    super.key,
    required this.list,
    required this.labelBuilder,
  });

  @override
  ConsumerState<AtomDropdownmenu<T>> createState() => _AtomDropdownmenuState<T>();
}

class _AtomDropdownmenuState<T> extends ConsumerState<AtomDropdownmenu<T>> {
  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(widget.list);
    return asyncValue.when(
      data: (items) => DropdownMenu<T>(
        dropdownMenuEntries: items
            .map(
              (e) =>
                  DropdownMenuEntry<T>(value: e, label: widget.labelBuilder(e)),
            )
            .toList(),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => AtomText(data: "Erreur $e"),
    );
  }
}
