import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  

  const CustomIconButton({super.key, 
    required this.onPressed,
    required this.icon,
    required this.label,
    
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton.icon(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(60, 60)),
          backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 241, 234, 181)),
        ),
        icon: Icon(icon, color: Colors.black),
        label: Flexible(child: Text(label, style: const TextStyle(color: Colors.black),
       )),
      ),
    );
  }
}