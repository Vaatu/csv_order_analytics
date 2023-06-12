import 'package:csv/csv.dart';
import 'dart:io';

import 'package:csv_order_analytics/csv_order_analytics.dart';

void main(List<String> arguments) {
  final inputFileName = getInputFileName();

  final inputFile = File(inputFileName);

  if (!inputFile.existsSync()) {
    print('Error: Input file not found');
    return;
  }
  try {
    final csvContent = inputFile.readAsStringSync();

    final csvConverter = CsvToListConverter(eol: '\n');
    final csvList = csvConverter.convert(csvContent);

    final quantityOutputFileName = "0_$inputFileName";

    final List<List<dynamic>> quantityOutputLines = calculateAverageQuantityPerOrder(csvList);
    writeOutputToFile(quantityOutputLines, quantityOutputFileName);

    final brandOutputFileName = "1_$inputFileName";
    final brandOutputLines = findMostPopularBrand(csvList);

    writeOutputToFile(brandOutputLines, brandOutputFileName);
    print('Quantity output written to $quantityOutputFileName');
    print('Brand output written to $brandOutputFileName');
  } catch (e) {
    print('Error reading or processing the input file: $e');
  }
}
