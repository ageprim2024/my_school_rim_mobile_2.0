import 'package:flutter/material.dart';
import 'package:my_school_rim/tools/constants/expression.dart';

import '../../tools/constants/colors.dart';
import '../../tools/constants/fonts.dart';
import '../../tools/constants/sizes.dart';
import 'my_icon.dart';
import 'my_text.dart';

class MyListView extends StatelessWidget {
  final Widget? details;
  final List<Map> map;
  final String? leadingTopValue;
  final String? leadingDownValue;
  final String? titleValue;
  final String? subtitleValue1;
  final String? subtitleValue2;
  final String? keyIndex;
  final void Function(String)? onTapOne;
  final void Function(String)? onTapTwo;
  final void Function(String)? onTapThree;
  final void Function(String)? onTapFour;
  final void Function(String)? onTapFive;
  final void Function(String)? onTapSix;
  final IconData? iconOne;
  final IconData? iconTwo;
  final IconData? iconThree;
  final IconData? iconFour;
  final IconData? iconFive;
  final IconData? iconSix;
  const MyListView(
      {super.key,
      this.details,
      required this.map,
      this.leadingTopValue,
      this.leadingDownValue,
      this.titleValue,
      this.subtitleValue1,
      this.subtitleValue2,
      this.onTapOne,
      this.onTapTwo,
      this.onTapThree,
      this.onTapFour,
      this.onTapFive,
      this.onTapSix,
      this.keyIndex,
      this.iconOne,
      this.iconTwo,
      this.iconThree,
      this.iconFour,
      this.iconFive,
      this.iconSix});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: map.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              index == 0 && details != null ? details! : const SizedBox(),
              (index > 0)
                  ? ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: leadingTopValue != null
                                  ? MyText(
                                      data: '${map[index][leadingTopValue]}',
                                      color: green,
                                    )
                                  : const SizedBox()),
                          Expanded(
                              child: leadingDownValue != null
                                  ? MyText(
                                      data: '${map[index][leadingDownValue]}',
                                      color: red,
                                    )
                                  : const SizedBox()),
                        ],
                      ),
                      title: titleValue != null
                          ? MyText(
                              data: '${map[index][titleValue]}',
                              color: blue,
                              fontSize: font12,
                            )
                          : const SizedBox(),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            subtitleValue1 != null
                                ? MyText(
                                    data: '${map[index][subtitleValue1]}',
                                    color: bluelight,
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              width: 6,
                            ),
                            subtitleValue2 != null
                                ? MyText(
                                    data: '${map[index][subtitleValue2]}',
                                    color: bluelight,
                                    fontSize: font12,
                                  )
                                : const SizedBox(),
                          ]),
                          Row(
                            children: [
                              onTapOne != null
                                  ? MyIcon(
                                      icon: map[index][userCollectionDRC] == true?  Icons.done : Icons.close,
                                      size: size22,
                                      onTap: () {
                                        onTapOne!('${map[index][keyIndex]}');
                                      },
                                      color:map[index][userCollectionDRC] == true?  green : red,
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                width: onTapTwo != null ? 6 : 0,
                              ),
                              onTapTwo != null
                                  ? MyIcon(
                                      icon: iconTwo,
                                      size: size22,
                                      onTap: () {
                                        onTapTwo!('${map[index][keyIndex]}');
                                      },
                                      color: black,
                                    )
                                  : const MyIcon(),
                              SizedBox(
                                width: onTapThree != null ? 6 : 0,
                              ),
                              onTapThree != null
                                  ? MyIcon(
                                      icon: iconThree,
                                      size: size22,
                                      onTap: () {
                                        onTapThree!('${map[index][keyIndex]}');
                                      },
                                      color:blue,
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                width: onTapFour != null ? 6 : 0,
                              ),
                              onTapFour != null
                                  ? MyIcon(
                                      icon: iconFour,
                                      size: size22,
                                      onTap: () {
                                        onTapFour!('${map[index][keyIndex]}');
                                      },
                                      color: bluelight,
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                width: onTapFive != null ? 6 : 0,
                              ),
                              onTapFive != null
                                  ? MyIcon(
                                      icon: iconFive,
                                      size: size22,
                                      onTap: () {
                                        onTapFive!('${map[index][keyIndex]}');
                                      },
                                      color: gray,
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                width: onTapSix != null ? 6 : 0,
                              ),
                              onTapSix != null
                                  ? MyIcon(
                                      icon: iconSix,
                                      size: size22,
                                      onTap: () {
                                        onTapSix!('${map[index][keyIndex]}');
                                      },
                                      color: orang,
                                    )
                                  : const SizedBox(width: 0),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(),
              const Divider(
                height: 2,
                color: Color(gray),
              )
            ],
          );
        });
  }
}
