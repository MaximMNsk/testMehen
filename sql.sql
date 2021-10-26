/**
 * Простой запрос
 */

select res.dep_id, SUM(res.male) as males, SUM(res.female) as females from (
        SELECT dep_id, SUM(gender=1) as male, SUM(gender=0) as female 
        FROM users
        group by dep_id, gender
    ) as res
group by res.dep_id;




/**
 * Процедурный запрос
 */


DROP PROCEDURE IF EXISTS createTmpTab;
DELIMITER $$
CREATE PROCEDURE createTmpTab()
    BEGIN
	DROP table if exists ResultData ;
    CREATE temporary table ResultData(
    	dep_id INTEGER,
        males INTEGER,
        females INTEGER
    );
    END
$$ DELIMITER ;



DROP PROCEDURE IF EXISTS insertIdexes;
DELIMITER $$
CREATE PROCEDURE insertIdexes()
    BEGIN
	    DECLARE res_dep_id INTEGER DEFAULT 0;
        DECLARE done INT DEFAULT FALSE;
        DECLARE cursor_deps CURSOR FOR
            select DISTINCT dep_id from users;
	    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN cursor_deps;
    loop_deps: LOOP
		FETCH cursor_deps INTO res_dep_id;
        IF done THEN LEAVE loop_deps; END IF; 
        INSERT INTO ResultData (ResultData.dep_id) values (res_dep_id);
        CALL updateDataMales(res_dep_id);
        CALL updateDataFemales(res_dep_id);
	END LOOP;

    END
$$ DELIMITER ;



DROP PROCEDURE IF EXISTS updateDataMales;
DELIMITER $$
CREATE PROCEDURE updateDataMales( source_dep_id INTEGER )
    BEGIN
        DECLARE done INT DEFAULT FALSE;
        DECLARE malesCount INTEGER;
        DECLARE cursor_males CURSOR FOR
            select count(*) from users where dep_id = source_dep_id and gender = 1;
            
	    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
		OPEN cursor_males;
        loop_males: LOOP
        	FETCH cursor_males into malesCount;
            UPDATE ResultData SET males = malesCount where dep_id = source_dep_id;
        	IF done THEN LEAVE loop_males; END IF; 
        END LOOP;
	END
$$ DELIMITER ;


DROP PROCEDURE IF EXISTS updateDataFemales;
DELIMITER $$
CREATE PROCEDURE updateDataFemales( source_dep_id INTEGER )
    BEGIN
        DECLARE done INT DEFAULT FALSE;
        DECLARE femalesCount INTEGER;
        DECLARE cursor_females CURSOR FOR
            select count(*) from users where dep_id = source_dep_id and gender = 0;
            
	    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
		OPEN cursor_females;
        loop_females: LOOP
        	FETCH cursor_females into femalesCount;
            UPDATE ResultData SET females = femalesCount where dep_id = source_dep_id;
        	IF done THEN LEAVE loop_females; END IF; 
        END LOOP;
	END
$$ DELIMITER ;


CALL createTmpTab();
CALL insertIdexes();
SELECT * from ResultData;