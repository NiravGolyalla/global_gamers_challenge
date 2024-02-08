import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

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
          builder: (context, state) => const Placeholder(key: Key('home')),
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const Placeholder(key: Key('settings')),
        ),
      ]
    ),
  ],
);