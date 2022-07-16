import 'package:aceeby_gala_2022/models/table_model.dart';
import 'package:aceeby_gala_2022/services/table_service.dart';
import 'package:flutter/foundation.dart';

class TableVM with ChangeNotifier {
  TableVM();

  final TableService tableService = TableService();

  final List<TableModel> _tableList = [];
  List<TableModel> get tableList => _tableList;

  int _count = 0;
  int get count => _count;

  Future<bool> addTable(Map<String, dynamic> formValues) async {
    bool result = false;

    TableModel table = TableModel(
      tableName: formValues['name'],
      tableNumber: int.parse(formValues['number']),
      tableCapacity: int.parse(formValues['capacity']),
    );

    var response = await tableService.addTable(table);

    if (response.id != null) {
      result = true;
    }
    return result;
  }

  updateTable(String tableId, Map<String, dynamic> formValues) async
  {
    TableModel table = TableModel(
      tableName: formValues['name'],
      tableNumber: int.parse(formValues['number']),
      tableCapacity: int.parse(formValues['capacity']),
      referenceId: tableId,
    );
    tableService.updateTable(table);
    return true;
  }

  void deleteTable() {
    notifyListeners();
  }

  Future<List<TableModel>>? getTables() async {
    var response = await tableService.getTables();
    if (kDebugMode) {
      print(response);
    }
    _tableList.clear();
    _count = 0;
    for (var doc in response.docs)
    {
      var data = doc.data() as Map<String, dynamic>;
      TableModel table = TableModel.fromMap(data);
      table.referenceId = doc.id;
      _tableList.add(table);
      _count++;
    }
    return _tableList;
  }
}
