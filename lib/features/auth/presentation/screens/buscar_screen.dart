import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tag_control/features/shared/shared.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BuscarScreen extends StatefulWidget {
  const BuscarScreen({super.key});

  @override
  State<BuscarScreen> createState() => _BuscarScreenState();
}

class _BuscarScreenState extends State<BuscarScreen> {
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

                  setState(() {
                    
                    if (value == 0) {
                      Navigator.pushNamed(context, '/login');
                      return;
                    }
                    if (value == 2) {
                      Navigator.pushNamed(context, '/registar');
                      return;
                    }
                  });

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
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back_rounded,
                            size: 40, color: Colors.white)),
                    const Spacer(flex: 1),
                    Text('Buscar equipaje',
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
                  child:  _RegisterForm(),
                )
              ],
            ),
          ))),
    );
  }
}

class _RegisterForm extends StatefulWidget {


  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {

  TextEditingController ctrlBoleto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          // const SizedBox( height: 50 ),
          // Text('Nuevo registro', style: textStyles.titleMedium ),
          const SizedBox(height: 50),

          // const CustomTextFormField(
          //   label: 'Número de boleto o TAG',
          //   keyboardType: TextInputType.number,
          // ),
          // const SizedBox(height: 30),


          Row(
            
            children: [
              Expanded(
                  child: CustomTextFormField(
                control: ctrlBoleto,
                label: 'Número de boleto o TAG',
                keyboardType: TextInputType.number,
              )),
              
              const SizedBox(width: 10,),

              SizedBox.fromSize(
                size: const Size(56, 56),
                child: ClipOval(
                  child: Material(
                    color: Colors.amberAccent,
                    child: InkWell(
                      splashColor: Colors.green,
                      onTap: escanearCodigo,
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

          // const CustomTextFormField(
          //   label: 'Número TAG',
          //   keyboardType: TextInputType.number,
          // ),
          // const SizedBox( height: 30 ),

          SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Buscar',
                buttonColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, '/consultar');
                },
              )),





          const Spacer(flex: 2),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const Text('¿Ya tienes cuenta?'),
          //     TextButton(
          //       onPressed: (){},
          //       child: const Text('Ingresa aquí')
          //     )
          //   ],
          // ),

          // const Spacer( flex: 1),
        ],
      ),
    );
  }
  
  Future escanearCodigo() async {
    String resultado;

    try {
      resultado = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", false, ScanMode.BARCODE);
    } on PlatformException {
      resultado = "Fallo escaner";
    }

    setState(() => ctrlBoleto.text = resultado);
  }

}
