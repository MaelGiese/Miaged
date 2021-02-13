import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AcheterModel {
  final Firestore firestore = Firestore.instance;

  static List<Item> items = [
    Item(0,
      'Magnifique robe bleu',
        25,
        'L / 40 / 12',
        'https://images.vinted.net/thumbs/f800/02_0152f_y3R5SVTmq7wJ3D4bnaiDLcsY.jpeg?1613165050-1db7d0a7c1032c7f357e322e0359f5d62ee75b0e',
        'Magnifque robe bleu dos transparent C\'est une taille L cintré à la taille je ne l’ai jamais mise',
        Colors.blue.withOpacity(0.1))];

  /// Get item by [id].
    Item getById(int id) {

      if(items.length != 0){
        int length = id % items.length;
        return Item(
            id,
            items[length].titre,
            items[length].prix,
            items[length].taille,
            items[length].url,
            items[length].description,
            items[length].couleur);
      }else{
        return null;
      }
    }

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    if(items.length == 1){
      updateItemsFromDatabase();
    }

    return getById(position);
  }

  
  void updateItemsFromDatabase() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection("Item").getDocuments();
    var list = querySnapshot.documents;
    for (var value in list) {
      items.add(Item(value.data['id'], value.data['titre'], value.data['prix'], value.data['taille'], value.data['url'], value.data['description'], Color(value.data['couleur']).withOpacity(0.1)));
    }
  }

}

@immutable
class Item {
  final int id;
  final double prix;
  final String titre, url, description, taille;
  final Color couleur;

  Item(this.id, this.titre, this.prix, this.taille, this.url, this.description, this.couleur);
  // To make the sample app look nicer, each item is given one of the
  // Material Design primary colors.
      //: color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}