import '../models/sensors/descriptions_entity.dart';
import '../models/sensors/sensors_entity.dart';
import '../models/sensors/soil_table/soil_row_entity.dart';
import '../models/sensors/soil_table/soil_row_values_entity.dart';
import '../models/sensors/soil_table/soil_table_entity.dart';

abstract class SensorsCalculus {
  static List<SensorsEntity> sensorsCalculus(
      {required List<SensorsEntity> listSensor}) {
    List<SensorsEntity> sensorsModify = [];
    for (var sensor in listSensor) {
      sensor.descriptions.sort(
        (a, b) => a.index!.compareTo(b.index!),
      );
      SoilTableEntity soilTable = SoilTableEntity();
      List<DescriptionSensorsEntity> descriptionsModify = [];
      String? batteryModify;
      for (var description in sensor.descriptions) {
        if (description.depth == null) {
          batteryModify = _getBattery(itemDescription: description);
          final descriptionSensor = description.copyWith(
            itemSensor: description.name,
            value: _checkParse(description: description),
          );
          descriptionsModify.add(descriptionSensor);
        } else {
          soilTable = _makeSoilTable(
            soilTable: soilTable,
            soilDescription: description,
          );
        }
      }
      final newSensor = sensor.copyWith(
        descriptions: descriptionsModify,
        soilTable: soilTable,
        battery: batteryModify,
      );
      sensorsModify.add(newSensor);
    }
    return sensorsModify;
  }

  static String _checkParse({
    required DescriptionSensorsEntity description,
  }) {
    if (description.value != null) {
      final parsed = double.tryParse(description.value!);
      if (parsed != null) {
        return parsed.toStringAsFixed(1);
      }
    }
    return '-';
  }

  static SoilTableEntity _makeSoilTable({
    required DescriptionSensorsEntity soilDescription,
    required SoilTableEntity soilTable,
  }) {
    SoilRowValuesEntity soilRowValue = SoilRowValuesEntity(
      value: _checkParse(
        description: soilDescription,
      ),
    );
    if (soilDescription.name!.contains('st')) {
      soilTable.headerTable = _searchAndAddSoilTableHeader(
        soilTableHeader: soilTable.headerTable ?? [],
        soilEnum: 'temp',
      );
      soilRowValue.typeSoil = 'temp';
    } else if (soilDescription.name!.contains('vwc')) {
      soilTable.headerTable = _searchAndAddSoilTableHeader(
        soilTableHeader: soilTable.headerTable ?? [],
        soilEnum: 'humidity',
      );
      soilRowValue.typeSoil = 'humidity';
    } else if (soilDescription.name!.contains('vic')) {
      soilTable.headerTable = _searchAndAddSoilTableHeader(
        soilTableHeader: soilTable.headerTable ?? [],
        soilEnum: 'ions',
      );
      soilRowValue.typeSoil = 'ions';
    } else if (soilDescription.name!.contains('ec')) {
      soilTable.headerTable = _searchAndAddSoilTableHeader(
        soilTableHeader: soilTable.headerTable ?? [],
        soilEnum: 'condutivity',
      );
      soilRowValue.typeSoil = 'condutivity';
    }
    soilTable.soilVariables = _searchAndAddSoilRow(
      soilDescription: soilDescription,
      soilVariables: soilTable.soilVariables ?? [],
      soilRowValue: soilRowValue,
    );
    return soilTable;
  }

  static List<String> _searchAndAddSoilTableHeader({
    required List<String> soilTableHeader,
    required String soilEnum,
  }) {
    final resultSearch = soilTableHeader.firstWhere(
      (element) => element == soilEnum,
      orElse: () => '',
    );
    if (resultSearch.isEmpty) {
      soilTableHeader = [...soilTableHeader, soilEnum];
    }
    return soilTableHeader;
  }

  static List<SoilRowEntity> _searchAndAddSoilRow({
    required DescriptionSensorsEntity soilDescription,
    required List<SoilRowEntity> soilVariables,
    required SoilRowValuesEntity soilRowValue,
  }) {
    final resultSearchDepth = soilVariables.indexWhere(
      (element) => element.depth == soilDescription.depth,
    );
    if (resultSearchDepth == -1) {
      soilVariables = [
        ...soilVariables,
        SoilRowEntity(
          depth: soilDescription.depth,
          soilRowValues: [
            soilRowValue,
          ],
        ),
      ];
    } else {
      soilVariables[resultSearchDepth].soilRowValues.add(soilRowValue);
    }
    return soilVariables;
  }

  static String? _getBattery({
    required DescriptionSensorsEntity itemDescription,
  }) {
    if (itemDescription.name == 'bv1') {
      return itemDescription.value;
    }
    return null;
  }
}
