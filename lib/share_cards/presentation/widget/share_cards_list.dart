import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/share_cards/presentation/page/share_cards_details_page.dart';
import 'package:deck_share/ui/atom/base_dismissible.dart';
import 'package:deck_share/ui/atom/base_list_tile.dart';
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
        : Expanded(
            child: ListView.builder(
              itemCount: shareCardsList.length,
              itemBuilder: (context, index) {
                return BaseDismissible(
                  dismissibleKey: ValueKey(shareCardsList[index].id),
                  onDismissed: (direction) async {
                    await ref
                        .read(shareCardsControllerProvider.notifier)
                        .deleteShareCards(shareCardsList[index].id!);
                  },
                  child: BaseListTile(
                    //leading: Text("Day of the lending"),
                    title: Text(
                      "${shareCardsList[index].lendingCards.length} cards lend by ${shareCardsList[index].lender}",
                    ),
                    trailing: Text("Applicant : ${shareCardsList[index].applicant}"),
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
                  ),
                );
              },
            ),
          );
  }
}
