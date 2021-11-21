import 'package:flutter/material.dart';

class ProjectAppBar extends StatelessWidget implements PreferredSizeWidget{
  const ProjectAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}
  