import 'dart:developer';

import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/share_cards/presentation/page/share_cards_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareCardsListWidget extends ConsumerStatefulWidget {
  const ShareCardsListWidget({super.key});

  @override
  ConsumerState<ShareCardsListWidget> createState() =>
      _ShareCardsListWidgetState();
}

class _ShareCardsListWidgetState extends ConsumerState<ShareCardsListWidget> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<ShareCards>> state = ref.watch(
      shareCardsControllerProvider,
    );
    //ref.read(wishlistViewerControllerProvider.notifier).getAllWishlists();
    List<ShareCards> shareCardsList = state.value ?? [];
    return state.isLoading
        ? const CircularProgressIndicator()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: shareCardsList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text("Day of the lending"),
                title: Text("Cards lend by ${shareCardsList[index].lender}"),
                subtitle: Text(
                  "${shareCardsList[index].lendingCards.length} are lend",
                ),
                trailing: Text(shareCardsList[index].applicant),
                onTap: () async {
                  print("onTap");
                  await ref
                      .read(shareCardsControllerProvider.notifier)
                      .selectItem(shareCardsList[index].id!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShareCardsDetailsPage(),
                    ),
                  );
                },
                onLongPress: () async {
                  bool result = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Delete"),
                        content: Text(
                          "Are you sure you want to delete this list ?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Text("Validate"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: Text("Cancel"),
                          ),
                        ],
                      );
                    },
                  );
                  result
                      ? await ref
                            .read(shareCardsControllerProvider.notifier)
                            .deleteShareCards(shareCardsList[index].id!)
                      : null;
                },
              );
            },
          );
  }
}
