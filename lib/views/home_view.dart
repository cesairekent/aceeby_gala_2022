import 'package:aceeby_gala_2022/core/app_colors.dart';
import 'package:aceeby_gala_2022/core/app_font_size.dart';
import 'package:aceeby_gala_2022/models/guest_model.dart';
import 'package:aceeby_gala_2022/shared/widgets/cards/guest_card.dart';
import 'package:aceeby_gala_2022/view_models/base_view_model.dart';
import 'package:aceeby_gala_2022/view_models/guest_view_model.dart';
import 'package:aceeby_gala_2022/views/add_guest_view.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length + 1).toString());
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

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
              print('Add Guess');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: HexColor(AppColors.white),
            ),
            onPressed: () {
              print('Search Guess');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.table_bar,
              color: HexColor(AppColors.white),
            ),
            onPressed: () {
              print('Table List');
            },
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 15),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(),
          footer: CustomFooter(
            builder: (context, mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = const Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = const CircularProgressIndicator.adaptive();
              } else if (mode == LoadStatus.failed) {
                body = const Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = const Text("release to load more");
              } else {
                body = const Text("No more Data");
              }
              return SizedBox(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: guestVM.guestList.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (c, i) => GuestCard(
                    user: guestVM.guestList[i],
                    onTap: () {
                      print('Tapped');
                      _showGuestDetailDialog(context, guestVM.guestList[i]);
                    },
                  ),
                  itemExtent: 100.0,
                  itemCount: guestVM.guestList.length,
                )
              : Center(
                  child: Text(
                    'Aucun Invité',
                    style: TextStyle(
                      fontSize: AppFontSize.h4,
                      fontWeight: FontWeight.w600,
                      color: HexColor(
                        AppColors.primary,
                      ),
                    ),
                  ),
                ),
        ),
      ),
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
