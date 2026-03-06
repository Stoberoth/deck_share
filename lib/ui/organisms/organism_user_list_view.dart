import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_user_list.dart';
import 'package:deck_share/user/presentation/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrganismUserListView extends ConsumerStatefulWidget {
  const OrganismUserListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return OrganismUserListViewState();
  }
}

class OrganismUserListViewState extends ConsumerState {
  @override
  void initState() async {
    super.initState();
    Future.microtask(() =>)
    await ;
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(userListControllerProvider);
    return list.when(
      data: (users) => ListView.builder(
        itemCount: list.value!.length,
        itemBuilder: (context, index) {
          return MoleculeUserList(userProfile: list.value![index]);
        },
      ),
      error: (error, stack) => Center(child: AtomText(data: "Error")),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
