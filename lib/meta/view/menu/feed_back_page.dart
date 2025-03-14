import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:why_not_143_team/meta/helper/constant/color_constant.dart';
import 'package:why_not_143_team/meta/helper/constant/padding_constant.dart';
import 'package:why_not_143_team/meta/helper/constant/string.dart';
import 'package:why_not_143_team/meta/helper/constant/text_style.dart';
import 'package:why_not_143_team/meta/helper/route/route_constant.dart';
import 'package:why_not_143_team/meta/view/menu/about_page.dart';
import 'package:why_not_143_team/meta/widget/general_button.dart';
class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  String feedbackTitle = '';
  String feedbackMessage = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leadingWidth: 80,
            title: Text(StringConstant.instance.feedBack,
                style: GoogleFonts.poppins(
                    color: ColorConstant.instance.yankeBlue))),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: PaddingConstant.instance.loginPadding,
                child: SubText(text: StringConstant.instance.feedBackSub),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: PaddingConstant.instance.loginPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TittleWidget(
                              text: StringConstant.instance.feedBackCaption),
                        ],
                      ),
                    ),
                    Padding(
                      padding: PaddingConstant.instance.loginPadding,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            feedbackTitle = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: StringConstant.instance.feedBackCaptionSub,
                          hintStyle: TextStyleConstant.instance.textSmallMedium
                              .copyWith(color: ColorConstant.instance.neutral),
                        ),
                      ),
                    ),
                    Padding(
                      padding: PaddingConstant.instance.loginPadding,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            feedbackMessage = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: StringConstant.instance.feedBackMessage,
                          hintStyle: TextStyleConstant.instance.textSmallMedium
                              .copyWith(color: ColorConstant.instance.neutral),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GeneralButton(
                      text: StringConstant.instance.feedBackSend,
                      function: send,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void send() {
    Navigator.pushNamed(context, RouteConstant.homeScreenRoute);
  }
}
