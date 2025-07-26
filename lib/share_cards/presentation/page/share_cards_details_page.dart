import 'package:deck_share/scryfall_searcher/presentation/widget/card_details_widget.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareCardsDetailsPage extends ConsumerWidget {
  const ShareCardsDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Share cards details")),
      body: SafeArea(
        child: FutureBuilder(
          future: ref
              .read(shareCardsControllerProvider.notifier)
              .getShareCardsbyId(
                ref.read(shareCardsControllerProvider.notifier).selectedItem,
              ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Lender : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      snapshot.data!.lender,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Applicant : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      snapshot.data!.applicant,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Center(
                  child: Text(
                    "List of Cards :",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.lendingCards.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.black45,
                          child: ListTile(
                            hoverColor: Colors.lightBlue,
                            leading: Image(
                              image: Image.network(
                                snapshot
                                    .data!
                                    .lendingCards[index]
                                    .imageUris!
                                    .normal
                                    .toString(),
                              ).image,
                            ),
                            title: Text(
                              snapshot.data!.lendingCards[index].name,
                            ),
                            subtitle: Text(
                              snapshot.data!.lendingCards[index].typeLine,
                            ),
                            onLongPress: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return CardDetails_widget(
                                    card: snapshot.data!.lendingCards[index],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
