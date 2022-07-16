import 'package:aceeby_gala_2022/core/app_colors.dart';
import 'package:aceeby_gala_2022/core/app_font_size.dart';
import 'package:aceeby_gala_2022/models/guest_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GuestCard extends StatelessWidget
{
  final GuestModel user;
  final VoidCallback onTap;

  const GuestCard({Key? key, required this.user, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                user.fullName,
                style: TextStyle(
                  fontSize: AppFontSize.h6,
                  color: HexColor(AppColors.primary),
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 5),
              AutoSizeText(
                'Billet ${user.invitationCardType}',
                style: TextStyle(
                  fontSize: AppFontSize.h6,
                  fontWeight: FontWeight.normal,
                  color: HexColor(AppColors.gray),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 5),
              AutoSizeText(
                'Table ${user.table?.tableName} (${user.table?.tableNumber})',
                style: TextStyle(
                  fontSize: AppFontSize.h6,
                  color: HexColor(AppColors.gray),
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
