import 'package:flutter/material.dart';
 
/// It will be used in the home page.
/// It will be used to display the wishlists of the user.


class WishListWidget extends StatelessWidget {
  const WishListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 500, child: ListView.builder(shrinkWrap: true, itemCount: 20, itemBuilder: (context, index) {
      return  ListTile(
          title: Text('Wishlist $index'),
          subtitle: Text('Wishlist $index'),
          leading: Icon(Icons.star),
          trailing: Icon(Icons.arrow_forward),
        );
    }));
  }
}