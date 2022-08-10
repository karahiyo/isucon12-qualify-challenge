DELETE FROM tenant WHERE id > 100;
DELETE FROM visit_history WHERE created_at >= '1654041600';
DELETE FROM visit_history2 WHERE created_at >= '1654041600';
DELETE FROM billing_report;
DELETE FROM competition_rank;
