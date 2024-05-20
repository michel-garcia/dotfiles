; extends

(encapsed_string
    (string_content) @injection.content
    (#match?
        @injection.content
        "^\s*(ALTER|CREATE|DELETE|DROP|EXPLAIN|INSERT|REPLACE|SELECT|UPDATE)"
    )
    (#set! injection.language "sql")
)

(encapsed_string
    (string_content) @injection.content
    (#match?
        @injection.content
        "^\s*(alter|create|delete|drop|explain|insert|replace|select|update)"
    )
    (#set! injection.language "sql")
)
