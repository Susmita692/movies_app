import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/movie_inventory.dart';

import 'main.dart';

class MovieModel with ChangeNotifier {
  String _inventoryBox = 'inventory';

  List _inventoryList = <MovieInventory>[];

  List get inventoryList => _inventoryList;

  addItem(MovieInventory inventory) async {
    var box = await Hive.openBox<MovieInventory>(_inventoryBox);

    box.add(inventory);

    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    notifyListeners();
  }

  getItem() async {
    final box = await Hive.openBox<MovieInventory>(_inventoryBox);

    _inventoryList = box.values.toList();

    if(firstLoad) {
      firstLoad = false;
      notifyListeners();
    }
  }

  updateItem(int index, MovieInventory inventory) async{
    final box = Hive.box<MovieInventory>(_inventoryBox);

    box.putAt(index, inventory);

    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    notifyListeners();
  }

  deleteItem(int index) async{
    final box = Hive.box<MovieInventory>(_inventoryBox);

    box.deleteAt(index);

    getItem();

    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    notifyListeners();
  }

}