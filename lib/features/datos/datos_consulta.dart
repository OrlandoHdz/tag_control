import 'package:flutter/material.dart';

class DatosConsulta {
  final String titulo;
  final String valor;
  final IconData icon;

  const DatosConsulta({required this.titulo, required this.valor, required this.icon});
}

const datDatosConsulta = <DatosConsulta>[
  DatosConsulta(titulo: "Número de Boleto", valor: "1400009", icon: Icons.credit_card),
  DatosConsulta(titulo: "Número de TAG", valor: "TAG-20230516-1210-23472", icon: Icons.tag),
  DatosConsulta(titulo: "Asiento", valor: "J16", icon: Icons.chair),
  DatosConsulta(titulo: "Nombre", valor: "Jose Manuel García Treviño", icon: Icons.person),
  DatosConsulta(titulo: "Origen", valor: "Monterrey, NL",icon: Icons.location_city),
  DatosConsulta(titulo: "Destino", valor: "León GTO", icon: Icons.location_on_sharp),
];
