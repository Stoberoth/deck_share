// This page will be used to create a new wishlist

import 'package:deck_share/scryfall_searcher/presentation/page/scryfall_card_picker.dart';
import 'package:deck_share/ui/atom/base_button.dart';
import 'package:deck_share/ui/atom/base_dismissible.dart';
import 'package:deck_share/ui/atom/base_icon_button.dart';
import 'package:deck_share/ui/atom/base_list_tile.dart';
import 'package:deck_share/ui/atom/base_text_field.dart';
import 'package:deck_share/ui/organisms/base_app_bar.dart';
import 'package:deck_share/ui/templates/base_template.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:scryfall_api/scryfall_api.dart';

class WishlistCreationPage extends StatefulWidget {
  const WishlistCreationPage({super.key});

  @override
  State<WishlistCreationPage> createState() => _WishlistCreationPageState();
}

class _WishlistCreationPageState extends State<WishlistCreationPage> {
  List<MtgCard> pick_cards = [];
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      baseAppBar: BaseAppBar(
        title: "Create a new wishlist",
        actions: [
          BaseIconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Navigator.pop(
                context,
                Wishlist(
                  id: UniqueKey().hashCode.toString(),
                  name: nameController.text,
                  cards: pick_cards,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // need to add field to complete whishlist informations
            // add text controller to the text field
            BaseTextField(
              controller: nameController,
              hintText: "Name of the deck's wishlist",
              icon: Icon(Icons.text_fields),
            ),
            BaseButton(
              label: "Add card",
              onPressed: () async {
                pick_cards = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ScryfallCardPicker(pickCards: pick_cards),
                  ),
                );
                setState(() {});
              },
            ),

            // add cards to the wishlist and show the list of cards
            pick_cards.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return BaseDismissible(
                          dismissibleKey: ValueKey(pick_cards[index].id),
                          onDismissed: (direction) {
                            setState(() {
                              pick_cards.removeAt(index);
                            });
                          },
                          child: BaseListTile(
                            leading: pick_cards[index].cardFaces != null
                                ? Image(
                                    image: Image.network(
                                      pick_cards[index]
                                          .cardFaces![0]
                                          .imageUris!
                                          .normal
                                          .toString(),
                                    ).image,
                                  )
                                : Image(
                                    image: Image.network(
                                      pick_cards[index].imageUris!.normal
                                          .toString(),
                                    ).image,
                                  ),
                            title: Text(pick_cards[index].name),
                            subtitle: Text(pick_cards[index].typeLine),
                          ),
                        );
                      },
                      itemCount: pick_cards.length,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
