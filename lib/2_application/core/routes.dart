import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/2_application/core/go_router_observer.dart';
import 'package:todo_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/home/bloc/navigation_todo_cubit.dart';
import 'package:todo_app/2_application/pages/home/home_page.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

const String _basePath = '/home';

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '$_basePath/${DashboardPage.pageConfig.title}',
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      name: SettingsPage.pageConfig.title,
      path: '$_basePath/${SettingsPage.pageConfig.title}',
      builder: (context, state) => const SettingsPage(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: HomePage.pageConfig.title,
          path: '$_basePath/:tab',
          builder: (context, state) => HomePage(
            key: state.pageKey,
            tab: state.pathParameters['tab'] ?? 'dashboard',
          ),
        ),
      ],
    ),
    GoRoute(
      name: CreateToDoCollectionPage.pageConfig.title,
      path: '$_basePath/overview/${CreateToDoCollectionPage.pageConfig.title}',
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('create collection'),
          leading: BackButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.goNamed(
                  HomePage.pageConfig.title,
                  pathParameters: {'tab': OverviewPage.pageConfig.title},
                );
              }
            },
          ),
        ),
        body: SafeArea(child: CreateToDoCollectionPage.pageConfig.child),
      ),
    ),
    GoRoute(
      name: ToDoDetailPage.pageConfig.title,
      path: '$_basePath/overview/:collectionId',
      builder: (context, state) {
        return BlocListener<NavigationToDoCubit, NavigationToDoCubitState>(
          listenWhen: (previous, current) =>
              previous.isSecondBodyDisplayed != current.isSecondBodyDisplayed,
          listener: (context, state) {
            if (context.canPop() && (state.isSecondBodyDisplayed ?? false)) {
              context.pop();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('details'),
              leading: BackButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.goNamed(
                      HomePage.pageConfig.title,
                      pathParameters: {'tab': OverviewPage.pageConfig.title},
                    );
                  }
                },
              ),
            ),
            body: ToDoDetailPageProvider(
              key: state.pageKey,
              collectionId: CollectionId.fromUniqueString(
                state.pathParameters['collectionId'] ?? '',
              ),
            ),
          ),
        );
      },
    ),
  ],
);
