import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '/../components/AppBarComponent.dart';
import '../../screens/PhotoEditScreen.dart';
import '../../utils/Colors.dart';
import 'package:photo_view/photo_view.dart';
// import 'package:share_plus/share_plus.dart';

class PhotoViewerWidget extends StatefulWidget {
  static String tag = '/PhotoViewerWidget';
  final FileSystemEntity fileSystemEntity;

  PhotoViewerWidget(this.fileSystemEntity);

  @override
  _PhotoViewerWidgetState createState() => _PhotoViewerWidgetState();
}

class _PhotoViewerWidgetState extends State<PhotoViewerWidget> {
  ImageProvider? imageProvider;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    imageProvider = Image.file(File(widget.fileSystemEntity.path)).image;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(
        context: context,
        title: '',
        list: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              PhotoEditScreen(file: File(widget.fileSystemEntity.path))
                  .launch(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () async {
              // final result = await Share.shareXFiles(
              //     [widget.fileSystemEntity.path],
              //     text: 'Great picture');

              // if (result.status == ShareResultStatus.success) {
              //   print('Thank you for sharing the picture!');
              // }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              showConfirmDialogCustom(context, onAccept: (v) {
                File(widget.fileSystemEntity.path).deleteSync();

                finish(context);
              },
                  title: 'Do you want to delete this picture?',
                  dialogType: DialogType.CONFIRMATION,
                  primaryColor: colorPrimary);
            },
          ),
        ],
      ),
      body: PhotoView(
        imageProvider: imageProvider,
        minScale: PhotoViewComputedScale.contained,
        maxScale: 1.0,
      ),
    );
  }
}
