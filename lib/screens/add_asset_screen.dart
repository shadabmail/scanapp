import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../config/app_config.dart';
import '../config/app_strings.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';
import '../utils/button_styles.dart';
import '../utils/container_decoration.dart';
import '../widgets/app_header.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_image_picker.dart';
import '../widgets/app_radio_group.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../database/database_helper.dart';
import '../models/asset_model.dart';
 
class AddAssetScreen extends StatefulWidget {
  const AddAssetScreen({super.key});

  @override
  State<AddAssetScreen> createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends State<AddAssetScreen> {
  String? selectedCategory;
  final categories = ['Furniture', 'Electronics', 'Equipment', 'Vehicle', 'Other'];
  final qrIdController = TextEditingController();
  final assetNameController = TextEditingController();
  final summaryController = TextEditingController();
  bool showQR = false;
  String? selectedImagePath;
  String? selectedImageName;
  bool imageValidationError = false;
  String assetType = AppStrings.direct;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.background),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(title: AppStrings.addAsset, showBackButton: true),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: Responsive.wp(context, 90),
                      ),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: _autovalidateMode,
                        child: Container(
                          margin: EdgeInsets.all(Responsive.wp(context, 3)),
                          padding: EdgeInsets.all(Responsive.wp(context, 4)),
                          decoration: AppContainerDecoration.card(),
                          child: Column(
                            children: [
                              AppRadioGroup(
                                label: AppStrings.assetType,
                                value: assetType,
                                options: const [AppStrings.direct, AppStrings.indirect],
                                onChanged: (val) => setState(() => assetType = val),
                              ),
                              SizedBox(height: Responsive.hp(context, 1.5)),
                              AppTextField(
                                controller: qrIdController,
                                label: AppStrings.qrId,
                                icon: Icons.qr_code,
                                isRequired: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppStrings.qrIdRequired;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: Responsive.hp(context, 1.5)),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  style: AppButtonStyles.primary(borderRadius: 12).copyWith(
                                    padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: Responsive.hp(context, 1.8)),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (qrIdController.text.isNotEmpty) {
                                      setState(() => showQR = true);
                                    }
                                  },
                                  icon: const Icon(Icons.qr_code_2, color: Colors.white),
                                  label: Text(AppStrings.generateQR, style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 14), fontWeight: FontWeight.w600)),
                                ),
                              ),
                              if (showQR && qrIdController.text.isNotEmpty)
                                SizedBox(height: Responsive.hp(context, 1.5)),
                              if (showQR && qrIdController.text.isNotEmpty)
                                Container(
                                  padding: EdgeInsets.all(Responsive.wp(context, 4)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                                    boxShadow: const [
                                      BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 3))
                                    ],
                                  ),
                                  child: QrImageView(
                                    data: qrIdController.text,
                                    version: QrVersions.auto,
                                    size: Responsive.wp(context, 40),
                                  ),
                                ),
                              SizedBox(height: Responsive.hp(context, 1.5)),
                              AppTextField(
                                controller: assetNameController,
                                label: AppStrings.assetName,
                                icon: Icons.label,
                                isRequired: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppStrings.assetNameRequired;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: Responsive.hp(context, 1.5)),
                              AppImagePicker(
                                selectedImageName: selectedImageName,
                                hasError: imageValidationError,
                                onImageSelected: (path, name) {
                                  setState(() {
                                    selectedImagePath = path;
                                    selectedImageName = name;
                                    imageValidationError = false;
                                  });
                                },
                              ),
                              // SizedBox(height: Responsive.hp(context, 1.5)),
                              // DropdownButtonFormField<String>(
                              //   value: selectedCategory,
                              //   dropdownColor: const Color(0xFF0B1F2B),
                              //   style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 14)),
                              //   decoration: InputDecoration(
                              //     labelText: 'Category *',
                              //     labelStyle: TextStyle(color: const Color(0xFF5ED6E5), fontSize: Responsive.sp(context, 14)),
                              //     prefixIcon: const Icon(Icons.category, color: Color(0xFF5ED6E5)),
                              //     filled: true,
                              //     fillColor: Colors.white.withOpacity(0.08),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(12),
                              //       borderSide: const BorderSide(color: Colors.white24),
                              //     ),
                              //     focusedBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(12),
                              //       borderSide: const BorderSide(color: Color(0xFF5ED6E5), width: 2),
                              //     ),
                              //   ),
                              //   items: categories.map((cat) => DropdownMenuItem(
                              //     value: cat,
                              //     child: Text(cat),
                              //   )).toList(),
                              //   onChanged: (val) => setState(() => selectedCategory = val),
                              // ),
                              SizedBox(height: Responsive.hp(context, 1.5)),
                              AppTextField(
                                controller: summaryController,
                                label: AppStrings.summary,
                                icon: Icons.description,
                                maxLines: 4,
                              ),
                              SizedBox(height: Responsive.hp(context, 2.5)),
                              SizedBox(
                                width: double.infinity,
                                height: Responsive.hp(context, 6.5),
                                child: ElevatedButton(
                                  style: AppButtonStyles.primary(),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate() && selectedImagePath != null) {
                                      try {
                                        final appDir = await getApplicationDocumentsDirectory();
                                        final fileName = '${DateTime.now().millisecondsSinceEpoch}${path.extension(selectedImagePath!)}';
                                        final savedImage = File('${appDir.path}/$fileName');
                                        await File(selectedImagePath!).copy(savedImage.path);

                                        final asset = Asset(
                                          qrId: qrIdController.text,
                                          name: assetNameController.text,
                                          type: assetType,
                                          summary: summaryController.text.isEmpty ? null : summaryController.text,
                                          imagePath: savedImage.path,
                                        );

                                        await DatabaseHelper.instance.insertAsset(asset);

                                        if (context.mounted) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor: AppColors.darkBackground2,
                                              title: const Text(AppStrings.success, style: TextStyle(color: Colors.white)),
                                              content: const Text(AppStrings.assetAddedSuccess, style: TextStyle(color: Colors.white)),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    _formKey.currentState!.reset();
                                                    setState(() {
                                                      selectedImagePath = null;
                                                      selectedImageName = null;
                                                      selectedCategory = null;
                                                      showQR = false;
                                                      imageValidationError = false;
                                                      assetType = AppStrings.direct;
                                                      qrIdController.clear();
                                                      assetNameController.clear();
                                                      summaryController.clear();
                                                    });
                                                  },
                                                  child: Text('OK', style: TextStyle(color: AppColors.primaryAccent)),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Error saving asset: $e')),
                                          );
                                        }
                                      }
                                    } else {
                                      setState(() {
                                        _autovalidateMode = AutovalidateMode.onUserInteraction;
                                        if (selectedImagePath == null) imageValidationError = true;
                                      });
                                      if (selectedImagePath == null) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text(AppStrings.selectImage)),
                                        );
                                      }
                                    }
                                  },
                                  child: Text(AppStrings.submitButton, style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 16), fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
