import 'package:aceeby_gala_2022/models/guest_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GuestService
{
  final CollectionReference collection = FirebaseFirestore.instance.collection('guests');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addGuest(GuestModel guest) {
    return collection.add(guest.toJson());
  }

  void updateGuest(GuestModel guest) async {
    await collection.doc(guest.referenceId).update(guest.toJson());
  }

  void deleteGuest(GuestModel guest) async {
    await collection.doc(guest.referenceId).delete();
  }
}