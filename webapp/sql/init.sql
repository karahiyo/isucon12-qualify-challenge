DELETE FROM tenant WHERE id > 100;
DELETE FROM visit_history WHERE created_at >= '1654041600';
UPDATE id_generator SET id=2678400000 WHERE stub='a';
ALTER TABLE id_generator AUTO_INCREMENT=2678400000;

DELETE FROM visit_history2;
-- INSERT INTO visit_history2
-- SELECT tenant_id, competition_id, player_id, MIN(created_at) AS created_at, MAX(updated_at) AS updated_at
-- FROM visit_history
-- GROUP BY tenant_id, competition_id, player_id;

DROP TABLE IF EXISTS billing_report;
CREATE TABLE billing_report
(
    competition_id VARCHAR(255) NOT NULL,
    competition_title VARCHAR(255) NOT NULL,
    player_count INT NOT NULL DEFAULT 0,
    visitor_count INT NOT NULL DEFAULT 0,
    billing_player_yen INT NOT NULL DEFAULT 0,
    billing_visitor_yen INT NOT NULL DEFAULT 0,
    billing_yen INT NOT NULL DEFAULT 0,
    PRIMARY KEY (competition_id)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;
