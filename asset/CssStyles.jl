# CSS style constructors








# ---------------- add <style></style>
"""
    tag_style( CssStylesStr::String ; type::String = "text/css" )

add a pair of <style> tags for your CSS style string.
"""
tag_style( CssStylesStr::String ; type::String = "text/css" ) = begin
    return PairedHtmlTag(
        "style", "", "", "", String[], Dict( "type" => add_doublequotations(type) ), CssStylesStr
    )
end


# ---------------- link to external CSS file
"""
    link_css( href::String )

linking an external css file. returns a <link /> tag string.
"""
link_css( href::String ) = tag_link( "stylesheet", "text/css", href )





# ------------------------ JS script string
"""
    CSS_str(script)
"""
macro CSS_str(script)
    return quote
        tag_style( "\n" * string($script) * "\n" )
    end
end # CSS_str





















#
