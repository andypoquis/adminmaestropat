import 'package:adminmaestropat/app/data/models/unit_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/products_controller.dart';
import '../../../data/models/modul_model.dart';

class ProductPage extends GetView<ProductsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 100,
        width: 500,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(
              () => SizedBox(
                width: 150,
                child: FloatingActionButton(
                  onPressed: () => controller.isEditing.value
                      ? controller.updateProduct()
                      : controller.addProduct(),
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
                ? SizedBox(
                    width: 150,
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: () => controller.deleteproduct(),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Eliminar',
                            style: TextStyle(color: Colors.white),
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
          controller.isEditing.value ? 'Editar producto' : 'Nuevo producto',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              inputWidget('Nombre del Producto', controller.productController,
                  controller.productNameFocused, context),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                child: Obx(
                  () => DropdownButton<String>(
                    dropdownColor: Colors.white,
                    hint: const Text('Ingresar unidad de medida'),
                    isExpanded: true,
                    underline: const SizedBox(),
                    style: const TextStyle(color: Colors.black),
                    value: controller.unitSelect.value.documentId,
                    onChanged: (value) => controller.updateUnitMeasure(value!),
                    items:
                        controller.unitMeasurement.map((UnitMeasurement unit) {
                      return DropdownMenuItem<String>(
                        value: unit.documentId,
                        child: Text(
                          unit.name!,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                child: Obx(
                  () => DropdownButton<String>(
                    dropdownColor: Colors.white,
                    hint: const Text('Seleccionar módulo'),
                    isExpanded: true,
                    underline: const SizedBox(),
                    style: const TextStyle(color: Colors.black),
                    value: controller.modulSelect.value.documentId,
                    onChanged: (value) => controller.updateModules(value!),
                    items: controller.modules.map((Modul modul) {
                      return DropdownMenuItem<String>(
                        value: modul.documentId,
                        child: Text(
                          modul.name!,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => SizedBox(
                    height: controller.variants.length *
                        75, // Ajusta esta altura según sea necesario
                    child: Obx(() => controller.variants.isNotEmpty
                        ? ListView.separated(
                            padding: const EdgeInsets.all(20),
                            itemBuilder: (context, index) => Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(controller.variants[index]),
                                    IconButton(
                                        onPressed: () =>
                                            controller.deleteVariants(index),
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red[400],
                                        ))
                                  ]),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: controller.variants.length,
                          )
                        : Container()),
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: inputWidget(
                      'Agregar variante',
                      controller.varientController,
                      controller.variantFocused,
                      context,
                    ),
                  ),
                  IconButton(
                      onPressed: () => controller.addVariant(),
                      icon: const Icon(Icons.add))
                ],
              ),
              Obx(() => SizedBox(
                    height: controller.variants.length *
                        75, // Ajusta esta altura según sea necesario
                    child: Obx(() => controller.variants.isNotEmpty
                        ? ListView.separated(
                            padding: const EdgeInsets.all(20),
                            itemBuilder: (context, index) => Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(controller.variants[index]),
                                    IconButton(
                                        onPressed: () =>
                                            controller.deleteVariants(index),
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red[400],
                                        ))
                                  ]),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: controller.variants.length,
                          )
                        : Container()),
                  )),
              const SizedBox(height: 20),
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
