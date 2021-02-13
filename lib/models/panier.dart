import 'package:flutter/foundation.dart';
import '../models/acheter.dart';

class PanierModel extends ChangeNotifier {
  AcheterModel _achat;
  final List<int> _itemIds = [];

  AcheterModel get achat => _achat;

  set achat(AcheterModel newAchat) {
    assert(newAchat != null);
    assert(_itemIds.every((id) => newAchat.getById(id) != null),
    'L\'achat $newAchat ne possède pas $_itemIds');
    _achat = newAchat;
    notifyListeners();
  }

  /// List of items in the cart.
  List<Item> get items => _itemIds.map((id) => _achat.getById(id)).toList();

  /// The current total price of all items.
  double get totalPrice =>
      items.fold(0, (total, current) => total + current.prix);

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }
}