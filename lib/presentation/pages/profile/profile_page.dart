import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/config/app_colors.dart';
import 'package:news/config/app_text_styles.dart';
import 'package:news/presentation/controllers/auth/auth_controller.dart';
import 'package:news/presentation/pages/news/news_page.dart';

class ProfilePage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      init: controller,
      builder: (_) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Profile'),
          ),
          child: controller.isLoggedIn.value
              ? SignInView()
              : SignUpView(
                  onRegister: (username) {
                    controller.signUpWith(username);
                  },
                ),
        );
      },
    );
  }
}

class SignInView extends StatefulWidget {
  @override
  _SignInView createState() => _SignInView();
}

class _SignInView extends State<SignInView> {
  final AuthController controller = Get.find();

  CategoryType _currentCategory = CategoryType.bitcoin;

  @override
  void initState() {
    super.initState();
    _currentCategory = controller.user?.type ?? CategoryType.bitcoin;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            _buildItem(
              "Username:",
              Text(
                controller.user?.username ?? "",
                style: AppTextStyle.title,
              ),
            ),
            _buildItem(
              "Category:",
              TextButton(
                onPressed: () {
                  _selectCategory(context);
                },
                child: Text(_currentCategory.keyword.capitalizeFirst ?? ""),
              ),
            ),
            TextButton(onPressed: controller.logout, child: Text("Logout")),
          ],
        ),
      ),
    );
  }

  _buildItem(String title, Widget child) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.title,
        ),
        SizedBox(
          width: 10,
        ),
        child
      ],
    );
  }

  _selectCategory(BuildContext context) {
    final actions = CategoryType.values
        .map(
          (e) => CupertinoActionSheetAction(
            child: Text(e.keyword.capitalizeFirst ?? ""),
            onPressed: () {
              setState(() {
                _currentCategory = e;
              });
              controller.saveCategory(e);
              Navigator.pop(context);
            },
          ),
        )
        .toList();

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select category'),
        actions: actions,
      ),
    );
  }
}

class SignUpView extends StatelessWidget {
  final _userNameController = TextEditingController();
  final Function(String) onRegister;

  SignUpView({required this.onRegister});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            SizedBox(
              height: 50,
              child: Text(
                "Register your username",
                style: AppTextStyle.title,
              ),
            ),
            SizedBox(height: 50),
            _buildLoginForm(context),
            SizedBox(height: 50),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      height: 50,
      child: CupertinoTextField(
        keyboardType: TextInputType.emailAddress,
        placeholder: "Enter username",
        controller: _userNameController,
      ),
    );
  }

  Widget _buildLoginButton() {
    return MaterialButton(
      onPressed: () {
        onRegister(_userNameController.text);
      },
      child: Text(
        "Register",
        style: AppTextStyle.body,
      ),
      color: AppColors.primary,
      elevation: 0,
      minWidth: 350,
      height: 55,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
