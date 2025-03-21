import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:why_not_143_team/meta/helper/constant/asset_path.dart';
import 'package:why_not_143_team/meta/helper/constant/color_constant.dart';
import 'package:why_not_143_team/meta/helper/constant/string.dart';
import 'package:why_not_143_team/meta/helper/constant/text_style.dart';
import 'package:why_not_143_team/core/services/firebase_auth_method.dart';
import 'package:why_not_143_team/meta/helper/constant/padding_constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:why_not_143_team/meta/helper/route/route_constant.dart';
import 'package:why_not_143_team/meta/helper/utils/show_toast_message.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen(ZoomDrawerController drawerController, {Key? key})
      : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final _firebaseUser = context.watch<User?>();
    return Scaffold(
      backgroundColor: ColorConstant.instance.yankeBlue,
      body: SafeArea(
        child: Column(
          children: [
            menuAvatar(_firebaseUser, context),
            menuDivider(),
            sizedBox1(),
            menuPerson(_firebaseUser, context),
            menuRateOurApp(),
            menuAbout(),
            menuSendBack(),
            sizedBox2(),
            const LogOut(),
          ],
        ),
      ),
    );
  }

  Widget menuAvatar(_firebaseUser, context) {
    return _firebaseUser != null
        ? Padding(
            padding: PaddingConstant.instance.loginPadding,
            child: DrawerHeader(
              child: SizedBox(
                height: 100.h,
                width: 100.w,
                child: _firebaseUser.photoURL != null
                    ? CircleAvatar(
                        backgroundImage:
                            NetworkImage("${_firebaseUser.photoURL}"),
                      )
                    : CircleAvatar(
                        backgroundImage:
                            AssetImage(AssetPath.instance.menuPerson),
                      ),
              ),
            ),
          )
        : Padding(
            padding: PaddingConstant.instance.loginPadding,
            child: DrawerHeader(
              child: SizedBox(
                height: 100.h,
                width: 100.w,
                child: CircleAvatar(
                  backgroundImage: AssetImage(AssetPath.instance.menuPerson),
                ),
              ),
            ),
          );
  }

  SizedBox sizedBox2() {
    return SizedBox(
      height: 100.h,
    );
  }

  SizedBox sizedBox1() {
    return SizedBox(
      height: 30.h,
    );
  }

  Padding menuSendBack() {
    return Padding(
      padding: PaddingConstant.instance.menuPadding,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteConstant.feedBackScreenRoute);
        },
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Icon(
              Icons.send,
              color: ColorConstant.instance.white,
              size: 25,
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              StringConstant.instance.menuSendBack,
              textAlign: TextAlign.center,
              style: TextStyleConstant.instance.textSmallMedium
                  .copyWith(color: ColorConstant.instance.white),
            ),
          ],
        ),
      ),
    );
  }

  Padding menuAbout() {
    return Padding(
      padding: PaddingConstant.instance.menuPadding,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteConstant.aboutScreenRoute);
        },
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Icon(
              Icons.double_arrow_rounded,
              color: ColorConstant.instance.white,
              size: 25,
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              StringConstant.instance.menuAbout,
              textAlign: TextAlign.center,
              style: TextStyleConstant.instance.textSmallMedium
                  .copyWith(color: ColorConstant.instance.white),
            ),
          ],
        ),
      ),
    );
  }

  Padding menuRateOurApp() {
    return Padding(
      padding: PaddingConstant.instance.menuPadding,
      child: InkWell(
        onTap: _launchUrl,
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Icon(
              Icons.star,
              color: ColorConstant.instance.white,
              size: 25,
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              StringConstant.instance.menuRateOurApp,
              textAlign: TextAlign.center,
              style: TextStyleConstant.instance.textSmallMedium
                  .copyWith(color: ColorConstant.instance.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuPerson(_firebaseUser, context) {
    return _firebaseUser != null
        ? Padding(
            padding: PaddingConstant.instance.menuPadding,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteConstant.profileRoute);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
                    Icons.person,
                    color: ColorConstant.instance.white,
                    size: 25,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  _firebaseUser.displayName != null
                      ? Flexible(
                          child: Text(
                            "${_firebaseUser.displayName}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyleConstant.instance.textSmallMedium
                                .copyWith(color: ColorConstant.instance.white),
                          ),
                        )
                      : Flexible(
                          child: Text(
                            "${_firebaseUser.email}",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleConstant.instance.textSmallMedium
                                .copyWith(color: ColorConstant.instance.white),
                          ),
                        )
                ],
              ),
            ),
          )
        : Padding(
            padding: PaddingConstant.instance.menuPadding,
            child: InkWell(
              onTap: () {
                showToast(context, "Lütfen giriş yapınız.");
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
                    Icons.person,
                    color: ColorConstant.instance.white,
                    size: 25,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    StringConstant.instance.menuPerson,
                    textAlign: TextAlign.center,
                    style: TextStyleConstant.instance.textSmallMedium
                        .copyWith(color: ColorConstant.instance.white),
                  ),
                ],
              ),
            ),
          );
  }

  Divider menuDivider() {
    return const Divider(
      color: Colors.white,
      thickness: 1,
    );
  }
}

class LogOut extends StatefulWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    final _firebaseUser = context.watch<User?>();
    return _firebaseUser != null
        ? Padding(
            padding: PaddingConstant.instance.menuPadding,
            child: InkWell(
              onTap: () {
                context.read<FirebaseAuthMethods>().signOut(context).then(
                    (value) => Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteConstant.homeScreenRoute,
                        (Route<dynamic> route) => false));
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
                    Icons.logout,
                    color: ColorConstant.instance.white,
                    size: 25,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    StringConstant.instance.logOut,
                    textAlign: TextAlign.center,
                    style: TextStyleConstant.instance.textSmallMedium
                        .copyWith(color: ColorConstant.instance.white),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: PaddingConstant.instance.menuPadding,
            child: InkWell(
              onTap: () async {
                Navigator.pushNamed(context, RouteConstant.loginScreenRoute);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
                    Icons.login_outlined,
                    color: ColorConstant.instance.white,
                    size: 25,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    StringConstant.instance.loginSignIn,
                    textAlign: TextAlign.center,
                    style: TextStyleConstant.instance.textSmallMedium
                        .copyWith(color: ColorConstant.instance.white),
                  ),
                ],
              ),
            ),
          );
  }
}

void _launchUrl() async {
  final Uri _url = Uri.parse('https://github.com/senaecelik/Why-not-143');

  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}
