import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/2_application/pages/home/bloc/navigation_todo_cubit.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required String tab})
    : index = tabs.indexWhere((element) => element.title == tab);

  static const PageConfig pageConfig = PageConfig(
    icon: Icons.home,
    title: 'Home',
  );

  final int index;

  static const tabs = [
    DashboardPage.pageConfig,
    OverviewPage.pageConfig,
    SettingsPage.pageConfig,
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final destinations = HomePage.tabs
      .map(
        (page) =>
            NavigationDestination(icon: Icon(page.icon), label: page.title),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('primary-navigation-medium'),
                builder: (context) => AdaptiveScaffold.standardNavigationRail(
                  leading: IconButton(
                    onPressed: () {
                      context.pushNamed(
                        CreateToDoCollectionPage.pageConfig.title,
                      );
                    },
                    icon: Icon(CreateToDoCollectionPage.pageConfig.icon),
                    tooltip: 'Add Collection',
                  ),
                  trailing: IconButton(
                    onPressed: () =>
                        context.pushNamed(SettingsPage.pageConfig.title),
                    icon: Icon(SettingsPage.pageConfig.icon),
                  ),
                  selectedLabelTextStyle: TextStyle(
                    color: theme.colorScheme.surface,
                  ),
                  selectedIconTheme: IconThemeData(
                    color: theme.colorScheme.surface,
                  ),
                  unselectedIconTheme: IconThemeData(
                    color: theme.colorScheme.surface.withAlpha(128),
                  ),
                  onDestinationSelected: (index) =>
                      _tapOnNavigationDestination(context, index),
                  selectedIndex: widget.index,
                  destinations: destinations
                      .map(
                        (element) =>
                            AdaptiveScaffold.toRailDestination(element),
                      )
                      .toList(),
                ),
              ),
            },
          ),
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                key: const Key('bottom-navigation-small'),
                builder: (context) =>
                    AdaptiveScaffold.standardBottomNavigationBar(
                      currentIndex: widget.index,
                      destinations: destinations,
                      onDestinationSelected: (index) =>
                          _tapOnNavigationDestination(context, index),
                    ),
              ),
            },
          ),
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.smallAndUp: SlotLayout.from(
                key: const Key('primary-body'),
                builder: (_) => HomePage.tabs[widget.index].child,
              ),
            },
          ),
          secondaryBody: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('secondary-body-medium'),
                builder: widget.index != 1
                    ? null
                    : (_) =>
                          BlocBuilder<
                            NavigationToDoCubit,
                            NavigationToDoCubitState
                          >(
                            builder: (context, state) {
                              final selectedId = state.selectedCollectionId;
                              final isSecondBodyDisplayed = Breakpoints
                                  .mediumAndUp
                                  .isActive(context);

                              context
                                  .read<NavigationToDoCubit>()
                                  .secondBodyHasChanged(
                                    isSecondBodyDisplayed:
                                        isSecondBodyDisplayed,
                                  );

                              if (selectedId == null) {
                                return const Placeholder();
                              }

                              return ToDoDetailPageProvider(
                                key: Key(selectedId.value),
                                collectionId: selectedId,
                              );
                            },
                          ),
              ),
            },
          ),
        ),
      ),
    );
  }

  void _tapOnNavigationDestination(BuildContext context, int index) =>
      context.goNamed(
        HomePage.pageConfig.title,
        pathParameters: {'tab': HomePage.tabs[index].title},
      );
}
