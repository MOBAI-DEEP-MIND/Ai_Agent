import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/loader.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/snack_bar.dart';
import '../../../home/presentation/views/home_view.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_text_field.dart';
import 'sign_up_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            } else if (state is AuthSuccess) {
              // navigate

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeView(),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Loader();
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: double.infinity,
                    decoration:BoxDecoration(image:DecorationImage(image: AssetImage('assets/images/logo.png')) ),
                  ),
                  SizedBox(height: 60),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color : AppPallete.primaryColor),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sign in to continue your reading journey',
                    style: TextStyle(fontSize: 16,   color : AppPallete.primaryColor),
                  ),
                  SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AuthTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email_outlined,
                          validator:
                              (value) => value!.isEmpty ? 'Enter email' : null,
                        ),

                        // Password Field
                        AuthTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed:
                                () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                          ),
                          validator:
                              (value) =>
                                  value!.length < 6
                                      ? 'Minimum 6 characters'
                                      : null,
                        ),
                      ],
                    ),
                  ),

                  // Email Field
                  SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignIn(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:  AppPallete.primaryColor,
                      ),
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                           color : AppPallete.primaryColor
                        ),
                      ),
                      TextButton(
                        onPressed:
                            () => Navigator.of(context).push(MaterialPageRoute(builder: (_)=> SignUpView())),
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
