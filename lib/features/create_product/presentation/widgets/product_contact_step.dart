import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/constants/dimensions.dart';
import 'package:roasters/core/localization/app_localizations.dart';
import 'package:roasters/core/theme/app_colors.dart';
import 'package:roasters/core/theme/app_text_styles.dart';
import 'package:roasters/core/utils/validators.dart';
import 'package:roasters/features/create_product/domain/entities/contact_entity.dart';
import 'package:roasters/features/create_product/presentation/cubit/cubit.dart';
import 'package:roasters/shared/widgets/inputs/app_text_field.dart';
import 'package:roasters/shared/widgets/toast/toast_widget.dart';

class ProductContactStep extends StatefulWidget {
  const ProductContactStep({super.key});

  @override
  State<ProductContactStep> createState() => _ProductContactStepState();
}

class _ProductContactStepState extends State<ProductContactStep> {
  final size = AppSizes.instance;

  late List<ContactItem> contacts;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final cubit = context.read<CreateProductCubit>();
    final existingContacts = cubit.formState.contacts;

    // إذا كانت هناك بيانات مسبقة نستخدمها، وإلا ننشئ عنصر افتراضي
    contacts = existingContacts.isNotEmpty
        ? existingContacts
        .map((e) => ContactItem(
      controller: TextEditingController(text: e.number),
      type: e.type,
    ))
        .toList()
        : [ContactItem()];
  }
  @override
  void dispose() {
    for (var contact in contacts) {
      contact.controller.dispose();
    }
    super.dispose();
  }
  void addContact() {
    setState(() {
      contacts.add(ContactItem());
    });
    updateCubit();
  }

  void removeContact(int index) {

    if (contacts.length > 1) {
      contacts[index].controller.dispose();
      setState(() {
        contacts.removeAt(index);
      });
      updateCubit();
    }
  }

  void updateCubit() {

    final contactsList = contacts
        .map((e) => ContactEntity(
      type: e.type,
      number: e.controller.text,
    ))
        .toList();

    context.read<CreateProductCubit>().setContacts(contactsList);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.padding.screenHorizontal),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...contacts.asMap().entries.map((entry) {
              int index = entry.key;
              ContactItem item = entry.value;

              return Column(
                children: [
                  AppTextField(
                    controller: item.controller,
                    label: AppLocalizations.of(context).translate("phone_number"),
                    keyboardType: TextInputType.phone,
                    onChanged: (_) => updateCubit(),
                  ),
                  SizedBox(height: size.spacing.small),
                  AppTextField(
                    label: AppLocalizations.of(context).translate("contact_type"),
                    readOnly: true,
                    suffix: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.padding.fieldHorizontal,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          dropdownColor: AppColors.backgroundSearchBox,
                          borderRadius:
                          BorderRadius.circular(size.borderRadius.extraLarge),
                          value: item.type,
                          items: [
                            DropdownMenuItem(
                              value: "call",
                              child: Text(
                                AppLocalizations.of(context).translate("call"),
                                style: AppTextStyles.firaMedium16(
                                    color: AppColors.textPrimaryDark),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "whatsapp",
                              child: Text(
                                AppLocalizations.of(context).translate("whatsapp"),
                                style: AppTextStyles.firaMedium16(
                                    color: AppColors.textPrimaryDark),
                              ),
                            ),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                item.type = val;
                                updateCubit();
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.spacing.small),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (index == contacts.length - 1)
                        IconButton(
                          icon: Icon(Icons.add, color: AppColors.secondary),
                          onPressed: addContact,
                        )
                      else
                        const SizedBox(),
                      if (contacts.length > 1)
                        IconButton(
                          icon: Icon(Icons.delete, color: AppColors.primaryDark),
                          onPressed: () => removeContact(index),
                        )
                      else
                        const SizedBox(),
                    ],
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Contact Item Model
class ContactItem {
  TextEditingController controller;
  String type;

  ContactItem({TextEditingController? controller, this.type = "call"})
      : controller = controller ?? TextEditingController();
}