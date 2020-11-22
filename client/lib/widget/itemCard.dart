import 'package:client/constants.dart';
import 'package:flutter/material.dart';
class ItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final IconData trailing;
  final String imageUrl;

  ItemCard({
    @required this.title,
    @required this.onPressed,
    @required this.trailing,
    @required this.imageUrl,
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: primaryColor,
          ),
        ),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Image.network(
              '${this.imageUrl}',
              fit: BoxFit.fill,
            ),
          ),
          title: Text('${this.title}'),
          subtitle: this.subtitle == '' ? Container() : Text('${this.subtitle}'),
          onTap: onPressed,
          trailing: Icon(this.trailing),
        ),
      ),
    );
  }
}