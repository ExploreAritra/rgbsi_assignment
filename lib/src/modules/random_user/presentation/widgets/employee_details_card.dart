import 'dart:io';
import 'package:assignment/src/core/utils/date_utils.dart';
import 'package:assignment/src/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../business/entities/random_user_entity.dart';

class EmployeeCard extends StatelessWidget {
  final UserEntity? user;
  const EmployeeCard({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              spreadRadius: 0,
              offset: Offset(1, 1),
            ),
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _basicDetails(),
                    _registeredSince(),
                    _emailAddress(),
                  ],
                ),
              ),
              _image(),
            ],
          ),
          _address(),
        ],
      ),
    );
  }

  Widget _basicDetails() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text:
                "${user?.name?.title ?? ""} ${user?.name?.first ?? ""} ${user?.name?.last ?? ""}",
            style: textStyles.xlTextSemiBoldStyle.copyWith(
              color: Colors.black,
            ),
          ),
          TextSpan(
            text:
                " (${user?.dob?.age}, ${user?.gender?.substring(0, 1).toUpperCase()})",
            style: textStyles.smTextMediumStyle.copyWith(
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _registeredSince() {
    return Text(
      "Registered ${DateUtil.daysSince(dateTime: user?.registered?.date)} days ago",
      style: textStyles.xsTextMediumStyle,
    ).marginOnly(top: 4);
  }

  Widget _emailAddress() {
    return Text(
      "e-mail: ${user?.email}",
      style: textStyles.smTextMediumStyle,
    );
  }

  Widget _image() {
    return user?.picture?.path != null
        ? CircleAvatar(
            radius: 30,
            backgroundImage: FileImage(File(user!.picture!.path!)),
          )
        : CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              user?.picture?.large ?? "",
            ),
          );
  }

  Widget _address() {
    return Text(
      "${user?.location?.street?.number}, ${user?.location?.street?.name}\n${user?.location?.city}, ${user?.location?.state}\n${user?.location?.country}, ${user?.location?.postcode}",
      style: textStyles.smTextMediumStyle,
    ).marginOnly(top: 10);
  }
}
