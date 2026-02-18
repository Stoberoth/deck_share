import 'package:deck_share/share_cards/presentation/page/home_share_cards.dart';
import 'package:deck_share/ui/templates/template_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return TemplateHome(
      body: ShareCardsPage(),
    );
    
  }
}
