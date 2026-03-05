import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../config/app_config.dart';
import '../config/app_strings.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';
import '../utils/button_styles.dart';
import '../utils/container_decoration.dart';
import '../widgets/app_header.dart';
import '../database/database_helper.dart';
import '../models/asset_model.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  String? selectedFileName;
  String? selectedFilePath;
  bool isProcessing = false;

  Future<void> _pickExcelFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );
    if (result != null) {
      setState(() {
        selectedFileName = result.files.single.name;
        selectedFilePath = result.files.single.path;
      });
    }
  }

  Future<void> _processExcel() async {
    if (selectedFilePath == null) return;

    setState(() => isProcessing = true);

    try {
      final bytes = File(selectedFilePath!).readAsBytesSync();
      final excel = Excel.decodeBytes(bytes);
      final sheet = excel.tables[excel.tables.keys.first];

      if (sheet == null) throw Exception('No sheet found');

      final appDir = await getApplicationDocumentsDirectory();
      int inserted = 0;

      for (var i = 1; i < sheet.maxRows; i++) {
        final row = sheet.rows[i];
        if (row.isEmpty || row[0]?.value == null) continue;

        final qrId = row[0]?.value.toString() ?? '';
        final name = row.length > 1 ? row[1]?.value.toString() ?? '' : '';
        final type = row.length > 2 ? row[2]?.value.toString() ?? 'Direct' : 'Direct';
        final summary = row.length > 3 ? row[3]?.value.toString() : null;
        final imagePath = row.length > 4 ? row[4]?.value.toString() : null;

        if (qrId.isEmpty || name.isEmpty) continue;

        String finalImagePath;
        if (imagePath != null && imagePath.isNotEmpty && File(imagePath).existsSync()) {
          final ext = imagePath.split('.').last;
          final copiedImage = File('${appDir.path}/asset_${qrId}_${DateTime.now().millisecondsSinceEpoch}.$ext');
          await File(imagePath).copy(copiedImage.path);
          finalImagePath = copiedImage.path;
        } else {
          final qrFile = File('${appDir.path}/qr_$qrId.png');
          await _generateQRImage(qrId, qrFile.path);
          finalImagePath = qrFile.path;
        }

        final asset = Asset(
          qrId: qrId,
          name: name,
          type: type,
          summary: summary,
          imagePath: finalImagePath,
        );

        await DatabaseHelper.instance.insertAsset(asset);
        inserted++;
      }

      setState(() => isProcessing = false);

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.darkBackground2,
            title: const Text('Success', style: TextStyle(color: Colors.white)),
            content: Text('$inserted assets imported successfully!', style: const TextStyle(color: Colors.white)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    selectedFileName = null;
                    selectedFilePath = null;
                  });
                },
                child: Text('OK', style: TextStyle(color: AppColors.primaryAccent)),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      setState(() => isProcessing = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _generateQRImage(String data, String path) async {
    final qrValidationResult = QrValidator.validate(
      data: data,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    if (qrValidationResult.status == QrValidationStatus.valid) {
      final qrCode = qrValidationResult.qrCode!;
      final painter = QrPainter.withQr(
        qr: qrCode,
        gapless: true,
        emptyColor: Colors.white,
      );
      final picData = await painter.toImageData(200);
      await File(path).writeAsBytes(picData!.buffer.asUint8List());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.background),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(title: "Document", showBackButton: true),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: Responsive.wp(context, 90),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(Responsive.wp(context, 3)),
                        padding: EdgeInsets.all(Responsive.wp(context, 4)),
                        decoration: AppContainerDecoration.card(),
                        child: Column(
                          children: [
                            Text(
                              'Import Assets from Excel',
                              style: TextStyle(
                                color: AppColors.primaryAccent,
                                fontSize: Responsive.sp(context, 16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: Responsive.hp(context, 2)),
                            Text(
                              'Excel format: QR ID | Name | Type | Summary | Image Path (optional)',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: Responsive.sp(context, 12),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: Responsive.hp(context, 3)),
                            GestureDetector(
                              onTap: _pickExcelFile,
                              child: Container(
                                padding: EdgeInsets.all(Responsive.wp(context, 4)),
                                decoration: AppContainerDecoration.imagePicker(hasError: false),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.file_upload,
                                      color: AppColors.primaryAccent,
                                      size: Responsive.wp(context, 6),
                                    ),
                                    SizedBox(width: Responsive.wp(context, 3)),
                                    Expanded(
                                      child: Text(
                                        selectedFileName ?? 'Pick Excel File (.xlsx, .xls)',
                                        style: TextStyle(
                                          color: selectedFileName != null ? AppColors.white : Colors.white54,
                                          fontSize: Responsive.sp(context, 14),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: Responsive.hp(context, 3)),
                            SizedBox(
                              width: double.infinity,
                              height: Responsive.hp(context, 6.5),
                              child: ElevatedButton(
                                style: AppButtonStyles.primary(),
                                onPressed: isProcessing || selectedFilePath == null ? null : _processExcel,
                                child: isProcessing
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                      )
                                    : Text(
                                        'Import Assets',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Responsive.sp(context, 16),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),
                          ],
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
