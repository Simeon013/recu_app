import 'package:flutter/material.dart';
import 'package:recu_app/db/db_functions.dart';
import 'package:recu_app/db/tables/appartement.dart';
import 'package:recu_app/screens/add_apartment.dart';

class ApartmentListPage extends StatefulWidget {
  @override
  _ApartmentListPageState createState() => _ApartmentListPageState();
}

class _ApartmentListPageState extends State<ApartmentListPage> {
  List<AppartementTable> _appartements = [];

  @override
  void initState() {
    super.initState();
    _loadAppartements();
  }

  Future<void> _loadAppartements() async {
    List<AppartementTable> appartements = await DBFunctions.readAllAppartements();
    setState(() {
      _appartements = appartements;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des appartements'),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddApartmentPage()),
          ).then((value) {
            _loadAppartements();
          });
        },
      ),
    );
  }

  Widget _buildList() {
    if (_appartements.isEmpty) {
      return Center(
        child: Text('Aucun appartement trouvé.'),
      );
    }

    return ListView.builder(
      itemCount: _appartements.length,
      itemBuilder: (context, index) {
        final appartement = _appartements[index];
        return ListTile(
          title: Text('${appartement.name}'),
          subtitle: Text('${appartement.nbChambres} chambres - ${appartement.prix} €'),
          trailing: Checkbox(
            value: appartement.status,
            onChanged: (value) async {
              setState(() {
                appartement.status = value!;
              });
              await DBFunctions.updateAppartement(appartement);
            },
          ),
        );
      },
    );
  }
}
