import 'package:aksat/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class HomeWidgetCard extends StatelessWidget {
  const HomeWidgetCard(
      {Key? key,
      required this.text,
      required this.imageUrl,
      required this.onTap})
      : super(key: key);
  final String text;
  final String imageUrl;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25, right: 12, left: 12),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 12,
                    offset: const Offset(0, 3)),
              ],
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Image(
                  image: AssetImage(imageUrl),
                  width: MediaQuery.of(context).size.width * 1 / 3.5,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontsAssets.primaryArabicFont),
              )
            ],
          ),
        ),
      ),
    );
  }
}
