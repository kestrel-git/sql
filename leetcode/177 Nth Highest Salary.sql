CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) RETURNS TABLE (Salary INT) AS $$
DECLARE
    limit_num INT;
BEGIN
    limit_num = 1;
    IF N < 1 THEN 
        limit_num = 0;
        N = 1;
    END IF;
    
    RETURN QUERY (
        SELECT
            DISTINCT e.salary
        FROM Employee e
        ORDER BY 1 DESC
        LIMIT limit_num OFFSET N-1
    );
END;
$$ LANGUAGE plpgsql;
