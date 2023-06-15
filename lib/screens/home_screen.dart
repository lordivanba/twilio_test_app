import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twilio/providers/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController codeController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Consumer<HomeProvider>(
            builder: (context, provider, child) {
              return buildColumn(
                phoneController,
                provider,
                context,
                codeController,
              );
            },
          )),
    );
  }

  Column buildColumn(
      TextEditingController phoneController,
      HomeProvider provider,
      BuildContext context,
      TextEditingController codeController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                keyboardType: TextInputType.phone,
                maxLength: 10,
                controller: phoneController,
                decoration: const InputDecoration(
                  label: Text("Phone number"),
                  border: OutlineInputBorder(),
                ),
                onChanged: (String value) => provider.setPhoneNumber = value,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(
                120,
                100,
              )),
              onPressed: provider.phoneNumber.length == 10
                  ? () => provider.sendCode(context)
                  : null,
              child: const Text("SEND CODE"),
            )
          ],
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                controller: codeController,
                decoration: const InputDecoration(
                  label: Text("Code"),
                  border: OutlineInputBorder(),
                ),
                onChanged: (String value) => provider.setCode = value,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(
                120,
                100,
              )),
              onPressed: provider.code.length == 6
                  ? () => provider.verifyCode(context)
                  : null,
              child: const Text("VERIFY"),
            )
          ],
        ),
      ],
    );
  }
}
