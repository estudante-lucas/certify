import 'package:certify/shared/exceptions/incorrect_cells_length_error.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TableData extends StatelessWidget {
  const TableData({
    Key? key,
    required this.headers,
    required this.rows,
    required this.onAdd,
  }) : super(key: key);

  final List<String> headers;
  final List<List<Widget>> rows;
  final void Function() onAdd;

  @override
  Widget build(BuildContext context) {
    if (rows.any((row) => row.length != headers.length)) {
      throw IncorrectCellsLengthError();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.topRight,
          child: OutlinedButton(
            onPressed: onAdd,
            child: const Text(
              "Adicionar",
              style: TextStyle(color: AppColors.success),
            ),
          ),
        ),
        DataTable(
          columns: headers
              .map(
                (header) => DataColumn(
                  label: Expanded(
                    child: Text(
                      header,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              )
              .toList(),
          rows: rows
              .map((row) => DataRow(
                    cells: row.map((widget) => DataCell(widget)).toList(),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
