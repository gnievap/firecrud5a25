import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Iniciar sesión con google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn(); 
    // Obtener los detalles de autenticación
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Crear una nueva credencial de acceso con Google
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Regresar la credencial de acceso
    return await _firebaseAuth.signInWithCredential(credential);
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}