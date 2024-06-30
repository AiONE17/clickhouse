CREATE table current.srid_action
(
    `srid`      String,
    `rid_hash`  UInt64,
    `action_id` UInt32,
    `dt`        DateTime,
    `place_cod` UInt64,
    `dt_load`   datetime materialized now()
)
ENGINE = ReplacingMergeTree(dt)
ORDER BY (rid_hash)
TTL toStartOfDay(dt) + interval 3 week;


CREATE MATERIALIZED VIEW default.mv_srid_tracker_to_current
TO current.srid_action
(
    `srid`      String,
    `rid_hash`  UInt64,
    `action_id` UInt32,
    `dt`        DateTime,
    `place_cod` UInt64,
    `dt_load`   datetime materialized now()
)
AS
SELECT srid,
       rid_hash,
       action_id,
       dt,
       place_cod
FROM stage.srid_tracker;