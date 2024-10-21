-- procedure calculates the weighted average score for all users 
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE current_user_id INT;
    DECLARE cur CURSOR FOR SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    
    user_loop: LOOP
        FETCH cur INTO current_user_id;
        IF done THEN
            LEAVE user_loop;
        END IF;

        -- Call the procedure to compute the average for each user
        CALL ComputeAverageWeightedScoreForUser(current_user_id);
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;
