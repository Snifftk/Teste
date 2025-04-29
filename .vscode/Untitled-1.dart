import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CadastroUsuarioPage(),
    debugShowCheckedModeBanner: false,
  ));
}

// 🧾 Tela de Cadastro
class CadastroUsuarioPage extends StatefulWidget {
  @override
  _CadastroUsuarioPageState createState() => _CadastroUsuarioPageState();
}

class _CadastroUsuarioPageState extends State<CadastroUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _idadeController = TextEditingController(); // Bônus: idade
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  bool _aceitaTermos = false;

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      if (_aceitaTermos) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmacaoScreen(
              nome: _nomeController.text,
              idade: _idadeController.text,
            ),
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
    _idadeController.clear();
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
    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(value)) return 'Formato inválido';
    return null;
  }

  String? _validarIdade(String? value) {
    if (value == null || value.trim().isEmpty) return 'Idade obrigatória';
    if (int.tryParse(value) == null || int.parse(value) <= 0) return 'Idade inválida';
    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Senha obrigatória';
    if (value.length < 6) return 'Mínimo de 6 caracteres';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Deve conter letra maiúscula';
    if (!RegExp(r'\d').hasMatch(value)) return 'Deve conter número';
    return null;
  }

  String? _validarConfirmarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Confirme sua senha';
    if (value != _senhaController.text) return 'Senhas não coincidem';
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
                keyboardType: TextInputType.emailAddress,
                validator: _validarEmail,
              ),
              TextFormField(
                controller: _idadeController,
                decoration: InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
                validator: _validarIdade,
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
}

// ✅ Tela de Confirmação
class ConfirmacaoScreen extends StatelessWidget {
  final String nome;
  final String idade;

  const ConfirmacaoScreen({required this.nome, required this.idade, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirmação')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🎉 Usuário $nome cadastrado com sucesso!',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text('Idade: $idade anos', style: TextStyle(fontSize: 16)),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Voltar para a tela anterior
                },
                icon: Icon(Icons.arrow_back),
                label: Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
