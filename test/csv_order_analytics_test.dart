import 'dart:io';

import 'package:csv_order_analytics/csv_order_analytics.dart';
import 'package:test/test.dart';

void main() {
  group('calculateAverageQuantityPerOrder', () {
    test("should calculate the average quantity per order for each product", () {
      final records = [
        ['ID1', 'Minneapolis', 'shoes', '2', 'Air'],
        ['ID2', 'Chicago', 'shoes', '1', 'Air'],
        ['ID3', 'Central Department Store', 'shoes', '5', 'BonPied'],
        ['ID4', 'Quail Hollow', 'forks', '3', 'Pfitzcraft'],
      ];

      final expectedOutput = [
        ['Product Name', 'Average Quantity per Order'],
        ['shoes', 2.0],
        ['forks', 0.75],
      ];
      expect(calculateAverageQuantityPerOrder(records), equals(expectedOutput));
    });

    test('should throw an error if the CSV format is invalid', () {
      final records = [
        ['ID1', 'Minneapolis', 'shoes', '2'],
        ['ID2', 'Chicago', 'shoes', '1'],
      ];

      expect(() => calculateAverageQuantityPerOrder(records), throwsA('Invalid CSV format'));
    });
  });
  group('findMostPopularBrand', () {
    test('should find the most popular brand for each product', () {
      final records = [
        ['ID944806', 'Willard Vista', 'Intelligent Copper Knife', '3', 'Hilll-Gorczany'],
        ['ID644525', 'Roger Centers', 'Intelligent Copper Knife', '1', 'Kunze-Bernhard'],
        ['ID348204', 'Roger Centers', 'Small Granite Shoes', '4', 'Rowe and Legros'],
        ['ID710139', 'Roger Centers', 'Intelligent Copper Knife', '4', 'Hilll-Gorczany'],
        ['ID426632', 'Willa Hollow', 'Intelligent Copper Knife', '4', 'Hilll-Gorczany'],
      ];

      final expectedOutput = [
        ['Product Name', 'Most Popular Brand'],
        ['Intelligent Copper Knife', 'Hilll-Gorczany'],
        ['Small Granite Shoes', 'Rowe and Legros'],
      ];

      expect(findMostPopularBrand(records), equals(expectedOutput));
    });
  });
  group('generateUniqueFileName', () {
    test('should generate a unique file name when a file with the same name exists', () {
      final existingFileName = 'output.csv';
      final expectedUniqueFileName = 'output(1).csv';

      // Create a file with the same name
      File(existingFileName).createSync();

      expect(generateUniqueFileName(existingFileName), equals(expectedUniqueFileName));

      // Clean up
      File(existingFileName).deleteSync();
    });

    test('should return the original file name when no file with the same name exists', () {
      final fileName = 'output.csv';
      final expectedUniqueFileName = 'output.csv';

      expect(generateUniqueFileName(fileName), equals(expectedUniqueFileName));
    });
  });
  group('writeOutputToFile', () {
    test('should write the output to a file', () {
      final output = [
        ['Product Name', 'Average Quantity per Order'],
        ['shoes', 2.0],
        ['forks', 0.75],
      ];

      final fileName = 'output.csv';

      // Call the function
      writeOutputToFile(output, fileName);

      // Check if the file exists
      expect(File(fileName).existsSync(), isTrue);

      // Clean up
      File(fileName).deleteSync();
    });
  });

}
