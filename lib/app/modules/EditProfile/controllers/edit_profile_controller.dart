import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var profileImage = Rxn<String>();

  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = pickedFile.path;
    }
  }

  void saveProfile() {
    // Save profile logic here
    Get.snackbar('نجاح', 'تم تعديل المعلومات الشخصية بنجاح');
  }
}
