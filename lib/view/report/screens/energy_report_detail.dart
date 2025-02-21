import 'package:auspower_flutter/providers/power_consumption_provider.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EnergyEntryDetail extends StatefulWidget {
  const EnergyEntryDetail({super.key});

  @override
  State<EnergyEntryDetail> createState() => _EnergyEntryDetailState();
}

class _EnergyEntryDetailState extends State<EnergyEntryDetail> {
  late EnergyEntrySource energyEntrySource;

  List dailyEntry = [
    {"source": "Energy Source"},
    {"source": "Consumption"},
  ];
  List monthlyEntry = [
    {"source": "Energy Source"},
    {"source": "Consumption(Provision)"},
    {"source": "Consumption(Final)"},
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<PowerConsumptionProvider>(
      builder: (context, value, child) {
        List tableValues = 0 == 0 ? dailyEntry : monthlyEntry;
        energyEntrySource =
            EnergyEntrySource(employeeData: tableValues, columns: tableValues);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Energy Entry"),
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SafeArea(
              child: SfDataGrid(
            allowTriStateSorting: true,
            showSortNumbers: true,
            allowMultiColumnSorting: true,
            source: energyEntrySource,
            isScrollbarAlwaysShown: true,
            allowSorting: false,
            columnWidthMode: ColumnWidthMode.auto,
            horizontalScrollPhysics: const AlwaysScrollableScrollPhysics(),
            verticalScrollPhysics: const AlwaysScrollableScrollPhysics(),
            columns: List<GridColumn>.generate(
              tableValues.length,
              (index) {
                final columnName = tableValues[index];
                return GridColumn(
                  columnName: columnName["source"],
                  // width: columnName["field_name"].length > 10
                  //     ? 150
                  //     : double.nan,
                  label: Container(
                    color: Palette.primary,
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: Text(
                      columnName["source"],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          )),
        );
      },
    );
  }
}

class EnergyEntrySource extends DataGridSource {
  final List columns;
  late Map<DataGridRow, Map<String, TextEditingController>> rowControllers;

  EnergyEntrySource(
      {required List<dynamic> employeeData, required this.columns}) {
    _employeeData = employeeData.map<DataGridRow>((e) {
      return DataGridRow(
        cells: columns.map((column) {
          var value = e[column["energy_source_name"]] ?? '';
          return DataGridCell(
              columnName: column["energy_source_name"], value: value);
        }).toList(),
      );
    }).toList();

    // Initialize rowControllers map
    rowControllers = {};

    // Initialize TextEditingControllers for "Consumption" columns
    for (var row in _employeeData) {
      Map<String, TextEditingController> controllersForRow = {};
      for (var column in columns) {
        // Check for columns that require user input (e.g., "Consumption")
        if (column["source"].contains("Consumption")) {
          controllersForRow[column["source"]] = TextEditingController();
        }
      }
      rowControllers[row] = controllersForRow;
    }
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        var displayValue = e.value.toString();

        // Find the controller for the current cell if it's a "Consumption" column
        TextEditingController? controller;
        if (rowControllers[row] != null &&
            rowControllers[row]!.containsKey(e.columnName)) {
          controller = rowControllers[row]![e.columnName];
        }

        // Show TextField for "Consumption" columns
        if (e.columnName.contains("Consumption") && controller != null) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number, // Set input type as required
              decoration: InputDecoration(
                hintText: displayValue, // Show current value as hint
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Optionally, handle value change here if you need to update the row data
              },
            ),
          );
        }

        // Default display for non-Consumption columns
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(displayValue), // Display value for non-editable columns
        );
      }).toList(),
    );
  }

  // Optionally, you can update row data with the new values from the TextEditingController
  void updateRowData(DataGridRow row) {
    for (var column in row.getCells()) {
      if (column.columnName.contains("Consumption")) {
        // Get the value from the controller and update the row data
        var controller = rowControllers[row]?[column.columnName];
        if (controller != null) {
          // Update the row data (you may need to update your data source accordingly)
          // e.g., update the column value in the row with the new value from controller.text
        }
      }
    }
  }
}
