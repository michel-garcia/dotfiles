; extends

(string (string_value) @sql
    (#lua-match? @sql "^%s*SELECT")
    (#exclude_children! @sql))
(string (string_value) @sql
    (#lua-match? @sql "^%s*UPDATE")
    (#exclude_children! @sql))
(string (string_value) @sql
    (#lua-match? @sql "^%s*DELETE")
    (#exclude_children! @sql))
(string (string_value) @sql
    (#lua-match? @sql "^%s*CREATE")
    (#exclude_children! @sql))
(string (string_value) @sql
    (#lua-match? @sql "^%s*INSERT")
    (#exclude_children! @sql))
(string (string_value) @sql
    (#lua-match? @sql "^%s*REPLACE")
    (#exclude_children! @sql))
(string (string_value) @sql
    (#lua-match? @sql "^%s*DROP")
    (#exclude_children! @sql))
(string (string_value) @sql
    (#lua-match? @sql "^%s*ALTER")
    (#exclude_children! @sql))
(string (string_value) @sql
    (#lua-match? @sql "^%s*EXPLAIN")
    (#exclude_children! @sql))

(encapsed_string (string_value) @sql
    (#lua-match? @sql "^%s*SELECT")
    (#exclude_children! @sql))
(encapsed_string (string_value) @sql
    (#lua-match? @sql "^%s*UPDATE")
    (#exclude_children! @sql))
(encapsed_string (string_value) @sql
    (#lua-match? @sql "^%s*DELETE"))
(encapsed_string (string_value) @sql
    (#lua-match? @sql "^%s*CREATE")
    (#exclude_children! @sql))
(encapsed_string (string_value) @sql
    (#lua-match? @sql "^%s*INSERT")
    (#exclude_children! @sql))
(encapsed_string (string_value) @sql
    (#lua-match? @sql "^%s*REPLACE")
    (#exclude_children! @sql))
(encapsed_string (string_value) @sql
    (#lua-match? @sql "^%s*DROP")
    (#exclude_children! @sql))
(encapsed_string (string_value) @sql
    (#lua-match? @sql "^%s*ALTER")
    (#exclude_children! @sql))
(encapsed_string (string_value) @sql
    (#lua-match? @sql "^%s*EXPLAIN")
    (#exclude_children! @sql))

