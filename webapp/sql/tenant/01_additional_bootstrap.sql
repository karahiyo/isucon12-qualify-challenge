-- すでに作成済みのテーブルに対する追加の初期化処理

CREATE TABLE player_score2
(
    player_id VARCHAR(255) NOT NULL,
    competition_id VARCHAR(255) NOT NULL,
    score BIGINT NOT NULL,
    row_num BIGINT NOT NULL,
    created_at BIGINT NOT NULL,
    updated_at BIGINT NOT NULL,
    PRIMARY KEY (player_id, competition_id)
);

INSERT INTO player_score2(player_id, competition_id, score, row_num, created_at, updated_at)
SELECT player_id, competition_id, score, max(row_num) as row_num, created_at, updated_at
FROM player_score
GROUP BY player_id, competition_id;

DELETE FROM player_score;

DROP INDEX IF EXISTS player_comp_idx;
DROP INDEX IF EXISTS comp_player_idx;
DROP INDEX IF EXISTS player_score_tenant_comp_idx;

CREATE INDEX IF NOT EXISTS comp_player_idx ON player_score2(competition_id, player_id, score DESC, row_num);
