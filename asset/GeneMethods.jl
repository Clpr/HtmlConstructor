# general methods defined


# -------------- general method: create tag string from a tag type instance
function new_tag( d::SingleHtmlTag )
    local res::Vector = String[ "<" * d.tag, ]
    # add id
    if d.id != ""; push!(res, "id=" * add_doublequotations(d.id) ); end;
    # add class
    if d.class != ""; push!(res, "class=" * add_doublequotations(d.class) ); end;
    # add CSS style
    if d.style != ""; push!(res, "style=" * add_doublequotations(d.style) ); end;
    # add paired attributes
    append!(res, [ key * "=" * value for (key,value) in d.pairedAttributes ])
    # add single attributes
    append!(res, d.singleAttributes)
    # close the tag
    push!(res, "/>")
    # join the tag as a string, each part is separated by a space
    return join(res, " ")::String
end # new tag
# --------
function new_tag( d::PairedHtmlTag )
    local res::Vector = String[ "<" * d.tag, ]
    # add id
    if d.id != ""; push!(res, "id=" * add_doublequotations(d.id) ); end;
    # add class
    if d.class != ""; push!(res, "class=" * add_doublequotations(d.class) ); end;
    # add CSS style
    if d.style != ""; push!(res, "style=" * add_doublequotations(d.style) ); end;
    # add paired attributes
    append!(res, [ key * "=" * value for (key,value) in d.pairedAttributes ])
    # add single attributes
    append!(res, d.singleAttributes)
    # close the tag
    push!(res, ">")
    # add contents between paired tags & the right tag
    push!(res, d.content); push!(res, "</" * d.tag * ">" )
    # join the tag as a string, each part is separated by a space
    return join(res, " ")::String
end # new tag
# --------



# -------------- quickly packaging your contents with a paired tag
"""
    add_pairedtags( tag::String, content::String )

a quick and convenient method to package your content(s) with a paired tag (e.g. <div>)
**WITHOUT ANY ATTRIBUTE**. For example:
add_pairedtags("del", "this is a sample.") --> "<del>this is a sample.</del>";
returns a string.
"""
add_pairedtags( tag::String, content::String ) = "<" * tag * ">" * content * "</" * tag * ">"



# -------------- add \"\" to a string
"""
    add_doublequotations( s::String )

add explicit double quotations to the given string,
e.g. add_doublequotations("fuck") --> "\"fuck\""
"""
add_doublequotations( s::String ) = "\"" * s * "\""









#
