import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/share_cards/presentation/page/share_cards_creation_page.dart';
import 'package:deck_share/share_cards/presentation/widget/share_cards_list.dart';
import 'package:deck_share/ui/atom/base_floating_action_button.dart';
import 'package:deck_share/ui/organisms/base_app_bar.dart';
import 'package:deck_share/ui/templates/base_template.dart';
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
    return BaseTemplate(
      baseAppBar: BaseAppBar(title: 'Deck Share : Share Cards'),
      body: SafeArea(child: Column(children: [ShareCardsListWidget()])),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BaseFloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          ShareCards? sc = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ShareCardsCreationPage(pickCards: [], amILender: true),
            ),
          );
          if (sc != null) {
            await ref
                .read(shareCardsControllerProvider.notifier)
                .addShareCards(sc);
          }
        },
      ),
    );
  }
}
