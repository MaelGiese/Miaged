import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/panier.dart';

class Panier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier', style: Theme.of(context).textTheme.headline1),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _PanierList(),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            _PanierTotal()
          ],
        ),
      ),
    );
  }
}

class _PanierList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;
    var panier = context.watch<PanierModel>();

    return ListView.builder(
      itemCount: panier.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done),
        trailing: IconButton(
          icon: Icon(Icons.remove_shopping_cart),
          onPressed: () {
            panier.remove(panier.items[index]);
          },
        ),
        title: Text(
          panier.items[index].titre,
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _PanierTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
    Theme.of(context).textTheme.headline1.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<PanierModel>(
                builder: (context, panier, child) =>
                    Text(panier.totalPrice.toString() + '€', style: hugeStyle)),
            SizedBox(width: 24),
            TextButton(
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Buying not supported yet.')));
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: Text('ACHETER'),
            ),
          ],
        ),
      ),
    );
  }
}