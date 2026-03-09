import 'package:deck_share/share_cards/presentation/providers/share_cards_providers.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AtomDropdownmenu<T> extends ConsumerStatefulWidget {
  final FutureProvider<List<T>> list;
  final String Function(T) labelBuilder;
  final String Function(T) idBuilder;
  const AtomDropdownmenu({
    super.key,
    required this.list,
    required this.labelBuilder,
    required this.idBuilder
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
      onSelected: (value) {
        ref.read(selectId.notifier).state = widget.idBuilder(value as T);
        print(widget.idBuilder(value));
      },
      ),
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => AtomText(data: "Erreur $e"),
    );
  }
}
