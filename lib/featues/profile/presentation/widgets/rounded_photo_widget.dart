import 'dart:io';

import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RoundedPhotoWidget extends StatefulWidget {
  const RoundedPhotoWidget({super.key});

  @override
  State<RoundedPhotoWidget> createState() => _RoundedPhotoWidgetState();
}

class _RoundedPhotoWidgetState extends State<RoundedPhotoWidget> {
  File? _imageFile;
  String? _webImagePath;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.width_150,
      height: AppDimensions.height_150,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _imagePicker(context),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: AppDimensions.width_150,
              height: AppDimensions.height_150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.padding_8),
                child: CircleAvatar(
                  radius: AppDimensions.radius_30,
                  backgroundColor: Colors.grey[200],
                  child: Padding(
                    padding: EdgeInsets.all(AppDimensions.padding_8),
                    child: ClipOval(
                      child: Image(
                        image:
                            kIsWeb
                                ? (_webImagePath != null
                                    ? NetworkImage(_webImagePath!)
                                    : AssetImage(AppAssets.doctorImage)
                                        as ImageProvider)
                                : (_imageFile != null
                                    ? FileImage(_imageFile!)
                                    : AssetImage(AppAssets.doctorImage)
                                        as ImageProvider),
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: AppDimensions.height_15,
              right: AppDimensions.width_15,
              child: CircleAvatar(
                backgroundColor: ColorsManager.lightBlueAccent,
                child: Icon(
                  Icons.edit,
                  size: AppDimensions.width_30,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _imagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              _buildListTileImagePicker(
                Icons.camera_alt,
                AppStrings.takePhoto,
                () async => pickedImage(ImageSource.camera),
              ),
              _buildListTileImagePicker(
                Icons.photo_album_outlined,
                AppStrings.chooseFromGallery,
                () async => pickedImage(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListTileImagePicker(
    IconData iconData,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title, style: TextStyles.font14DarckBlueMedium),
      onTap: onTap,
    );
  }

  void pickedImage(ImageSource source) async {
    context.pop();
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      setState(() {
        kIsWeb ? _webImagePath = picked.path : _imageFile = File(picked.path);
      });
    }
  }
}
