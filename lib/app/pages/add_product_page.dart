import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/drink_model.dart';
import '../../utils/snackbar.dart';
import '../../widgets/custom_Input.dart';
import '../Provider/providers.dart';

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage> {
// Create an image provider with riverpod
  final addImageProvider = StateProvider<XFile?>((_) => null);

  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController priceTextEditingController = TextEditingController();
  TextEditingController drinkAmountTextEditingController =
      TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    _addDrink() async {
      final storage = ref.read(databaseProvider);
      final fileStorage = ref.read(storageProvider); // reference file storage
      final imageFile =
          ref.read(addImageProvider.state).state; // referece the image File
      if (storage == null || fileStorage == null || imageFile == null) {
        print("Error: storage, fileStorage or imageFile is null");
        return;
      }
      // Upload to Filestorage
      final imageUrl = await fileStorage.uploadFile(
        imageFile.path,
      );
      await storage.addDrink(Drink(
        name: titleTextEditingController.text,
        description: descriptionTextEditingController.text,
        drinkNumber: int.parse(drinkAmountTextEditingController.text),
        price: double.parse(priceTextEditingController.text),
        imageUrl: imageUrl,
      ));
      openIconSnackBar(
          context,
          "Drink added successfully",
          const Icon(
            Icons.check,
            color: Colors.white,
          ),
          Colors.green);
      Navigator.pop(context);
    }



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D16D6),
        title: Text('Add Drinks'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(children: [
            CustomInputFieldFb1(
              inputController: titleTextEditingController,
              labelText: 'Drink Name',
              hintText: 'Drink Name',
            ),
            const SizedBox(height: 15),
            CustomInputFieldFb1(
              inputController: priceTextEditingController,
              labelText: 'Price ',
              hintText: 'Price',
            ),
            const SizedBox(height: 15),
            CustomInputFieldFb1(
              inputController: drinkAmountTextEditingController,
              labelText: 'Amount',
              hintText: 'No of drinks',
            ),
            const SizedBox(height: 15),
            CustomInputFieldFb1(
              inputController: descriptionTextEditingController,
              labelText: 'Description',
              hintText: 'Desxription',
            ),
            const SizedBox(height: 15),
            Consumer(
              builder: (context, watch, child) {
                final image = ref.watch(addImageProvider);
                return image == null
                    ? const Text('No image selected')
                    : Image.file(
                        File(image.path),
                        height: 200,
                      );
              },
            ),
            ElevatedButton(
              child: const Text('Upload Image'),
              onPressed: () async {
                final image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  ref.watch(addImageProvider.state).state = image;
                }
              },
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () => _addDrink(), child: const Text("Add Product")),
          ])),
    );
  }
}
