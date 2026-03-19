import 'dart:io';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_system/utils/app_colors.dart';
import 'package:hrms_system/models/my_controller.dart';
import 'package:hrms_system/utils/current_user_info.dart';
import 'package:hrms_system/utils/helperMethods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/dashboardController.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  MyController getXController = Get.put(MyController());

  String imageURL = '';

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          StickyHeader(
            header: Container(
              // height: 160.0,
              decoration: BoxDecoration(
                color: AppColor.blue900,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.grey300,
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Obx(() => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white,
                            image: DecorationImage(image: NetworkImage(CurrentUserInfo.profileImageUrl.value),
                              fit: BoxFit.cover,
                            ),
                          ),
                          padding: EdgeInsets.all(3.0),
                          margin: EdgeInsets.only(right: 25.0),
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundColor: AppColor.transparent,
                            // backgroundImage: NetworkImage('gs://hrmsystem-6a062.appspot.com/images/1000039450.jpg',),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 22.0,
                          bottom: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              Get.dialog(
                                barrierDismissible: true,
                                Dialog(
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          child: Container(
                                              padding: EdgeInsets.all(12.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delete),
                                                  SizedBox(width: 7.0,),
                                                  Text('Remove profile image'),
                                                ],
                                              )
                                          ),
                                          onTap: () async{
                                            // Code to remove profile image
                                            DocumentSnapshot<Map<String, dynamic>> profileImageSnapshot =
                                                await FirebaseFirestore.instance
                                                .collection('profileImages')
                                                .doc('${CurrentUserInfo.empID.value}')
                                                .get();
                                            if(profileImageSnapshot.exists) {
                                              await HelperMethods.deleteProfileImageDoc();

                                              CurrentUserInfo.profileImageUrl.value = 'https://firebasestorage.googleapis.com/v0/b/hrmsystem-6a062.appspot.com/o/images%2FprofileImageDefault.png?alt=media&token=7a43fc33-4feb-4b8a-a4fd-5e58ca2eb089';

                                              String oldImgUrl = profileImageSnapshot.data()!['imgUrl'];
                                              await FirebaseStorage.instance.refFromURL(oldImgUrl).delete();

                                              Get.back();
                                            } else {
                                              // Nothing to delete

                                              Get.back();

                                              Get.snackbar(
                                                "No image to delete!",
                                                "You haven't uploaded any profile image",
                                                colorText: AppColor.black,
                                                backgroundColor: AppColor.blue100,
                                                icon: Icon(Icons.error),
                                                duration: Duration(seconds: 3),
                                              );
                                            }
                                          },
                                        ),
                                        GestureDetector(
                                          child: Container(
                                              padding: EdgeInsets.all(12.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.add_a_photo),
                                                  SizedBox(width: 7.0,),
                                                  Text('Change Profile Image'),
                                                ],
                                              )
                                          ),
                                          onTap: () async{
                                            /*
                                            * Step 1: Pick/Capture an image (image_picker)
                                            * Step 2: Upload the image to firebase storage
                                            * Step 3: Get the URL of the uploaded image
                                            * Step 4: Store the image URL inside the corresponding document of the databse
                                            * Step 5: Display the image in the profile
                                            * */

                                            // Step 1: Pick image
                                            // Install image picker
                                            //Import the corresponding library

                                            ImagePicker imagePicker = ImagePicker();
                                            XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                                            print('${file?.path}');

                                            if(file==null) return;

                                            // Step 2: Upload to firebase storage
                                            // Install firebase_storage
                                            // Import the library

                                            // Get reference of storage root
                                            Reference referenceRoot = FirebaseStorage.instance.ref();
                                            Reference referenceDirImages = referenceRoot.child('images');

                                            // Create a reference for the image to be stored
                                            Reference referenceImageToUpload = referenceDirImages.child('${file?.name}');

                                            // Instead of passing the name of the file we can create a unique name by passing the timestamp
                                            // String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
                                            // Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

                                            // Store the file and handle errors while uploading through try catch
                                            try {
                                              Get.back();

                                              // Snacbar
                                              Get.snackbar(
                                                "Profile picture changed successfully!",
                                                "Just wait for a few seconds for the changes to get reflected.",
                                                colorText: AppColor.black,
                                                backgroundColor: AppColor.blue100,
                                                icon: Icon(Icons.add_a_photo),
                                                duration: Duration(seconds: 4),
                                                // snackPosition: SnackPosition.BOTTOM,
                                              );

                                              await referenceImageToUpload.putFile(File(file!.path));

                                              // Success: get the download url
                                              imageURL = await referenceImageToUpload.getDownloadURL();

                                              // Change in app data
                                              CurrentUserInfo.profileImageUrl.value = imageURL;

                                              // Delete the old image
                                              DocumentSnapshot<Map<String, dynamic>> profileImageSnapshot =
                                              await FirebaseFirestore.instance
                                                  .collection('profileImages')
                                                  .doc('${CurrentUserInfo.empID.value}')
                                                  .get();
                                              if(profileImageSnapshot.exists) {
                                                String oldImgUrl = profileImageSnapshot.data()!['imgUrl'];
                                                await FirebaseStorage.instance.refFromURL(oldImgUrl).delete();
                                              } else {
                                                // Nothing to delete
                                              }

                                              // Set link in Firestore Database
                                              await HelperMethods.changeProfileImage(imageURL);
                                            } catch(e) {
                                              print("Error while uplaoding file: $e");
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.blue100,
                              ),
                                padding: EdgeInsets.all(7.0),
                                child: Icon(Icons.camera_alt,
                                  size: 15.0,
                                )
                            ),
                          ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx( () => Text('${CurrentUserInfo.empName.value}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColor.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Obx( () => Text('ID: ${CurrentUserInfo.empID.value}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            content: Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.grey300,
                    spreadRadius: 0.0,
                    blurRadius: 10.0,
                  ),
                ],
              ),
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Personal Information',
                        style: TextStyle(
                          color: AppColor.blue900,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      // Icon(Icons.edit_note,
                      //   color: AppColor.blue900,
                      // ),
                    ],
                  ),
                  Obx(() => InfoTile(Icons.email, '${CurrentUserInfo.empEmail.value}')),
                  Obx(() => InfoTile(Icons.phone, '${CurrentUserInfo.empPhNum.value}')),
                  Obx(() => InfoTile(Icons.cake, '${CurrentUserInfo.empDOB.value.day.toString().padLeft(2, "0")}/${CurrentUserInfo.empDOB.value.month.toString().padLeft(2, "0")}/${CurrentUserInfo.empDOB.value.year}')),
                  Obx(() => InfoTile(Icons.bloodtype, '${CurrentUserInfo.empBldGrp.value}')),
                  Obx(() => InfoTile(Icons.flag, '${CurrentUserInfo.empNationality.value}')),
                  Obx(() => InfoTile(Icons.language, '${CurrentUserInfo.empLang.value}')),
                  Obx(() => InfoTile(Icons.location_on, '${CurrentUserInfo.empAdd.value}')),
                ],
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: AppColor.grey300,
                  spreadRadius: 0.0,
                  blurRadius: 10.0,
                ),
              ],
            ),
            margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Employment Details',
                  style: TextStyle(
                    color: AppColor.blue900,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Obx(() => InfoTile(Icons.abc, '${CurrentUserInfo.empJobTitle.value}')), //Job title
                Obx(() => InfoTile(Icons.timelapse, '${CurrentUserInfo.empStatus.value}')), //Employment status
                Obx(() => InfoTile(Icons.calendar_month, '${CurrentUserInfo.empStartDate.value.day.toString().padLeft(2, "0")}/${CurrentUserInfo.empStartDate.value.month.toString().padLeft(2, "0")}/${CurrentUserInfo.empStartDate.value.year}')), //Employment status
                Obx(() => InfoTile(Icons.pie_chart, '${CurrentUserInfo.empDept.value}')), //Employee Department
                // Obx(() => InfoTile(Icons.star, '${CurrentUserInfo.empPerformanceRatings.value}')), // Performance Ratings
                // Obx(() => InfoTile(Icons.add_chart, '${CurrentUserInfo.empAchievements.value}')), // Achievements
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget InfoTile(IconData icon, String? text) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(icon,
          color: AppColor.blue900,
        ),
      ),
      Expanded(child: Text('$text')),
    ],
  );
}
