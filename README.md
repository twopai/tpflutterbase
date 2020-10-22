# tpflutterbase

A tpflutter Flutter plugin.

### Example

``` dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
List<T>items=[...];
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
      child: (items?.length??0)==0?Container():
                 Container(
                   child: GoodsTypeWidget(
                     datas: items.map((e) => GoodsTypeModel(img: e?.img,name: e?.title)).toList(),
                     backGroundColor: ColorUtils.color_transparent,
                     onItemTap: (int itemIndex)=>_toTypeListPage(itemIndex,),
                   ),
                 ),
      ),
    ),
  ));
}

_toTypeListPage(int itemIndex) async {

}
```
