<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:cts="http://chs.harvard.edu/xmlns/cts3"
    xmlns:dc="http://purl.org/dc/elements/1.1"
    xmlns:ti="http://chs.harvard.edu/xmlns/cts3/ti"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output
        encoding="UTF-8"
        indent="no"
        method="html"/>
    <xsl:template
        match="/">
        <html>
            <head>
                <title>Inventory</title>
                <style media="screen" type="text/css">
                    @import "normalize.css";
                    @import "app.css";
                    @import "inventory.css";</style>
            </head>
            <body>
                <header>Center for Hellenic Studies: Canonical Text Services</header>
                <nav>
                    <p>CTS: <a
                            href="home">home</a> | <a
                            href="credits">credits</a>
                    </p>
                </nav>
                <article>
                    <h1>Inventory of texts</h1>
                    <ul>
                        <xsl:apply-templates
                            select="//ti:textgroup"/>
                    </ul>
                    <xsl:choose>
                        <xsl:when
                            test="//cts:inv">
                            <xsl:variable
                                name="lnkVar">./CTS?inv=<xsl:value-of
                                    select="//cts:inv"/>&amp;request=GetCapabilities</xsl:variable>
                            <p>
                                <xsl:element
                                    name="a">
                                    <xsl:attribute
                                        name="href">
                                        <xsl:value-of
                                            select="$lnkVar"/>
                                    </xsl:attribute>
                                    <xsl:element
                                        name="img">
                                        <xsl:attribute
                                            name="src">xml.png</xsl:attribute>
                                    </xsl:element>
                                </xsl:element>
                            </p>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:variable
                                name="lnkVar">./CTS?request=GetCapabilities</xsl:variable>
                            <p>
                                <xsl:element
                                    name="a">
                                    <xsl:attribute
                                        name="href">
                                        <xsl:value-of
                                            select="$lnkVar"/>
                                    </xsl:attribute>
                                    <xsl:element
                                        name="img">
                                        <xsl:attribute
                                            name="src">xml.png</xsl:attribute>
                                    </xsl:element>
                                </xsl:element>
                            </p>
                        </xsl:otherwise>
                    </xsl:choose>
                </article>
                <footer>
                    <xsl:value-of
                        select="//cts:versionInfo"/>
                </footer>
            </body>
        </html>
    </xsl:template>
    <xsl:template
        name="ti:namespace">
        <li>
            <strong>
                <xsl:value-of
                    select="./@abbreviation"/>
            </strong>: <xsl:value-of
                select="./@nsURI"/>
            <text> </text>
            <xsl:value-of
                select="ti:description"/>
        </li>
    </xsl:template>
    <xsl:template
        match="ti:textgroup">
        <li>
            <strong>
                <xsl:value-of
                    select="ti:groupname[1]"/>
            </strong>
            <xsl:element
                name="span">
                <xsl:attribute
                    name="class">metadata</xsl:attribute>
                <xsl:text>(group ID </xsl:text>
                <xsl:value-of
                    select="./@projid"/>
                <xsl:text>) </xsl:text>
            </xsl:element>
        </li>
        <ul>
            <xsl:for-each
                select="ti:work">
                <xsl:sort
                    select="ti:title[1]"/>
                <xsl:apply-templates
                    select="."/>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template
        match="ti:work">
        <li>
            <em
                class="title">
                <xsl:value-of
                    select="ti:title[1]"/>
            </em>
            <xsl:element
                name="span">
                <xsl:attribute
                    name="class">metadata</xsl:attribute>
                <xsl:text>(work ID </xsl:text>
                <xsl:value-of
                    select="./@projid"/>
                <xsl:text>) </xsl:text>
            </xsl:element>
            <ul>
                <xsl:apply-templates
                    select="ti:edition[ti:online]"/>
                <xsl:apply-templates
                    select="ti:translation[ti:online]"/>
                <xsl:apply-templates
                    mode="offline"
                    select="ti:edition"/>
                <xsl:apply-templates
                    mode="offline"
                    select="ti:translation"/>
            </ul>
        </li>
    </xsl:template>
    <xsl:template
        match="ti:edition|ti:translation"
        mode="offline">
        <xsl:choose>
            <xsl:when
                test="ti:online">
                <!-- do nothing -->
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates
                    select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template
        match="ti:edition|ti:translation">
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
            <xsl:value-of
                select="ti:label"/>
            <xsl:element
                name="span">
                <xsl:attribute
                    name="class">metadata</xsl:attribute>
                <xsl:text>(edition ID </xsl:text>
                <xsl:value-of
                    select="./@projid"/>
                <xsl:text>) </xsl:text>
            </xsl:element>
            <xsl:value-of
                select="ti:description"/>
            <xsl:if
                test="ti:online">
                <xsl:variable
                    name="qualifiedWorkId">
                    <xsl:value-of
                        select="ancestor::ti:work/@projid"/>
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
                        select="ancestor::ti:textgroup/@projid"/>.<xsl:value-of
                        select="$workId"/>.<xsl:value-of
                        select="$edId"/></xsl:variable>
                <p>See valid references, limited to <form
                        action="./CTS">
                        <input
                            name="request"
                            type="hidden"
                            value="GetValidReff"/>
                        <input
                            name="withXSLT"
                            type="hidden"
                            value="chs-gvr"/>
                        <input
                            name="urn"
                            type="hidden"
                            value="{$urn}"/>
                        <xsl:if
                            test="//cts:inv">
                            <xsl:variable
                                name="inv">
                                <xsl:value-of
                                    select="//cts:inv"/>
                            </xsl:variable>
                            <input
                                name="inv"
                                type="hidden"
                                value="{$inv}"/>
                        </xsl:if>
                        <select
                            name="level">
                            <xsl:apply-templates
                                select="ti:online/ti:citationMapping/ti:citation[1]">
                                <xsl:with-param
                                    name="level">1</xsl:with-param>
                            </xsl:apply-templates>
                        </select>
                        <input
                            type="submit"
                            value="Find references"/>
                    </form>
                </p>
                <!--
                <p>Online. Work cited by <xsl:choose>
                        <xsl:when
                            test="count(ti:online/ti:citationMapping/ti:citation) = 1"> 1 citation
                            format. </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="count(ti:online/ti:citationMapping/ti:citation)"/> citation
                            formats. </xsl:otherwise>
                    </xsl:choose>
                </p>
                -->
            </xsl:if>
        </li>
    </xsl:template>
    <xsl:template
        match="ti:citation">
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
            select="ti:citation">
            <xsl:with-param
                name="level">
                <xsl:value-of
                    select="$level + 1"/>
            </xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    <xsl:template
        match="ti:collection">
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
