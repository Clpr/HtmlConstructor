# included by src.jl
# core types used in html constructing



# ------------------- type tree
abstract type AbstractHtmlTag <: Any end


# ------------------- public constants
const CONS = (
    redasterisk = "<font color=red>*</font>", # red asterisk for required terms
)



# ------------------- 成对tag: <tag>content</tag>
mutable struct PairedHtmlTag <: AbstractHtmlTag
    tag::String  # tag name, e.g. table, head
    id::String  # tag id
    class::String  # tag class applied
    style::String  # CSS style
    singleAttributes::Vector{String}  # single attribute, e.g. required
    pairedAttributes::Dict{String,String}  # paired attributes, e.g. min=2000, width=\"100\"
    content::Vector{T} where T <: AbstractHtmlTag  # content between <tag> and </tag>
    # NOTE: html标签里的引号'和"要求显式写出
end
# ------------------- 单个标签tag: <tag />
mutable struct SingleHtmlTag <: AbstractHtmlTag
    tag::String  # tag name, e.g. table, head
    id::String  # tag id
    class::String  # tag class applied
    style::String  # CSS style
    singleAttributes::Vector{String}  # single attribute, e.g. required
    pairedAttributes::Dict{String,String}  # paired attributes, e.g. min=2000, width=\"100\"
    # NOTE: html标签里的引号'和"要求显式写出
end
# -------------------- 空白tag：blank tag, (a placeolder for pure string contents)
struct BlankHtmlTag <: AbstractHtmlTag
    content::String
end
# -------------------- HTML page (.html file)
"""
    HtmlPage

type to define an HTML page file.
"""
mutable struct HtmlPage <: Any
    filename::String # file name when saved
    pagetitle::String # page title displayed on browser's status bar
    lang::String # language, "en-us" by default
    charset::String # <meta charset = "utf-8" /> by default
    head::Vector # a list of the elements in the <head> part
    body::Vector # a list of the elements in the <body> part, ordered
    # ---------------------------
    function HtmlPage( filename::String = "index.html",
        pagetitle::String = "main", lang::String = "en-us",
        charset::String = "utf-8" )
        new(filename,pagetitle,lang,charset,[],[])
    end
end
















#
