import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/2_application/core/page_config.dart';

class CreateToDoCollectionPageProvider extends StatelessWidget {
  const CreateToDoCollectionPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateToDoCollectionPage();
  }
}

class CreateToDoCollectionPage extends StatefulWidget {
  const CreateToDoCollectionPage({super.key});

  static const pageConfig = PageConfig(
    title: 'Create ToDo Collection',
    icon: Icons.add_task_rounded,
    child: CreateToDoCollectionPageProvider(),
  );

  @override
  State<CreateToDoCollectionPage> createState() =>
      _CreateToDoCollectionPageState();
}

class _CreateToDoCollectionPageState extends State<CreateToDoCollectionPage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title!';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Color'),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final parsedColor = int.tryParse(value);
                  if (parsedColor == null || parsedColor < 0 || parsedColor > ToDoColor.predefinedColors.length) {
                    return 'Only numbers between 0 and ${ToDoColor.predefinedColors.length - 1} are allowed!';
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final isValid = _formKey.currentState?.validate();
                if (isValid == true) {
                  // call our cubit
                  context.pop();
                }
              },
              child: const Text('Save Collection'),
            ),
          ],
        ),
      ),
    );
  }
}
