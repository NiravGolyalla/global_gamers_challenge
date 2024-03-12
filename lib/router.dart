import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:global_gamers_challenge/src/gameone.dart';
import 'package:global_gamers_challenge/show_games.dart';

import 'my_home_page.dart';

final router = GoRouter(
  initialLocation: '/',
  errorPageBuilder: (context, state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    );
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(key: Key('startmenu')),
      routes: [
        GoRoute(
          path: 'home',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: ShowGames(key: Key('home')),
              transitionDuration: const Duration(milliseconds: 150),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeIn)),
                  ),
                  child: child),
                );
          },
          // builder: (context, state) => ShowGames(key: Key('home')),
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const Placeholder(key: Key('settings')),
        ),
      ]
    ),
  ],
);