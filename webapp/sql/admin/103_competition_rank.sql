CREATE TABLE `competition_rank`
(
    `competition_id` VARCHAR(255) NOT NULL,
    `rank` BIGINT NOT NULL,
    `score` BIGINT NOT NULL,
    `player_id` VARCHAR(255) NOT NULL,
    `player_display_name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`competition_id`, `rank`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;
