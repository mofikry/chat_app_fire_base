import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainButton extends StatelessWidget {
  const MainButton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
        onPressed: onTap,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .button!
              .copyWith(color: const Color(0xFF2B475E)),
        ),
      ),
    );
  }
}
