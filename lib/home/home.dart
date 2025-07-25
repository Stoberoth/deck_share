import 'package:deck_share/scryfall_searcher/presentation/page/scryfall_card_picker.dart';
import 'package:deck_share/share_cards/presentation/page/home_share_cards.dart';
import 'package:deck_share/wishlist/presentation/page/home_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final List<Widget> _listOfPages = [HomeWishlistPage(), ShareCardsPage()];

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listOfPages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'WishList'),
          BottomNavigationBarItem(
            icon: Icon(Icons.handshake),
            label: 'ShareCards',
          ),
        ],
        currentIndex: currentPageIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {setState(() {
          currentPageIndex = index;
        });},
      ),
    );
  }
}
