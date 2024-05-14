import 'package:flutter/material.dart';
import 'package:ricoletta/models.dart';

class AddAnimalView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddAnimalViewState();
}

class AddAnimalViewState extends State<AddAnimalView> {
  final _formKey = GlobalKey<FormState>();

  String sexo = 'M';
  DateTime? selectedDate = DateTime(2019);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Hero(tag: 'add_animal', child: Icon(Icons.paragliding))),
      body:
      Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16),

        children: [
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: <Widget>[

                Wrap(
                  children: [
                    ListTile(
                        title: Text('Sexo'),
                        trailing: Wrap(
                          children: [Icon(Icons.male), Icon(Icons.female)],
                        )),
                    RadioListTile(
                      title: const Text('Macho'),
                      value: 'M',
                      groupValue: sexo,
                      onChanged: (String? value) {
                        setState(() {
                          sexo = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('Fêmea'),
                      value: 'F',
                      groupValue: sexo,
                      onChanged: (String? value) {
                        setState(() {
                          sexo = value!;
                        });
                      },
                    ),
                  ],
                ),

                Wrap(
                  children: [
                    ListTile(
                      title: Text('Nascimento'),
                      trailing: Icon(Icons.cake),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: InputDatePickerFormField(
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        fieldLabelText: '',
                        fieldHintText:
                        'Entre com a data de nascimento. Pode ser aproximada.',
                        initialDate: selectedDate,
                        onDateSubmitted: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                      ),
                    )
                  ],
                ),


                Wrap(
                  children: [
                    ListTile(
                      title: Text('Abatimento / Falecimento'),
                      trailing: Icon(Icons.cake),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: InputDatePickerFormField(
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        fieldLabelText: '',
                        fieldHintText:
                        'Entre com a data de nascimento. Pode ser aproximada.',
                        initialDate: selectedDate,
                        onDateSubmitted: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                      ),
                    )
                  ],
                ),

                ListTile(
                  title: Text('Id do genitor (opcional)'),
                  trailing: Icon(Icons.paragliding),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      keyboardType: TextInputType.number,

                      decoration: const InputDecoration(
                        labelText: 'Enter your username',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    )),


                Wrap(
                  children: [
                    ListTile(
                      title: Text('Id da genitora (opcional)'),
                      trailing: Icon(Icons.paragliding),

                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        )),
                  ],
                ),
                Container(
                padding: EdgeInsets.all(16),
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );

                          Future.delayed(Duration(seconds: 5)).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Animal cadastrado!'),
                                  backgroundColor: Colors.green),
                            );
                          });
                        }
                      },
                      child: const Text('Cadastrar'),
                    ),
                    width: double.infinity,
                    height: 50,
                  )
                  ,),

              ],
            ),
          ),

      bottomSheet: BottomSheet(
        builder: (BuildContext context) {
          return ListTile(
            leading: Icon(Icons.link),
            title: Text('Conectado como:'),
            trailing: Text('Saulo Oliveira',
                style: TextStyle(fontWeight: FontWeight.bold)),
          );
        },
        onClosing: () {
          print('fechando');
        },
      ),
    );
  }
}
