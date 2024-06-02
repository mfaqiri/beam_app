import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:beam_app/beams.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
        const MyApp({super.key});

        @override
        Widget build (BuildContext context) {
                return ChangeNotifierProvider(
                create:  (context) => BeamAppState(),
                child: MaterialApp(
                        title: 'Beam App',
                        theme: ThemeData(
                         useMaterial3: true,
                         colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
                        ),
                        home: const BeamApp()
                ),
                );
        }


}

class BeamAppState extends ChangeNotifier {
 var logger = Logger('BeamAppState');

 var beamObject = BeamObject();

 bool canGetCategory() => beamObject.beamType == null ? false : true;

 bool canGetSize() => beamObject.beamType == null || beamObject.beamCategory == null ? false : true;

 void setType(String type) {
        beamObject.beamType = type;
        notifyListeners();
        logger.info('beamType set to ${beamObject.beamType}');
        }

 void setCategory(String category) {
        beamObject.beamCategory = category;
        notifyListeners();
        logger.info('beamCategory set to ${beamObject.beamCategory}');
        }

 void setSize(String size) {
        beamObject.beamSize = size;
        notifyListeners();
        logger.info('beamSize set to ${beamObject.beamSize}');
        }

 List<DropdownMenuEntry<String>> getCategory()
        {
               return beamMap[beamObject.beamType]?.keys.map<DropdownMenuEntry<String>>((String value){
                         return DropdownMenuEntry<String>(value: value, label: value);
                }).toList() ?? List<DropdownMenuEntry<String>>.empty();
        }



 List<DropdownMenuEntry<String>> getSize()
        {
               return beamMap[beamObject.beamType]?[beamObject.beamCategory]?.map<DropdownMenuEntry<String>>((String value){
                       return DropdownMenuEntry<String>(value: value, label: value);
                }).toList() ?? List<DropdownMenuEntry<String>>.empty();
        }

 List<DropdownMenuEntry<String>> getType()
        {
               return beamMap.keys.toList().map<DropdownMenuEntry<String>>((String value){
                                                        return DropdownMenuEntry<String>(value: value, label: value);
                                                }).toList();
        }

}


class BeamApp extends StatefulWidget {
        const BeamApp({super.key});

        @override
        State<BeamApp> createState() => _BeamAppState();
}

class _BeamAppState extends State<BeamApp> {
 @override
 Widget build(BuildContext context) {
 return LayoutBuilder(
  builder: (context, constraints) {
  return Scaffold(
       body: Row( 
       children: [
        Expanded(
        child: Container( 
                color: Theme.of(context).colorScheme.primaryContainer,
                child: BeamSelectionPage(),
        ),
        ),
        ],

     ),

  );
}
);

 }


        

}

class BeamSelectionPage extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
                var beamAppState = context.watch<BeamAppState>();
                return Column(
                                children: <Widget>[
                                        DropdownMenu<String>(
                                                onSelected: (String? value) {
                                                        beamAppState.setType(value!);
                                                },
                                                dropdownMenuEntries: beamAppState.getType(),
                                        ),
                                        DropdownMenu<String>(
                                                enabled: beamAppState.canGetCategory(),
                                                onSelected: (String? value) {
                                                               beamAppState.setCategory(value!);
                                                },
                                                dropdownMenuEntries: beamAppState.getCategory()
                                        ),
                                        DropdownMenu<String>(
                                                enabled: beamAppState.canGetSize(),
                                                onSelected: (String? value) {
                                                        beamAppState.setSize(value!);
                                                },
                                                dropdownMenuEntries: beamAppState.getSize(), 
                                        ),
                                ]
                        );

        }



}

