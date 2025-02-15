import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'books_collection_view.dart';
import 'books_details_view.dart';
import 'cart_view.dart';
import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'core/common/widgets/loader.dart';
import 'core/theme/app_theme.dart';
import 'features/AI-Assistant/presentation/assistant_cubit/chat_cubit.dart';
import 'features/AI-Assistant/presentation/views/chat_view.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/views/sign_in_view.dart';
import 'features/auth/presentation/views/sign_up_view.dart';
import 'features/home/domain/entities/book.dart';
import 'features/home/presentation/bloc/book_bloc.dart';
import 'features/home/presentation/views/home_view.dart';
import 'features/search/presentation/manager/search_books_cubit/search_books_cubit.dart';
import 'features/search/presentation/views/search_view.dart';
import 'features/splash/presentation/view/splash_view.dart';
import 'init_dependencies.dart';
import 'payement_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<BookBloc>()),
        BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (context) => serviceLocator<ChatCubit>()),

        BlocProvider(create: (context) => SearchBooksCubit()),

        BlocProvider(create: (context) => serviceLocator<AppUserCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppUserCubit>(
      context,
    ).updateUser(serviceLocator<Box>().get('posterId').toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: BlocConsumer<AppUserCubit, AppUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AppUserLoggedIn) {
            // return BooksCollectionView(books: [
            //   Book(id: 1, title: 'Book 1', author: 'Author 1', price: 10, url: '', description: ''),
            //   Book(id: 2, title: 'Book 2', author: 'Author 2', price: 15 ,url: '', description: ''),
            //   Book(id: 3, title: 'Book 3', author: 'Author 3', price: 20, url: '', description: ''),
            // ],collectionName: '',);
            return HomeView();
          } else if (state is AppUserLoading) {
            return Loader();
          }
          return SignInView();
        },
      ),
    );
  }
}
