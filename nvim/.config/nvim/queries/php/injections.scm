; extends

(string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Aa][Ll][Tt][Ee][Rr]")
    (#set! injection.language "sql")
)

(encapsed_string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Aa][Ll][Tt][Ee][Rr]")
    (#set! injection.language "sql")
)

(string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]")
    (#set! injection.language "sql")
)

(encapsed_string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]")
    (#set! injection.language "sql")
)

(string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Dd][Ee][Ll][Ee][Tt][Ee]")
    (#set! injection.language "sql")
)

(encapsed_string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Dd][Ee][Ll][Ee][Tt][Ee]")
    (#set! injection.language "sql")
)

(string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Dd][Rr][Oo][Pp]")
    (#set! injection.language "sql")
)

(encapsed_string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Dd][Rr][Oo][Pp]")
    (#set! injection.language "sql")
)

(string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Ee][Xx][Pp][Ll][Aa][Ii][Nn]")
    (#set! injection.language "sql")
)

(encapsed_string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Ee][Xx][Pp][Ll][Aa][Ii][Nn]")
    (#set! injection.language "sql")
)

(string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Ii][Nn][Ss][Ee][Rr][Tt]")
    (#set! injection.language "sql")
)

(encapsed_string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Ii][Nn][Ss][Ee][Rr][Tt]")
    (#set! injection.language "sql")
)

(string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Rr][Ee][Pp][Ll][Aa][Cc][Ee]")
    (#set! injection.language "sql")
)

(encapsed_string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Rr][Ee][Pp][Ll][Aa][Cc][Ee]")
    (#set! injection.language "sql")
)

(string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Ss][Ee][Ll][Ee][Cc][Tt]")
    (#set! injection.language "sql")
)

(encapsed_string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Ss][Ee][Ll][Ee][Cc][Tt]")
    (#set! injection.language "sql")
)

(string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Ss][Hh][Oo][Ww]")
    (#set! injection.language "sql")
)

(encapsed_string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Ss][Hh][Oo][Ww]")
    (#set! injection.language "sql")
)

(string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Uu][Pp][Dd][Aa][Tt][Ee]")
    (#set! injection.language "sql")
)

(encapsed_string
    (string_content) @injection.content
    (#any-lua-match? @injection.content "^%s*[Uu][Pp][Dd][Aa][Tt][Ee]")
    (#set! injection.language "sql")
)
