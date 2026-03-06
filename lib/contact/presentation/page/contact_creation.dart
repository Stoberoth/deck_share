import "package:deck_share/ui/organisms/organism_app_bar.dart";
import "package:deck_share/ui/templates/template_base.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:deck_share/ui/molecules/molecule_contact_form.dart";

class ContactCreation extends ConsumerWidget {
  const ContactCreation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TemplateBase(
      baseAppBar: OrganismAppBar(title: "Création de contact"),
      body: Column(children: [MoleculeContactForm(),],) 
    );
  }
}
