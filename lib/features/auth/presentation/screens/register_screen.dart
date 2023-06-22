import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tag_control/features/shared/shared.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                          Navigator.pushNamed(context, '/login');
                        },
                        icon: const Icon(Icons.arrow_back_rounded,
                            size: 40, color: Colors.white)),
                    const Spacer(flex: 1),
                    Text('Registrar equipaje',
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
                  child: _RegisterForm(),
                )
              ],
            ),
          ))),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController ctrlBoleto = TextEditingController();
  TextEditingController ctlTag = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text('Nuevo registro', style: textStyles.titleMedium),
            const SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                    child: CustomTextFormField(
                  control: ctrlBoleto,
                  label: 'Número de boleto',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Campo requerido';
                    if (value.trim().isEmpty) return 'Campo requerido';
                    return null;
                  },
                )),
                const SizedBox(
                  width: 10,
                ),
                SizedBox.fromSize(
                  size: const Size(56, 56),
                  child: ClipOval(
                    child: Material(
                      color: Colors.amberAccent,
                      child: InkWell(
                        splashColor: Colors.green,
                        onTap: escanearCodigoBoleto,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.qr_code_scanner),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Row(children: [
              Expanded(
                child: CustomTextFormField(
                  control: ctlTag,
                  label: 'Número TAG',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Campo requerido';
                    if (value.trim().isEmpty) return 'Campo requerido';
                    return null;
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox.fromSize(
                size: const Size(56, 56),
                child: ClipOval(
                  child: Material(
                    color: Colors.blueAccent,
                    child: InkWell(
                      splashColor: Colors.green,
                      onTap: escanearCodigoTag,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.qr_code_scanner),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ]),
            const SizedBox(height: 30),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomFilledButton(
                  text: 'Registrar',
                  buttonColor: Colors.black,
                  onPressed: () {
                    final isValid = _formKey.currentState!.validate();
                    if (!isValid) return;

                    ctrlBoleto.clear();
                    ctlTag.clear();

                    const snackBar = SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Registro guradado con exito'),
                      // action: SnackBarAction(
                      //   label: 'Cerrar',
                      //   onPressed: () {
                      //     // Some code to undo the change.
                      //   },
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    // showDialog(
                    //     context: context,
                    //     barrierDismissible: false,
                    //     builder: (context) => AlertDialog(
                    //           title: const Text(" ¿Estás seguro?"),
                    //           content: const Text(
                    //               "Se registraran los datos en la plataforma realizando el match entre el número de boleto con el tag"),
                    //           actions: [
                    //             TextButton(
                    //                 onPressed: () => Navigator.pop(context),
                    //                 child: const Text("Cancelar")),
                    //             FilledButton(
                    //                 onPressed: () {
                    //                   Navigator.pop(context);
                    //                   ctrlBoleto.clear();
                    //                   ctlTag.clear();

                    //                   final snackBar = SnackBar(
                    //                               duration: const Duration(seconds: 4),
                    //                               content: const Text('Registro guradado con exito'),
                    //                               action: SnackBarAction(
                    //                                 label: 'Cerrar',
                    //                                 onPressed: () {
                    //                                   // Some code to undo the change.
                    //                                 },
                    //                               ),
                    //                             );

                    //                   ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    //                 },
                    //                 child: const Text("Aceptar"))
                    //           ],
                    //         ));
                  },
                )),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Future escanearCodigoBoleto() async {
    String resultado;

    try {
      resultado = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", false, ScanMode.BARCODE);
    } on PlatformException {
      resultado = "Fallo escaner";
    }

    setState(() => ctrlBoleto.text = resultado);
  }

  Future escanearCodigoTag() async {
    String resultado;

    try {
      resultado = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", false, ScanMode.BARCODE);
    } on PlatformException {
      resultado = "Fallo escaner";
    }

    setState(() => ctlTag.text = resultado);
  }
}
