import 'package:bongobondhu_app/core/utils/asset_path.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommonImageWidget extends StatelessWidget {
  const CommonImageWidget({
    super.key,
    required this.imageUrl,
    this.height = 163,
    this.width = 290,
    this.fit = BoxFit.fill,
  });

  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    //log('image -> $imageUrl');
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => Image.asset(
        imagePlaceholderPath,
        height: height,
        width: width,
        fit: fit,
      ),
      errorWidget: (context, url, error) => Image.asset(
        imagePlaceholderPath,
        height: height,
        width: width,
        fit: fit,
      ),
    );
  }
}
