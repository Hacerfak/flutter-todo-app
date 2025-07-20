// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get olaMundo => 'Olá Mundo!';

  @override
  String get titulo => 'Listas';

  @override
  String get cancelar => 'Cancelar';

  @override
  String get adicionar => 'Adicionar';

  @override
  String get adicionarItem => 'Adicionar item';

  @override
  String get descricao => 'Descrição';

  @override
  String get erroDescricao => 'Por favor, informe a descrição.';

  @override
  String get maisOpcoes => 'Mais opções';

  @override
  String get excluir => 'Excluir';

  @override
  String get excluirItem => 'Excluir item';

  @override
  String get excluirItens => 'Excluir itens';

  @override
  String get excluirTodosItens => 'Deseja excluir todos os itens?';

  @override
  String get sobre => 'Sobre';

  @override
  String get dev => 'Criado por: Eder Gross Cichelero';

  @override
  String get editarItem => 'Editar item';

  @override
  String get alterar => 'Alterar';

  @override
  String confirmarExclusao(String tituloExluido) {
    return 'Deseja excluir o item $tituloExluido?';
  }
}
