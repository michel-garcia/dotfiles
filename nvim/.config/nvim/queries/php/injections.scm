; extends

(encapsed_string
    (string_value) @sql
    (#match? @sql "^\s*(ALTER|CREATE|DELETE|DROP|EXPLAIN|INSERT|REPLACE|SELECT|UPDATE)"))
