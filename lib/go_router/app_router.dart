import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    // Nested routes
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ScreenA();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/b',
          builder: (BuildContext context, GoRouterState state) {
            return const ScreenB();
          },
        ),
      ],
    ),
    // Route with path parameters
    GoRoute(
      path: '/c/:id',
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['id'];
        return ScreenC(id: id != null ? int.parse(id) : null);
      },
    ),
    // Route with query parameters
    GoRoute(
      path: '/d',
      builder: (BuildContext context, GoRouterState state) {
        final keyword = state.uri.queryParameters['keyword'];
        return ScreenD(keyword: keyword);
      },
    ),
    GoRoute(
      path: '/e',
      builder: (BuildContext context, GoRouterState state) {
        final userMap = state.extra as Map<String, dynamic>?;

        final user = userMap != null ?  User.fromJson(userMap) : null;

        return ScreenE(user: user);
      },
    ),
  ],
  redirect: (context, state) {
    // final isLoggedIn = AuthService.instance.isLoggedIn;
    // final isGoingToLogin = state.matchedLocation == '/login';
    
    // // Redirect to login if not authenticated
    // if (!isLoggedIn && !isGoingToLogin) {
    //   return '/login';
    // }
    
    // // Redirect to home if already logged in and going to login
    // if (isLoggedIn && isGoingToLogin) {
    //   return '/';
    // }
    
    return null; // No redirect needed
  },
);
