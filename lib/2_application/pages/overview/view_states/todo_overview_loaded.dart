import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/2_application/pages/home/bloc/navigation_todo_cubit.dart';

class ToDoOverviewLoaded extends StatelessWidget {
  const ToDoOverviewLoaded({super.key, required this.collections});

  final List<ToDoCollection> collections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final item = collections[index];
        final colorScheme = Theme.of(context).colorScheme;
 
        return BlocBuilder<NavigationToDoCubit, NavigationToDoCubitState>(
          buildWhen: (previous, current) => previous.selectedCollectionId != current.selectedCollectionId,  
          builder: (context, state) {
            return ListTile(
              tileColor: colorScheme.surface,
              selectedTileColor: colorScheme.surfaceContainerHighest,
              iconColor: item.color.color,
              selectedColor: item.color.color,
              selected: state.selectedCollectionId == item.id,
              onTap: () {
                context
                    .read<NavigationToDoCubit>()
                    .selectedToDoCollectionChanged(item.id);
                if (Breakpoints.small.isActive(context)) {
                  context.pushNamed(
                    ToDoDetailPage.pageConfig.title,
                    pathParameters: {'collectionId': item.id.value},
                  );
                }
              },
              leading: const Icon(Icons.circle),
              title: Text(item.title),
            );
          },
        );
      },
    );
  }
}
