import 'package:flutter/material.dart';
import 'textfield.dart';
import 'package:call_log/call_log.dart';
import 'logs.dart';
import 'package:intl/intl.dart';

class PhonelogsScreen extends StatefulWidget {
  @override
  _PhonelogsScreenState createState() => _PhonelogsScreenState();
}

class _PhonelogsScreenState extends State<PhonelogsScreen>
    with WidgetsBindingObserver {
  //Iterable<CallLogEntry> entries;
  PhoneTextField pf = new PhoneTextField();
  CallLogs cl = new CallLogs();

  late AppLifecycleState _notification;
  late Future<Iterable<CallLogEntry>> logs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    logs = cl.getCallLogs();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if (AppLifecycleState.resumed == state) {
      setState(() {
        logs = cl.getCallLogs();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone"),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          pf,
          //TextField(controller: t1, decoration: InputDecoration(labelText: "Phone number", contentPadding: EdgeInsets.all(10), suffixIcon: IconButton(icon: Icon(Icons.phone), onPressed: (){print("pressed");})),keyboardType: TextInputType.phone, textInputAction: TextInputAction.done, onSubmitted: (value) => call(value),),
          FutureBuilder(
            future: logs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  Iterable<CallLogEntry> entries = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Card(
                            child: ListTile(
                              leading: cl.getAvator(
                                  entries.elementAt(index).callType!),
                              title: cl.getTitle(entries.elementAt(index)),
                              subtitle: Text(DateFormat.yMMMd().add_jm().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                          entries.elementAt(index).timestamp ??
                                              0,
                                        ),
                                      ) +
                                  "\n" +
                                  cl.getTime(
                                      entries.elementAt(index).duration ?? 0)),
                              isThreeLine: true,
                              trailing: IconButton(
                                  icon: Icon(Icons.phone),
                                  color: Colors.blueAccent,
                                  onPressed: () {
                                    cl.call(entries.elementAt(index).number!);
                                  }),
                            ),
                          ),
                          onLongPress: () => pf.update(
                            entries.elementAt(index).number.toString(),
                          ),
                        );
                      },
                      itemCount: entries.length,
                    ),
                  );
                } else {
                  // Handle the case where snapshot.data is null
                  return Center(child: CircularProgressIndicator());
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
