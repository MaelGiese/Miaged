import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/panier.dart';
import '../models/acheter.dart';
import '../screens/itemDetails.dart';

class Acheter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInPanier = context.select<PanierModel, bool>(
          (panier) => panier.items.contains(item),
    );

    return TextButton(
      onPressed: isInPanier
          ? null
          : () {
        var panier = context.read<PanierModel>();
        panier.add(item);
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInPanier ? Icon(Icons.check, semanticLabel: 'ADDED') : Icon(Icons.add_shopping_cart_sharp, size: 35),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Acheter', style: Theme.of(context).textTheme.headline1),
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () => Navigator.pushNamed(context, '/profil'),
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/panier'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<AcheterModel, Item>(
          (i) => i.getByPosition(index),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),

      child: LimitedBox(
        maxHeight: 500,
      child: Container(
        decoration: BoxDecoration(
          color: item.couleur,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Hero(
                      tag: "${item.id}",
                      child: GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => ItemDetails(item: item),
                            )),
                        child: Image.network(item.url),
                      ),
                    ),
                  ),
                ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      item.prix.toString() + '€',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      item.taille,
                      style: TextStyle(color: item.couleur.withOpacity(0.5)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20 / 4),
                      child: Text(
                        item.titre,
                        style: TextStyle(color: item.couleur.withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
                new Spacer(),
                _AddButton(item: item),
              ],
            ),
        ],
        ),
      ),
      ),
    );
  }
}