//Copyright (c) 2024 Eder Gross Cichelero

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/models/home.dart';

void main() => runApp(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Home(),
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.titulo,
        debugShowCheckedModeBanner: false,
      ),
    );
