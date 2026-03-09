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
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(userListControllerProvider.notifier).getAllUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(userListControllerProvider);
    return list.when(
      data: (users) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return MoleculeUserList(userProfile: users[index]);
        },
      ),
      error: (error, stack) => Center(child: AtomText(data: "Error")),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
