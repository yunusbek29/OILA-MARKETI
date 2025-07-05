import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/bag_bloc/bag_cubit.dart';
import 'package:flutter_application_1/bloc/detail_bloc/detail_cubit.dart';
import 'package:flutter_application_1/bloc/favorite_bloc/favorite_cubit.dart';
import 'package:flutter_application_1/bloc/shop_bloc/shop_cubit.dart';
import 'package:flutter_application_1/bloc/profile_bloc/profile_cubit.dart';
import 'package:flutter_application_1/ui/screens/splash/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShopCubit>(create: (_) => ShopCubit()),
        BlocProvider<BagCubit>(create: (_) => BagCubit()),
        BlocProvider<ProfileCubit>(create: (_) => ProfileCubit()),
        BlocProvider<DetailCubit>(create: (_) => DetailCubit()),
        BlocProvider<FavoriteCubit>(create: (_) => FavoriteCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Oila Market',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
