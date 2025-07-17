import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareCardsDetailsPage extends ConsumerWidget {
  const ShareCardsDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Details Panel")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: ref
                .read(shareCardsControllerProvider.notifier)
                .getShareCardsbyId(
                  ref.read(shareCardsControllerProvider.notifier).selectedItem,
                ),
            builder: (context, snapshot) {
              if(!snapshot.hasData)
              {
                return CircularProgressIndicator();
              }
              return Column(
                children: [
                  Row(
                    children: [Text("Lender : "), Text(snapshot.data!.lender)],
                  ),
                  Row(
                    children: [
                      Text("Applicant : "),
                      Text(snapshot.data!.applicant),
                    ],
                  ),
                  Center(
                    child: Text(
                      "List of Cards :",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.lendingCards.length,
                    itemBuilder: (context, index) {
                      return Text(snapshot.data!.lendingCards[index]);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
