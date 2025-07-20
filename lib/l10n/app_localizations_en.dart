// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get olaMundo => 'Hello World!';

  @override
  String get titulo => 'Lists';

  @override
  String get cancelar => 'Cancel';

  @override
  String get adicionar => 'Add';

  @override
  String get adicionarItem => 'Add item';

  @override
  String get descricao => 'Description';

  @override
  String get erroDescricao => 'Please provide the description.';

  @override
  String get maisOpcoes => 'More options';

  @override
  String get excluir => 'Delete';

  @override
  String get excluirItem => 'Delete item';

  @override
  String get excluirItens => 'Delete items';

  @override
  String get excluirTodosItens => 'Do you want to delete all items?';

  @override
  String get sobre => 'About';

  @override
  String get dev => 'Created by: Eder Gross Cichelero';

  @override
  String get editarItem => 'Edit item';

  @override
  String get alterar => 'Change';

  @override
  String confirmarExclusao(String tituloExluido) {
    return 'Do you want to delete the $tituloExluido item?';
  }
}
