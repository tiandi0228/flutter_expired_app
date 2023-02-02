import 'package:flutter/material.dart';
import 'package:flutter_expired_app/constants.dart';
import 'package:flutter_expired_app/screens/create/store/category_provider.dart';
import 'package:flutter_expired_app/screens/create/widgets/body.dart';
import 'package:flutter_expired_app/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);
  static String routeName = '/create';

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (_) => CategoryProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '新增',
            style: TextStyle(
              color: mTitleColor,
            ),
          ),
          backgroundColor: mModuleColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: mTitleColor,
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, ((route) => false));
            },
          ),
        ),
        body: const Body(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
