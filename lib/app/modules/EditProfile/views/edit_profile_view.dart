import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yatrim/app/modules/EditProfile/controllers/edit_profile_controller.dart';
import 'package:yatrim/app/modules/Language/controllers/language_controller.dart'; // Import LanguageController

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController =
        Get.put(LanguageController()); // Get the language controller

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xff00bb6e)),
        title: Text(
          languageController.translate('edit_personal_info'), // Translated text
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(16.w), // Responsive padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              GestureDetector(
                onTap: controller.pickImage,
                child: Obx(
                  () => CircleAvatar(
                    radius: 50.r, // Responsive radius
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: controller.profileImage.value != null
                        ? FileImage(File(controller.profileImage.value!))
                            as ImageProvider
                        : null,
                    child: controller.profileImage.value == null
                        ? const Icon(Icons.camera_alt,
                            size: 30, color: Colors.grey)
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20.h), // Responsive height

              // Name Field
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  languageController.translate('name'), // Translated text
                  style: TextStyle(
                    fontSize: 14.sp, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8.h), // Responsive height
              TextField(
                controller: controller.nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: languageController
                      .translate('name_placeholder'), // Translated hint text
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 16.h), // Responsive padding
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14.r), // Responsive radius
                    borderSide: BorderSide(color: Color(0xffe9e9e9)),
                  ),
                ),
              ),
              SizedBox(height: 16.h), // Responsive height

              // Email Field
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  languageController.translate('email'), // Translated text
                  style: TextStyle(
                    fontSize: 14.sp, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8.h), // Responsive height
              TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: languageController
                      .translate('email_placeholder'), // Translated hint text
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 16.h), // Responsive padding
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14.r), // Responsive radius
                    borderSide: BorderSide(color: Color(0xffe9e9e9)),
                  ),
                ),
              ),
              SizedBox(height: 16.h), // Responsive height

              // Phone Field
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  languageController
                      .translate('phone_number'), // Translated text
                  style: TextStyle(
                    fontSize: 14.sp, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8.h), // Responsive height
              TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: languageController
                      .translate('phone_placeholder'), // Translated hint text
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 16.h), // Responsive padding
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14.r), // Responsive radius
                    borderSide: BorderSide(color: Color(0xffe9e9e9)),
                  ),
                ),
              ),
              SizedBox(height: 40.h), // Responsive height

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BB6E),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.r), // Responsive radius
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 16.h), // Responsive padding
                  ),
                  child: Text(
                    languageController
                        .translate('edit'), // Translated button text
                    style: TextStyle(
                      fontSize: 18.sp, // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
