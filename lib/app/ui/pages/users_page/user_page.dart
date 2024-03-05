import 'package:adminmaestropat/app/data/models/modul_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/users_controller.dart';

class UserPage extends GetView<UsersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 100,
        width: 500,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => SizedBox(
                width: 150,
                child: FloatingActionButton(
                  onPressed: () => controller.isEditing.value
                      ? controller.updateUser()
                      : controller.addUser(),
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
                ? const SizedBox(
                    width: 20,
                  )
                : const SizedBox(
                    width: 0,
                  )),
            Obx(() => controller.isEditing.value
                ? SizedBox(
                    width: 150,
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: () => controller.deleteUser(),
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
        title: Text(
          controller.isEditing.value ? 'Editar Usuario' : 'Nuevo Usuario',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                child: Obx(
                  () => DropdownButton<String>(
                    dropdownColor: Colors.white,
                    hint: const Text('Perfil del usuario'),
                    isExpanded: true,
                    underline: SizedBox(),
                    style: TextStyle(color: Colors.black),
                    value: controller.profileSelect.value.documentId,
                    onChanged: (value) => controller.updateUnitMeasure(value!),
                    items: controller.profiles.map((Modul unit) {
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
              Obx(() => controller.profileSelect.value.name == 'Administrador'
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        inputWidget(
                          'DNI',
                          controller.dniController,
                          context,
                        ),
                        const SizedBox(height: 20),
                        inputWidget(
                          'Email',
                          controller.emailController,
                          context,
                        ),
                        const SizedBox(height: 20),
                        inputWidget(
                          'password',
                          controller.passwordController,
                          context,
                        ),
                        const SizedBox(height: 20),
                        inputWidget(
                          'Nombre Completo',
                          controller.nameController,
                          context,
                        ),
                        const SizedBox(height: 20),
                        inputWidget(
                          'Número de Teléfono',
                          controller.phoneNumberController,
                          context,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        inputWidget(
                          'Nombre Razón social',
                          controller.businessNameController,
                          context,
                        ),
                        const SizedBox(height: 20),
                        inputWidget(
                          'RUC',
                          controller.dniController,
                          context,
                        ),
                        const SizedBox(height: 20),
                        inputWidget(
                          'Email',
                          controller.emailController,
                          context,
                        ),
                        const SizedBox(height: 20),
                        inputWidget(
                          'password',
                          controller.passwordController,
                          context,
                        ),
                        const SizedBox(height: 20),
                        inputWidget(
                          'Nombre Completo',
                          controller.nameController,
                          context,
                        ),
                        const SizedBox(height: 20),
                        inputWidget(
                          'Número de Teléfono',
                          controller.phoneNumberController,
                          context,
                        ),
                      ],
                    )),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputWidget(
    String hintText,
    TextEditingController inputController,
    context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.grey,
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
          // Puedes agregar lógica aquí para manejar el evento onTap
        },
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  Widget inputPasswordWidget(
    String hintText,
    TextEditingController inputController,
    context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.grey,
          width: 1.5,
        ),
      ),
      child: TextField(
        obscureText: true,
        controller: inputController,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
        onChanged: (value) {
          // Puedes agregar lógica aquí para manejar cambios en el texto
        },
        onTap: () {
          // Puedes agregar lógica aquí para manejar el evento onTap
        },
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
