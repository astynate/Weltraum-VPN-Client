import 'package:flutter/material.dart';
import 'package:weltraum/classes/application/application_state.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.state,
  });

  final ApplicationState state;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.25),
      child: state.account?.avatar == null || state.account!.avatar.isEmpty
          ? const Icon(
              Icons.person,
              size: 50,
              color: Color.fromRGBO(255, 255, 255, 0.25),
            )
          : ClipOval(
              child: Image.network(
                state.account?.avatar ?? "",
                width: 98,
                height: 98,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.person,
                    size: 50,
                    color: Color.fromRGBO(255, 255, 255, 0.25),
                  );
                },
              ),
            ),
    );
  }
}