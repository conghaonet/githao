import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePreviewPage extends StatelessWidget {
  static const ROUTE_NAME = '/image_preview';
  final String imageUrl;
  ImagePreviewPage(this.imageUrl, {Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    var _title = imageUrl.substring(imageUrl.lastIndexOf('/')+1, imageUrl.length);

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        ),
      ),
    );
  }

}