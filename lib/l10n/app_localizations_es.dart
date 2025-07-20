// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get olaMundo => '¡Hola Mundo!';

  @override
  String get titulo => 'Liza';

  @override
  String get cancelar => 'Cancelar';

  @override
  String get adicionar => 'Para agregar';

  @override
  String get adicionarItem => 'Añadir artículo';

  @override
  String get descricao => 'Descripción';

  @override
  String get erroDescricao => 'Proporcione la descripción.';

  @override
  String get maisOpcoes => 'Mas opciones';

  @override
  String get excluir => 'Borrar';

  @override
  String get excluirItem => 'Eliminar elemento';

  @override
  String get excluirItens => 'Eliminar objetos';

  @override
  String get excluirTodosItens => '¿Desea eliminar todos los elementos?';

  @override
  String get sobre => 'Acerca de';

  @override
  String get dev => 'Creado por: Eder Gross Cichelero';

  @override
  String get editarItem => 'Editar elemento';

  @override
  String get alterar => 'Alterar';

  @override
  String confirmarExclusao(String tituloExluido) {
    return '¿Desea eliminar el elemento $tituloExluido?';
  }
}
