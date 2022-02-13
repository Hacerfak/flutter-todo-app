import 'package:flutter/material.dart';
import 'package:todo/models/Home.dart';

void main() => runApp(
      const MaterialApp(
        home: Home(),
        title: "Lista de Tarefas",
        debugShowCheckedModeBanner: false,
      ),
    );
