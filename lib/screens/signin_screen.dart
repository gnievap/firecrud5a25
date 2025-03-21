import 'package:fire_crud_5a25/screens/pets_screen.dart';
import 'package:fire_crud_5a25/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido a la aplicación de mascotas'),
            ElevatedButton.icon(
              onPressed: () async {
                final credenciales = await _authService.signInWithGoogle();
                print('Usuario: ${credenciales.user?.displayName}');
                print('Correo: ${credenciales.user?.email}');
                // Si todo sale bien, navegar a la pantalla de mascotas
                if ( mounted && credenciales.user != null) {
                 Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => PetsScreen()));
                }                        },
              icon: const Icon(Icons.login),
              label: const Text('Iniciar sesión con Google',
              ),
            ),
          ],
        ),
      ),
    );
  }

}