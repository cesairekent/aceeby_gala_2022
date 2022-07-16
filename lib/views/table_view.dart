import 'package:aceeby_gala_2022/core/app_colors.dart';
import 'package:aceeby_gala_2022/models/table_model.dart';
import 'package:aceeby_gala_2022/view_models/table_view_model.dart';
import 'package:aceeby_gala_2022/views/add_or_edit_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class TableView extends StatefulWidget {
  TableView({Key? key}) : super(key: key);

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView>
{
  @override
  Widget build(BuildContext context) {
    var tableVM = context.watch<TableVM>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tables'),
        backgroundColor: HexColor(AppColors.primary),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: HexColor(
            AppColors.white,
          ),
        ),
        onPressed: () {
          _addOrEditTableDialog(context, null);
        },
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: tableVM.tableService.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();
            return _buildList(context, snapshot.data?.docs ?? []);
          },
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final table = TableModel.fromSnapshot(snapshot);

    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: NetworkImage(
            'https://picsum.photos/200/300',
          ),
        ),
        title: Text(table.tableName),
        subtitle: Text(
            "Table n° ${table.tableNumber} d'une capacité de ${table.tableCapacity} Places"),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          _addOrEditTableDialog(context, table);
        },
      ),
    );
  }

  _addOrEditTableDialog(BuildContext context, TableModel? table) {
    showMaterialModalBottomSheet(
      context: context,
      elevation: 10,
      expand: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(
              30,
            ),
          ),
          color: HexColor(AppColors.white),
        ),
        child: AddOrEditTableView(
          table: table,
        ),
      ),
    );
  }
}
