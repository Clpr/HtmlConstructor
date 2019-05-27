# included by src.jl
# core types used in html constructing



# ------------------- type tree
abstract type AbstractHtmlTag <: Any end


# ------------------- public constants
const CONS = (
    redasterisk = "<font color=red>*</font>", # red asterisk for required terms
)


# ------------------- 成对tag: <tag>content</tag>
struct PairedHtmlTag <: AbstractHtmlTag
    tag::String  # tag name, e.g. table, head
    id::String  # tag id
    class::String  # tag class applied
    style::String  # CSS style
    singleAttributes::Vector{String}  # single attribute, e.g. required
    pairedAttributes::Dict{String,String}  # paired attributes, e.g. min=2000, width=\"100\"
    content::String  # content between <tag> and </tag>
    # NOTE: html标签里的引号'和"要求显式写出
end
# ------------------- 单个标签tag: <tag />
struct SingleHtmlTag <: AbstractHtmlTag
    tag::String  # tag name, e.g. table, head
    id::String  # tag id
    class::String  # tag class applied
    style::String  # CSS style
    singleAttributes::Vector{String}  # single attribute, e.g. required
    pairedAttributes::Dict{String,String}  # paired attributes, e.g. min=2000, width=\"100\"
    # NOTE: html标签里的引号'和"要求显式写出
end







#
