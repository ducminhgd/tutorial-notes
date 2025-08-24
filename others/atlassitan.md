# Atlassian tools

## Confluence

1. Auto number heading
  Add this script into a bookmark, and click (run) it in the editting mode of Confluence

  ```javascript
  javascript:(function()%7Bfunction addIndex() %7Bvar indices %3D %5B%5D%3BjQuery(".ak-editor-content-area .ProseMirror").find("h1%2Ch2%2Ch3%2Ch4%2Ch5%2Ch6").each(function(i%2Ce) %7Bvar hIndex %3D parseInt(this.nodeName.substring(1)) - 1%3Bif (indices.length - 1 > hIndex) %7Bindices%3D indices.slice(0%2C hIndex %2B 1 )%3B%7Dif (indices%5BhIndex%5D %3D%3D undefined) %7Bindices%5BhIndex%5D %3D 0%3B%7Dindices%5BhIndex%5D%2B%2B%3BjQuery(this).html(indices.join(".")%2B". " %2B removeNo(jQuery(this).html()))%3B%7D)%3B%7Dfunction removeNo(str) %7Blet newstr %3D str.trim()%3Bnewstr %3D newstr.replace(%2F%5B%5Cu00A0%5Cu1680%E2%80%8B%5Cu180e%5Cu2000-%5Cu2009%5Cu200a%E2%80%8B%5Cu200b%E2%80%8B%5Cu202f%5Cu205f%E2%80%8B%5Cu3000%5D%2Fg%2C' ')%3Bif(IsNumeric(newstr.substring(0%2Cnewstr.indexOf(' '))))%7Breturn newstr.substring(newstr.indexOf(' ')%2B1).trim()%3B%7Dreturn newstr%3B%7Dfunction IsNumeric(num) %7Bnum %3D num.split('.').join("")%3Breturn (num >%3D0 %7C%7C num < 0)%3B%7DaddIndex()%7D)()
  ```
