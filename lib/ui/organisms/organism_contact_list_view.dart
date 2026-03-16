import 'package:deck_share/contact/application/providers/contact_providers.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrganismContactListView extends ConsumerStatefulWidget {
  @override
  ConsumerState<OrganismContactListView> createState() {
    // TODO: implement createState
    return OrganismContactListViewState();
  }
}

class OrganismContactListViewState
    extends ConsumerState<OrganismContactListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.read(contactServiceProvider).getAllContact(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AtomText(data: "Liste des contacts", fontSize: 30,),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 400),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return MoleculeContactTile(contact: snapshot.data![index]);
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
