import 'package:flutter_expired_app/model/home.dart';
import 'package:flutter_expired_app/utils/request.dart';

// 到期物品列表
class HomeAPI {
  // 获取详情信息
  static Future<HomeModel> getHomeData({
    String? name,
    required int page,
    required int pageSize,
  }) async {
    var response = await RequestUtil().get(
      'product/page',
      params: {
        "name": name,
        "page": page,
        "page_size": pageSize,
      },
    );
    return HomeModel.fromJson(response);
  }
}
