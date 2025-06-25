import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mindtrack/about.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/endpoint/editavatar.dart';
import 'package:mindtrack/endpoint/getquizresults.dart';
import 'package:mindtrack/endpoint/getuser.dart';
import 'package:mindtrack/firstpage.dart';
import 'package:mindtrack/journal.dart';
import 'package:mindtrack/login.dart';
import 'package:mindtrack/models/avatars.dart';
import 'package:mindtrack/models/usermodel.dart';
import 'package:mindtrack/questions.dart';
import 'package:url_launcher/url_launcher.dart';

final storage = FlutterSecureStorage();

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

  DateTime? _lastQuizDate;
  bool _canRetakeQuiz = false;

  final user_nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final moodController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await getUser();
    if (!mounted) return;
    if (user != null) {
      final quizResult = await fetchLatestQuizResult();
      if (!mounted) return;
      final DateTime? quizDate = quizResult?.date;
      final now = DateTime.now();
      bool canRetake = false;
      if (quizDate != null) {
        canRetake = now.difference(quizDate).inDays >= 14;
      }
      setState(() {
        _user = user;
        user_nameController.text = user.username ?? '';
        emailController.text = user.email ?? '';
        phoneController.text = user.phone ?? '';
        moodController.text = quizResult?.title ?? 'Unknown';
        _isLoading = false;
        selectedAvatar = user.avatar;
        _lastQuizDate = quizDate;
        _canRetakeQuiz = canRetake;
      });
    } else {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  void _showRetakeDialog() {
    final daysLeft = _lastQuizDate != null
        ? 14 - DateTime.now().difference(_lastQuizDate!).inDays
        : 14;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Locked'),
        content: Text('Retake Quiz available in $daysLeft days'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAvatarChange(String avatar) async {
    final success = await updateAvatar(avatar);
    if (!mounted) return;
    if (success) {
      await _loadUser();
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update avatar')),
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
                  child: Image.asset('assets/icons/fundal_profil.png'),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      GestureDetector(
                        onTap: _showAvatarPicker,
                        child: Center(
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColors.pink,
                              border: Border.all(
                                  color: MyColors.lightblue, width: 6),
                            ),
                            child: selectedAvatar != null &&
                                    selectedAvatar!.isNotEmpty
                                ? ClipOval(
                                    child: Image.asset(
                                      'assets/avatars/$selectedAvatar',
                                      fit: BoxFit.cover,
                                      width: 160,
                                      height: 160,
                                    ),
                                  )
                                : const Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 48,
                                      color: MyColors.black,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildProfileField(const Icon(Icons.person),
                          user_nameController, isEditing),
                      _buildProfileField(
                          const Icon(Icons.email), emailController, isEditing),
                      _buildProfileField(
                          const Icon(Icons.phone), phoneController, isEditing),
                      _buildProfileField(
                        Image.asset('assets/icons/examination.png'),
                        moodController,
                        isEditing,
                        alwaysReadOnly: true,
                      ),
                      const SizedBox(height: 22),
                      Container(
                        width: 300,
                        height: 2,
                        color: MyColors.black.withOpacity(0.5),
                      ),
                      GestureDetector(
                        onTap: _canRetakeQuiz
                            ? () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const QuizPage()),
                                )
                            : _showRetakeDialog,
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Icon(
                                Icons.restart_alt_rounded,
                                size: 30,
                                color: MyColors.black,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Retake Quiz',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.black,
                                  fontFamily: 'Inter-VariableFont_opsz,wght',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 2,
                        color: MyColors.black.withOpacity(0.5),
                      ),
                      _buildMenuItem(Icons.book_outlined, 'Journal', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => JournalScreen()),
                        );
                      }),
                      const SizedBox(height: 4),
                      Container(
                        width: 300,
                        height: 2,
                        color: MyColors.black.withOpacity(0.5),
                      ),
                      _buildMenuItem(Icons.info_outline, 'About Us', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AboutScreen()),
                        );
                      }),
                      const SizedBox(height: 4),
                      Container(
                        width: 300,
                        height: 2,
                        color: MyColors.black.withOpacity(0.5),
                      ),
                      _buildMenuItem(
                          Icons.emergency_outlined, "Suicide Help Line",
                          () async {
                        final Uri phoneUri =
                            Uri(scheme: 'tel', path: '0800801200');
                        if (await canLaunchUrl(phoneUri)) {
                          await launchUrl(phoneUri);
                        } else {
                          print('Could not launch phone dialer');
                        }
                      }),
                      const SizedBox(height: 4),
                      Container(
                        width: 300,
                        height: 2,
                        color: MyColors.black.withOpacity(0.5),
                      ),
                      _buildMenuItem(Icons.logout, 'Log Out', () async {
                        await storage.delete(key: 'token');
                        if (!context.mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => StartPage()),
                        );
                      }),
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
          SizedBox(width: 20, height: 20, child: iconWidget),
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

  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return SizedBox(
      height: 45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: GestureDetector(
          onTap: onTap,
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
                        color: MyColors.black.withOpacity(0.4)),
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
                    child: Image.asset('assets/avatars/$avatar',
                        fit: BoxFit.cover),
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
