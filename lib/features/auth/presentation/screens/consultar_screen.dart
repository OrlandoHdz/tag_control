import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../datos/datos_consulta.dart';
import '../../../shared/widgets/geometrical_background.dart';

class ConsultarScreen extends StatelessWidget {
  const ConsultarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyles = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              onTap: (value) {
                if (value == 0) {
                  Navigator.pushNamed(context, '/login');
                  return;
                }
                if (value == 1) {
                  Navigator.pushNamed(context, '/buscar');
                  return;
                }
                if (value == 2) {
                  Navigator.pushNamed(context, '/registar');
                  return;
                }
              },
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.person_3),
                    activeIcon: const Icon(Icons.person_3_outlined),
                    label: "Login",
                    backgroundColor: color.primary),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.find_in_page),
                    activeIcon: const Icon(Icons.find_in_page_outlined),
                    label: "Buscar TAG",
                    backgroundColor: color.tertiary),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.app_registration),
                    activeIcon: const Icon(Icons.app_registration_outlined),
                    label: "Registrar TAG",
                    backgroundColor: color.secondary),
              ]),
          body: GeometricalBackground(
              child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                // Icon Banner
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/buscar');
                        },
                        icon: const Icon(Icons.arrow_back_rounded,
                            size: 40, color: Colors.white)),
                    const Spacer(flex: 1),
                    Text('Consultando',
                        style: textStyles.titleMedium
                            ?.copyWith(color: Colors.white)),
                    const Spacer(flex: 2),
                  ],
                ),

                const SizedBox(height: 50),

                Container(
                  height:
                      size.height - 260, // 80 los dos sizebox y 100 el ícono
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(100)),
                  ),
                  child: const _DatosForm(),
                )
              ],
            ),
          ))),
    );
  }
}

class _DatosForm extends StatelessWidget {
  const _DatosForm();

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: ListView.builder(
            itemCount: datDatosConsulta.length,
            itemBuilder: (context, index) {
              final dato = datDatosConsulta[index];
              return ListTile(
                leading: Icon(dato.icon, color: colors.primary),
                title: Text(
                  dato.titulo,
                  style: textStyles.bodyLarge,
                ),
                subtitle: Text(
                  dato.valor,
                  style: textStyles.titleSmall,
                ),
              );
            }));
  }
}
