CREATE TABLE `visit_history2`
(
    `tenant_id` BIGINT UNSIGNED NOT NULL,
    `competition_id` VARCHAR(255) NOT NULL,
    `player_id` VARCHAR(255) NOT NULL,
    `created_at` BIGINT NOT NULL,
    `updated_at` BIGINT NOT NULL,
    PRIMARY KEY (`tenant_id`, `competition_id`, player_id )
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

INSERT INTO visit_history2
SELECT tenant_id, competition_id, player_id, MIN(created_at) AS created_at, MAX(updated_at) AS updated_at
FROM visit_history
GROUP BY tenant_id, competition_id, player_id;
