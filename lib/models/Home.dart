import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //variável com a lista de tarefas.
  List _listaTarefas = [];

  //Controller para gerenciar o texto na adição das tarefas
  final TextEditingController _controllerTarefa = TextEditingController();

  // Função privada para fazer a leitura do arquivo com os dados salvos.
  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  //Função privada para salvar as tarefas e gravar as alterações no arquivo.
  _salvarTarefa() {
    String textoDigitado = _controllerTarefa.text;

    Map<String, dynamic> tarefa = <String, dynamic>{};
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;

    setState(
      () {
        _listaTarefas.add(tarefa);
      },
    );

    _salvarArquivo();

    _controllerTarefa.text = "";
  }

  // Função privada para gravar os dados no arquivo json.
  _salvarArquivo() async {
    var arquivo = await _getFile();

    String dados = json.encode(_listaTarefas);
    arquivo.writeAsString(dados);
  }

  //Função privada para ler os dados do arquivo que foi lido pela função _getFile().
  _lerArquivo() async {
    try {
      final arquivo = await _getFile();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  //Ao inicializar a classe, fizemos a leitura de dados de tarefas previamento salvas em outra execução do aplicativo.
  @override
  void initState() {
    super.initState();

    _lerArquivo().then(
      (dados) {
        setState(
          () {
            _listaTarefas = json.decode(dados);
          },
        );
      },
    );
  }

  ///Criamos cada item da lista utilizando um Dismisseble, e como filho um list tile para exibir as informações dos itens.
  ///Junto é criado um snackbar para desfazer a exclusão de um item utilizando a feature do dismisseble.
  Widget criarItemLista(context, index) {
    //Define a cor de cada item com base na cor primária do projeto (Azul)
    Color _getColor(BuildContext context) {
      return _listaTarefas[index]['realizada']
          ? Colors.black54
          : Theme.of(context).primaryColor;
    }

    //Define o estilo dos itens, quando o mesmo á marcado como concluído.
    TextStyle? _getTextStyle(BuildContext context) {
      if (!_listaTarefas[index]['realizada']) return null;

      return const TextStyle(
        color: Colors.black54,
        decoration: TextDecoration.lineThrough,
      );
    }

    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      onDismissed: (direction) {
        String? tituloExluido = _listaTarefas[index]['titulo'];
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Excluir Tarefa"),
              content: Text("Deseja excluir a tarefa '$tituloExluido' ?"),
              actions: <Widget>[
                TextButton(
                  child: const Text("Cancelar"),
                  onPressed: () {
                    //Insere novamente item removido na lista
                    setState(
                      () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                TextButton(
                  child: const Text("Excluir"),
                  onPressed: () {
                    _listaTarefas.removeAt(index);
                    _salvarArquivo();
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      },
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
        ),
      ),
      child: ListTile(
        title: Text(
          _listaTarefas[index]['titulo'],
          style: _getTextStyle(context),
        ),
        leading: CircleAvatar(
          backgroundColor: _getColor(context),
          //child: Text(_listaTarefas[index]['titulo'][0]),
          child: const Icon(Icons.check),
        ),
        onTap: () {
          setState(
            () {
              if (!_listaTarefas[index]['realizada']) {
                _listaTarefas[index]['realizada'] = true;
              } else {
                _listaTarefas[index]['realizada'] = false;
              }
            },
          );
          _salvarArquivo();
        },
        onLongPress: () {
          _controllerTarefa.text = _listaTarefas[index]['titulo'];
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Editar Tarefa"),
                content: TextField(
                  controller: _controllerTarefa,
                  decoration:
                      const InputDecoration(labelText: "Ajuste sua tarefa"),
                  autofocus: true,
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Cancelar"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: const Text("Alterar"),
                    onPressed: () {
                      //salvar
                      if (_controllerTarefa.text.isNotEmpty) {
                        setState(
                          () {
                            _listaTarefas[index]['titulo'] =
                                _controllerTarefa.text;
                          },
                        );
                        _salvarArquivo();
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _escolha(BuildContext context, int item) {
    switch (item) {
      case 0:
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Excluir tarefas'),
              content: const Text('Deseja excluir todas as tarefas?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        _listaTarefas.clear();
                      },
                    );
                    _salvarArquivo();
                    Navigator.pop(context);
                  },
                  child: const Text('Excluir'),
                ),
              ],
            );
          },
        );
        break;
      case 1:
        showAboutDialog(
          context: context,
          applicationName: 'Lista de Tarefas',
          applicationVersion: '1.1.1',
          applicationIcon: const Icon(Icons.info),
          applicationLegalese: 'Criado por: Eder Gross Cichelero',
        );
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    //_salvarArquivo();
    //print("itens: " + DateTime.now().millisecondsSinceEpoch.toString() );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de tarefas"),
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) => _escolha(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Excluir tarefas'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Sobre'),
              )
            ],
          ),
        ],
        //backgroundColor: Colors.yellow,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        //backgroundColor: Colors.yellow,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Adicionar Tarefa"),
                content: TextField(
                  controller: _controllerTarefa,
                  decoration:
                      const InputDecoration(labelText: "Digite sua tarefa"),
                  autofocus: true,
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Cancelar"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: const Text("Adicionar"),
                    onPressed: () {
                      //salvar
                      if (_controllerTarefa.text.isNotEmpty) {
                        _salvarTarefa();
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              );
            },
          );
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: _listaTarefas.length, itemBuilder: criarItemLista),
          )
        ],
      ),
    );
  }
}
