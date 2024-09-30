import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.colorTitle,
    required this.colorBg,
    required this.colorFg,
  });
  final String title;
  final Color colorTitle;
  final Color colorBg;
  final Color colorFg;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: colorBg,
      foregroundColor: colorFg,
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            Icons.more_vert,
            size: 32,
          ),
        )
      ],
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.bodyLarge!.copyWith(color: colorTitle),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
