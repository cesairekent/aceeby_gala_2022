import 'package:aceeby_gala_2022/core/app_colors.dart';
import 'package:aceeby_gala_2022/core/app_font_size.dart';
import 'package:aceeby_gala_2022/models/table_model.dart';
import 'package:aceeby_gala_2022/shared/widgets/buttons/basic_btn.dart';
import 'package:aceeby_gala_2022/shared/widgets/buttons/loading_btn.dart';
import 'package:aceeby_gala_2022/shared/widgets/forms/text_input_field.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../view_models/base_view_model.dart';
import '../view_models/table_view_model.dart';

class AddOrEditTableView extends StatefulWidget {
  final TableModel? table;
  const AddOrEditTableView({Key? key, required this.table}) : super(key: key);

  @override
  State<AddOrEditTableView> createState() => _AddOrEditTableViewState();
}

class _AddOrEditTableViewState extends State<AddOrEditTableView> {
  final GlobalKey<FormBuilderState> _addOrEditTableFormKey =
      GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    var tableVM = context.watch<TableVM>();
    var baseVM = context.watch<BaseVM>();
    return Column(
      children: [
        SizedBox(
          height: 75,
          child: Center(
            child: AutoSizeText(
              "Ajouter une table",
              style: TextStyle(
                fontSize: AppFontSize.h4,
                fontWeight: FontWeight.bold,
                color: HexColor(AppColors.primary),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: HexColor(AppColors.white),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Column(
                  children: <Widget>[
                    FormBuilder(
                      key: _addOrEditTableFormKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 30,
                          ),
                          TextInputField(
                            name: 'name',
                            hintText: 'Entre le nom de la table',
                            labelText: 'Nom complet',
                            onSaved: (value) {},
                            onChanged: (value) {},
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            initialFormValue: widget.table != null
                                ? widget.table!.tableName.toString()
                                : '',
                            validators: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                  errorText: 'Ce champ est requis',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextInputField(
                            name: 'number',
                            hintText: 'Entre le numéro de la able',
                            labelText: 'Numéro de la table',
                            onSaved: (value) {},
                            onChanged: (value) {},
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            initialFormValue: widget.table != null
                                ? widget.table!.tableNumber.toString()
                                : '',
                            validators: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                  errorText: 'Ce champ est requis',
                                ),
                                FormBuilderValidators.numeric(
                                    errorText:
                                        'Seuls les chiffres sont autorisés'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextInputField(
                            name: 'capacity',
                            hintText: 'Entre le nombre de place de cette table',
                            labelText: 'Nombre de place',
                            onSaved: (value) {},
                            onChanged: (value) {},
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            initialFormValue: widget.table != null
                                ? widget.table!.tableCapacity.toString()
                                : '',
                            validators: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                  errorText: 'Ce champ est requis',
                                ),
                                FormBuilderValidators.numeric(
                                    errorText:
                                        'Seuls les chiffres sont autorisés'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        LoadingButton(
          elevation: 0,
          backgroundColor: HexColor(AppColors.primary),
          borderColor: HexColor(AppColors.primary),
          textColor: HexColor(AppColors.white),
          btnText: 'Ajouter',
          onPressed: () async {
            baseVM.showLoading();
            if (_addOrEditTableFormKey.currentState!.saveAndValidate()) {
              if (kDebugMode) {
                print(_addOrEditTableFormKey.currentState!.value);
              }
              bool response = false;
              if (widget.table != null) {
                response = await tableVM
                    .updateTable(widget.table!.referenceId! ,_addOrEditTableFormKey.currentState!.value);
              } else {
                response = await tableVM
                    .addTable(_addOrEditTableFormKey.currentState!.value);
              }

              if (response == true) {
                if (!mounted) return;
                Navigator.pop(context);
              }
            }
            baseVM.hideLoading();
          },
        ),
        const SizedBox(height: 20),
        BasicButton(
          elevation: 0,
          backgroundColor: HexColor(AppColors.white),
          borderColor: HexColor(AppColors.primary),
          textColor: HexColor(AppColors.primary),
          btnText: 'Annuler',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
