import 'package:aceeby_gala_2022/core/app_colors.dart';
import 'package:aceeby_gala_2022/core/app_font_size.dart';
import 'package:aceeby_gala_2022/core/decoration.dart';
import 'package:aceeby_gala_2022/models/table_model.dart';
import 'package:aceeby_gala_2022/view_models/table_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class TableDropdownInputField extends StatefulWidget {
  const TableDropdownInputField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.initialFormValue = '',
    required this.onSaved,
    required this.onChanged,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final String initialFormValue;
  final FormFieldSetter<String> onSaved;
  final Function(String?) onChanged;
  final AutovalidateMode autovalidateMode;

  @override
  State<TableDropdownInputField> createState() =>
      _TableDropdownInputFieldState();
}

class _TableDropdownInputFieldState extends State<TableDropdownInputField>
{
  var seen = Set<TableModel>();

  @override
  Widget build(BuildContext context) {
    var tableVM = context.read<TableVM>();
    return FutureBuilder<List<TableModel>>(
      future: tableVM.getTables(),
      builder:
          (BuildContext buildContext, AsyncSnapshot<List<TableModel>> tables) {
        if (tables.hasData) {
          return FormBuilderDropdown(
            name: 'guest_table',
            //initialValue: widget.initialFormValue,
            decoration: AppDecoration.inputDecoartion(
                widget.labelText, widget.hintText),
            allowClear: true,
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            items: tables.data!
                .where((element) => seen.add(element))
                .map(
                  (table) => DropdownMenuItem(
                    value: table,
                    child: Text(
                      table.tableName,
                      style: TextStyle(
                        color: HexColor(AppColors.gray),
                        fontSize: AppFontSize.h7,
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
