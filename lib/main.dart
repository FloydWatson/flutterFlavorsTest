import 'package:flavortest/bootstrap.dart';
import 'package:flavortest/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:provider/provider.dart';

void main() async {
  // set up a flavour to be used within the app
  FlavorConfig(name: "ANDROID", variables: {"type": 1});
  // run Botstrap boot() before app initilisation. This migrates the data base
  await boot();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AppProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // future builder not working as context does notcontain the provider. Need to work out why this is the case
        home:
            // FutureBuilder(
            //   future: Sync.syncEntities(context),
            //   builder: (ctx, snapshot) =>
            //       snapshot.connectionState == ConnectionState.waiting
            //           ? CircularProgressIndicator()
            //           :
            MyHomePage(title: 'Flutter Demo Home Page'),
        // ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    int _type = FlavorConfig.instance.variables["type"];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times: ${_type}',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              Provider.of<AppProvider>(context).firstName(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Sync.syncEntities(context);
          _incrementCounter;
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
