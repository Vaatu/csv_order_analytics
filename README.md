A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`.

# CSV Order Analysis

This script processes a CSV file containing order details from an online shopping website and generates two separate output files: one with the average quantity of each product purchased per order and another with the most popular brand for each product.

## Input File Structure

The input CSV file should have the following columns, in order:

- Order ID: The ID of the order placed.
- Delivery Area: The area where the order was delivered.
- Product Name: Name of the product.
- Quantity: Quantity of the product offered in that order.
- Brand: Brand of the ordered product.

Please ensure that the data is comma-delimited and that the row order does not matter.

## How to Use

1. Ensure that you have [Dart](https://dart.dev/get-dart) installed on your system.

2. Clone this repository or download the script file.

3. Open a terminal and navigate to the directory where the script is located.

4. Run the following command:

   ```bash
   dart run

5. You will be prompted to enter the input CSV file name. Provide the file name, including the .csv extension, and press Enter.

6. The script will process the CSV file and generate two output files: 0_input_file_name.csv for the average quantity and 1_input_file_name.csv for the most popular brand.

7. Check the generated output files for the results.


## Example

Suppose we have an input file named orders.csv with the following content:
```
ID944806,Willard Vista,Intelligent Copper Knife,3,Hilll-Gorczany
ID644525,Roger Centers,Intelligent Copper Knife,1,Kunze-Bernhard
ID348204,Roger Centers,Small Granite Shoes,4,Rowe and Legros
ID710139,Roger Centers,Intelligent Copper Knife,4,Hilll-Gorczany
ID426632,Willa Hollow,Intelligent Copper Knife,4,Hilll-Gorczany
```
Running the script and providing orders.csv as the input file will generate two output files:

- 0_orders.csv:
```
Product Name,Average Quantity per Order
Intelligent Copper Knife,2.4
Small Granite Shoes,0.8
```

- 1_orders.csv:
```
Product Name,Most Popular Brand
Intelligent Copper Knife,Hilll-Gorczany
Small Granite Shoes,Rowe and Legros
```
