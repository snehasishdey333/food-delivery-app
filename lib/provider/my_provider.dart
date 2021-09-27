import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foody/models/categories_model.dart';

class MyProvider extends ChangeNotifier {
  List<CategoriesModel> categoriesList = [];
  late CategoriesModel categoriesModel;
  Future<void> getCategories() async {
    List<CategoriesModel> newCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('XN7qM47M5cBfJrz0z4QA')
        .collection('burger')
        .get();
    querySnapshot.docs.forEach((element) {
      categoriesModel = CategoriesModel(
        image: (element.data() as dynamic)['image'],
        name: (element.data() as dynamic)['name'],
      );
      print(categoriesModel.name);
      newCategoriesList.add(categoriesModel);
      categoriesList = newCategoriesList;
    });
  }

  get throwList {
    return categoriesList;
  }
}
