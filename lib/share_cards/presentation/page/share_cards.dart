import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/share_cards/presentation/page/share_cards_creation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Page to create a share cards
///

class ShareCardsPage extends ConsumerStatefulWidget {
  const ShareCardsPage({super.key});

  @override
  ConsumerState<ShareCardsPage> createState() => _ShareCardsPageState();
}

class _ShareCardsPageState extends ConsumerState<ShareCardsPage> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<ShareCards>> state = ref.watch(
      shareCardsControllerProvider,
    );
    List<ShareCards> shareCardsList = state.value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Share Cards"),
        actions: [
          IconButton(
            onPressed: () async {
              ShareCards sc = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShareCardsCreationPage(),
                ),
              );
              await ref
                  .read(shareCardsControllerProvider.notifier)
                  .addShareCards(sc);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: state.isLoading
                ? const CircularProgressIndicator()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: shareCardsList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text(shareCardsList[index].lender),
                        title: Text("Cards $index"),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
