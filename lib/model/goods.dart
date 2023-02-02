class GoodsList {
  String name;
  String manufactureDate;
  String qualityGuaranteePeriod;
  String categoryName;
  String icon;

  GoodsList({
    required this.name,
    required this.manufactureDate,
    required this.qualityGuaranteePeriod,
    required this.categoryName,
    required this.icon,
  });

  factory GoodsList.fromJson(Map<String, dynamic> json) => GoodsList(
        name: json["name"],
        manufactureDate: json['manufacture_date'],
        qualityGuaranteePeriod: json['quality_guarantee_period'],
        categoryName: json['category_name'],
        icon: json['icon'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "manufactureDate": manufactureDate,
        "qualityGuaranteePeriod": qualityGuaranteePeriod,
        "categoryName": categoryName,
        "icon": icon,
      };
}
