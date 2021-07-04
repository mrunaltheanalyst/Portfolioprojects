-- Cleaning data in SQL Queries

Select * 
From [Portfolio Project].dbo.[Nashville Housing]

--Standardize date format------------------------------------------------------------------------------------

Select SaleDateConverted, CONVERT(date,SaleDate)
From [Portfolio Project].dbo.[Nashville Housing]

Update [Nashville Housing]
SET SaleDate = CONVERT(date,SaleDate)

ALTER TABLE [Nashville Housing]
Add SaleDateConverted Date;


Update [Nashville Housing]
SET SaleDateConverted = CONVERT(date,SaleDate)


-- Populate Property Address data

Select *
From [Portfolio Project].dbo.[Nashville Housing]
--wHERE PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.propertyaddress,b.PropertyAddress)
From [Portfolio Project].dbo.[Nashville Housing] A
JOIN [Portfolio Project].dbo.[Nashville Housing] B
     ON A.ParcelID = b.ParcelID
	 and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

Update a
SET PropertyAddress =  ISNULL(a.propertyaddress,b.PropertyAddress)
From [Portfolio Project].dbo.[Nashville Housing] A
JOIN [Portfolio Project].dbo.[Nashville Housing] B
     ON A.ParcelID = b.ParcelID
	 and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


--Breaking out Address into Individual columns

Select PropertyAddress
From [Portfolio Project].dbo.[Nashville Housing]
--wHERE PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address

FROM [Portfolio Project].dbo.[Nashville Housing]


ALTER TABLE [Nashville Housing]
Add PropertySplitAddress Nvarchar(255);


Update [Nashville Housing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)


ALTER TABLE [Nashville Housing]
Add PropertySplitCity Nvarchar(255);


Update [Nashville Housing]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

Select *
FROM [Portfolio Project].dbo.[Nashville Housing]

Select OwnerAddress
FROM [Portfolio Project].dbo.[Nashville Housing]


Select 
Parsename(REPLACE(OwnerAddress,',','.'), 3)
,Parsename(REPLACE(OwnerAddress,',','.'), 2)
,Parsename(REPLACE(OwnerAddress,',','.'), 1)
FROM [Portfolio Project].dbo.[Nashville Housing]

ALTER TABLE [Nashville Housing]
Add OwnerSplitAddress Nvarchar(255);


Update [Nashville Housing]
SET OwnerSplitAddress = Parsename(REPLACE(OwnerAddress,',','.'), 3)


ALTER TABLE [Nashville Housing]
Add OwnerSplitCity Nvarchar(255);


Update [Nashville Housing]
SET OwnerSplitCity = Parsename(REPLACE(OwnerAddress,',','.'), 2)




ALTER TABLE [Nashville Housing]
Add OwnerSplitState Nvarchar(255);


Update [Nashville Housing]
SET OwnerSplitState = Parsename(REPLACE(OwnerAddress,',','.'), 1)


--Change y and n to yes and no in soldasvacant field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
FROM [Portfolio Project].dbo.[Nashville Housing]
Group by SoldAsVacant
order by 2

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
       When SoldAsVacant = 'N' THEN 'No'
	   END
FROM [Portfolio Project].dbo.[Nashville Housing]

Update [Nashville Housing]
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
       When SoldAsVacant = 'N' THEN 'No'
	   END


--Remove duplicates
With RowNumCTE AS(
Select *,
ROW_NUMBER() OVER (
PARTITION BY ParcelID,
             PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 ORDER BY
			    UniqueID
				) row_num
FROM [Portfolio Project].dbo.[Nashville Housing]
)
Select *
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress

--Delete unused Columns

Select *
From [Portfolio Project].dbo.[Nashville Housing]

ALTER TABLE [Portfolio Project].dbo.[Nashville Housing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE [Portfolio Project].dbo.[Nashville Housing]
DROP COLUMN SaleDate