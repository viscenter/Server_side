<?xml version="1.0" encoding="UTF-8"?>
<!-- 
Transform a TextInventory document into XHTML.
-->
<xsl:stylesheet
    version="1.0"
    xmlns:cts="http://chs.harvard.edu/xmlns/cts3/ti"
    xmlns:dc="http://purl.org/dc/elements/1.1"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template
        match="/">
        <html>
            <head>
                <title>Text Inventory</title>
                <style
                    media="screen"
                    type="text/css"> 
                   
                    @import "webbase.css";
                    @import "webinventory.css"; 
                    
                </style>
            </head>
            <body>
                <h1>Text Inventory</h1>
                <!--
                <xsl:apply-templates select="/cts:TextInventory/cts:collection[@isdefault = 'yes']"/>
                -->
                <xsl:if
                    test="/cts:TextInventory/cts:ctsnamespace">
                    <h2>Namespaces</h2>
                    <p>A CTS namespace is a standard source for identifiers for some corpus of
                        texts.</p>
                    <ul>
                        <xsl:apply-templates
                            select="/cts:TextInventory/cts:ctsnamespace"/>
                    </ul>
                </xsl:if>
                <h2>Texts</h2>
                <ul>
                    <xsl:for-each
                        select="//cts:textgroup">
                        <xsl:sort select="cts:groupname[1]"/>
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
    <xsl:template
        name="cts:namespace">
        <li>
            <strong>
                <xsl:value-of
                    select="./@abbreviation"/>
            </strong>: <xsl:value-of
                select="./@nsURI"/>
            <text> </text>
            <xsl:value-of
                select="cts:description"/>
        </li>
    </xsl:template>
    <xsl:template
        match="cts:textgroup">
        <li> 
            
            <strong> <xsl:value-of
            select="cts:groupname[1]"/>
            </strong>
            <xsl:element name="span">
                <xsl:attribute name="class">metadata</xsl:attribute>
                <xsl:text>(group ID </xsl:text>
                <xsl:value-of
                select="./@projid"/>
                <xsl:text>) </xsl:text>
            </xsl:element>
               
        <!--
            <xsl:if test="count(cts:groupname) > 1">
                <xsl:for-each select="cts:groupname">
                   
                        <xsl:if
                            test="position() != last()">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
              
                </xsl:for-each>
            </xsl:if> -->
             
        </li>
        <ul>
            <xsl:for-each
                select="cts:work">
                <xsl:sort select="cts:title[1]"/>
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template
        match="cts:work">
        <li>  <em
            class="title">
            <xsl:value-of select="cts:title[1]"/>
        </em>
            <xsl:element name="span">
                <xsl:attribute name="class">metadata</xsl:attribute>
                <xsl:text>(work ID </xsl:text>
                <xsl:value-of select="./@projid"/>
                <xsl:text>) </xsl:text>
            </xsl:element>
          
            
            
            <!-- <xsl:for-each
                select="cts:title">
                <em
                    class="title">
                    <xsl:value-of
                        select="."/>
                </em>
          
                <span
                    class="metadata">[<xsl:value-of
                        select="./@xml:lang"/>]</span>
                <xsl:if
                    test="position() != last()">
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:for-each>
            -->
            
            <ul>
                <xsl:apply-templates
                    select="cts:edition"/>
                <xsl:apply-templates
                    select="cts:translation"/>
            </ul>
        </li>
    </xsl:template>
    <xsl:template
        match="cts:edition|cts:translation">
        <li>
            <xsl:choose>
                <xsl:when
                    test="local-name() = 'edition'"> Edition: </xsl:when>
                <xsl:when
                    test="local-name() = 'translation'"> Translation: <span
                        class="metadata">[<xsl:value-of
                            select="./@xml:lang"/>] </span>
                </xsl:when>
            </xsl:choose>
            <xsl:value-of select="cts:label"/>
            
            <xsl:element name="span">
                <xsl:attribute name="class">metadata</xsl:attribute>
                <xsl:text>(edition ID </xsl:text>
                <xsl:value-of select="./@projid"/>
                <xsl:text>) </xsl:text>
            </xsl:element>
           
            <xsl:value-of
                select="cts:description"/>
            <xsl:if
                test="cts:online">
                <xsl:variable
                    name="qualifiedWorkId">
                    <xsl:value-of
                        select="ancestor::cts:work/@projid"/>
                </xsl:variable>
                <xsl:variable
                    name="workId">
                    <xsl:value-of
                        select="substring-after($qualifiedWorkId,':')"/>
                </xsl:variable>
                <xsl:variable
                    name="edId">
                    <xsl:value-of
                        select="substring-after(./@projid,':')"/>
                </xsl:variable>
                <xsl:variable
                    name="urn">urn:cts:<xsl:value-of
                        select="ancestor::cts:textgroup/@projid"/>.<xsl:value-of
                        select="$workId"/>.<xsl:value-of
                        select="$edId"/></xsl:variable>
                <p>Online. Work cited by <xsl:choose>
                        <xsl:when
                            test="count(cts:online/cts:citationMapping/cts:citation) = 1"> 1
                            citation format. </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="count(cts:online/cts:citationMapping/cts:citation)"/>
                            citation formats. </xsl:otherwise>
                    </xsl:choose>
                </p>
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template
        match="cts:citation">
        <xsl:param
            name="level"/>
        <option
            value="{$level}">
            <xsl:value-of
                select="./@label"/>
        </option>
        <xsl:variable
            name="nextLevel">
            <xsl:value-of
                select="$level + 1"/>
        </xsl:variable>
        <xsl:apply-templates
            select="cts:citation">
            <xsl:with-param
                name="level">
                <xsl:value-of
                    select="$level + 1"/>
            </xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template
        match="cts:collection">
        <p>collection <xsl:value-of
                select="./@id"/></p>
    </xsl:template>
    <!-- Default: replicate unrecognized nodes and attributes -->
    <xsl:template
        match="@*|node()"
        priority="-1">
        <xsl:copy>
            <xsl:apply-templates
                select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
