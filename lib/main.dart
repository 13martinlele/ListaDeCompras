import 'package:flutter/material.dart';

void main() {
  runApp(Lista());
}

class Cliente {
  String nome;
  String categoria;
  String preco;
  String tamanho;

  Cliente(
      {required this.nome,
      required this.categoria,
      required this.preco,
      required this.tamanho});
}

class Lista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Adiciona a imagem do logo
                Image.asset(
                  'imagens/logo.png',
                  height: 244, // Ajuste conforme necessário
                  width: 275, // Ajuste conforme necessário
                ),

                // Adiciona a segunda imagem acima do logo
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Verificar credenciais
                if (_usernameController.text == 'leticia' &&
                    _passwordController.text == 'leticia123') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentListPage()),
                  );
                } else {
                  // Exibir mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Credenciais inválidas')),
                  );
                }
              },
              child: Text('Login'),
            ),
            Text('Leticia Martin'),
          ],
        ),
      ),
    );
  }
}

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  // Lista de alunos (simulando um banco de dados)
  List<Cliente> students = [
    Cliente(
        nome: 'banana', categoria: 'fruta', preco: '2.00', tamanho: 'media'),
    Cliente(
        nome: 'patinho', categoria: 'carne', preco: '20.00', tamanho: 'grande'),
    Cliente(
        nome: 'pao', categoria: 'padaria', preco: '3.00', tamanho: 'pequena'),
    Cliente(
        nome: 'bolo', categoria: 'padaria', preco: '12.00', tamanho: 'pequena'),
    Cliente(
        nome: 'sushi', categoria: 'peixe', preco: '10.00', tamanho: 'pequena'),
    Cliente(
        nome: 'feijao', categoria: 'graos', preco: '17.00', tamanho: 'pequena'),
    Cliente(
        nome: 'macarrao', categoria: 'massa', preco: '5.00', tamanho: 'medio'),
    Cliente(
        nome: 'arroz', categoria: 'graos', preco: '20.00', tamanho: 'medio'),
    Cliente(
        nome: 'água', categoria: 'bebida', preco: '1.00', tamanho: 'grande'),
    Cliente(
        nome: 'morango',
        categoria: 'fruta',
        preco: '10.00',
        tamanho: 'pequena'),
  ];

  bool _isValidCategoria(String categoria) {
    // Validar o formato do email
    final categoriaRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return categoriaRegex.hasMatch(categoria);
  }

  bool _isValidPreco(String preco) {
    // Validar o formato do email
    final categoriaRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return categoriaRegex.hasMatch(preco);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(students[index].nome),
            subtitle: Text(students[index].categoria),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Excluir aluno
                students.removeAt(index);
                // Atualizar a interface
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cliente removido')),
                );
                // Atualizar a lista de alunos
                setState(() {});
              },
            ),
            onTap: () async {
              // Editar o aluno
              Cliente updatedStudent = await showDialog(
                context: context,
                builder: (context) {
                  TextEditingController _nomeController =
                      TextEditingController(text: students[index].nome);
                  TextEditingController _categoriaController =
                      TextEditingController(text: students[index].categoria);
                  TextEditingController _precoController =
                      TextEditingController(text: students[index].preco);
                  TextEditingController _tamanhoController =
                      TextEditingController(text: students[index].tamanho);

                  return AlertDialog(
                    title: Text('Editar Cliente'),
                    content: Column(
                      children: [
                        TextField(
                          controller: _nomeController,
                          decoration: InputDecoration(labelText: 'Nome'),
                        ),
                        TextField(
                          controller: _categoriaController,
                          decoration: InputDecoration(labelText: 'Categoria'),
                        ),
                        TextField(
                          controller: _precoController,
                          decoration: InputDecoration(labelText: 'Preco'),
                        ),
                        TextField(
                          controller: _tamanhoController,
                          decoration: InputDecoration(labelText: 'Tamanho'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Validar e salvar as alterações
                          if (_nomeController.text.isNotEmpty &&
                              _categoriaController.text.isNotEmpty &&
                              _isValidCategoria(_categoriaController.text) &&
                              _precoController.text.isNotEmpty &&
                              _isValidPreco(_precoController.text) &&
                              _tamanhoController.text.isNotEmpty &&
                              _precoController.text ==
                                  _tamanhoController.text) {
                            Navigator.pop(
                              context,
                              Cliente(
                                nome: _nomeController.text.trim(),
                                categoria: _categoriaController.text.trim(),
                                preco: _precoController.text.trim(),
                                tamanho: _tamanhoController.text.trim(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Preencha todos os campos corretamente')),
                            );
                          }
                        },
                        child: Text('Salvar'),
                      ),
                    ],
                  );
                },
              );

              if (updatedStudent != null) {
                // Atualizar o aluno na lista
                students[index] = updatedStudent;
                // Atualizar a interface
                setState(() {});
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Adicionar novo aluno
          Cliente newStudent = await showDialog(
            context: context,
            builder: (context) {
              TextEditingController _nomeController = TextEditingController();
              TextEditingController _categoriaController =
                  TextEditingController();
              TextEditingController _precoController = TextEditingController();
              TextEditingController _tamanhoController =
                  TextEditingController();

              return AlertDialog(
                title: Text('Novo Cliente'),
                content: Column(
                  children: [
                    TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                    TextField(
                      controller: _categoriaController,
                      decoration: InputDecoration(labelText: 'Categoria'),
                    ),
                    TextField(
                      controller: _precoController,
                      decoration: InputDecoration(labelText: 'Preco'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: _tamanhoController,
                      decoration: InputDecoration(labelText: 'Tamanho'),
                      obscureText: true,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_nomeController.text.isNotEmpty &&
                          _categoriaController.text.isNotEmpty &&
                          _isValidCategoria(_categoriaController.text) &&
                          _precoController.text.isNotEmpty &&
                          _isValidPreco(_precoController.text) &&
                          _tamanhoController.text.isNotEmpty &&
                          _precoController.text == _tamanhoController.text) {
                        Navigator.pop(
                          context,
                          Cliente(
                            nome: _nomeController.text.trim(),
                            categoria: _categoriaController.text.trim(),
                            preco: _precoController.text.trim(),
                            tamanho: _tamanhoController.text.trim(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Preencha todos os campos corretamente')),
                        );
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );

          if (newStudent != null) {
            // Adicionar o novo aluno à lista
            students.add(newStudent);

            // Atualizar a tela
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
