
import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../widgets/app_header.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_picker/image_picker.dart';

const kBackgroundGradient = RadialGradient(
  colors: [
    Color(0xFF163A4D),
    Color(0xFF0B1F2B),
  ],
  radius: 1.2,
  center: Alignment(0, -0.3),
);

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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: kBackgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(title: "Add Asset", showBackButton: true),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: Responsive.wp(context, 90),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.all(Responsive.wp(context, 3)),
                          padding: EdgeInsets.all(Responsive.wp(context, 4)),
                          decoration: BoxDecoration(
                            color: const Color(0xFF132F40).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 15, offset: Offset(0, 5))
                            ],
                          ),
                          child: Column(
                            children: [
                              // TextFormField(
                              //   controller: qrIdController,
                              //   style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 14)),
                              //   decoration: InputDecoration(
                              //     labelText: 'QR ID *',
                              //     labelStyle: TextStyle(color: const Color(0xFF5ED6E5), fontSize: Responsive.sp(context, 14)),
                              //     prefixIcon: const Icon(Icons.qr_code, color: Color(0xFF5ED6E5)),
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
                              // ),
                              // SizedBox(height: Responsive.hp(context, 1.5)),
                              // SizedBox(
                              //   width: double.infinity,
                              //   child: ElevatedButton.icon(
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor: const Color(0xFF5ED6E5),
                              //       padding: EdgeInsets.symmetric(vertical: Responsive.hp(context, 1.8)),
                              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              //       elevation: 5,
                              //     ),
                              //     onPressed: () {
                              //       if (qrIdController.text.isNotEmpty) {
                              //         setState(() => showQR = true);
                              //       }
                              //     },
                              //     icon: const Icon(Icons.qr_code_2, color: Colors.white),
                              //     label: Text('Generate QR Code', style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 14), fontWeight: FontWeight.w600)),
                              //   ),
                              // ),
                              // if (showQR && qrIdController.text.isNotEmpty)
                              //   SizedBox(height: Responsive.hp(context, 1.5)),
                              // if (showQR && qrIdController.text.isNotEmpty)
                              //   Container(
                              //     padding: EdgeInsets.all(Responsive.wp(context, 4)),
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(12),
                              //       boxShadow: const [
                              //         BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 3))
                              //       ],
                              //     ),
                              //     child: QrImageView(
                              //       data: qrIdController.text,
                              //       version: QrVersions.auto,
                              //       size: Responsive.wp(context, 40),
                              //     ),
                              //   ),
                              // SizedBox(height: Responsive.hp(context, 1.5)),
                              TextFormField(
                                controller: assetNameController,
                                onChanged: (value) {
                                  if (_formKey.currentState != null) {
                                    _formKey.currentState!.validate();
                                  }
                                },
                                style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 14)),
                                decoration: InputDecoration(
                                  labelText: 'Asset Name *',
                                  labelStyle: TextStyle(color: const Color(0xFF5ED6E5), fontSize: Responsive.sp(context, 14)),
                                  prefixIcon: const Icon(Icons.label, color: Color(0xFF5ED6E5)),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.08),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.white24),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Color(0xFF5ED6E5), width: 2),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.red),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.red, width: 2),
                                  ),
                                ),
                                validator: (value) => null,
                              ),
                              SizedBox(height: Responsive.hp(context, 1.5)),
                              GestureDetector(
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                  if (image != null) {
                                    setState(() {
                                      selectedImagePath = image.path;
                                      selectedImageName = image.name;
                                      imageValidationError = false;
                                    });
                                  }
                                },
                                child: Container(
                                  height: Responsive.hp(context, 15),
                                  padding: EdgeInsets.all(Responsive.wp(context, 3)),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: imageValidationError ? Colors.red : const Color(0xFF5ED6E5).withOpacity(0.3),
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add_photo_alternate, color: const Color(0xFF5ED6E5), size: Responsive.wp(context, 10)),
                                        SizedBox(height: Responsive.hp(context, 0.5)),
                                        Text(
                                          selectedImageName ?? 'Add Image *',
                                          style: TextStyle(
                                            color: const Color(0xFF5ED6E5),
                                            fontSize: Responsive.sp(context, 13),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: Responsive.hp(context, 1.5)),
                              DropdownButtonFormField<String>(
                                value: selectedCategory,
                                dropdownColor: const Color(0xFF0B1F2B),
                                style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 14)),
                                decoration: InputDecoration(
                                  labelText: 'Category *',
                                  labelStyle: TextStyle(color: const Color(0xFF5ED6E5), fontSize: Responsive.sp(context, 14)),
                                  prefixIcon: const Icon(Icons.category, color: Color(0xFF5ED6E5)),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.08),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.white24),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Color(0xFF5ED6E5), width: 2),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.red),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.red, width: 2),
                                  ),
                                ),
                                items: categories.map((cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat),
                                )).toList(),
                                onChanged: (val) {
                                  setState(() => selectedCategory = val);
                                  if (_formKey.currentState != null) {
                                    _formKey.currentState!.validate();
                                  }
                                },
                                validator: (value) => null,
                              ),
                              SizedBox(height: Responsive.hp(context, 1.5)),
                              TextField(
                                controller: summaryController,
                                maxLines: 4,
                                style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 14)),
                                decoration: InputDecoration(
                                  labelText: 'Summary',
                                  labelStyle: TextStyle(color: const Color(0xFF5ED6E5), fontSize: Responsive.sp(context, 14)),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(bottom: 60),
                                    child: Icon(Icons.description, color: Color(0xFF5ED6E5)),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.08),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.white24),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Color(0xFF5ED6E5), width: 2),
                                  ),
                                ),
                              ),
                              SizedBox(height: Responsive.hp(context, 2.5)),
                              SizedBox(
                                width: double.infinity,
                                height: Responsive.hp(context, 6.5),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF5ED6E5),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                    elevation: 8,
                                  ),
                                  onPressed: () {
                                    if (selectedImagePath != null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: const Color(0xFF132F40),
                                          title: const Text('Success', style: TextStyle(color: Colors.white)),
                                          content: const Text('Asset added successfully!', style: TextStyle(color: Colors.white)),
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
                                                  assetNameController.clear();
                                                  summaryController.clear();
                                                });
                                              },
                                              child: const Text('OK', style: TextStyle(color: Color(0xFF5ED6E5))),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (selectedImagePath == null) {
                                      setState(() => imageValidationError = true);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Please select an image')),
                                      );
                                    }
                                  },
                                  child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 16), fontWeight: FontWeight.w600)),
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
