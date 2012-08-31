<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:img="http://chs.harvard.edu/xmlns/img">
    <!-- need to make all replies to CHS Image Extension fully 
        namespaced
        -->
    <xd:doc
        scope="stylesheet"
        xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> June 22, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> Neel Smith</xd:p>
            <xd:p>Stylesheet to transform CHS Image Extension's reply to
            GetIIPMooViewer request into an HTML document with 
            zoomable image.  Updated to support overlay of a single RoI
	      as a highlighted region.</xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:template match="/">
        <html>
            
            <head>
                <title><xsl:apply-templates select="//img:id"></xsl:apply-templates>: zoomable image</title>
                
                <link rel="stylesheet" type="text/css" media="all" href="aias/iip-cite.css" />
                
                <script type="text/javascript" src="aias/mootools-1.2-core.js"></script>
                
                <script type="text/javascript" src="aias/mootools-1.2-more.js"></script>
                
                <script type="text/javascript" src="aias/iipmooviewer-cite.js"></script>
                
                
                
                <script type="text/javascript">
                    var server = "<xsl:value-of select="//img:serverUrl/@val"/>";
                    var image = "<xsl:value-of select="//img:imgPath/@val"/>";
                    var credit = "<xsl:value-of select="//img:label"/>";
                    var roi = "<xsl:value-of select="//img:roi/@val"/>";
                    var imgId = "<xsl:apply-templates select="//img:id"/>";
                    var imgUrn = "<xsl:apply-templates select="//img:urn"/>";
	                // left, top, width, height
                    // Create our viewer object - note: must assign this to the 'iip' variable
                    iip = new IIP( "targetframe", {
                    image: image,
                    imgId : imgId,
                    server: server,
                    credit: credit, 
                    controls: false,
                    zoom: 1,
                    render: 'spiral',
                    citeROI: roi,
                    showNavButtons: true
                    });
                    
                </script>
                
            </head>
            
            <body>
                <p>   URL base:     <xsl:value-of select="//img:serverUrl/@val"/></p>  
                <p>Image path:  <xsl:value-of select="//img:imgPath/@val"/></p>
                <p>Label : <xsl:apply-templates select="//img:label"></xsl:apply-templates></p>
                <p>RoI : <xsl:apply-templates select="//img:roi/@val"></xsl:apply-templates></p>

                <div style="width:99%;height:99%;margin-left:auto;margin-right:auto" id="targetframe"></div>
                
            </body>
        </html>
    </xsl:template>
    
    
</xsl:stylesheet>
