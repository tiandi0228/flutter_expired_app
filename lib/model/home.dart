import 'dart:convert';
import 'package:flutter_expired_app/model/goods.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  int totalRecords;
  int totalPages;
  List<GoodsList> goodsList;

  HomeModel({
    required this.totalPages,
    required this.totalRecords,
    required this.goodsList,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        totalRecords: json['total_records'],
        totalPages: json['total_pages'],
        goodsList: List<GoodsList>.from(
          json["records"].map(
            (x) => GoodsList.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "total_pages": totalPages,
        "total_records": totalRecords,
        "records": List<dynamic>.from(goodsList.map((x) => x.toJson())),
      };
}
