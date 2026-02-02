// enfin un bouton de validation

import 'package:deck_share/scryfall_searcher/presentation/controller/scryfall_controller.dart';
import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:deck_share/ui/atom/atom_image.dart';
import 'package:deck_share/ui/atom/atom_list_tile.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/atom/atom_text_field.dart';
import 'package:deck_share/ui/molecules/molecule_card_tile.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/organisms/organism_loan_cards_list.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

class LoanCreationPage extends ConsumerStatefulWidget {
  const LoanCreationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoanCreationState();
}

class _LoanCreationState extends ConsumerState<LoanCreationPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contactController = TextEditingController();
    TextEditingController noteController = TextEditingController();
    return BaseTemplate(
      baseAppBar: BaseAppBar(title: "Nouveau prêt"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // text field pour le titre du prêt

            // la liste des cartes prêter ou à prêter

            // menu de selection pour les contacts ou alors dans un premier temps juste entrer le nom

            // Date picker pour une date de rendu

            // Text field pour ajouter une note sur le prêt
            BaseTextField(
              controller: titleController,
              hintText: "Ex: Modern Burn Deck",
            ),
            // leading l'image de la carte (la crop image je pense)
            // en title le nom de la carte et en trailing de quoi la supprimer de la liste
            BaseLoanCardList(
              pickCardList: [
                MtgCard.fromJson({
                  "object": "card",
                  "id": "0277c0b1-da97-49c1-a539-7fbaa1f77419",
                  "oracle_id": "4457ed35-7c10-48c8-9776-456485fdf070",
                  "multiverse_ids": [],
                  "tcgplayer_id": 518875,
                  "cardmarket_id": 744590,
                  "name": "Lightning Bolt",
                  "lang": "en",
                  "released_at": "2023-12-01",
                  "uri":
                      "https://api.scryfall.com/cards/0277c0b1-da97-49c1-a539-7fbaa1f77419",
                  "scryfall_uri":
                      "https://scryfall.com/card/sld/901/lightning-bolt?utm_source=api",
                  "layout": "normal",
                  "highres_image": true,
                  "image_status": "highres_scan",
                  "image_uris": {
                    "small":
                        "https://cards.scryfall.io/small/front/0/2/0277c0b1-da97-49c1-a539-7fbaa1f77419.jpg?1758887999",
                    "normal":
                        "https://cards.scryfall.io/normal/front/0/2/0277c0b1-da97-49c1-a539-7fbaa1f77419.jpg?1758887999",
                    "large":
                        "https://cards.scryfall.io/large/front/0/2/0277c0b1-da97-49c1-a539-7fbaa1f77419.jpg?1758887999",
                    "png":
                        "https://cards.scryfall.io/png/front/0/2/0277c0b1-da97-49c1-a539-7fbaa1f77419.png?1758887999",
                    "art_crop":
                        "https://cards.scryfall.io/art_crop/front/0/2/0277c0b1-da97-49c1-a539-7fbaa1f77419.jpg?1758887999",
                    "border_crop":
                        "https://cards.scryfall.io/border_crop/front/0/2/0277c0b1-da97-49c1-a539-7fbaa1f77419.jpg?1758887999",
                  },
                  "mana_cost": "{R}",
                  "cmc": 1.0,
                  "type_line": "Instant",
                  "oracle_text": "Lightning Bolt deals 3 damage to any target.",
                  "colors": ["R"],
                  "color_identity": ["R"],
                  "keywords": [],
                  "all_parts": [
                    {
                      "object": "related_card",
                      "id": "3c738171-d0dc-4cc2-8af8-1d306143db37",
                      "component": "combo_piece",
                      "name": "Lightning Bolt",
                      "type_line": "Instant",
                      "uri":
                          "https://api.scryfall.com/cards/3c738171-d0dc-4cc2-8af8-1d306143db37",
                    },
                    {
                      "object": "related_card",
                      "id": "4f095067-cf24-4061-8626-dc68a66a0b36",
                      "component": "combo_piece",
                      "name": "Toralf's Disciple",
                      "type_line": "Creature — Human Warrior",
                      "uri":
                          "https://api.scryfall.com/cards/4f095067-cf24-4061-8626-dc68a66a0b36",
                    },
                    {
                      "object": "related_card",
                      "id": "69b51576-532b-450e-a8bf-0482cac04618",
                      "component": "combo_piece",
                      "name": "Thayan Evokers",
                      "type_line": "Creature — Human Wizard",
                      "uri":
                          "https://api.scryfall.com/cards/69b51576-532b-450e-a8bf-0482cac04618",
                    },
                    {
                      "object": "related_card",
                      "id": "618806ea-7ea8-4cfb-a8c1-c3defa34e7dd",
                      "component": "combo_piece",
                      "name": "Indris, the Hydrostatic Surge",
                      "type_line": "Legendary Creature — Otter Incarnation",
                      "uri":
                          "https://api.scryfall.com/cards/618806ea-7ea8-4cfb-a8c1-c3defa34e7dd",
                    },
                  ],
                  "legalities": {
                    "standard": "not_legal",
                    "future": "not_legal",
                    "historic": "banned",
                    "timeless": "legal",
                    "gladiator": "legal",
                    "pioneer": "not_legal",
                    "modern": "legal",
                    "legacy": "legal",
                    "pauper": "legal",
                    "vintage": "legal",
                    "penny": "not_legal",
                    "commander": "legal",
                    "oathbreaker": "legal",
                    "standardbrawl": "not_legal",
                    "brawl": "legal",
                    "alchemy": "not_legal",
                    "paupercommander": "legal",
                    "duel": "legal",
                    "oldschool": "not_legal",
                    "premodern": "legal",
                    "predh": "legal",
                  },
                  "games": ["paper"],
                  "reserved": false,
                  "game_changer": false,
                  "foil": true,
                  "nonfoil": false,
                  "finishes": ["foil"],
                  "oversized": false,
                  "promo": true,
                  "reprint": true,
                  "variation": false,
                  "set_id": "4d92a8a7-ccb0-437d-abdc-9d70fc5ed672",
                  "set": "sld",
                  "set_name": "Secret Lair Drop",
                  "set_type": "box",
                  "set_uri":
                      "https://api.scryfall.com/sets/4d92a8a7-ccb0-437d-abdc-9d70fc5ed672",
                  "set_search_uri":
                      "https://api.scryfall.com/cards/search?order=set&q=e%3Asld&unique=prints",
                  "scryfall_set_uri":
                      "https://scryfall.com/sets/sld?utm_source=api",
                  "rulings_uri":
                      "https://api.scryfall.com/cards/0277c0b1-da97-49c1-a539-7fbaa1f77419/rulings",
                  "prints_search_uri":
                      "https://api.scryfall.com/cards/search?order=released&q=oracleid%3A4457ed35-7c10-48c8-9776-456485fdf070&unique=prints",
                  "collector_number": "901",
                  "digital": false,
                  "rarity": "rare",
                  "card_back_id": "0aeebaf5-8c7d-4636-9e82-8c27447861f7",
                  "artist": "Christopher Rush",
                  "artist_ids": ["c96773f0-346c-4f7d-9271-2d98cc5d86e1"],
                  "illustration_id": "2cb6200c-d05b-419c-bd10-8b9c146e2339",
                  "border_color": "black",
                  "frame": "2015",
                  "frame_effects": ["inverted", "fullart"],
                  "security_stamp": "oval",
                  "full_art": true,
                  "textless": false,
                  "booster": false,
                  "story_spotlight": false,
                  "edhrec_rank": 163,
                  "prices": {
                    "usd": null,
                    "usd_foil": "13.03",
                    "usd_etched": null,
                    "eur": null,
                    "eur_foil": "20.59",
                    "tix": null,
                  },
                  "related_uris": {
                    "tcgplayer_infinite_articles":
                        "https://partner.tcgplayer.com/c/4931599/1830156/21018?subId1=api&trafcat=tcgplayer.com%2Fsearch%2Farticles&u=https%3A%2F%2Fwww.tcgplayer.com%2Fsearch%2Farticles%3FproductLineName%3Dmagic%26q%3DLightning%2BBolt",
                    "tcgplayer_infinite_decks":
                        "https://partner.tcgplayer.com/c/4931599/1830156/21018?subId1=api&trafcat=tcgplayer.com%2Fsearch%2Fdecks&u=https%3A%2F%2Fwww.tcgplayer.com%2Fsearch%2Fdecks%3FproductLineName%3Dmagic%26q%3DLightning%2BBolt",
                    "edhrec": "https://edhrec.com/route/?cc=Lightning+Bolt",
                  },
                  "purchase_uris": {
                    "tcgplayer":
                        "https://partner.tcgplayer.com/c/4931599/1830156/21018?subId1=api&u=https%3A%2F%2Fwww.tcgplayer.com%2Fproduct%2F518875%3Fpage%3D1",
                    "cardmarket":
                        "https://www.cardmarket.com/en/Magic/Products?idProduct=744590&referrer=scryfall&utm_campaign=card_prices&utm_medium=text&utm_source=scryfall",
                    "cardhoarder":
                        "https://www.cardhoarder.com/cards?affiliate_id=scryfall&data%5Bsearch%5D=Lightning+Bolt&ref=card-profile&utm_campaign=affiliate&utm_medium=card&utm_source=scryfall",
                  },
                }),
              ],
            ),
            BaseTextField(
              controller: contactController,
              hintText: "Entre le nom du contact",
            ),
            // TODO ajouter un bouton et un text pour le date picker
            BaseTextField(
              controller: noteController,
              hintText: "Ajouter des notes",
            ),
          ],
        ),
      ),
      floatingActionButton: BaseButton(label: "Créer le prêt", buttonColor: AppColors.surface, onPressed: (){},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
