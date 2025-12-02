import 'package:flutter/material.dart';
import 'package:planeance/planeance.dart';

class FormEcheance {
  static DropdownButtonFormField<int?> dropMenuEcheance({
    required List<DirectoryModel> listDirectory,
    required void Function(int? value)? onChangedCallback,
    int? initialValue,
  }) {
    return DropdownButtonFormField<int>(
      isExpanded: true,
      initialValue: initialValue,
      decoration: const InputDecoration(
        labelText: "Domaine",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      items: listDirectory
          .map(
            (directory) => DropdownMenuItem<int>(
              value: directory.key,

              child: Text(
               directory.name ,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          )
          .toList(),
      onChanged: onChangedCallback,
    );
  }
}
