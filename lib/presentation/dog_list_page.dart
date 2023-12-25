import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_cookbook/providers/dog_provider.dart';

class DogListPage extends StatelessWidget {
  DogListPage({Key? key}) : super(key: key);

  final dogNameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton.outlined(
        onPressed: () => addDogModal(context),
        icon: const Icon(
          Icons.add_circle_sharp,
          color: Colors.blue,
        ),
        iconSize: 65.0,
      ),
      body: SafeArea(
          child: Consumer<DogProvider>(builder: (context, dogProvider, _) {
        return FutureBuilder(
            future: dogProvider.getAllDogs(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final dogs = snapshot.data;
                return ListView(
                  children: List.generate(dogs!.length, (index) {
                    return ListTile(
                      title: Text(dogs[index].name),
                      trailing: Text("${dogs[index].age} years"),
                    );
                  }),
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
            }));
      })),
    );
  }

  void addDogModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 10.0,
                right: 10.0),
            child: SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: dogNameController,
                    textCapitalization: TextCapitalization.words,
                    
                  ),
                  TextFormField(),
                ],
              ),
            ),
          );
        });
  }
}
