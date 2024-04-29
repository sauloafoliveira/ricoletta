import 'package:flutter/material.dart';
import 'package:ricoletta/models.dart';

class AnimalCard extends StatelessWidget {
  final int id;

  const AnimalCard({super.key, this.id = 0});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          ListTile(
            title: Icon(Icons.male, color: Colors.blue),
            leading: Text(
              'ID ${id}',
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 50,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Icon(Icons.female), Text('Mãe')],
                  )
                )),
                Container(width: 10,),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Icon(Icons.male), Text('Pai')],
                        )
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListTile(
              leading: Icon(Icons.cake),
              title: Text('10/10/2023', textAlign: TextAlign.end),
            ),
          ),
          Expanded(
            child: ListTile(
              leading: Icon(Icons.accessible),
              title: Text('10/10/2023', textAlign: TextAlign.end),
            ),
          ),

          Expanded(

          child: Container(
            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
            child: ElevatedButton(onPressed: (){
              //Navigator.of(context).push(MaterialPageRoute(builder: ));
            }, child: Text('Ir para os produtos')),
          ),
          )

        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  // load info

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CentralContainer());
  }
}

class CentralContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CentralContainerState();
}

class CentralContainerState extends State<CentralContainer> {
  List<Animal> _animals = [];

  List<AnimalCard> _animalCards = [];

  int _index = 0;

  int animalId = 1;

  String _query = '';

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Yay! A SnackBar!'),
    );

    // first panel
    Widget? tab1 = null;

    if (_animalCards.isEmpty) {
      tab1 = Text(
        'Sem produtos :(',
        textAlign: TextAlign.center,
      );
    } else {
      tab1 = GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: _animalCards,
      );
    }

    return DefaultTabController(
      initialIndex: _index,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ricoleta'),
        ),
        body: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 16),
              child: TextFormField(
                initialValue: _query,
                onChanged: (value) {
                  setState(() {
                    _query = value;
                    _animalCards = _animals
                        .where((e) =>
                            (e.id.toString() == _query) || _query.isEmpty)
                        .map((e) => AnimalCard(id: e.id))
                        .toList();
                  });
                },
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Pesquisar por animais ou produtos",
                  fillColor: Colors.white70,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  tab1,
                  Icon(Icons.adb),
                  Icon(Icons.backpack),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: const TabBar(
          labelColor: Colors.blueGrey,
          indicatorColor: Colors.orangeAccent,
          tabs: [
            Tab(
                icon: Icon(
                  Icons.directions_car,
                  color: Colors.blueGrey,
                ),
                child: Text('Início')),
            Tab(icon: Icon(Icons.directions_transit), child: Text('Animais')),
            Tab(icon: Icon(Icons.directions_bike), child: Text('Produtos')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
          tooltip: 'Increment',
          onPressed: () {
            setState(() {
              animalId++;
              // _animals.add(Animal(animalId, 'F', 2, DateTime.now(),
              //     DateTime.now(), 2, 3, 'Ov'));
              _query = '';
              _animalCards = _animals.map((e) => AnimalCard(id: e.id)).toList();
            });

            showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      AnimalSex? _animalSex = AnimalSex.male;

                      return Container(
                        child: Column(
                          children: [Text('Sexo'), Text('Sexo'), Text('Sexo')],
                        ),
                      );
                    })
                .then((value) =>
                    ScaffoldMessenger.of(context).showSnackBar(snackBar));
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}

enum AnimalSex { male, female }

class AnimalForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnimalFormState();
}

class AnimalFormState extends State<AnimalForm> {
  @override
  Widget build(BuildContext context) {
    AnimalSex? _animalSex = AnimalSex.male;

    return Container(
        width: 600,
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Row(
                children: [
                  RadioListTile<AnimalSex>(
                    title: const Text('Macho'),
                    value: AnimalSex.male,
                    groupValue: _animalSex,
                    onChanged: (AnimalSex? value) {
                      setState(() {
                        _animalSex = value;
                      });
                    },
                  ),
                  RadioListTile<AnimalSex>(
                    title: const Text('Fêmea'),
                    value: AnimalSex.female,
                    groupValue: _animalSex,
                    onChanged: (AnimalSex? value) {
                      setState(() {
                        _animalSex = value;
                      });
                    },
                  ),
                ],
              ),
              Text('Venha')
            ],
          ),
        ));
  }
}
