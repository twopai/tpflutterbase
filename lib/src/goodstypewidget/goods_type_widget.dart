import 'package:flutter/material.dart';
import 'package:tpflutterbase/src/utils/image_utils.dart';

import 'goods_type_model.dart';

/**
 * 商品分类
 */
class GoodsTypeWidget extends StatefulWidget {
  List<GoodsTypeModel> datas;
  int perHorNum;
  int perPageVerNum;
  Function onItemTap;
  Color backGroundColor;
  String imgBaseUrl;
  GoodsTypeWidget({
    this.datas:const [],
    this.perHorNum:5,
    this.perPageVerNum:2,
    this.backGroundColor:Colors.white,
    this.imgBaseUrl,
    this.onItemTap
  });
  @override
  _GoodsTypeWidgetState createState() => _GoodsTypeWidgetState();
}

class _GoodsTypeWidgetState extends State<GoodsTypeWidget> {

  List<GoodsTypeModel>items=[];
  //每行多少个
  int perHorNum=5;
  //每页多少行
  int perPageVerNum=2;
  List<List<GoodsTypeModel>>pageItems=[];
  //共多少页
  int pageNum=1;
  //余数
  int reNum=0;
  //递增标记
  int remarkNum=1;
  int mPageIndex=1;

  @override
  void initState() {
    // TODO: implement initState
    _CountData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: widget.backGroundColor,
          padding: EdgeInsets.only(
//          left: 15,
//          right: 15,
          ),
          width: MediaQuery.of(context).size.width,
          height: ((MediaQuery.of(context).size.width)/perHorNum)*(items?.length<=perHorNum?1:perPageVerNum)+pageItems.length*10,
          child:
          PageView.builder(
              onPageChanged: (int pageIndex){
                mPageIndex=pageIndex+1;
                setState(() {});
              },
              itemCount: pageItems.length,
              itemBuilder: (BuildContext context,int index){
                return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: perHorNum,
                        mainAxisSpacing:10,
                        crossAxisSpacing: 0,
                        childAspectRatio: 1
                    ),
                    itemCount: pageItems[index].length,
                    itemBuilder: (BuildContext context,int innerIndex){
                      return GestureDetector(
                        child: Container(
//                          color: innerIndex==5?Colors.amberAccent:Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              (pageItems[index][innerIndex]?.img==null||('')==pageItems[index][innerIndex]?.img)?Container():
                              Container(
                                child: ImageUtils.loadNetworkImage(
                                    imgBaseUrl: widget.imgBaseUrl,
                                    imgPath: pageItems[index][innerIndex]?.img??'',
                                    width:((MediaQuery.of(context).size.width-15*2)/perHorNum-((MediaQuery.of(context).size.width-15*2)/perHorNum)/3),
                                    height:((MediaQuery.of(context).size.width-15*2)/perHorNum-((MediaQuery.of(context).size.width-15*2)/perHorNum)/3)
                                ),
                              ),
                              (pageItems[index][innerIndex]?.name==null||('')==pageItems[index][innerIndex]?.name)?Container():
                              Container(
                                child: Text(
                                  '${pageItems[index][innerIndex]?.name}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff333333)
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: ()=>widget.onItemTap(index*perHorNum*perPageVerNum+innerIndex),
                      );
                    }
                );
              }
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 24,
            color: widget.backGroundColor,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:pageItems.map((e) => Container(
                margin: EdgeInsets.only(
                  left: 1,
                  right: 1,
                ),
                child: Text(''),
                width: 12,
                height: 4,
                decoration: BoxDecoration(
                    color: (pageItems.indexOf(e)==(mPageIndex-1)?Color(0xff0D94FD):Color(0xffcccccc)),
                    borderRadius: BorderRadius.circular(10)
                ),
              )).toList(),
            )
        )
      ],
    );
  }

  void _CountData() {
    items=widget.datas;
    perHorNum=widget.perHorNum;
    perPageVerNum=widget.perPageVerNum;
    pageNum=(items.length/(perHorNum*perPageVerNum)).toInt();
    reNum=(items.length%(perHorNum*perPageVerNum)).toInt();
    while(remarkNum<=pageNum&&pageNum>=1){
      List<GoodsTypeModel>pageItemsCur=[];
      pageItemsCur.addAll(items.sublist((perHorNum*perPageVerNum*(remarkNum-1)),(perHorNum*perPageVerNum*(remarkNum))));
      pageItems.add(pageItemsCur);
      remarkNum++;
    }
    if(reNum!=0){
      List<GoodsTypeModel>pageItemsCur=[];
      pageItemsCur.addAll(items.sublist((items.length-reNum),(items.length)));
      pageItems.add(pageItemsCur);
    }
    setState(() {});
  }
}
