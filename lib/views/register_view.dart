import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/injection.dart';
import 'package:flutter_application_1/stores/auth_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _authStore = getIt<AuthStore>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await _authStore.register(
      _emailController.text.trim(),
      _passwordController.text,
    );
    if (success) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Usuário criado com sucesso! Faça login para continuar.',
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _authStore.errorMessage ?? 'Não foi possível cadastrar.',
          ),
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
                final isCompact =
                    constraints.maxWidth < 390 || constraints.maxHeight < 700;

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
                            'ALISTAMENTO GALÁCTICO',
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
                                    'Criar sua conta',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isCompact ? 20 : 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Cadastre suas credenciais para salvar sua coleção pessoal.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.65,
                                      ),
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
                                      if (value == null ||
                                          value.trim().isEmpty ||
                                          !value.contains('@')) {
                                        return 'Informe um e-mail válido';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    textInputAction: TextInputAction.next,
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
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.length < 6) {
                                        return 'A senha deve ter pelo menos 6 dígitos';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: _obscureConfirmPassword,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) {
                                      if (!_authStore.isLoading) {
                                        _handleRegister();
                                      }
                                    },
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration(
                                      label: 'Confirmar Senha',
                                      icon: Icons.lock_reset_outlined,
                                    ).copyWith(
                                      suffixIcon: IconButton(
                                        tooltip: _obscureConfirmPassword
                                            ? 'Mostrar confirmação'
                                            : 'Ocultar confirmação',
                                        color: const Color(0xFFFFD54F),
                                        icon: Icon(
                                          _obscureConfirmPassword
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureConfirmPassword =
                                                !_obscureConfirmPassword;
                                          });
                                        },
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value != _passwordController.text) {
                                        return 'As senhas não conferem';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: isCompact ? 18 : 24),
                                  Observer(
                                    builder: (_) => FilledButton.icon(
                                      onPressed: _authStore.isLoading
                                          ? null
                                          : _handleRegister,
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
                                              Icons.person_add_alt_1_outlined,
                                            ),
                                      label: Text(
                                        _authStore.isLoading
                                            ? 'Cadastrando...'
                                            : 'Cadastrar',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      style: FilledButton.styleFrom(
                                        foregroundColor: const Color(
                                          0xFF11151D,
                                        ),
                                        backgroundColor: const Color(
                                          0xFFFFD54F,
                                        ),
                                        disabledBackgroundColor: const Color(
                                          0xFFFFD54F,
                                        ),
                                        disabledForegroundColor: const Color(
                                          0xFF11151D,
                                        ),
                                        minimumSize: const Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'Já possui uma conta? Faça login',
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
            Positioned(
              top: 8,
              left: 8,
              child: IconButton(
                tooltip: 'Voltar',
                icon: const Icon(Icons.arrow_back, color: Color(0xFFFFD54F)),
                onPressed: () => Navigator.pop(context),
              ),
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