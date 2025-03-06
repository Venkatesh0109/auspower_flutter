import 'package:auspower_flutter/common/widgets/loaders.dart';
import 'package:auspower_flutter/models/currennt_power_machine_data.dart';
import 'package:auspower_flutter/providers/table_provider.dart';
import 'package:auspower_flutter/theme/palette.dart';
import 'package:auspower_flutter/utilities/extensions/context_extention.dart';
import 'package:auspower_flutter/view/dashboardscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SheetViewWidget extends StatefulWidget {
  const SheetViewWidget({super.key});

  @override
  State<SheetViewWidget> createState() => _SheetViewWidgetState();
}

class _SheetViewWidgetState extends State<SheetViewWidget> {
  List<CurrentPowerTableData> employees = [];
  late EmployeeDataSource employeeDataSource;

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    bool isTablet = context.widthFull() >= 600;

    return Consumer<TableProvider>(
      builder: (context, value, child) {
        employees = value.currentpowerTableData;
        employeeDataSource = EmployeeDataSource(employeeData: employees);

        return value.isLoading
            ? const Center(child: Loader())
            : Column(
                children: [
                  // Other content (e.g., header, button, etc.) here if needed
                  isPortrait && context.isMobile()
                      ? Expanded(
                          child: sheetViewDataGrid(),
                        )
                      : sheetViewDataGrid()
                ],
              );
      },
    );
  }

  SfDataGrid sheetViewDataGrid() {
    return SfDataGrid(
      allowTriStateSorting: false,
      allowMultiColumnSorting: false,
      source: employeeDataSource,
      isScrollbarAlwaysShown: true,
      sortingGestureType: SortingGestureType.tap,
      allowSorting: true,
      columnWidthMode: ColumnWidthMode.none,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      horizontalScrollPhysics: const AlwaysScrollableScrollPhysics(),
      verticalScrollPhysics: const AlwaysScrollableScrollPhysics(),
      // onCellTap: (details) {
      //   String columnName = details.column.columnName;

      //   employeeDataSource.sortData(columnName);
      //   setState(() {});
      // },
      columns: <GridColumn>[
        GridColumn(
            columnName: 'S.no',
            allowSorting: false,
            label: Container(
              color: Palette.primary,
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text(
                'S.no',
                style: TextStyle(color: Colors.white),
              ),
            ),
            columnWidthMode: ColumnWidthMode.auto),
        GridColumn(
            columnName: 'Status',
            width: 120,
            allowSorting: true,
            label: Container(
              color: Palette.primary,
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text(
                'Status',
                style: TextStyle(color: Colors.white),
              ),
            ),
            columnWidthMode: ColumnWidthMode.fitByCellValue),
        GridColumn(
          columnName: 'Date',
          sortIconPosition: ColumnHeaderIconPosition.end,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            color: Palette.primary,
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: const Text(
              'Date',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        GridColumn(
          columnName: 'Meter',
          sortIconPosition: ColumnHeaderIconPosition.end,
          width: 200,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            color: Palette.primary,
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'Meter',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        GridColumn(
            columnName: 'Slave Id',
            allowSorting: true,
            label: Container(
              color: Palette.primary,
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text(
                'Slave Id',
                style: TextStyle(color: Colors.white),
              ),
            ),
            columnWidthMode: ColumnWidthMode.auto),
        GridColumn(
            columnName: 'C.KWH',
            allowSorting: true,
            label: Container(
              color: Palette.primary,
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text(
                'C.KWH',
                style: TextStyle(color: Colors.white),
              ),
            ),
            columnWidthMode: ColumnWidthMode.auto),
        GridColumn(
          columnName: 'Energy',
          sortIconPosition: ColumnHeaderIconPosition.end,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            color: Palette.primary,
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'Energy',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        GridColumn(
          columnName: 'kva',
          sortIconPosition: ColumnHeaderIconPosition.end,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            color: Palette.primary,
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'kva',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        GridColumn(
          columnName: 'Average Powerfactor',
          sortIconPosition: ColumnHeaderIconPosition.end,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            color: Palette.primary,
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'Avg PF',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        GridColumn(
          columnName: 'Power(kw)',
          sortIconPosition: ColumnHeaderIconPosition.end,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            color: Palette.primary,
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'Power(kw)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        GridColumn(
          columnName: 'Meter Type',
          sortIconPosition: ColumnHeaderIconPosition.end,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            color: Palette.primary,
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: const Text(
              'Meter Type',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        GridColumn(
          sortIconPosition: ColumnHeaderIconPosition.end,
          columnName: 'IP Address',
          width: 150,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            color: Palette.primary,
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: const Text(
              'IP Address',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
