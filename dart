import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela de Cadastro',
      home: const CadastroScreen(),
    );
  }
}

class CadastroScreen extends StatelessWidget {
  const CadastroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioController = TextEditingController();
    final senhaController = TextEditingController();
    final confirmarSenhaController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usuarioController,
              decoration: const InputDecoration(labelText: 'Usuário'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmarSenhaController,
              decoration: const InputDecoration(labelText: 'Confirmar Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final usuario = usuarioController.text;
                final senha = senhaController.text;
                final confirmarSenha = confirmarSenhaController.text;

                if (senha != confirmarSenha) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('As senhas não coincidem')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Usuário $usuario cadastrado com sucesso!')),
                  );
                }
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}