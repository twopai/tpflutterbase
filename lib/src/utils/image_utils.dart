import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/**
 * 图片加载管理类
 */
class ImageUtils{
  /// 加载本地资源图片
  static Widget loadAssetImage(String imgPath, {double width, double height, BoxFit fit}){
    Image image = Image.asset(imgPath, height: height, width: width, fit: fit,);
    final ImageStream stream = image.image.resolve(ImageConfiguration.empty);
    stream.addListener(ImageStreamListener((ImageInfo image, bool synchronousCall){
    },onError: (dynamic exception, StackTrace stackTrace) {
    } ));
    return image;
  }

  /// 加载网络图片
  static Widget loadNetworkImage({Key key,String imgBaseUrl,String imgPath, BorderRadius radius:BorderRadius.zero,String placeholder : "none", double width, double height, BoxFit fit: BoxFit.cover}){
    print(imgPath);
    return Container(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: radius,
        child: CachedNetworkImage(
          key: key,
          imageUrl: (imgBaseUrl??'')+(imgPath??''),
          placeholder: (context, url) => loadAssetImage(placeholder, height: height, width: width, fit: fit),
          errorWidget: (context, url, error) => loadAssetImage(placeholder, height: height, width: width, fit: fit),
          width: width,
          height: height,
          fit: fit,
        )
      ),
    );

  }

  /// 加载网络图片
  static Widget FadeInImageAssetNetwork(String imgPath, {String placeholder : "none", double width, double height, BoxFit fit: BoxFit.cover}){
    print(imgPath);
    return FadeInImage.assetNetwork(
      image: imgPath == null ? "" : imgPath,
      placeholder:placeholder,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
