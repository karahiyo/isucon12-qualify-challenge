-- type BillingReport struct {
-- 	CompetitionID     string `json:"competition_id"`
-- 	CompetitionTitle  string `json:"competition_title"`
-- 	PlayerCount       int64  `json:"player_count"`        // スコアを登録した参加者数
-- 	VisitorCount      int64  `json:"visitor_count"`       // ランキングを閲覧だけした(スコアを登録していない)参加者数
-- 	BillingPlayerYen  int64  `json:"billing_player_yen"`  // 請求金額 スコアを登録した参加者分
-- 	BillingVisitorYen int64  `json:"billing_visitor_yen"` // 請求金額 ランキングを閲覧だけした(スコアを登録していない)参加者分
-- 	BillingYen        int64  `json:"billing_yen"`         // 合計請求金額
-- }

DROP TABLE billing_report;
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
