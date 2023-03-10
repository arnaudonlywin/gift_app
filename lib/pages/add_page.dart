import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gift_app/helpers/alert_dialog.dart';
import 'package:gift_app/helpers/color_helper.dart';
import 'package:gift_app/models/exchange_item.dart';
import 'package:gift_app/services/exchange_service.dart';
import 'package:gift_app/widgets/app_bar.dart';
import 'package:gift_app/widgets/image_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  File? _fileImage;
  final _contrepartieController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: getAppBar("Ajout"),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Merci de saisir un titre';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Titre *',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  minLines: 1,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _subtitleController,
                  decoration: const InputDecoration(
                    labelText: 'Sous-titre',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  minLines: 1,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 20),
                ImageWidget(
                  backgroundColor: Colors.purple,
                  text: "Photo",
                  onSetFile: (file) {
                    _fileImage = file;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _contrepartieController,
                  decoration: const InputDecoration(
                    labelText: 'Contreparties',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  minLines: 1,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: getBottomSheet(),
    );
  }

  ///Pr??sente un container avec un bouton en bas pour valider le formulaire
  Widget getBottomSheet() {
    return Container(
      height: 80,
      color: myGrey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: ElevatedButton(
            onPressed: _onAskConfirmation,
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(myPurple),
            ),
            child: const Text(
              "Ajouter !",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///Demande confirmation avant l'ajout
  void _onAskConfirmation() {
    MyAlertDialog(
      context: context,
      titleText: "??tes-vous s??r de vouloir ajouter cet article ?",
      choiceOneText: "Annuler",
      choiceTwoText: "Confirmer",
      choiceTwoCallback: _onConfirm,
    ).show();
  }

  ///Ajoute l'article
  void _onConfirm() {
    if (_formKey.currentState!.validate()) {
      final item = ExchangeItem(
        title: _titleController.text,
        subtitle: _subtitleController.text,
        fileImage: _fileImage,
        contreparties: _contrepartieController.text,
      );
      ExchangeService.add(item).then(
        (newItemId) {
          if (context.mounted) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message: "Objet bien ajout??",
              ),
            );
            Navigator.pop(context);
          }
        },
      ).catchError((error) {
        if (context.mounted) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: error.toString(),
            ),
          );
        }
      });
    }
  }
}
