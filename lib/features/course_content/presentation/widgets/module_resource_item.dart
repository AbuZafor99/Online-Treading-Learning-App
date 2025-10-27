import 'package:flutter/material.dart';

class ModuleResourceItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const ModuleResourceItem({
    super.key,
    required this.title,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor ?? const Color(0xffF4F4F4),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff090F12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
