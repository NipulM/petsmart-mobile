// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class PriceAndQuantitySection extends StatefulWidget {
  final String price;
  final Function(int) onQuantityChanged;

  const PriceAndQuantitySection({
    super.key, 
    required this.price,
    required this.onQuantityChanged,
  });

  @override
  State<PriceAndQuantitySection> createState() => _PriceAndQuantitySectionState();
}

class _PriceAndQuantitySectionState extends State<PriceAndQuantitySection> {
  TextEditingController quantityController = TextEditingController();
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    quantityController.text = quantity.toString();
  }

  void updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
      quantityController.text = quantity.toString();
      widget.onQuantityChanged(quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "\$${widget.price}",
          style: const TextStyle(
            fontSize: 24,
            fontFamily: 'Roboto Light',
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromARGB(255, 205, 203, 203),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.remove,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 20,
                ),
                onPressed: () {
                  if (quantity > 1) {
                    updateQuantity(quantity - 1);
                  }
                },
              ),
              SizedBox(
                width: 20,
                child: TextField(
                  controller: quantityController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onChanged: (value) {
                    final newQuantity = int.tryParse(value) ?? 1;
                    if (newQuantity >= 1 && newQuantity <= 10) {
                      updateQuantity(newQuantity);
                    }
                  },
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 20,
                ),
                onPressed: () {
                  if (quantity < 10) {
                    updateQuantity(quantity + 1);
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
