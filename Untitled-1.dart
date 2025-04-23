import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CadastroUsuarioPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class CadastroUsuarioPage extends StatefulWidget {
  @override
  _CadastroUsuarioPageState createState() => _CadastroUsuarioPageState();
}

class _CadastroUsuarioPageState extends State<CadastroUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  bool _aceitaTermos = false;

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      if (_aceitaTermos) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('📢 Cadastro realizado com sucesso, ${_nomeController.text}!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Você precisa aceitar os termos de uso.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _limparCampos() {
    _formKey.currentState!.reset();
    _nomeController.clear();
    _emailController.clear();
    _senhaController.clear();
    _confirmarSenhaController.clear();
    setState(() {
      _aceitaTermos = false;
    });
  }

  String? _validarNome(String? value) {
    if (value == null || value.trim().isEmpty) return 'Nome obrigatório';
    if (value.trim().length < 3) return 'Mínimo de 3 caracteres';
    return null;
  }

  String? _validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'E-mail obrigatório';
    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(value)) return 'Formato de e-mail inválido';
    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Senha obrigatória';
    if (value.length < 6) return 'Mínimo de 6 caracteres';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Deve conter uma letra maiúscula';
    if (!RegExp(r'\d').hasMatch(value)) return 'Deve conter um número';
    return null;
  }

  String? _validarConfirmarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Confirme sua senha';
    if (value != _senhaController.text) return 'As senhas não coincidem';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome completo'),
                validator: _validarNome,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: _validarEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: _validarSenha,
              ),
              TextFormField(
                controller: _confirmarSenhaController,
                decoration: InputDecoration(labelText: 'Confirmar senha'),
                obscureText: true,
                validator: _validarConfirmarSenha,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _aceitaTermos,
                    onChanged: (value) {
                      setState(() {
                        _aceitaTermos = value ?? false;
                      });
                    },
                  ),
                  Expanded(child: Text('Aceito os termos de uso')),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _aceitaTermos ? _cadastrar : null,
                child: Text('Cadastrar'),
              ),
              TextButton(
                onPressed: _limparCampos,
                child: Text('Limpar'),
              )
            ],
          ),
        ),
      ),
    );
  }
