import 'package:default_app/presentation/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

import '../../core/constants/string_constants.dart';
import '../../core/router/router.dart';
import '../../core/themes/app_theme.dart';
import '../shared/loader.dart';
import '../views/auth/sign_in/sign_in_screen.dart';
import '../views/auth/sign_up/sign_up_screen.dart';
import '/presentation/app/bloc/app_bloc.dart';
import 'providers/drawer_selected_index_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        sessionRepository: Injector.appInstance.get(),
        authRepository: Injector.appInstance.get(),
      )..add(CheckIfUserIsAuthenticated()),
      child: const AppBuilder(),
    );
  }
}

class AppBuilder extends StatelessWidget {
  const AppBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!Injector.appInstance.exists<GoRouter>()) {
      Injector.appInstance.registerSingleton<GoRouter>(() {
        return GoRouter(
          debugLogDiagnostics: true,
          routes: routes,
          initialLocation: SplashScreen.routeName,
          refreshListenable:
              GoRouterRefreshStream(context.read<AppBloc>().stream),
          redirect: (contextChild, state) {
            final blocRoute = contextChild.read<AppBloc>().state.initialRoute;
            if (blocRoute == SignUpScreen.routeName) {
              return SignUpScreen.routeName;
            }

            if (state.location == blocRoute) {
              return null;
            }
            final blocStateRoutes = [
              SplashScreen.routeName,
              SignInScreen.routeName,
              HomeScreen.routeName,
              SignInScreen.routeName
            ];

            if (blocStateRoutes.contains(state.location)) {
              return blocRoute;
            }

            if (blocRoute == SignInScreen.routeName) {
              return SignInScreen.routeName;
            }

            return null;
          },
        );
      });
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DrawerSelectedIndexProivder(),
        ),
      ],
      child: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is AppAuthenticatedUserState) {
            Injector.appInstance.get<GoRouter>().push(state.initialRoute);
          }
        },
        child: MaterialApp.router(
          title: nameApp,
          theme: theme,
          debugShowCheckedModeBanner: false,
          routeInformationProvider:
              Injector.appInstance.get<GoRouter>().routeInformationProvider,
          routeInformationParser:
              Injector.appInstance.get<GoRouter>().routeInformationParser,
          routerDelegate: Injector.appInstance.get<GoRouter>().routerDelegate,
        ),
      ),
    );
  }
}
