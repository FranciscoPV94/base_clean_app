import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/constants.dart';
import '../views/home/home_screen.dart';
import '/presentation/app/bloc/app_bloc.dart';
import '/presentation/app/providers/drawer_selected_index_provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  List<DrawerTileItem> get items => const [
        DrawerTileItem(
            icon: Icons.home_outlined,
            route: HomeScreen.routeName,
            description: 'Estatus general'),
      ];

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: MediaQuery.of(context).size.width * 0.80,
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: GestureDetector(
                //onTap: () => GoRouter.of(context).push(ProfileScreen.routeName),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(kPadding),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.nombre ?? 'Nombre no disponible',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(
                              height: kPadding / 4,
                            ),
                            Text(
                              'Ver perfil',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 10,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 35,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                            child: Text(
                              user.nombre?[0] != null
                                  ? user.nombre![0].toLowerCase()
                                  : '?',
                              style: const TextStyle(
                                fontSize: 30,
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              )),
          ...items.map(
            (item) => DrawerTile(
              tileIndex: items.indexOf(item),
              icon: item.icon,
              onTap: () => GoRouter.of(context).goNamed(item.route),
              title: item.description,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(
              right: kPadding,
              bottom: kPadding,
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                InkWell(
                  onTap: () => context.read<AppBloc>().add(LogoutUser()),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      const SizedBox(
                        width: kPadding / 3,
                      ),
                      Text(
                        'Cerrar Sesión',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).primaryColorDark),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
    required this.tileIndex,
  });

  final String title;
  final void Function() onTap;
  final IconData icon;
  final int tileIndex;

  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        context.watch<DrawerSelectedIndexProivder>().getSelectedIndex;
    final isSelected = tileIndex == selectedIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPadding / 8),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: InkWell(
          child: ListTile(
            minLeadingWidth: 25,
            leading: Icon(
              icon,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColorDark,
              size: 25,
            ),
            title: Text(title,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColorDark,
                    )),
            onTap: () {
              Navigator.of(context).pop();
              onTap();
              Provider.of<DrawerSelectedIndexProivder>(
                context,
                listen: false,
              ).setSelectedIndex(tileIndex);
            },
          ),
        ),
      ),
    );
  }
}

class DrawerTileItem {
  final IconData icon;
  final String route;
  final String description;

  const DrawerTileItem(
      {required this.icon, required this.route, required this.description});
}
