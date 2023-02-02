import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expired_app/constants.dart';
import 'package:flutter_expired_app/screens/create/create_screen.dart';
import 'package:flutter_expired_app/screens/home/home_screen.dart';
import 'package:flutter_expired_app/screens/login/login_screen.dart';
import 'package:flutter_expired_app/store/local_storage.dart';

// 底部导航的页面不需要动画效果
final List<String> noAnimateNames = [
  HomeScreen.routeName,
];

typedef WidgetFunction = Widget Function();

// 需要登录
final Map<String, WidgetFunction> authRoutes = {
  HomeScreen.routeName: () => const HomeScreen(),
  CreateScreen.routeName: () => const CreateScreen(),
};

// 无需登录
final Map<String, WidgetFunction> noAuthRoutes = {
  LoginScreen.routeName: () => const LoginScreen(),
};

// https://juejin.cn/post/6932736576417955847
// 动态路由
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  // 路由拦截 登录判断
  var routeName = _routeBeforeHook(settings);
  WidgetFunction? viewRender;

  viewRender = noAuthRoutes[routeName];

  // ignore: prefer_conditional_assignment
  if (viewRender == null) {
    viewRender = authRoutes[routeName];
  }

  // ignore: prefer_conditional_assignment
  if (viewRender == null) {
    viewRender = () {
      return const Scaffold(
        body: Center(
          child: Text("Notfund"),
        ),
      );
    };
  }

  // 根据 名称判断 是否需要路由动画效果
  if (noAnimateNames.contains(routeName)) {
    // 底部导航切换 没有动画
    return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => viewRender!());
  } else {
    return PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // 动画效果 从右滑动到左
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => viewRender!());
  }
}

String? _routeBeforeHook(RouteSettings settings) {
  var token = LocalStorage.get(Constants.accessTokenKey);
  String name = '${settings.name}';

  // 判断是否是 无需登录的路由
  if (noAuthRoutes.keys.contains(name)) {
    return name;
  }

  // 判断是否登录 没有登录就跳转login页面
  if (token == null || token == '') {
    return LoginScreen.routeName;
  }

  return name;
}

// 返回false 代表路由阻塞
typedef HookFunction = Future<bool> Function(BuildContext context);

// 自定义路由 封装 Navigator的一些方法
class AppRouter {
  AppRouter({required this.context});

  BuildContext context;

  // hook函数列表
  static final List<HookFunction> _beforeHooks = [];

  // 静态构造方法
  static AppRouter of(BuildContext context) {
    return AppRouter(context: context);
  }

  // 路由hook
  static beforeHook(HookFunction callback) {
    // 路由跳转之前 执行的操作 比如调用接口 检测用户是否登录
    _beforeHooks.add(callback);
  }

  // 取出当前路由的参数
  Map<String, dynamic> query() {
    // var param = _routeParamStack.last as T;
    // return param;
    dynamic query = ModalRoute.of(context)!.settings.arguments;
    return query ?? {};
  }

  Future _callBeforeHook() async {
    bool finalState = true;
    for (var call in _beforeHooks) {
      var state = await call(context);
      if (!state) {
        finalState = state;
        break;
      }
    }
    return Future.value(finalState);
  }

  pushNamed(String routeName, {dynamic arguments, Function(Object?)? popBack}) {
    // 跳转路由 并且当路由执行pop弹出的时候 会触发回调 popBack
    _callBeforeHook().then((value) {
      if (value) {
        Navigator.of(context)
            .pushNamed(routeName, arguments: arguments)
            .then((value) {
          if (popBack != null) {
            popBack(value);
          }
        });
      }
    });
  }

  pushNamedAndRemoveUntil(String routeName, {dynamic arguments}) {
    _callBeforeHook().then((value) {
      if (value) {
        Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false,
            arguments: arguments);
      }
    });
  }

  pop({dynamic arguments}) {
    _callBeforeHook().then((value) {
      if (value) {
        Navigator.of(context).pop(arguments);
      }
    });
  }
}
