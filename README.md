# Readme.md

## Project Data Cleaning Script

This script is designed to clean and standardize data stored in the `projectdatac` database. It consists of SQL queries that perform various data cleaning operations on the `datac` and `datah` tables within the database.

### Instructions:

1. **Standardize Sale Date:**
   - Converts the `SaleDate` column to a standardized date format using the `STR_TO_DATE` function.
   - Updates the `SaleDate` column with the standardized dates.

2. **Check for Null Addresses:**
   - Checks for null values in the `PropertyAddress` column of the `datah` table.

3. **Update Null Addresses:**
   - Updates null values in the `PropertyAddress` column by replacing them with corresponding non-null values from rows with the same `ParcelID`.

4. **Break Down Address into Columns:**
   - Splits the `PropertyAddress` column into separate columns for `PropertyStreetAddress` and `PropertyCityAddress`.
   - Adds new columns to the `datah` table for `PropertyStreetAddress` and `PropertyCityAddress`.
   - Updates these new columns with the split address components.

5. **Change SoldAsVacant Data:**
   - Converts values in the `SoldAsVacant` column from 'Y' and 'N' to 'Yes' and 'No' respectively.

6. **Find Duplicates:**
   - Identifies duplicate records within the `datah` table based on specific columns (`ParcelID`, `PropertyAddress`, `SalePrice`, `SaleDate`, `LegalReference`).

7. **Create View and Delete Unused Columns:**
   - Creates a view table named `ALLDATA` which contains all the data from the `datah` table.
   - Drops the `PropertyAddress` column from the `datah` table to remove redundant information.



