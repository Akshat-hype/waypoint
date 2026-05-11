import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../../../core/routes/route_names.dart';

import '../../../providers/auth_provider.dart';

import '../../../models/user_model.dart';

class SignupScreen
    extends ConsumerStatefulWidget {

  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen>
      createState() =>
          _SignupScreenState();
}

class _SignupScreenState
    extends ConsumerState<SignupScreen> {

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool isLoading = false;

  Future<void> signup() async {

    setState(() {
      isLoading = true;
    });

    try {

      final authService = ref.read(
        authServiceProvider,
      );

      final response =
          await authService.signup(
        name:
            nameController.text.trim(),

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
            content: Text(
              "Signup Success",
            ),
          ),
        );

        final token =
    response["token"];

final user =
    response["user"];

await ref
    .read(authNotifierProvider.notifier)
    .saveAuthData(
      token: token,
      user: UserModel.fromJson(user),
    );

if (!mounted) return;

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
                "Create Account",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Signup to continue",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller:
                    nameController,

                decoration:
                    const InputDecoration(
                  hintText: "Name",
                ),
              ),

              const SizedBox(height: 20),

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
                          : signup,

                  child:
                      isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Signup",
                            ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  const Text(
                    "Already have an account?",
                  ),

                  TextButton(
                    onPressed: () {
                      context.go(
                        RouteNames.login,
                      );
                    },

                    child: const Text(
                      "Login",
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