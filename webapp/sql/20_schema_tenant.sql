CREATE TABLE `competition` (
  `id` INTEGER NOT NULL PRIMARY KEY,
  `title` TEXT NOT NULL,
  `finished_at` DATETIME NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL
);

CREATE TABLE `player` (
  `id` INTEGER PRIMARY KEY,
  `name` TEXT NOT NULL UNIQUE,
  `display_name` TEXT NOT NULL,
  `is_disqualified` INTEGER NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL
);

CREATE TABLE `player_score` (
  `id` INTEGER PRIMARY KEY,
  `player_id` INTEGER NOT NULL,
  `competition_id` INTEGER NOT NULL,
  `score` INTEGER NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  UNIQUE (`player_id`, `competition_id`)
);
