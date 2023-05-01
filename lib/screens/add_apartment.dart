import 'package:flutter/material.dart';
import 'package:recu_app/db/tables/appartement.dart';
import 'package:recu_app/db/db_functions.dart';

import 'appartements_page.dart';

class AddApartmentPage extends StatefulWidget {
  @override
  _AddApartmentPageState createState() => _AddApartmentPageState();
}

class _AddApartmentPageState extends State<AddApartmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _appartement = AppartementTable(status: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un appartement'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nom de l\'appartement'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un nom de l\'appartement';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _appartement.name = value!;
                  }
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nombre de chambres'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un nombre de chambres';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _appartement.nbChambres = int.parse(value!);
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Prix'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un prix';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _appartement.prix = double.parse(value!);
                  },
                ),
                SizedBox(height: 16),
                CheckboxListTile(
                  title: Text('Occupé'),
                  value: _appartement.status == true,
                  onChanged: (bool? value) {
                    setState(() {
                      _appartement.status = (value != null && value) ? true : false;
                    });
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Ajouter'),
                  onPressed: () async {
                    await DBFunctions.createAppartement(_appartement);
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      bool success = (await DBFunctions.createAppartement(_appartement)) as bool;
                      if (success) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ApartmentListPage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Une erreur est survenue lors de l\'ajout de l\'appartement'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
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
