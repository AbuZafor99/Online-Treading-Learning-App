import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/widgets/module_resource_item.dart';
import '../../data/models/class_module_module.dart';

class ModuleAllResources extends StatelessWidget {
  final Module module;
  final int index;

  const ModuleAllResources({
    super.key,
    required this.module,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8.0),
      color: const Color(0xffE8ECF1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Text(
              'Module ${index + 1}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(color: Colors.grey[400], thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: module.resources.length,
              itemBuilder: (context, resourceIndex) {
                final resource = module.resources[resourceIndex];
                return ModuleResourceItem(
                  title: resource.name ?? 'No resource available',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
