import 'package:flutter/foundation.dart';
import 'package:flutter_expired_app/model/goods.dart';
import 'package:flutter_expired_app/model/home.dart';
import 'package:flutter_expired_app/service/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeProvider with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool loading = true;
  List<GoodsList> list = [];
  int page = 1;

  HomeProvider() {
    // 首页数据加载
    initData();
  }

  Future initData({bool refresh = false}) async {
    page = 1;
    HomeModel res = await HomeAPI.getHomeData(page: page, pageSize: 10);

    // 初次加载
    list = res.goodsList;
    loading = false;

    // 下拉刷新
    if (refresh) {
      list = res.goodsList;
      loading = false;
      refreshController.refreshCompleted();
      refreshController.resetNoData();
    }
    notifyListeners();
  }

  // 上拉加载
  Future loadData({bool refresh = false}) async {
    page += 1;
    HomeModel res = await HomeAPI.getHomeData(page: page, pageSize: 10);
    list += res.goodsList;
    loading = false;
    if (res.totalPages >= page) {
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
    notifyListeners();
  }
}
