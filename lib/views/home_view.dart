import 'package:aceeby_gala_2022/core/app_colors.dart';
import 'package:aceeby_gala_2022/models/guest_model.dart';
import 'package:aceeby_gala_2022/services/guest_service.dart';
import 'package:aceeby_gala_2022/shared/widgets/cards/guest_card.dart';
import 'package:aceeby_gala_2022/view_models/base_view_model.dart';
import 'package:aceeby_gala_2022/view_models/guest_view_model.dart';
import 'package:aceeby_gala_2022/views/add_guest_view.dart';
import 'package:aceeby_gala_2022/views/table_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GuestService guestService = GuestService();

  @override
  Widget build(BuildContext context) {
    var guestVM = context.watch<GuestVM>();
    var baseVM = context.watch<BaseVM>();

    return Scaffold(
      backgroundColor: HexColor(AppColors.white),
      floatingActionButton: FabCircularMenu(
        fabColor: HexColor(AppColors.primary),
        fabOpenColor: HexColor(AppColors.secondary),
        ringColor: HexColor(AppColors.secondary).withOpacity(0.75),
        fabCloseColor: HexColor(AppColors.secondary),
        ringDiameter: MediaQuery.of(context).size.width,
        fabOpenIcon: Icon(
          Icons.menu,
          color: HexColor(AppColors.white),
        ),
        fabCloseIcon: Icon(
          Icons.close,
          color: HexColor(AppColors.white),
        ),
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: HexColor(AppColors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddGuestView(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: HexColor(AppColors.white),
            ),
            onPressed: () {
              if (kDebugMode) {
                print('Search Guess');
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.table_bar,
              color: HexColor(AppColors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TableView(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 15),
        child: StreamBuilder<QuerySnapshot>
        (
          stream: guestVM.guestService.getStream(),
          builder: (context, snapshot)
          {
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
    final guest = GuestModel.fromSnapshot(snapshot);
    return GuestCard(
      user: guest,
      onTap: () {
        _showGuestDetailDialog(context, guest);
      },
    );
  }

  _showGuestDetailDialog(BuildContext context, GuestModel guest) {
    showMaterialModalBottomSheet(
      context: context,
      elevation: 10,
      expand: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: HexColor(AppColors.white),
        ),
        child: Container(),
      ),
    );
  }
}
