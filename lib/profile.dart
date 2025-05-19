import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/endpoint/editavatar.dart';
import 'package:mindtrack/endpoint/edituser.dart';
import 'package:mindtrack/endpoint/getuser.dart';
import 'package:mindtrack/models/avatars.dart';
import 'package:mindtrack/models/usermodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  bool _isLoading = true;
  UserModel? _user;
  String? selectedAvatar;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final moodController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await fetchUser();
    if (user != null) {
      setState(() {
        _user = user;
        nameController.text = user.fullname ?? "";
        emailController.text = user.email ?? "";
        phoneController.text = user.phone ?? "";
        moodController.text = null ?? "Unknown";
        _isLoading = false;
        selectedAvatar = user.avatar;
      });
    } else {
      setState(() => _isLoading = false);
    }
    if (selectedAvatar == "") selectedAvatar = avatarList.first;
  }

  Future<void> _handleAvatarChange(String avatar) async {
    final success = await updateAvatar(avatar);

    if (success) {
      await _loadUser();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update avatar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset("assets/icons/fundal_profil.png"),
                ),
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 49),
                      GestureDetector(
                        onTap: _showAvatarPicker,
                        child: Center(
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: MyColors.lightblue, width: 6),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/avatars/${selectedAvatar ?? avatarList.first}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildProfileField(
                          const Icon(Icons.person), nameController, isEditing),
                      _buildProfileField(
                          const Icon(Icons.email), emailController, isEditing),
                      _buildProfileField(
                          const Icon(Icons.phone), phoneController, isEditing),
                      _buildProfileField(
                        Image.asset("assets/icons/examination.png"),
                        moodController,
                        isEditing,
                        alwaysReadOnly: true,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 145,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (isEditing) {
                              List<Map<String, dynamic>> patchOps = [];

                              if (nameController.text != _user?.fullname) {
                                patchOps.add({
                                  "op": "replace",
                                  "path": "/fullname",
                                  "value": nameController.text,
                                });
                              }

                              if (emailController.text != _user?.email) {
                                patchOps.add({
                                  "op": "replace",
                                  "path": "/email",
                                  "value": emailController.text,
                                });
                              }

                              if (phoneController.text != _user?.phone) {
                                patchOps.add({
                                  "op": "replace",
                                  "path": "/phone",
                                  "value": phoneController.text,
                                });
                              }

                              await patchUser(patchOps);
                              await _loadUser();
                            }

                            setState(() => isEditing = !isEditing);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.pink,
                            foregroundColor: MyColors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Text(
                                  isEditing ? 'Save' : 'Edit',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter-VariableFont_opsz,wght',
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 12,
                                child: Icon(Icons.edit, size: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 300,
                        height: 2,
                        color: MyColors.black.withOpacity(0.5),
                      ),
                      _buildMenuItem(Icons.info, "About Us"),
                      const SizedBox(height: 4),
                      Container(
                        width: 300,
                        height: 2,
                        color: MyColors.black.withOpacity(0.5),
                      ),
                      _buildMenuItem(Icons.settings, "Settings"),
                      const SizedBox(height: 4),
                      Container(
                        width: 300,
                        height: 2,
                        color: MyColors.black.withOpacity(0.5),
                      ),
                      _buildMenuItem(Icons.logout, "Log Out"),
                      const SizedBox(height: 4),
                      Container(
                        width: 300,
                        height: 2,
                        color: MyColors.black.withOpacity(0.5),
                      ),
                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildProfileField(
    Widget iconWidget,
    TextEditingController controller,
    bool isEditable, {
    bool alwaysReadOnly = false,
  }) {
    return Container(
      width: 305,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: MyColors.cream,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: iconWidget,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: alwaysReadOnly ? false : isEditable,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Inter-VariableFont_opsz,wght',
                color: MyColors.black,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return SizedBox(
      height: 45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: GestureDetector(
          onTap: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 30),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: MyColors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter-VariableFont_opsz,wght',
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1.5),
                      blurRadius: 2,
                      color: MyColors.black.withOpacity(0.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          color: MyColors.lightblue,
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: avatarList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final avatar = avatarList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _handleAvatarChange(avatar);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: selectedAvatar == avatar
                        ? Border.all(color: Colors.green, width: 3)
                        : null,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/avatars/$avatar',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
