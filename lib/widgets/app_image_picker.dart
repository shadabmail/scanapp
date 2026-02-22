import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';
import '../utils/container_decoration.dart';

class AppImagePicker extends StatelessWidget {
  final String? selectedImageName;
  final bool hasError;
  final Function(String path, String name) onImageSelected;

  const AppImagePicker({
    super.key,
    required this.selectedImageName,
    required this.hasError,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          onImageSelected(image.path, image.name);
        }
      },
      child: Container(
        height: Responsive.hp(context, 15),
        padding: EdgeInsets.all(Responsive.wp(context, 3)),
        decoration: AppContainerDecoration.imagePicker(hasError: hasError),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_photo_alternate,
                color: AppColors.primaryAccent,
                size: Responsive.wp(context, 10),
              ),
              SizedBox(height: Responsive.hp(context, 0.5)),
              Text(
                selectedImageName ?? 'Add Image *',
                style: TextStyle(
                  color: AppColors.primaryAccent,
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
    );
  }
}
