import 'package:flutter/material.dart';
import 'package:flutter_expired_app/constants.dart';
import 'package:flutter_expired_app/model/category.dart';
import 'package:flutter_expired_app/screens/create/store/category_provider.dart';
import 'package:flutter_expired_app/screens/home/home_screen.dart';
import 'package:flutter_expired_app/service/create.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:ftoast/ftoast.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // 分类
  String selectCategory = '';
  // 商品名称
  String name = '';
  // 生产日期
  String manufactureDate = '';
  // 有效日期
  int qualityGuaranteePeriod = 0;
  String selectUnit = 'day';
  int remind = 0;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CategoryProvider>(context);

    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        _buildSingleCell('分类', state.categoryList, 'category', selectCategory),
        _buildTextInput('物品名称', '请输入物品名称', 'name', TextInputType.text),
        _buildDateCell('生产日期', 'start', manufactureDate),
        _buildSingleCell('时间单位', ['day', 'month', 'year'], 'unit', selectUnit),
        _buildTextInput('有效时间', '请输入有效时间', 'quality_guarantee_period',
            TextInputType.number),
        _buildTextInput('到期提醒', '请输入到期提醒天数', 'remind', TextInputType.number),
        Container(
          height: 50,
          margin: const EdgeInsets.all(20),
          child: TextButton(
            onPressed: () {
              List<CategoryList> list = state.list
                  .where((item) => item.name == selectCategory)
                  .toList();
              CreateAPI.getCreateData(
                name: name,
                manufactureDate: manufactureDate,
                qualityGuaranteePeriod: qualityGuaranteePeriod,
                categoryId: list.first.id,
                unit: selectUnit,
                remind: remind,
              );
              FToast.toast(
                context,
                duration: 800,
                msg: "添加成功",
                msgStyle: const TextStyle(
                  color: Colors.white,
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false);
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(100, 40)),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all(mModuleColor),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: const Text(
              '提交',
              style: TextStyle(
                color: mTitleColor,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 文本输入
  Widget _buildTextInput(title, hint, type, keyboardType) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            trailing: SizedBox(
              width: 250,
              child: TextField(
                enableInteractiveSelection: false,
                keyboardType: keyboardType,
                textAlign: TextAlign.right,
                onSubmitted: (String value) {
                  if (type == 'name') {
                    name = value;
                  }
                  if (type == 'remind') {
                    remind = int.parse(value);
                  }
                  if (type == 'quality_guarantee_period') {
                    qualityGuaranteePeriod = int.parse(value);
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black26,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black26,
                ),
                onChanged: (String newValue) {},
              ),
            ),
          ),
        ),
        const Divider(height: 1, indent: 0),
      ],
    );
  }

  // 单选选择器
  Widget _buildSingleCell(title, var data, var type, var selectData) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            onTap: () => _onClickSingleCell(data, type, selectData),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildText(selectData.toString()),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 1, indent: 0),
      ],
    );
  }

  // 时间选择器
  Widget _buildDateCell(title, var type, var selectData) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            onTap: () => _onClickDateCell(type),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildText(selectData.toString()),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 1, indent: 0),
      ],
    );
  }

  // 文本
  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black26,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // 单选点击事件
  void _onClickSingleCell(var data, var type, var selectData) {
    Pickers.showSinglePicker(
      context,
      data: data,
      selectData: selectData,
      pickerStyle: DefaultPickerStyle(),
      onConfirm: ((data, position) {
        setState(() {
          // 分类
          if (type == 'category') {
            selectCategory = data;
          }
          // 时间单位
          if (type == 'unit') {
            selectUnit = data;
          }
        });
      }),
    );
  }

  // 时间点击事件
  void _onClickDateCell(var type) {
    Pickers.showDatePicker(
      context,
      mode: DateMode.YMD,
      suffix: Suffix.normal(),
      minDate: PDuration(year: 2020, month: 2, day: 10),
      maxDate: PDuration(second: 22),
      onConfirm: (p) {
        setState(() {
          switch (type) {
            case 'start':
              manufactureDate =
                  "${p.year}-${p.month! < 10 ? '0${p.month}' : p.month}-${p.day! < 10 ? '0${p.day}' : p.day}";
              break;
          }
        });
      },
    );
  }
}
