--  calculates the weighted average score for a specific user
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_weight INT DEFAULT 0;
    DECLARE weighted_sum FLOAT DEFAULT 0;

    -- Calculate the total weight and weighted sum for the specified user
    SELECT SUM(p.weight), SUM(c.score * p.weight)
    INTO total_weight, weighted_sum
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;

    -- Update the user's average score if total weight is greater than 0
    IF total_weight > 0 THEN
        UPDATE users
        SET average_score = weighted_sum / total_weight
        WHERE id = user_id;
    END IF;
END //

DELIMITER ;
