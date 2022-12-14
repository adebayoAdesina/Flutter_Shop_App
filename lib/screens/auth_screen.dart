import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/exception/http_exception.dart';
import 'package:shop_app/providers/auth.dart';

enum AuthMode { signUp, logIn }

class AuthScreen extends StatelessWidget {
  static const id = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  const Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'MyShop',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                  Flexible(flex: size.width > 600 ? 2 : 1, child: const AuthCard())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.logIn;
  final Map<String, String> _authData = {'email': '', 'password': ''};
  bool _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController? animationController;
  Animation<Size>? animation;
  Animation<double>? opacityAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    animation = Tween<Size>(
      begin: const Size(double.infinity, 260),
      end: const Size(double.infinity, 320),
    ).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Curves.easeInExpo,
      ),
    );
    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.bounceOut));
    // animation!.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  Future<void> submit() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.signUp) {
        await context.read<AuthMethod>().signUp(
              _authData['email'] as String,
              _authData['password'] as String,
              context
            );
      } else {
        await context.read<AuthMethod>().signin(
              _authData['email'] as String,
              _authData['password'] as String,
              context
            );
      }
      // Navigator.pushReplacementNamed(context, ProductOviewViewScreen.id);
    } on HttpException catch (e) {
      var errorMessage = 'Authentication failed';
      if (e.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use';
      } else if (e.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This email address is inValid';
      } else if (e.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      }
      _showErrorDialog(errorMessage);
    } catch (e) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.logIn) {
      setState(() {
        _authMode = AuthMode.signUp;
      });
      animationController!.forward();
    } else {
      setState(() {
        _authMode = AuthMode.logIn;
      });
      animationController!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedBuilder(
        animation: animation!,
        builder: (context, _) => Container(
          // height: _authMode == AuthMode.signUp ? 320 : 260,
          height: animation!.value.height,
          constraints: BoxConstraints(minHeight: animation!.value.height),
          width: size.width * 0.75,
          padding: const EdgeInsets.all(16.0),
          child: _,
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                // if (_authMode == AuthMode.signUp)
                AnimatedContainer(
                  constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.signUp ? 60 : 0,
                      maxHeight: _authMode == AuthMode.signUp ? 120 : 0),
                  duration: const Duration(milliseconds: 300),
                  child: FadeTransition(
                    opacity: opacityAnimation!,
                    alwaysIncludeSemantics: true,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.signUp,
                      decoration:
                          const InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: _authMode == AuthMode.signUp
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                            }
                          : null,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => submit(),
                        child: Text(
                          _authMode == AuthMode.logIn ? 'LOGIN' : 'SIGN UP',
                        ),
                      ),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 4.0,
                  )),
                  onPressed: () => _switchAuthMode(),
                  child: Text(
                    '${_authMode == AuthMode.logIn ? 'SIGNUP' : 'LOGIN'} Instead',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
