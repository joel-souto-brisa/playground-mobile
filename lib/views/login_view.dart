import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_routes.dart';
import 'package:flutter_application_1/core/injection.dart';
import 'package:flutter_application_1/stores/auth_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authStore = getIt<AuthStore>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await _authStore.login(
      _emailController.text.trim(),
      _passwordController.text,
    );
    if (success) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.main);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_authStore.errorMessage ?? 'Não foi possível entrar.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080D17),
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF111C2D),
                      Color(0xFF080D17),
                      Color(0xFF090B12),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -90,
              right: -80,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFD54F).withValues(alpha: 0.06),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: -100,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF8DA8C9).withValues(alpha: 0.08),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 390 || constraints.maxHeight < 700;

                return Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isCompact ? 16 : 24,
                      vertical: isCompact ? 16 : 36,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: const Color(0xFFFFD54F),
                            size: isCompact ? 28 : 36,
                          ),
                          SizedBox(height: isCompact ? 8 : 12),
                          Text(
                            'STAR WARS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFFFD54F),
                              fontSize: isCompact ? 28 : 34,
                              fontWeight: FontWeight.w900,
                              letterSpacing: isCompact ? 3.5 : 5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'ENCICLOPÉDIA GALÁCTICA',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.65),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2.2,
                            ),
                          ),
                          SizedBox(height: isCompact ? 20 : 32),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(isCompact ? 18 : 24),
                            decoration: BoxDecoration(
                              color: const Color(0xE6101724),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.28),
                                  blurRadius: 28,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Acesse a galáxia',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isCompact ? 20 : 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Entre para explorar personagens, planetas e filmes.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.65),
                                      height: 1.4,
                                    ),
                                  ),
                                  SizedBox(height: isCompact ? 20 : 28),
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration(
                                      label: 'E-mail',
                                      icon: Icons.alternate_email,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'Informe seu e-mail';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) {
                                      if (!_authStore.isLoading) _handleLogin();
                                    },
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration(
                                      label: 'Senha',
                                      icon: Icons.lock_outline,
                                    ).copyWith(
                                      suffixIcon: IconButton(
                                        tooltip: _obscurePassword
                                            ? 'Mostrar senha'
                                            : 'Ocultar senha',
                                        color: const Color(0xFFFFD54F),
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword = !_obscurePassword;
                                          });
                                        },
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe sua senha';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: isCompact ? 18 : 24),
                                  Observer(
                                    builder: (_) => FilledButton.icon(
                                      onPressed: _authStore.isLoading
                                          ? null
                                          : _handleLogin,
                                      icon: _authStore.isLoading
                                          ? const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Color(0xFF11151D),
                                              ),
                                            )
                                          : const Icon(
                                              Icons.rocket_launch_outlined,
                                            ),
                                      label: Text(
                                        _authStore.isLoading
                                            ? 'Conectando...'
                                            : 'Entrar',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      style: FilledButton.styleFrom(
                                        foregroundColor: const Color(0xFF11151D),
                                        backgroundColor: const Color(0xFFFFD54F),
                                        disabledBackgroundColor: const Color(
                                          0xFFFFD54F,
                                        ),
                                        disabledForegroundColor: const Color(
                                          0xFF11151D,
                                        ),
                                        minimumSize: const Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.register,
                                      );
                                    },
                                    child: const Text(
                                      'Novo por aqui? Crie sua conta',
                                      style: TextStyle(
                                        color: Color(0xFFFFD54F),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: isCompact ? 16 : 24),
                          Text(
                            'QUE A FORÇA ESTEJA COM VOCÊ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.45),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.65)),
      prefixIcon: Icon(icon, color: const Color(0xFFFFD54F)),
      filled: true,
      fillColor: const Color(0xFF0B111C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFFFD54F), width: 1.5),
      ),
    );
  }
}
