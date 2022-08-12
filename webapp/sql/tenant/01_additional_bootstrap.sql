-- すでに作成済みのテーブルに対する追加の初期化処理

-- CREATE INDEX IF NOT EXISTS player_score_tenant_comp_idx
--     ON player_score(tenant_id, competition_id, player_id, row_num desc);
CREATE INDEX IF NOT EXISTS comp_player_idx ON player_score(competition_id, player_id, row_num desc);
CREATE INDEX IF NOT EXISTS player_comp_idx ON player_score(player_id, competition_id);

CREATE TEMPORARY TABLE player_score2 AS
  SELECT id, tenant_id, player_id, competition_id, score, max(row_num) as row_num, created_at, updated_at
  FROM player_score
  GROUP BY tenant_id, player_id, competition_id;

DELETE FROM player_score;
INSERT INTO player_score(id, tenant_id, player_id, competition_id, score, row_num, created_at, updated_at)
SELECT * FROM player_score2;
