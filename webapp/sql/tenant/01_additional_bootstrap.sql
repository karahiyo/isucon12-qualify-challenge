-- すでに作成済みのテーブルに対する追加の初期化処理

CREATE INDEX IF NOT EXISTS player_score_tenant_comp_idx
    ON player_score(tenant_id, competition_id, player_id, row_num desc);
