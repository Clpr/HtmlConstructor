  push!(LOAD_PATH,pwd())

  import HtmlConstructor


# --------- sample final html text
sample = """
<html>
<head>

  <meta charset = "utf-8" lang = "en-us" />

  <link rel="stylesheet" type="text/css" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />

  <script>
    var test = 123.456;
  </script>

  <style>
  .testcls {
    width : 50%;
    margin-left : 25%;
  }

  </style>

<head>

<body>

<h1 id="www" class="testcls" >Testig <b>HTML</b> Page</h1>
<hr />
<form style="width:80%;margin-left:10%;">
  <table id="maintab">
    <tr>
      <td>
        <label for="q_1">Please answer <input name="q_1" type="text" required /></label>
      </td>
      <td>
        <label for="q_2">Yes <input name="q_2" type="radio" value="true" checked /></label>
        <label for="q_2">No <input name="q_2" type="radio" value="true" /></label>
      </td>
    </tr>
    <tr>
      <input type="submit" onclick="alert('test done!')" />
    <tr>
  </table>
</form>
<br />
<ul>
  <li>test 1</li>
  <li>test 2</li>
  <li>test 3</li>
</ul>
</body>
</html>
"""




# --------- init an html page
page = HtmlConstructor.HtmlPage("index.html","test page")


# I. <head> part
# new an empty <head></head> tag
p_head = HtmlConstructor.new_blankpairedtags("head")
# add members to p_head.content
  # 1. <meta> tag
  push!(p_head.content, HtmlConstructor.tag_meta(charset="utf-8", lang="en-us") )
  # 2. <link> tag
  push!(p_head.content, HtmlConstructor.link_css(
    "//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"
  ))
  # 3. <script> tag + JS script
  tmpscript = HtmlConstructor.JS"""
    var test = 123.456;
  """
  push!(p_head.content, tmpscript)
  # 4. <style> tag + CSS class def
  tmpscript = HtmlConstructor.CSS"""
    .testcls {
      width : 50%;
      margin-left : 25%;
    }
  """
  push!(p_head.content, tmpscript)
# add filled <head> to the page
push!(page.head, p_head)



println(HtmlConstructor.new_tag(p_head))















  #
