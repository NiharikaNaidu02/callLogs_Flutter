import 'package:flutter/material.dart';

import 'logs.dart';

class PhoneTextField extends StatefulWidget {
  late Function update;

  @override
  _PhoneTextFieldState createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  TextEditingController t1 = TextEditingController();
  CallLogs cl = new CallLogs();
  bool empty = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.update = (text) {
      print('called: ' + text);

      setState(() {
        t1.text = text;
      });
    };

    t1.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16), // Adjust the height according to your needs
        TextFormField(
          controller: t1,
          decoration: InputDecoration(
            labelText: "Phone number",
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(18),
            suffixIcon: t1.text.length > 0
                ? IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: () {
                      cl.call(t1.text);
                    },
                  )
                : null,
          ),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (value) => {cl.call(t1.text)},
        ),
      ],
    );
  }
}
