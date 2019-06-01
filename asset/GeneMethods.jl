# general methods defined




# -------------- general method: create tag string from a tag type instance
function new_tag( d::SingleHtmlTag )
    local res::Vector = String[ "<" * d.tag, ]
    # add id, class, inline CSS style
    isa(d.id, Nothing) ? nothing : push!(res, "id=" * add_doublequotations(d.id) )
    isa(d.class, Nothing) ? nothing : push!(res, "class=" * add_doublequotations(d.class) )
    isa(d.style, Nothing) ? nothing : push!(res, "style=" * add_doublequotations(d.style) )
    # add paired attributes
    append!(res, [ key * "=" * add_doublequotations(value) for (key,value) in d.pairedAttributes ])
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
    # add id, class, inline CSS style
    isa(d.id, Nothing) ? nothing : push!(res, "id=" * add_doublequotations(d.id) )
    isa(d.class, Nothing) ? nothing : push!(res, "class=" * add_doublequotations(d.class) )
    isa(d.style, Nothing) ? nothing : push!(res, "style=" * add_doublequotations(d.style) )
    # add paired attributes
    append!(res, [ key * "=" * add_doublequotations(value) for (key,value) in d.pairedAttributes ])
    # add single attributes
    append!(res, d.singleAttributes)
    # close the tag
    push!(res, ">")
    # add contents between paired tags & the right tag
    if length(d.content) == 0
        # if there is no content, just skip it
        nothing
    elseif (length(d.content) == 1) & !(isa(d.content[1], PairedHtmlTag))
        # if there is only one element and it is not a paired tag (only paired tag has content!)
        push!(res, new_tag(d.content[1]))
    else
        # if there is more than one element in the tag`s content, loop and/or recursive stringlize all elements
        for tmptag in d.content
            if isa(tmptag, BlankHtmlTag)
                push!(res, tmptag.content)
            elseif isa(tmptag, SingleHtmlTag)
                push!(res, new_tag(tmptag))
            else
                push!(res, new_tag(tmptag)) # NOTE: recursive calling
            end
        end
    end
    # add </tag>
    push!(res, "</" * d.tag * ">" )
    # join the tag as a string, each part is separated by a space
    return join(res, " ")::String
end # new tag
# --------
new_tag( d::BlankHtmlTag ) = return (d.content)::String




# ------------------------------ convert a vector of any objects to a list of tags
"""
    vecany2vectag( list::Vector{Any} )

convert a vector of string-lize-able elements to a list of tags
"""
function vecany2vectag( list::Vector{Any} )
    local res = AbstractHtmlTag[]
    for x in list
        if isa(x, AbstractHtmlTag)
            push!(res, x)
        else
            try
                push!(res, BlankHtmlTag(string(x)) )
            catch
                @error("unsupported element type: $(typeof(x))")
            end
        end
    end
    return res::Vector{AbstractHtmlTag}
end  # vecany2vectag








# ------------------------------ add element to a paired tag`s content
"""
    add!( suptag::PairedHtmlTag, subtag::AbstractHtmlTag )

add a new sub-tag member to a given paired tag instance.
"""
function add!( suptag::PairedHtmlTag, subtag::AbstractHtmlTag )
    push!(suptag.content, subtag)
end # add
# ------------------------------ reload add! to add String
"""
    add!( suptag::PairedHtmlTag, subtag::String )

add a new sub-tag member (in the form of string) to a given paired tag instance.
"""
function add!( suptag::PairedHtmlTag, subtag::String )
    push!(suptag.content, BlankHtmlTag(subtag) )
end # add
# ------------------------------ reload add! to allow vector input
"""
    add!( suptag::PairedHtmlTag, v_subtag::Vector{T} where T <: AbstractHtmlTag )

add a list of new sub-tag members to a given paired tag instance.
"""
function add!( suptag::PairedHtmlTag, v_subtag::Vector{T} where T <: AbstractHtmlTag )
    for x in v_subtag; push!(suptag.content, x ); end
end # add
"""
    add!( suptag::PairedHtmlTag, v_subtag::Vector{String} )

add a list of new sub-tag members to a given paired tag instance.
"""
function add!( suptag::PairedHtmlTag, v_subtag::Vector{String} )
    for x in v_subtag; push!(suptag.content, BlankHtmlTag(x) ); end
end # add
"""
    add!( suptag::PairedHtmlTag, v_subtag::Vector{Any} )

add a mixed list of new sub-tag members to a given paired tag instance.
"""
function add!( suptag::PairedHtmlTag, v_subtag::Vector{Any} )
    for x in v_subtag; add!(suptag, x ); end
end # add
# -----------------------------------







# ------------------------------ pop! reload for tag types
"""
    pop!( d::PairedHtmlTag, k::Int )

reload of pop!(). deletes the item with key k in a PairedHtmlTag,
and returns the value associated with k.
"""
pop!( d::PairedHtmlTag, k::Int ) = pop!(d.content, k)::AbstractHtmlTag














# ----------------------- StrOrTag -> Tags
StrOrTag2Tag(content::StrOrTag) = return ( isa(content, String) ? BlankHtmlTag(content) : content )::AbstractHtmlTag
# ----------------------- quick "empty" tags
function quickEmptyPairedTag(tagname::String, content::StrOrTag)
    return PairedHtmlTag(tagname, nothing, nothing, nothing, content = AbstractHtmlTag[StrOrTag2Tag(content),] )
end # quickEmptyPairedTag
function quickEmptyPairedTag(tagname::String, content::Vector)
    return PairedHtmlTag(tagname, nothing, nothing, nothing, content = vecany2vectag(content) )
end # quickEmptyPairedTag
function quickEmptySingleTag(tagname::String)
    return SingleHtmlTag(tagname, nothing, nothing, nothing )
end # quickEmptyPairedTag




























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
add_doublequotations( s::String ) = begin
    if s[1] == '"' == s[end]
        return s::String
    else
        return ( "\"" * s * "\"" )::String
    end
end # add_doublequotations











#
