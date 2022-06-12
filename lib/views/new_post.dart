import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:melhor_negocio/views/widgets/custom_button.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final List<File> _imageList = [];
  final _formKey = GlobalKey<FormState>();

  Future _imagePicker() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      final pickedImageFile = File(pickedImage.path);
      setState(() {
        _imageList.add(pickedImageFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo anúncio"),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FormField<List>(
                builder: (state) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _imageList.length + 1,
                              itemBuilder: (context, indice) {
                                if (indice == _imageList.length) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          _imagePicker();
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey[400],
                                          radius: 50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(Icons.add_a_photo,
                                                  size: 40,
                                                  color: Colors.grey[100]),
                                              Text(
                                                "Adicionar",
                                                style: TextStyle(
                                                    color: Colors.grey[100]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                }

                                if (_imageList.isNotEmpty) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                        child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Image.file(
                                                            _imageList[indice]),
                                                        TextButton(
                                                          child: const Text(
                                                            "Excluir",
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _imageList
                                                                  .removeAt(
                                                                      indice);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                          },
                                                        )
                                                      ],
                                                    )));
                                          },
                                          child: CircleAvatar(
                                              radius: 50,
                                              backgroundImage:
                                                  FileImage(_imageList[indice]),
                                              child: Container(
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 0.4),
                                                alignment: Alignment.center,
                                                child: const Icon(Icons.delete,
                                                    color: Colors.red),
                                              ))));
                                }
                                return Container();
                              })),
                      if (state.hasError)
                        Text(
                          "[${state.errorText}]",
                          style:
                              const TextStyle(color: Colors.red, fontSize: 14),
                        )
                    ],
                  );
                },
                initialValue: _imageList,
                validator: (images) {
                  if (images!.isEmpty) {
                    return "Selecione uma imagem";
                  }
                  return null;
                },
              ),
              Row(
                children: const <Widget>[
                  Text("Estado"),
                  Text("Categoria"),
                ],
              ),
              const Text("Caixas de Texto"),
              CustomButton(
                  text: "Cadastrar anúncio",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  })
            ],
          ),
        ),
      )),
    );
  }
}
