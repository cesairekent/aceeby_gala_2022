import 'package:aceeby_gala_2022/models/table_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableService
{
  final CollectionReference collection = FirebaseFirestore.instance.collection('tables');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addTable(TableModel table) {
    return collection.add(table.toJson());
  }

  void updateTable(TableModel table) async {
    await collection.doc(table.referenceId).update(table.toJson());
  }

  void deleteTable(TableModel table) async {
    await collection.doc(table.referenceId).delete();
  }

  Future<QuerySnapshot<Object?>> getTables() async {
    return await collection.get();
  }
}