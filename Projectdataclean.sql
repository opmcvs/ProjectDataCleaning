SELECT * FROM projectdatac.datah;
USE projectdatac;

-- 1.STANDARDIZE SALE DATE and update
SELECT SaleDate, STR_TO_DATE(SaleDate, '%M %e, %Y') AS ConvertedSaleDate 
FROM projectdatac.datac;

UPDATE projectdatac.datac
SET SaleDate = STR_TO_DATE(SaleDate, '%M %e, %Y');

-- 2.TO CHECK IF THERE ARE NULL ADDRESSES
SELECT Propertyaddress FROM projectdatac.datah
WHERE PropertyAddress IS NULL; 


-- 3.After updating checking if there are any property address which are NULL.
UPDATE projectdatac.datah AS t1
JOIN projectdatac.datah AS t2 ON t1.ParcelID = t2.ParcelID AND t1.UniqueID <> t2.UniqueID
SET t1.Propertyaddress = COALESCE(t1.Propertyaddress, t2.Propertyaddress)
WHERE t1.Propertyaddress IS NULL;

-- 4.Breaking down the Address into columns (Address,city, )
SELECT * FROM projectdatac.datah;

SELECT SUBSTRING_INDEX(PropertyAddress,",",1),
SUBSTRING_INDEX(SUBSTRING_INDEX(PropertyAddress,",",-2),",",-1)
FROM projectdatac.datah;

ALTER TABLE projectdatac.datah
ADD COLUMN PropertyStreetAddress VARCHAR(100);

UPDATE projectdatac.datah
SET PropertyStreetAddress =SUBSTRING_INDEX(PropertyAddress,",",1);

ALTER TABLE projectdatac.datah
ADD COLUMN PropertyCityAddress VARCHAR(50);

UPDATE projectdatac.datah
SET PropertyCityAddress =SUBSTRING_INDEX(SUBSTRING_INDEX(PropertyAddress,",",-2),",",-1) ;


-- 5 Change The Data in SoldAsVacant from Y- Yes, N- No
SELECT distinct(SoldAsVacant),COUNT(SoldASVacant)
FROM projectdatac.datah
GROUP BY SoldAsVacant
ORDER BY 2;

SELECT SoldAsVacant,
CASE
    WHEN SoldAsVacant = 'Y' THEN SoldAsVacant = 'Yes'
    WHEN SoldAsVacant = 'N' THEN SoldAsVAcant = 'No'
    ELSE SoldAsVacant
    END AS ADJUSTED
    FROM projectdatac.datah;
    
 UPDATE projectdatac.datah
 SET SoldAsVacant = CASE
                WHEN SoldAsVacant = 'Y' THEN SoldAsVacant = 'Yes'
                WHEN SoldAsVacant = 'N' THEN SoldAsVAcant = 'No'
                ELSE SoldAsVacant
                END ;
                
-- 6. find out the duplicates.

WITH ROWNUM AS (
SELECT *,
 row_number() OVER(partition by ParcelID,
                                PropertyCityAddress,
                                PropertyStreetAddress,
                                SalePrice,
                                SaleDate,
                                LegalReference
                                ORDER BY
                                UniqueId) AS rowN
 FROM projectdatac.datah)    
 SELECT * FROM ROWNUM
 WHERE rowN >1
 ORDER BY PropertyStreetAddress; 
 
 -- 7 Creating a view table and DELETING UNUSED COLUMNS
CREATE VIEW ALLDATA AS 
SELECT * FROM projectdatac.datah;

ALTER TABLE projectdatac.datah
DROP COLUMN  PropertyAddress  ;



