# source of page constructor
module HtmlConstructor

    # types & low-level constructors
    export SingleHtmlTag, PairedHtmlTag, HtmlPage
    # basic generic methods
    export new_tag, add!, pop!
    export add_doublequotations, add_pairedtags
    # tag generators (common)
    export tag_hr, tag_br, tag_sup, tag_sub, tag_b, tag_i, tag_u, tag_del, tag_font
    export tag_h1, tag_h2, tag_h3, tag_h4, tag_h5, tag_h6
    export tag_div, tag_a, tag_ol, tag_ul
    # tag generators (form)
    export tag_form, tag_input_text, tag_input_number, tag_input_radio, tag_input_checkbox
    # tag for javascripts
    export tag_script, JS_str
    # CSS style constructors
    export link_css, tag_style, CS_str
    # tag for the head part
    export tag_meta, tag_link







# -------------- type definition
include("asset/CoreType.jl")

# -------------- general methods
include("asset/GeneMethods.jl")

# -------------- common tag generators
include("asset/TagGenerators_common.jl")

# -------------- tag generators used in forms
include("asset/TagGenerators_form.jl")

# -------------- tag generators for javascripts
# NOTE: including some often-used realizations
include("asset/TagGenerators_js.jl")



# -------------- CSS style constructors
include("asset/CssStyles.jl")




# -------------- tools to construct a page (work flow)
include("asset/PageConstructor.jl")


# -------------- tags used in <head> part
include("asset/TagGenerators_head.jl")


















end  # module src
#
