import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/units_controller.dart';

class UnitPage extends GetView<UnitsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 100,
        width: 500,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(
              () => Container(
                width: 150,
                child: FloatingActionButton(
                  onPressed: () => controller.isEditing.value
                      ? controller.updateUnit()
                      : controller.addUnit(),
                  isExtended: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        controller.isEditing.value ? Icons.edit : Icons.save,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        controller.isEditing.value ? 'Editar' : 'Guardar',
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Obx(() => controller.isEditing.value
                ? Container(
                    width: 150,
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: () => controller.deleteUnit(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Eliminar',
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                : Container())
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.delete))],
        title: Text(
          controller.isEditing.value
              ? 'Editar Unidad de medida'
              : 'Nueva Unidad de medida',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              inputWidget('Nombre', controller.nameController,
                  controller.unitNameFocused, context),
              SizedBox(height: 20),
              inputWidget('Símbolo', controller.symbolController,
                  controller.unitSymbolFocused, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputWidget(
    String hintText,
    TextEditingController inputController,
    RxBool isFocused,
    context,
  ) {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: isFocused.value ? Colors.purple : Colors.grey,
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: inputController,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
            onChanged: (value) {
              // Puedes agregar lógica aquí para manejar cambios en el texto
            },
            onTap: () {
              isFocused.value = true;
            },
            onSubmitted: (value) {
              isFocused.value = false;
            },
            onEditingComplete: () {
              isFocused.value = false;
              FocusScope.of(context).unfocus();
            },
          ),
        ));
  }
}
