import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import 'appartements_page.dart';

class CreateInvoicePage extends StatefulWidget {
  @override
  _CreateInvoicePageState createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data =
    await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un recu'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Nom du locataire'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez entrer un nom du locataire';
                      }
                      return null;
                    },
                    // onSaved: (value) {
                    //   _appartement.name = value!;
                    // }
                ),
                SizedBox(height: 16),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Mois'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez entrer le mois';
                      }
                      return null;
                    },
                    // onSaved: (value) {
                    //   _appartement.name = value!;
                    // }
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Somme'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer la somme';
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   _appartement.nbChambres = int.parse(value!);
                  // },
                ),
                SizedBox(height: 16),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: SfSignaturePad(
                        key: signatureGlobalKey,
                      ),
                    ),
                    ElevatedButton(
                        child: Text("Clear"),
                        onPressed: () async {
                          _handleClearButtonPressed();
                        })
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Ajouter'),
                  onPressed: () async {
                    _handleSaveButtonPressed();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
