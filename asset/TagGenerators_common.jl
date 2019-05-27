# common tag generators


# ----------------------- linking external sources (dropped those attributes which are not supported by HTML5)
"""
    tag_link( rel::String, type::String, href::String ; hreflang::Union{String, Nothing} = nothing, media::Union{String, Nothing} = nothing )

creates a <link /> tag which is used in <head></head> part of the html document.
all attributed not supported by HTML5 are removed.
returns a string.

1. :rel is limited to be one of [ \"alternate\", \"author\", \"help\", \"icon\", \"licence\", \"next\", \"pingback\", \"prefetch\", \"prev\", \"search\", \"sidebar\", \"stylesheet\", \"tag\" ]
"""
function tag_link( rel::String, type::String, href::String ;
    hreflang::Union{String, Nothing} = nothing, media::Union{String, Nothing} = nothing )
    # prepare attributes
    local tmppairedattrs = Dict{String,String}(
        "rel" => add_doublequotations(rel),
        "type" => add_doublequotations(type),
        "href" => add_doublequotations(href),
    )
    isa(hreflang, Nothing) ? nothing : tmppairedattrs["hreflang"] = add_doublequotations(hreflang)
    isa(media   , Nothing) ? nothing : tmppairedattrs["media"] = add_doublequotations(media)
    return new_tag(SingleHtmlTag( "link", "", "", "", String[], tmppairedattrs ))
end # tag_link




# ----------------------- horizental line & new line
hr() = "<hr />"
br() = "<br />"

# ----------------------- sup & sub
sup(content::String) = add_pairedtags("sup",content)
sub(content::String) = add_pairedtags("sub",content)




# ----------------------- bold font, italic, underline, del
bold( content::String ) = add_pairedtags("b",content)
italic( content::String ) = add_pairedtags("i",content)
underline( content::String ) = add_pairedtags("u",content)
deleteline( content::String ) = add_pairedtags("del",content)
# ----------------------- font block <font>
"""
    tag_font( content::String ; color::Union{String,Nothing} = nothing, face::Union{String,Nothing} = nothing, size::Union{String,Nothing} = nothing )

add a paired font tag to your content; returns a string;
not recommended since HTML 4.x;
"""
function tag_font( content::String ; color::Union{String,Nothing} = nothing, face::Union{String,Nothing} = nothing, size::Union{String,Nothing} = nothing )
    local tmppairedattrs::Dict = Dict{String}()
    isa(color, Nothing) ? nothing : tmppairedattrs["color"] = add_doublequotations(color)
    isa(face , Nothing) ? nothing : tmppairedattrs["face"] = add_doublequotations(face)
    isa(size , Nothing) ? nothing : tmppairedattrs["size"] = add_doublequotations(size)
    return new_tag(PairedHtmlTag( "font", "", "", "", String[], tmppairedattrs, content ))
end # tag_font




# ----------------------- division block <div>
"""
    tag_div( content::String ; id::String = "", class::String = "", style::String = "" )

creates a <div>content</div> tag string.
please organize your contents before packaging them in a div block.
"""
function tag_div( content::String ; id::String = "", class::String = "", style::String = "" )
    return new_tag(PairedHtmlTag( "div", id, class, style, String[], Dict(), content ))::String
end # tag_div


# ----------------------- Hyperlink <a>
"""
    tag_a( href::String, content::String ; id::String = "", class::String = "", style::String = "" )

generating paired <a>content</a> tag string, returns a string.
"""
function tag_a( href::String, content::String ;
    id::String = "", class::String = "", style::String = "" )
    # --------
    # preprare paired attributes
    local pairedattrs = Dict(
        "href" => add_doublequotations(href),
    )
    # make a PairedHtmlTag
    return new_tag(PairedHtmlTag( "a", id, class, style, String[], pairedattrs, content ))
end # tag_a


# ----------------------- header <h1> - <h6>
h1(content::String) = add_pairedtags("h1",content)
h2(content::String) = add_pairedtags("h2",content)
h3(content::String) = add_pairedtags("h3",content)
h4(content::String) = add_pairedtags("h4",content)
h5(content::String) = add_pairedtags("h5",content)
h6(content::String) = add_pairedtags("h6",content)


















# ----------------------- numerate list <ol>
"""
    tag_ol( items::Vector{String}, id::String = "", class::String = "", style::String = "", type::String = "1", start::String = "1", flag_reversed::Bool = false )

1. :type can be one of [ "A", "a", "1", "I", "i" ]
2. :items is a list of listing items
3. :start should be an integer to indicate where to start counting
4. return a string
"""
function tag_ol( items::Vector{String} ;
    id::String = "", class::String = "", style::String = "",
    type::String = "1", start::Int = 1, flag_reversed::Bool = false )
    # prepare list items
    local content::String = join([ "<li>" * x * "</li>" for x in items ]," ")
    # new a tag instance
    return new_tag(PairedHtmlTag(
        "ol", id, class, style, String[( flag_reversed ? "reversed" : "" ),], Dict(
            "type" => add_doublequotations(type),
            "start" => add_doublequotations(string(start)),
        ), content
    ))::String
end # tag_ol

# ----------------------- non-order list <ul>
"""
    tag_ul( items::Vector{String}, id::String = "", class::String = "", style::String = "", type::String = "1", start::String = "1", flag_reversed::Bool = false )

1. :type can be one of [ "default" "disc", "square", "circle" ]
2. :items is a list of listing items
4. return a string
"""
function tag_ul( items::Vector{String} ;
    id::String = "", class::String = "", style::String = "",
    type::Union{String,Nothing} = nothing )
    # prepare list items
    local content::String = join([ "<li>" * x * "</li>" for x in items ]," ")
    # new a tag instance
    local tmppairedattrs::Dict = isa(type, Nothing) ? Dict() : Dict( "type" => add_doublequotations(type), )
    return new_tag(PairedHtmlTag(
        "ul", id, class, style, String[], tmppairedattrs, content
    ))::String
end # tag_ol

















#
