import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cart_view.dart';
import '../../../../core/common/widgets/loader.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/snack_bar.dart';
import '../../../AI-Assistant/presentation/views/chat_view.dart';
import '../../domain/entities/book.dart';
import '../bloc/book_bloc.dart';
import '../widgets/book_collections.dart';
import '../widgets/categries_list.dart';
import '../widgets/custom_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Book> books = [];
  List<Book> recommendedBooks = [];
  @override
  void initState() {
    context.read<BookBloc>().add(FetchBooks());

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppPallete.primaryColor,
        onPressed: () {
          // Navigate to AddBookScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatView()),
          );
        },
        child: const Icon(
          CupertinoIcons.conversation_bubble,
          color: Colors.white,
        ),
      ),

      body: BlocConsumer<BookBloc, BookState>(
        listener: (context, state) {
          if (state is FetchBooksfailure) {
            return showSnackBar(context, state.errMessage);
          }
        },
        builder: (context, state) {
          if (state is BookLoading) {
            return Loader();
          } else if (state is FetchBooksSuccess ) {
            
          books = state.books;
                      return HomeViewBody(books: books,);
          } else if (state is FetchBooksByAISuccess) {
            books = state.books;
            return HomeViewBody(books: books,);
          } else if (state is FetchBooksInCartfailure) {
            return Center(child: Text('Something went wrong'));
          }
          return HomeViewBody(books: books,);
        },
      ),
    );
  }
}

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.books});

  final List<Book> books;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            busketOnPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => ShoppingCartScreen()));
            },
          ),
          SizedBox(height: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome ibaa ',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: AppPallete.primaryColor,
                ),
              ),
              Text(
                'books way to learn and read ',
                style: TextStyle(color: AppPallete.primaryColor),
              ),
              SizedBox(height: 10),
            ],
          ),

          CategoriesList(selectedTopics: []),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 6),
                BookCollections(collectionName: 'Recommended', books: books),

                const SizedBox(height: 6),
                BookCollections(collectionName: 'Others', books: books),
                // Add more sections here if needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
