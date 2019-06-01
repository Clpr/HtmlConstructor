# common tag generators
# NOTE: StrOrTag = Union{String, AbstractHtmlTag}




# ----------------------- horizental line & new line
tag_hr() = quickEmptySingleTag("hr")
tag_br() = quickEmptySingleTag("br")
# ----------------------- sup & sub
tag_sup(content::Union{StrOrTag,Vector}) = quickEmptyPairedTag("sup",content)
tag_sub(content::Union{StrOrTag,Vector}) = quickEmptyPairedTag("sub",content)
# ----------------------- bold font, italic, underline, del
tag_b(content::Union{StrOrTag,Vector}) = quickEmptyPairedTag("b",content)
tag_i(content::Union{StrOrTag,Vector}) = quickEmptyPairedTag("i",content)
tag_u(content::Union{StrOrTag,Vector}) = quickEmptyPairedTag("u",content)
tag_del(content::Union{StrOrTag,Vector}) = quickEmptyPairedTag("del",content)
# ----------------------- header <h1> - <h6>
tag_h1(content::Union{StrOrTag,Vector}) = quickEmptyPairedTag("h1",content)
tag_h2(content::Union{StrOrTag,Vector}) = quickEmptyPairedTag("h2",content)
tag_h3(content::Union{StrOrTag,Vector}) = quickEmptyPairedTag("h3",content)
tag_h4(content::Union{StrOrTag,Vector}) = quickEmptyPairedTag("h4",content)
tag_h5(content::Union{StrOrTag,Vector}) = quickEmptyPairedTag("h5",content)
tag_h6(content::Union{StrOrTag,Vector}) = quickEmptyPairedTag("h6",content)






# ----------------------- font block <font>
"""
    tag_font( content::StrOrTag ; color::Union{String,Nothing} = nothing, face::Union{String,Nothing} = nothing, size::Union{String,Nothing} = nothing )

add a paired font tag to your content; returns a PairedHtmlTag instance;
not recommended since HTML 4.x;
StrOrTag = Union{String, AbstractHtmlTag}.
"""
function tag_font( content::StrOrTag ; color::StrOrNo = nothing, face::StrOrNo = nothing, size::StrOrNo = nothing )
    local tmppairedattrs = Dict{String,String}()
    isa(color, Nothing) ? nothing : tmppairedattrs["color"] = add_doublequotations(color)
    isa(face , Nothing) ? nothing : tmppairedattrs["face"] = add_doublequotations(face)
    isa(size , Nothing) ? nothing : tmppairedattrs["size"] = add_doublequotations(size)
    return PairedHtmlTag( "font", nothing, nothing, nothing,
        pairedAttributes = tmppairedattrs,
        content = AbstractHtmlTag[StrOrTag2Tag(content),] )
end # tag_font


# ----------------------- division block <div>
"""
    tag_div( content::StrOrTag ; id::StrOrNo = nothing, class::StrOrNo = nothing, style::StrOrNo = nothing )

creates a <div>content</div> tag PairedHtmlTag.
please organize your contents before packaging them in a div block.
"""
function tag_div( content::StrOrTag ; id::StrOrNo = nothing, class::StrOrNo = nothing, style::StrOrNo = nothing )
    return PairedHtmlTag( "div", id, class, style,
        content = AbstractHtmlTag[StrOrTag2Tag(content),] )
end # tag_div




# ----------------------- Hyperlink <a>
"""
    tag_a( href::String, content::StrOrTag ; id::StrOrNo = nothing, class::StrOrNo = nothing, style::StrOrNo = nothing )

generating paired <a>content</a> tag string, returns a PairedHtmlTag.
"""
function tag_a( href::String, content::StrOrTag ;
    id::StrOrNo = nothing, class::StrOrNo = nothing, style::StrOrNo = nothing )
    # --------
    # preprare paired attributes
    local pairedattrs = Dict(
        "href" => add_doublequotations(href),
    )
    # make a PairedHtmlTag
    return PairedHtmlTag( "a", id, class, style,
        pairedAttributes = pairedattrs,
        content = AbstractHtmlTag[StrOrTag2Tag(content)] )
end # tag_a


# ----------------------- numerate list <ol>
"""
    tag_ol( items::Vector{T} where T <: StrOrTag ; id::StrOrNo = nothing, class::StrOrNo = nothing, style::StrOrNo = nothing, type::String = "1", start::Int = 1, flag_reversed::Bool = false )

1. :type can be one of [ "A", "a", "1", "I", "i" ]
2. :items is a list of listing items
3. :start should be an integer to indicate where to start counting
4. return a PairedHtmlTag
"""
function tag_ol( items::Vector{T} where T <: StrOrTag ;
    id::StrOrNo = nothing, class::StrOrNo = nothing, style::StrOrNo = nothing,
    type::String = "1", start::Int = 1, flag_reversed::Bool = false )
    # prepare list items
    local content::Vector = [ quickEmptyPairedTag("li", x) for x in items ]
    # new a tag instance
    return PairedHtmlTag(
        "ol", id, class, style,
            singleAttributes = String[( flag_reversed ? "reversed" : "" ),],
            pairedAttributes = Dict(
                "type" => add_doublequotations(type),
                "start" => add_doublequotations(string(start)),
            ),
            content = content
    )
end # tag_ol


# ----------------------- non-order list <ul>
"""
    tag_ul( items::Vector{T} where T <: StrOrTag ; id::StrOrNo = nothing, class::StrOrNo = nothing, style::StrOrNo = nothing, type::StrOrNo = nothing )

1. :type can be one of [ "default" "disc", "square", "circle" ]
2. :items is a list of listing items
4. return a PairedHtmlTag
"""
function tag_ul( items::Vector{T} where T <: StrOrTag ;
    id::StrOrNo = nothing, class::StrOrNo = nothing, style::StrOrNo = nothing,
    type::StrOrNo = nothing )
    # prepare list items
    local content::Vector = [ quickEmptyPairedTag("li", x) for x in items ]
    # new a tag instance
    local tmppairedattrs::Dict = isa(type, Nothing) ? Dict{String,String}() : Dict{String,String}( "type" => add_doublequotations(type), )
    return PairedHtmlTag( "ul", id, class, style,
        pairedAttributes = tmppairedattrs, content = content )
end # tag_ol

















#
