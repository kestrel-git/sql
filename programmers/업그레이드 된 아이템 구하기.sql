SELECT 
      TREE.ITEM_ID
    , INFO.ITEM_NAME
    , INFO.RARITY
FROM ITEM_TREE AS TREE
    JOIN ITEM_INFO AS INFO ON TREE.ITEM_ID = INFO.ITEM_ID
WHERE PARENT_ITEM_ID IS NOT NULL
  AND 'RARE' = (SELECT RARITY FROM ITEM_INFO WHERE TREE.PARENT_ITEM_ID = ITEM_ID)
ORDER BY 1 DESC
;
