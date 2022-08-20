import 'package:flutter/material.dart';
import 'package:petjoo/modules/user/view/login_view.dart';

class PleaseAuth extends StatelessWidget {
  const PleaseAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Oturum Açın'),
      content: const Text('Bu özelliği kullanabilmek için lütfen oturum açın.'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Kapat')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginView()));
            },
            child: const Text('Oturum Aç')),
      ],
    );
  }
}
