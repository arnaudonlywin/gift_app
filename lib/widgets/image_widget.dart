import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gift_app/helpers/adaptive_action_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ImageWidget extends StatefulWidget {
  final Color backgroundColor;
  final String text;
  final void Function(File?)? onSetFile;

  const ImageWidget({
    Key? key,
    required this.backgroundColor,
    required this.text,
    this.onSetFile,
  }) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  final int _imageQuality = 50;
  File? file;

  final actionSheetChoices = const TextStyle(
    color: Colors.blue,
    fontFamily: 'Arial',
    fontSize: 17,
  );
  final actionSheetCancel = const TextStyle(
    color: Colors.blue,
    fontFamily: 'Arial',
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );
  final actionSheetChoicesRed = const TextStyle(
    color: Colors.red,
    fontFamily: 'Arial',
    fontSize: 17,
  );

  Future _getImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: _imageQuality,
      );
      if (image == null) return;
      /* //Enregistre la photo dans la galerie du téléphone
      ImageGallerySaver.saveFile(image.path); */
      setState(() {
        file = File(image.path);
        if (widget.onSetFile != null) {
          widget.onSetFile!(file);
        }
      });
    } on PlatformException catch (e) {
      String errorText;
      switch (e.code) {
        case 'photo_access_denied':
          errorText =
              "Veuillez autoriser l'application à accéder à votre appareil photo";
          break;
        default:
          errorText = "Impossible d'accéder à votre appareil photo";
      }
      showTopSnackBar(
        OverlayState(),
        CustomSnackBar.error(
          message: errorText,
        ),
      );
    }
  }

  Future _getImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: _imageQuality,
      );
      if (image == null) return;
      setState(() {
        file = File(image.path);
        if (widget.onSetFile != null) {
          widget.onSetFile!(file);
        }
      });
    } on PlatformException catch (e) {
      String errorText;
      switch (e.code) {
        case 'photo_access_denied':
          errorText = "Veuillez autoriser l'application à accéder à vos photos";
          break;
        default:
          errorText = "Impossible d'accéder à vos photos";
      }
      showTopSnackBar(
        OverlayState(),
        CustomSnackBar.error(
          message: errorText,
        ),
      );
    }
  }

  Widget _withoutImage() {
    return GestureDetector(
      onTap: _onTapWidget,
      child: SizedBox(
        height: 300,
        width: 300,
        child: Card(
          color: widget.backgroundColor,
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  widget.text,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapWidget() {
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text(
            'À partir de la bibliothèque',
            style: actionSheetChoices,
          ),
          onPressed: _getImageFromGallery,
        ),
        BottomSheetAction(
          title: Text(
            'Prendre une photo',
            style: actionSheetChoices,
          ),
          onPressed: _getImageFromCamera,
        ),
      ],
      cancelAction: CancelAction(
        title: Text(
          'Annuler',
          style: actionSheetCancel,
        ),
      ),
    );
  }

  Widget _withImage() {
    if (file != null) {
      return SizedBox(
        height: 300,
        width: 300,
        child: Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: Image.file(file!).image,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: ClipOval(
                    child: Material(
                      color: widget.backgroundColor,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: _onTapTrash,
                        child: const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    throw Exception("Impossible d'appeller la fonction _withImage sans photo");
  }

  _onTapTrash() {
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text(
            'Supprimer la photo',
            style: actionSheetChoicesRed,
          ),
          onPressed: _deleteImage,
        ),
      ],
      cancelAction: CancelAction(
        title: Text(
          'Annuler',
          style: actionSheetCancel,
        ),
      ),
    );
  }

  _deleteImage() {
    setState(() {
      file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: (file == null) ? _withoutImage() : _withImage(),
    );
  }
}
