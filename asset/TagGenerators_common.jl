# common tag generators

# ----------------------- horizental line & new line
hr() = SingleHtmlTag("hr","","","",[],Dict())
br() = SingleHtmlTag("br","","","",[],Dict())

# ----------------------- sup & sub
sup(content::String) = PairedHtmlTag("sup","","","",[],Dict(),content)
sub(content::String) = PairedHtmlTag("sub","","","",[],Dict(),content)

# ----------------------- bold font, italic, underline, del
bold(content::String) = PairedHtmlTag("b","","","",[],Dict(),content)
italic(content::String) = PairedHtmlTag("i","","","",[],Dict(),content)
underline(content::String) = PairedHtmlTag("u","","","",[],Dict(),content)
deleteline(content::String) = PairedHtmlTag("del","","","",[],Dict(),content)

# ----------------------- header <h1> - <h6>
h1(content::String) = PairedHtmlTag("h1","","","",[],Dict(),content)
h2(content::String) = PairedHtmlTag("h2","","","",[],Dict(),content)
h3(content::String) = PairedHtmlTag("h3","","","",[],Dict(),content)
h4(content::String) = PairedHtmlTag("h4","","","",[],Dict(),content)
h5(content::String) = PairedHtmlTag("h5","","","",[],Dict(),content)
h6(content::String) = PairedHtmlTag("h6","","","",[],Dict(),content)






# ----------------------- font block <font>
"""
    tag_font( content::String ; color::Union{String,Nothing} = nothing, face::Union{String,Nothing} = nothing, size::Union{String,Nothing} = nothing )

add a paired font tag to your content; returns a PairedHtmlTag;
not recommended since HTML 4.x;
"""
function tag_font( content::String ; color::Union{String,Nothing} = nothing, face::Union{String,Nothing} = nothing, size::Union{String,Nothing} = nothing )
    local tmppairedattrs::Dict = Dict{String}()
    isa(color, Nothing) ? nothing : tmppairedattrs["color"] = add_doublequotations(color)
    isa(face , Nothing) ? nothing : tmppairedattrs["face"] = add_doublequotations(face)
    isa(size , Nothing) ? nothing : tmppairedattrs["size"] = add_doublequotations(size)
    return PairedHtmlTag( "font", "", "", "", String[], tmppairedattrs, content )
end # tag_font


# ----------------------- division block <div>
"""
    tag_div( content::String ; id::String = "", class::String = "", style::String = "" )

creates a <div>content</div> tag PairedHtmlTag.
please organize your contents before packaging them in a div block.
"""
function tag_div( content::String ; id::String = "", class::String = "", style::String = "" )
    return PairedHtmlTag( "div", id, class, style, String[], Dict(), content )
end # tag_div


# ----------------------- Hyperlink <a>
"""
    tag_a( href::String, content::String ; id::String = "", class::String = "", style::String = "" )

generating paired <a>content</a> tag string, returns a PairedHtmlTag.
"""
function tag_a( href::String, content::String ;
    id::String = "", class::String = "", style::String = "" )
    # --------
    # preprare paired attributes
    local pairedattrs = Dict(
        "href" => add_doublequotations(href),
    )
    # make a PairedHtmlTag
    return PairedHtmlTag( "a", id, class, style, String[], pairedattrs, content )
end # tag_a


# ----------------------- numerate list <ol>
"""
    tag_ol( items::Vector{String}, id::String = "", class::String = "", style::String = "", type::String = "1", start::String = "1", flag_reversed::Bool = false )

1. :type can be one of [ "A", "a", "1", "I", "i" ]
2. :items is a list of listing items
3. :start should be an integer to indicate where to start counting
4. return a PairedHtmlTag
"""
function tag_ol( items::Vector{String} ;
    id::String = "", class::String = "", style::String = "",
    type::String = "1", start::Int = 1, flag_reversed::Bool = false )
    # prepare list items
    local content::String = join([ "<li>" * x * "</li>" for x in items ]," ")
    # new a tag instance
    return PairedHtmlTag(
        "ol", id, class, style, String[( flag_reversed ? "reversed" : "" ),], Dict(
            "type" => add_doublequotations(type),
            "start" => add_doublequotations(string(start)),
        ), content
    )
end # tag_ol


# ----------------------- non-order list <ul>
"""
    tag_ul( items::Vector{String}, id::String = "", class::String = "", style::String = "", type::String = "1", start::String = "1", flag_reversed::Bool = false )

1. :type can be one of [ "default" "disc", "square", "circle" ]
2. :items is a list of listing items
4. return a PairedHtmlTag
"""
function tag_ul( items::Vector{String} ;
    id::String = "", class::String = "", style::String = "",
    type::Union{String,Nothing} = nothing )
    # prepare list items
    local content::String = join([ "<li>" * x * "</li>" for x in items ]," ")
    # new a tag instance
    local tmppairedattrs::Dict = isa(type, Nothing) ? Dict() : Dict( "type" => add_doublequotations(type), )
    return PairedHtmlTag(
        "ul", id, class, style, String[], tmppairedattrs, content
    )
end # tag_ol

















#
