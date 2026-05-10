import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../../../core/routes/route_names.dart';

import '../../../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends ConsumerState<LoginScreen> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool isLoading = false;

  Future<void> login() async {

    setState(() {
      isLoading = true;
    });

    try {

      final authService = ref.read(
        authServiceProvider,
      );

      final response =
          await authService.login(
        email:
            emailController.text.trim(),

        password:
            passwordController.text.trim(),
      );

      if (response["success"] == true) {

        if (!mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text("Login Success"),
          ),
        );

        context.go(RouteNames.home);

      } else {

        if (!mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
              response["message"],
            ),
          ),
        );
      }
    } catch (error) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 60),

              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Login to continue",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller:
                    emailController,

                decoration:
                    const InputDecoration(
                  hintText: "Email",
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller:
                    passwordController,

                obscureText: true,

                decoration:
                    const InputDecoration(
                  hintText: "Password",
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                height: 55,

                child: ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : login,

                  child:
                      isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Login",
                            ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  const Text(
                    "Don't have an account?",
                  ),

                  TextButton(
                    onPressed: () {
                      context.go(
                        RouteNames.signup,
                      );
                    },

                    child: const Text(
                      "Signup",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}