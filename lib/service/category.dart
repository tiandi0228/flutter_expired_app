import 'package:flutter_expired_app/model/category.dart';
import 'package:flutter_expired_app/utils/request.dart';

// 分类列表
class CategoryAPI {
  // 获取详情信息
  static Future<CategoryModel> getCategoryData() async {
    var response = await RequestUtil().get('category');

    final Map<String, dynamic> data = {"list": []};

    for (var item in response) {
      data['list'].add(item);
    }

    return CategoryModel.fromJson(data);
  }
}
