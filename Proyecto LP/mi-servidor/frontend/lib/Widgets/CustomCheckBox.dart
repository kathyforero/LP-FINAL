import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final String text; // Texto asociado al checkbox
  final ValueChanged<bool?>? onChanged; // Callback para manejar cambios
  final bool initialValue; // Valor inicial del checkbox

  const CustomCheckbox({
    super.key,
    required this.text,
    this.onChanged,
    this.initialValue = false,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue; // Inicializa con el valor inicial
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
              if (widget.onChanged != null) {
                widget.onChanged!(value); // Llama al callback si está definido
              }
            });
          },
          activeColor: Colors.purple, // Color cuando está activo
          checkColor: Colors.white, // Color del check dentro del checkbox
        ),
        Text(
          widget.text,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}