import 'package:flutter/material.dart';
import 'package:flutter_expired_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Cell extends StatelessWidget {
  const Cell({
    Key? key,
    required this.title,
    required this.category,
    required this.date,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String category;
  final String date;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 0,
        left: 20,
        bottom: 20,
        right: 20,
      ),
      padding: const EdgeInsets.all(mDefaultPadding / 2),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: mModuleColor,
        borderRadius: BorderRadius.circular(mDefaultPadding / 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              title,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: mTitleColor,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: mDefaultPadding / 2,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 3,
                  right: 3,
                  top: 1,
                  bottom: 3,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: mBorderColor,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(mDefaultPadding / 4),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/$icon.svg",
                      width: 15,
                      height: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      category,
                      style: const TextStyle(
                        color: Color(0xFF9A9A9A),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  date.toString().substring(0, 10),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFFA0A0A0),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
