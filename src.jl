# source of page constructor
module src

    # types & low-level constructors
    export SingleHtmlTag, PairedHtmlTag
    # basic generic methods
    export new_tag, add_doublequotations, add_pairedtags
    # tag generators (common)
    export tag_link
    export hr, br, sup, sub, bold, italic, underline, deleteline, tag_font
    export h1, h2, h3, h4, h5, h6
    export tag_div, tag_a, tag_ol, tag_ul
    # tag generators (form)
    export tag_form, tag_input_text, tag_input_number, tag_input_radio, tag_input_checkbox
    # tag for javascripts
    export tag_script, JS_str
    # CSS style constructors
    export link_css, tag_style








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

























end  # module src
#
