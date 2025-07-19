import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/images.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final bool removeDomainFromUrl;
  final BoxFit? fit;
  final Widget Function(BuildContext, String)? placeholderFunction;
  final Widget Function(BuildContext, String, dynamic)? whenError;
  final ImageWidgetBuilder? imageBuilder;

  /// نسبة الارتفاع من الشاشة (إذا لم يتم تحديد memCacheHeight يدويًا)
  final double? heightRatio;

  /// نسبة العرض من الشاشة (إذا لم يتم تحديد memCacheWidth يدويًا)
  final double? widthRatio;

  /// إذا تم التحديد، يتم استخدام هذا مباشرة
  final int? memCacheHeight;
  final int? memCacheWidth;

  final double loaderStrokeWidth;

  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.removeDomainFromUrl = false,
    this.fit,
    this.placeholderFunction,
    this.whenError,
    this.imageBuilder,
    this.memCacheHeight,
    this.memCacheWidth,
    this.heightRatio = 0.15,
    this.widthRatio = 0.35,
    this.loaderStrokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    final url = removeDomainFromUrl ? _stripDomain(imageUrl) : imageUrl;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final resolvedHeight =
        memCacheHeight ?? (screenHeight * (heightRatio ?? 0.15)).toInt();
    final resolvedWidth =
        memCacheWidth ?? (screenWidth * (widthRatio ?? 0.35)).toInt();

    // ✅ صورة محلية إن كان الرابط غير صالح
    if (url.isEmpty || !(url.startsWith('http') || url.startsWith('https'))) {
      return Image.asset(
        width: widthRatio,
        height: heightRatio,
        AppImages.kerrorImage,
        fit: fit ?? BoxFit.cover,
      );
    }

    return CachedNetworkImage(
        imageUrl: url,
        fit: fit ?? BoxFit.cover,
        memCacheHeight: resolvedHeight,
        memCacheWidth: resolvedWidth,
        imageBuilder: imageBuilder,
        placeholder: placeholderFunction ??
            (context, url) => Center(
                  child: Image.asset('assets/images/loading.gif'),
                ),
        errorWidget: whenError ??
            (context, url, error) => Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 200,
                ));
  }

  String _stripDomain(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.path;
    } catch (_) {
      return url;
    }
  }
}
