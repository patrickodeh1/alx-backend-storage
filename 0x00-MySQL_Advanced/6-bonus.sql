-- tored procedure to add a correction for a student
DELIMITER //

CREATE PROCEDURE AddBonus(IN user_id INT, IN project_name VARCHAR(255), IN score INT)
BEGIN
    DECLARE project_id INT;

    -- Check if the project exists, if not insert it
    SET project_id = (SELECT id FROM projects WHERE name = project_name);
    IF project_id IS NULL THEN
        INSERT INTO projects (name) VALUES (project_name);
        SET project_id = LAST_INSERT_ID();
    END IF;

    -- Insert the correction
    INSERT INTO corrections (user_id, project_id, score) 
    VALUES (user_id, project_id, score);
END //

DELIMITER ;
