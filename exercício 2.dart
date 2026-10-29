import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int fator_1 = 1;
  int fator_2 = 1;
  int voltar_fator1 = 1;
  int voltar_fator2 = 1;

  TextEditingController controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(
                  value: fator_2 / 10,
                  color: Colors.red,
                  backgroundColor: Colors.green,
                ),
                const SizedBox(height: 20),
                Text(
                  '$fator_1 * $fator_2',
                  style: const TextStyle(fontSize: 32),
                ),
                TextField(
                  controller: controlador,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                Builder(builder: (interno_context) {
                  return ElevatedButton(
                    onPressed: () {
                      int? resposta = int.tryParse(controlador.text);
                      if (resposta == null) return;

                      ScaffoldMessenger.of(interno_context).clearSnackBars();

                      if (resposta == fator_1 * fator_2) {
                        setState(() {
                          if (fator_2 < 10) {
                            fator_2++;
                          } else {
                            fator_1++;
                            fator_2 = 1;
                          }
                        });
                      } else {
                        voltar_fator1 = fator_1;
                        voltar_fator2 = fator_2;

                        setState(() {
                          fator_1++;
                          fator_2 = 1;
                        });

                        final snackBar = SnackBar(
                          content: const Text('Errou, clique aqui para continuar.'),
                          action: SnackBarAction(
                            label: 'Continuar',
                            onPressed: () {
                              setState(() {
                                fator_1 = voltar_fator1;
                                fator_2 = voltar_fator2;
                              });
                            },
                          ),
                        );

                        ScaffoldMessenger.of(interno_context).showSnackBar(snackBar);
                      }

                      controlador.clear();
                    },
                    child: const Text('Verificar'),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}