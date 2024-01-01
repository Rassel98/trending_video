
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
    // return SizedBox(
    //   height: height,
    //   width: weight,
    //   child: ElevatedButton(
    //     onPressed: onPressed,
    //     style: ElevatedButton.styleFrom(
    //       backgroundColor: Colors.white,
    //       foregroundColor: Colors.white,
    //       elevation: 1,
    //       padding: EdgeInsets.zero,
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
    //           side: const BorderSide(color: Colors.red)
    //           ),
    //     ),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Icon(iconData,color: Colors.black45,),
    //         Text(
    //           title,
    //           style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
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

class ButtonModel {
  IconData icon;
  String title;
  double hei;
  double wei;
  ButtonModel(this.icon, this.title,this.hei,this.wei);
}

final List<ButtonModel> buttons = [
  ButtonModel(Icons.favorite_border_outlined, "MASH ALLAH (12k)",60,150),
  ButtonModel(Icons.thumb_up_alt_outlined, "LIKE (12k)",60,100),
  ButtonModel(Icons.share, "SHARE",60,100),
  ButtonModel(Icons.flag, "REPORT",60,100),
];
