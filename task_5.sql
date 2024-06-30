CREATE TABLE stage.srid_tracker
(
    `srid`      String,
    `rid_hash`  UInt64,
    `action_id` UInt32,
    `dt`        DateTime,
    `place_cod` UInt64,
    `dt_load`   datetime materialized now()
)
ENGINE = MergeTree()
PARTITION BY toYYYYMMDD(dt)
ORDER BY (rid_hash,action_id)
TTL toStartOfDay(dt) + interval 3 week
SETTINGS ttl_only_drop_parts=1;


CREATE TABLE direct_log.srid_tracker_buf
(
    `srid`      String,
    `rid_hash`  UInt64,
    `action_id` UInt32,
    `dt`        DateTime,
    `place_cod` UInt64
)
ENGINE = Buffer('stage', 'srid_tracker',  1, 10, 100, 10000, 1000000, 10000000, 100000000);