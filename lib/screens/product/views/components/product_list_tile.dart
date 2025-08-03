import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile(
      {super.key,
      required this.value,
      required this.title,
      this.isShowBottomBorder = false,
      this.press,
      this.trailing});

  final String title, value;
  final bool isShowBottomBorder;
  final VoidCallback? press;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const Divider(height: 1),
          ListTile(
              onTap: press,
              minLeadingWidth: 24,
              title: Text(title),
              trailing: trailing ??
                  (press == null
                      ? Text(value)
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(value),
                            SvgPicture.asset(
                              "assets/icons/miniRight.svg",
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            )
                          ],
                        ))),
          if (isShowBottomBorder) const Divider(height: 1),
        ],
      ),
    );
  }
}
