import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_expired_app/screens/home/store/home_provider.dart';
import 'package:flutter_expired_app/screens/home/widgets/cell.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_expired_app/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeProvider>(context);

    return state.loading
        ? const Center(
            child: Text('loading'),
          )
        : Container(
            padding: const EdgeInsets.only(top: kIsWeb ? 20.0 : 60.0),
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: mBackgroundColor,
            ),
            child: GestureDetector(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: const WaterDropHeader(),
                onRefresh: () => state.initData(refresh: true),
                onLoading: state.loadData,
                controller: state.refreshController,
                child: Wrap(
                  children: state.list.map<Widget>(
                    (item) {
                      return Cell(
                        title: item.name,
                        category: item.categoryName,
                        date: item.qualityGuaranteePeriod,
                        icon: item.icon,
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          );
  }
}
