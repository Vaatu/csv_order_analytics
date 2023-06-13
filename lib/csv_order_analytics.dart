import 'dart:io';

import 'package:csv/csv.dart';


/// Prompts the user to enter the input file name and returns it.
/// Returns an empty string if no input is provided.
String getInputFileName() {
  print('Enter the input file name (including .csv extension)');
  return stdin.readLineSync()?.trim() ?? "";
}
/// Calculates the average quantity per order for each product based on the provided order records.
/// Throws an exception with the message "Invalid CSV format" if the CSV format is invalid.
/// Returns a list of lists representing the output CSV data.
List<List<dynamic>> calculateAverageQuantityPerOrder(List<List<dynamic>> records) {
  final productQuantityMap = <String, dynamic>{};
  final List<List<dynamic>> output = [
    ['Product Name', 'Average Quantity per Order']
  ];

  for (final record in records) {
    if (record.length < 5) {
      throw "Invalid CSV format";
    }
    final productName = record[2].toString();
    final quantity = double.tryParse(record[3].toString());
    if (quantity != null) {
      if (productQuantityMap.containsKey(productName)) {
        double newQuantity = productQuantityMap[productName]! + quantity;
        productQuantityMap[productName] = newQuantity;
      } else {
        productQuantityMap[productName] = quantity.toDouble();
      }
    }
  }
  for (var e in productQuantityMap.entries) {
    productQuantityMap[e.key] = e.value / records.length;
  }

  for (var element in productQuantityMap.entries) {
    List<dynamic> row = [element.key, element.value];
    output.add(row);
  }

  return output;
}

/// Finds the most popular brand for each product based on the provided order records.
/// Most popular is defined as the brand with the most total orders for the item, not the quantity purchased.
/// If two or more brands have the same popularity for a product, any one of them is included.
/// Returns a list of lists representing the output CSV data.
List<List<dynamic>> findMostPopularBrand(List<List<dynamic>> records) {
  final products = <String, Map<String, int>>{};
  final List<List<dynamic>> output = [
    ['Product Name', 'Most Popular Brand']
  ];
  for (final record in records) {
    final productName = record[2].toString();
    final brand = record[4].toString();

    if (!products.containsKey(productName)) {
      products[productName] = {brand: 1};
    } else {
      final brandMap = products[productName]!;
      brandMap[brand] = (brandMap[brand] ?? 0) + 1;
      products[productName] = brandMap;
    }
  }
  products.forEach((productName, brandMap) {
    final popularBrands = <String>[];
    int maxOrders = 0;

    brandMap.forEach((brand, orderCount) {
      if (orderCount > maxOrders) {
        maxOrders = orderCount;
        popularBrands.clear();
        popularBrands.add(brand);
      } else if (orderCount == maxOrders) {
        popularBrands.add(brand);
      }
    });

    final popularBrand = popularBrands.join(', ');
    output.add([productName, popularBrand]);
  });

  return output;
}

/// Generates a unique file name by appending a number to the original file name if it already exists.
/// Returns the unique file name.
String generateUniqueFileName(String fileName) {
  var uniqueFileName = fileName;
  var fileNumber = 0;

  while (File(uniqueFileName).existsSync()) {
    fileNumber++;
    final extensionIndex = fileName.lastIndexOf('.');
    final extension = fileName.substring(extensionIndex);

    final fileNameWithoutExtension = fileName.substring(0, extensionIndex);
    uniqueFileName = '$fileNameWithoutExtension($fileNumber)$extension';
  }

  return uniqueFileName;
}

/// Writes the output data to a file.
/// Takes the output data and the file name as input parameters.
void writeOutputToFile(List<List<dynamic>> output, String fileName) {
  final csvContent = ListToCsvConverter(eol: "\n").convert(output);
  final outputFile = File(generateUniqueFileName(fileName));
  outputFile.writeAsStringSync(csvContent);
}
