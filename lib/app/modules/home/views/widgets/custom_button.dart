
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class CustomButton extends StatelessWidget {
  final double height;
  final double weight;
  final VoidCallback onPressed;
  Color bgColors;
  Color border;
  final String iconData;
  final String title;
  CustomButton(
      {Key? key,
      required this.height,
      required this.weight,
      required this.title,
      required this.iconData,
      this.bgColors = Colors.transparent,
      this.border = Colors.transparent,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Ink(
        height: height,
        width: weight,
        padding: const EdgeInsets.only(left: 6,top: 6,bottom: 6,right: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffE2E8F0),width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           // Icon(iconData,color: const Color(0xff718096),size: 24,),
            SvgPicture.asset(
              iconData,
              height: 24,
              width: 24,
            ),
            Text(
              title,
              style: const TextStyle(color: Color(0xff718096), fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

