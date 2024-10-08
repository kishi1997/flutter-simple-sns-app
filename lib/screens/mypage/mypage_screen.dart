import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/screens/mypage/edit_profile.dart';
import 'package:simple_sns_app/screens/onboarding_screen.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/utils/provider_utils.dart';
import 'package:simple_sns_app/utils/link_utils.dart';
import 'package:simple_sns_app/utils/snack_bar_utils.dart';
import 'package:simple_sns_app/utils/token_utils.dart';
import 'package:simple_sns_app/widgets/user/uset_icon.dart';

const String TERMS_OF_SERVICE_URL =
    'https://anycloud.notion.site/a260154689f841a093bab65716ea6fc4?pvs=4';
const String PRIVACY_POLICY_URL =
    'https://anycloud.notion.site/e91dc1d372554c8e9168c47f95a1d850?pvs=4';

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});

  Future<void> _launchLink(BuildContext context, String url) async {
    try {
      await launchURL(url);
    } catch (e) {
      if (!context.mounted) return;
      logError(e);
      showFailureSnackBar(context, 'エラーが発生しました。しばらく経ってからもう一度お試しください。');
    }
  }

  Widget _linkListTile(BuildContext context, String linkUrl, String text) {
    return GestureDetector(
      onTap: () async {
        await _launchLink(context, linkUrl);
      },
      child: ListTile(
        title: Text(text),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  void handleLogout(BuildContext context) {
    tokenStorage.deleteToken();
    userProvider.clearUser();
    showSuccessSnackBar(context, "ログアウトしました");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      (route) => false,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            'ログアウトしますか？',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text('キャンセル', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text('ログアウト',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onPressed: () {
                handleLogout(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: const AppHeader(title: 'マイページ'),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 70,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: UserIcon(iconImageUrl: currentUser?.iconImageUrl),
                ),
              ),
              const SizedBox(width: 24.0),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    currentUser?.name ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    currentUser?.email ?? "",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              )),
            ],
          ),
        ),
        ListTile(
          title: const Text('プロフィール編集'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfileScreen(
                  name: currentUser!.name,
                  email: currentUser.email!,
                  iconUrl: currentUser.iconImageUrl,
                ),
              ),
            );
          },
        ),
        _linkListTile(context, TERMS_OF_SERVICE_URL, "利用規約"),
        _linkListTile(context, PRIVACY_POLICY_URL, "プライバシーポリシー"),
        ListTile(
          title: const Text('ログアウト'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            _showLogoutDialog(context);
          },
        ),
      ]),
    );
  }
}
