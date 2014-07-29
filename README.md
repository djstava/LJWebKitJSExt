LJWebKitJSExt
=============

WebKit Javascript Extentsion for LJ

1 Put the files into
  $(WebKitSourceCodeRoot)/WebCore/page
  
2 Build thd WebKit

3 Test page
    <html> 
    <body> 
    <script type="text/javascript"> 
		document.write("<br/> ============= This is from LJWebKit JSExt setStandby no argument:");
    	document.write(ljstandby.setStandby()); 
    	document.write("<br/> ============= This is from LJWebKit JSExt setStandby with argument:");
    	document.write(ljstandby.setStandbyWithArgu("hello ljstandby")); 
    </script> 
    </body> 
    </html>
