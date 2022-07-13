import 'package:aceeby_gala_2022/core/app_colors.dart';
import 'package:aceeby_gala_2022/core/app_font_size.dart';
import 'package:aceeby_gala_2022/shared/widgets/buttons/basic_btn.dart';
import 'package:aceeby_gala_2022/shared/widgets/buttons/loading_btn.dart';
import 'package:aceeby_gala_2022/shared/widgets/forms/dropdown_input_field.dart';
import 'package:aceeby_gala_2022/shared/widgets/forms/text_input_field.dart';
import 'package:aceeby_gala_2022/view_models/base_view_model.dart';
import 'package:aceeby_gala_2022/view_models/guest_view_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class AddGuestView extends StatefulWidget
{
  const AddGuestView({Key? key}) : super(key: key);

  @override
  State<AddGuestView> createState() => _AddGuestViewState();
}

class _AddGuestViewState extends State<AddGuestView>
{
  final items =
  [
    "COUPLE",
    "SIMPLE",
  ];
  final GlobalKey<FormBuilderState> _addGuestFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context)
  {
    var guestVM = context.watch<GuestVM>();
    var baseVM = context.watch<BaseVM>();

    return Scaffold(
      backgroundColor: HexColor(AppColors.white),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Center(
                child: AutoSizeText(
                  "Ajouter un invité",
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
                          key: _addGuestFormKey,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 30,
                              ),
                              TextInputField(
                                name: 'full_name',
                                hintText: 'Entre le nom complet',
                                labelText: 'Nom complet',
                                onSaved: (value) {},
                                onChanged: (value) {},
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                              DropdownInputField(
                                name: 'invitation_card_type',
                                labelText: 'Type de billet',
                                hintText: 'Choisissez le type de billet',
                                onSaved: (value) {},
                                onChanged: (value) {},
                                items: items,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextInputField(
                                name: 'invitation_number',
                                hintText: 'Entre le numéro du billet',
                                labelText: 'Numéro du billet',
                                onSaved: (value) {},
                                onChanged: (value) {},
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                validators: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(
                                      errorText: 'Ce champ est requis',
                                    ),
                                    FormBuilderValidators.numeric(
                                      errorText: 'Seuls les chiffres sont autorisés'
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DropdownInputField(
                                name: 'guest_table',
                                labelText: 'Table',
                                hintText: 'Choisissez la table',
                                onSaved: (value) {},
                                onChanged: (value) {},
                                items: items,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextInputField(
                                name: 'invited_by',
                                hintText: 'Entre le nom de qui vous a invité',
                                labelText: 'Nom de qui vous a invité',
                                onSaved: (value) {},
                                onChanged: (value) {},
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
              onPressed: () async
              {
                baseVM.showLoading();
                if (_addGuestFormKey.currentState!.saveAndValidate())
                {
                  if (kDebugMode) {
                    print(_addGuestFormKey.currentState!.value);
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
        ),
      ),
    );
  }
}
