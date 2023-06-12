import 'dart:io';

import 'package:csv/csv.dart';

String getInputFileName() {
  print('Enter the input file name (including .csv extension)');
  return stdin.readLineSync()?.trim() ?? "";
}

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

void writeOutputToFile(List<List<dynamic>> output, String fileName) {
  final csvContent = ListToCsvConverter(eol: "\n").convert(output);
  final outputFile = File("./outputs/$generateUniqueFileName(fileName)");
  outputFile.writeAsStringSync(csvContent);
}
