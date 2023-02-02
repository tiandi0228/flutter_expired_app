import 'package:flutter/material.dart';
import 'package:flutter_expired_app/screens/create/create_screen.dart';
import 'package:flutter_expired_app/screens/home/store/home_provider.dart';
import 'package:flutter_expired_app/screens/home/widgets/body.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, CreateScreen.routeName);
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        body: const Body(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
