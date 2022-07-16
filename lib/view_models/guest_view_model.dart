import 'package:aceeby_gala_2022/models/guest_model.dart';
import 'package:aceeby_gala_2022/models/table_model.dart';
import 'package:aceeby_gala_2022/services/guest_service.dart';
import 'package:flutter/foundation.dart';

class GuestVM with ChangeNotifier
{
  GuestVM();

  final GuestService guestService = GuestService();

  final List<GuestModel> _guestList = [];
  List<GuestModel> get guestList => _guestList;

  int _count = 0;
  int get count => _count;

  Future<bool> addGuest(Map<String, dynamic> formValues) async
  {
    bool result = false;

    GuestModel guest = GuestModel(
      fullName: formValues['full_name'],
      invitationCardType: formValues['invitation_card_type'],
      invitationCardNumber: formValues['invitation_number'],
      tableId: formValues['guest_table'].referenceId!,
      table: formValues['guest_table'],
      invitedBy: formValues['invited_by'],
    );

    var response = await guestService.addGuest(guest);

    if(response.id != null)
    {
      result = true;
      //guest.referenceId = response.id;
      //_guestList.add(guest);
      //_count++;
      notifyListeners();
    }
    return result;
  }

  Future getGuests() async
  {
    var response = guestService.getStream();
    if (kDebugMode) {
      print(response);
    }
  }

  updateGuest(int guestId, Map<String, dynamic> formValues) {
    notifyListeners();
  }

  void deleteGuest()
  {
    notifyListeners();
  }
}