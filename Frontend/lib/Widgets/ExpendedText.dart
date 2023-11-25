import 'package:flutter/material.dart';

class ExpandableText extends StatelessWidget {
  final String text;
  final int maxLines;
  final String expandText;
  final String collapseText;
  final bool expanded;
  final Function onTap;

  ExpandableText({
    required this.text,
    required this.maxLines,
    required this.expandText,
    required this.collapseText,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          maxLines: expanded ? null : maxLines,
          style: TextStyle(color: Colors.grey),
          // overflow: TextOverflow.ellipsis,
        ),
        if (text.split(' ').length > 18)
          TextButton(
            onPressed: () => onTap(),
            child: Text(
              expanded ? collapseText : expandText,
              style: TextStyle(color: Colors.grey.shade900),
            ),
          ),
      ],
    );
  }
}
