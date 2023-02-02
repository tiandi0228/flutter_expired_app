import 'package:flutter/cupertino.dart';
import 'package:flutter_expired_app/model/category.dart';
import 'package:flutter_expired_app/service/services.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryList> list = [];
  final List<String> categoryList = [];

  CategoryProvider() {
    initData();
  }

  Future initData() async {
    CategoryModel res = await CategoryAPI.getCategoryData();

    list = res.list;

    for (var item in res.list) {
      categoryList.add(item.name);
    }

    notifyListeners();
  }
}
