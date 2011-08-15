CREATE TABLE `messages` (
    `sender`    VARCHAR(255) NOT NULL DEFAULT '',
    `recipient` VARCHAR(255) NOT NULL DEFAULT '',

    `id`        VARCHAR(255) DEFAULT NULL,
    `type`      VARCHAR(255) DEFAULT NULL,
    `body`      TEXT,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
