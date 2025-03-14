import 'package:fire_crud_5a25/models/pet_model.dart';
import 'package:fire_crud_5a25/services/firestore_service.dart';
import 'package:flutter/material.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {

  // Instancia de FirestoreService
  final FirestoreService _firestoreService = FirestoreService();
  // Controllers para las cajas de texto
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _razaController = TextEditingController();
  final TextEditingController _generoController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();

  void _deletePet(String docId) {
    _firestoreService.deletePet('mascotas', docId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis mascotas - Firebase CRUD'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nombreController,
            decoration: const InputDecoration(
              labelText: 'Nombre',
            ),
          ),
          TextField(
            controller: _tipoController,
            decoration: const InputDecoration(
              labelText: 'Tipo',
            ),
          ),
          TextField(
            controller: _razaController,
            decoration: const InputDecoration(
              labelText: 'Raza',
            ),
          ),
          TextField(
            controller: _generoController,
            decoration: const InputDecoration(
              labelText: 'Género',
            ),
          ),
          TextField(
            controller: _edadController,
            decoration: const InputDecoration(
              labelText: 'Edad',
            ),
          ),
          ElevatedButton(
            onPressed: null,
            child: const Text('Agregar mascota'),
          ),

          // Aquí se mostrarán las mascotas
          Expanded(
            child: StreamBuilder(
              stream: _firestoreService.getPets('mascotas'), 
              builder: (context, AsyncSnapshot<List<PetModel>> snapshot) {
                if (snapshot.hasError) {
                  return  Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  children: snapshot.data!.map( (PetModel pet) {
                    return ListTile(
                      title: Text(pet.nombre),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(pet.tipo),
                          Text(pet.raza),
                          Text(pet.genero),
                          Text(pet.edad.toString()),
                        ],
                      ),
                      onTap: null,
                      trailing: IconButton(
                        onPressed: () => _deletePet(pet.id), 
                        icon: Icon(Icons.delete),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}