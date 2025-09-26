
<#$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://localhost/ToBeScrapted.html

# Get a count of links in the page 
$scraped_page.Links.count

#Display URL only

$scraped_page.Links

$scraped_page.Links | Select-Object outertext, href
#>
#$h2s = $scraped_page.ParsedHtml.body.getElementsBytagname("h2") | Select-Object outertext
#$h2s

$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where {
$_.getAttributeNode("class").value -ilike "div-1" 
} | Select-Object innertext

$divs1

