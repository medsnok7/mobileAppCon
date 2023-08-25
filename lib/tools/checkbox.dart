
import 'package:mobileappconcorde/tools/tool_exports.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({super.key});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: isChecked,
        activeColor: Colors.blue,
        tristate: true,
        onChanged: (newBool) {
          setState(() {
            isChecked = newBool;
          });
        });
  }
}
