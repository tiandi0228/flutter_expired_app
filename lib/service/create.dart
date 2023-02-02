import 'package:flutter_expired_app/utils/request.dart';

// 添加信息
class CreateAPI {
  static Future<dynamic> getCreateData({
    // 名称
    required String name,
    // 生产日期
    required String manufactureDate,
    // 保质期
    required int qualityGuaranteePeriod,
    // 分类
    required int categoryId,
    // 时间单位
    required String unit,
    // 提醒时间
    required int remind,
  }) async {
    var response = await RequestUtil().post(
      'product/add',
      params: {
        "name": name,
        "manufacture_date": manufactureDate,
        "quality_guarantee_period": qualityGuaranteePeriod,
        "category_id": categoryId,
        "unit": unit,
        "remind": remind,
      },
    );
    return response;
  }
}
