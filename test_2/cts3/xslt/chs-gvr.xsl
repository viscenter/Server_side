<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:cts="http://chs.harvard.edu/xmlns/cts3" xmlns:dc="http://purl.org/dc/elements/1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="UTF-8" indent="no" method="html"/>
	<xsl:template match="/">
		<xsl:variable name="psg">
			<xsl:value-of select="//cts:request/cts:psg"/>
		</xsl:variable>
		<xsl:variable name="workUrn">
			<xsl:value-of select="//cts:request/cts:workUrn"/>
		</xsl:variable>
		<html>
			<head>
				<title>Valid references</title>
				<style media="screen" type="text/css">
                    @import "normalize.css";
                    @import "app.css";    
				</style>
			</head>
			<body>
				<script src="getPassage.js" type="text/javascript"/>
				<ul class="data">
					<xsl:element name="li">
						<xsl:attribute name="id">workUrn</xsl:attribute>
						<xsl:attribute name="value">
							<xsl:value-of select="$workUrn"/>
						</xsl:attribute>
						<xsl:value-of select="$workUrn"/>
					</xsl:element>
					<xsl:element name="li">
						<xsl:attribute name="id">psg</xsl:attribute>
						<xsl:attribute name="value">
							<xsl:value-of select="$psg"/>
						</xsl:attribute>
						<xsl:value-of select="$psg"/>
					</xsl:element>
				</ul>
				
				<header>Center for Hellenic Studies: Canonical Text Services</header>
				
				<nav>
					<p>
						<xsl:variable name="inv">
							<xsl:value-of select="//cts:inv"/>
						</xsl:variable>
						<xsl:variable name="gcparams">./CTS?inv=<xsl:value-of select="$inv"/>&amp;request=GetCapabilities&amp;withXSLT=chs-gc</xsl:variable>
						
						
						CTS: <a href="home">home</a> | 
						<xsl:element name="a">
							<xsl:attribute name="href"><xsl:value-of select="$gcparams"/></xsl:attribute>catalog of texts
						
						</xsl:element>
						| <a href="credits">credits</a>
					</p>
				</nav>
				<article>
				<xsl:choose>
					<xsl:when test="/cts:CTSError">
						<xsl:apply-templates select="cts:CTSError"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="//cts:request/cts:edition">
								<h1>Valid references for <xsl:value-of select="//cts:request/cts:groupname"/>, <em>
										<xsl:value-of select="//cts:request/cts:title"/>
									</em></h1>
								<h2>
									<xsl:value-of select="//cts:request/cts:label"/>
								</h2>
							</xsl:when>
							<xsl:when test="//cts:request/cts:translation">
								<h1>Valid references for <xsl:value-of select="//cts:request/cts:groupname"/>, <em>
										<xsl:value-of select="//cts:request/cts:title"/>
									</em></h1>
								<h2>
									<xsl:value-of select="//cts:request/cts:label"/>
								</h2>
							</xsl:when>
							<xsl:when test="//cts:request/cts:title">
								<h1>Valid references for <xsl:value-of select="//cts:request/cts:groupname"/>, <em>
										<xsl:value-of select="//cts:request/cts:title"/>
									</em></h1>
							</xsl:when>
							<xsl:when test="//cts:request/cts:groupname">
								<h1>Valid references for group <xsl:value-of select="//cts:request/cts:groupname"/></h1>
							</xsl:when>
						</xsl:choose>
						<xsl:variable name="urnString" select="/cts:GetValidReff/cts:request/cts:requestUrn"/>
						<p class="urn"> (= <xsl:value-of select="$urnString"/>) </p>
						<ul class="cts-content">
							<xsl:apply-templates select="/cts:GetValidReff/cts:reply/cts:reff"/>
						</ul>
						<xsl:choose>
							<xsl:when test="//cts:inv">
								<xsl:variable name="inv">
									<xsl:value-of select="//cts:inv"/>
								</xsl:variable>
								<xsl:variable name="lnkVar">./CTS?inv=<xsl:value-of select="$inv"/>&amp;request=GetValidReff&amp;urn=<xsl:value-of select="//cts:requestUrn"
									/></xsl:variable>
								<p>
									<xsl:element name="a">
										<xsl:attribute name="href">
											<xsl:value-of select="$lnkVar"/>
										</xsl:attribute>
										<xsl:element name="img">
											<xsl:attribute name="src">xml.png</xsl:attribute>
										</xsl:element>
									</xsl:element>
								</p>
							</xsl:when>
							<xsl:otherwise>
								<xsl:variable name="lnkVar">./CTS?request=GetValidReff&amp;urn=<xsl:value-of select="//cts:requestUrn"/></xsl:variable>
								<p>
									<xsl:element name="a">
										<xsl:attribute name="href">
											<xsl:value-of select="$lnkVar"/>
										</xsl:attribute>
										<xsl:element name="img">
											<xsl:attribute name="src">xml.png</xsl:attribute>
										</xsl:element>
									</xsl:element>
								</p>
							</xsl:otherwise>
						</xsl:choose>
						<div class="form">
							<form action="./CTS" onsubmit="return setUrn()">
								<fieldset>
									<legend>Go directly to passage</legend>
									<ol>
										<li>
											<label for="psgInput">reference</label>
											<input id="psgInput" name="psg" value="{$psg}"/>
										</li>
									</ol>
									<input name="request" type="hidden" value="GetPassagePlus"/>
									<input name="withXSLT" type="hidden" value="chs-gp"/>
									<input name="urn" type="hidden" value="{$urnString}"/>
									<xsl:if test="//cts:inv">
										<xsl:variable name="inv">
											<xsl:value-of select="//cts:inv"/>
										</xsl:variable>
										<input name="inv" type="hidden" value="{$inv}"/>
									</xsl:if>
									
									Lines of context: <select
										name="context">
										<option
											value="0">none</option>
										<option>5</option>
										<option>10</option>
										<option>20</option>
									</select>
								</fieldset>
								<fieldset class="submit">
									<input type="submit" value="Get passage"/>
								</fieldset>
							</form>
						</div>
						
					</xsl:otherwise>
				</xsl:choose>
				</article>
				<footer>
					<xsl:value-of select="//cts:versionInfo"/>
				</footer>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="cts:CTSError">
		<h1>CTS Error</h1>
		<p class="error">
			<xsl:apply-templates select="cts:message"/>
		</p>
		<p>Error code: <xsl:apply-templates select="cts:code"/></p>
		<p>CTS library version: <xsl:apply-templates select="cts:libraryVersion"/>
		</p>
		<p>CTS library date: <xsl:apply-templates select="cts:libraryDate"/>
		</p>
	</xsl:template>
	<xsl:template match="cts:reff">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="cts:urn">
		<li>
			<xsl:call-template name="urnPsg">
				<xsl:with-param name="urnStr">
					<xsl:value-of select="."/>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:text>:  </xsl:text>
			<!-- put together var with gp string -->
			<xsl:choose>
				<xsl:when test="//cts:inv">
					<xsl:variable name="inv">
						<xsl:value-of select="//cts:inv"/>
					</xsl:variable>
					<xsl:variable name="psg">./CTS?withXSLT=chs-gp&amp;request=GetPassagePlus&amp;urn=<xsl:value-of select="."/>&amp;inv=<xsl:value-of select="$inv"
						/></xsl:variable>
					<xsl:element name="a">
						<xsl:attribute name="href">
							<xsl:value-of select="$psg"/>
						</xsl:attribute> view passage</xsl:element>
					<xsl:if test="//cts:request/cts:level">
						<xsl:variable name="level">
							<xsl:value-of select="//cts:request/cts:level"/>
						</xsl:variable>
						<xsl:variable name="minimumLeaf">
							<xsl:value-of select="//cts:request/cts:minimumLeaf"/>
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="$level &lt; $minimumLeaf">
								<xsl:variable name="newLevel">
									<xsl:value-of select="$level + 1"/>
								</xsl:variable>
								<!-- include inventory as param -->
								<xsl:variable name="url">./CTS?withXSLT=chs-gvr&amp;request=GetValidReff&amp;urn=<xsl:value-of select="."/>&amp;level=<xsl:value-of select="$newLevel"
										/>&amp;inv=<xsl:value-of select="$inv"/></xsl:variable>
								<xsl:text> : </xsl:text>
								<xsl:element name="a">
									<xsl:attribute name="href">
										<xsl:value-of select="$url"/>
									</xsl:attribute>
                                        expand one level
                                    </xsl:element>
							</xsl:when>
							<xsl:otherwise><!-- no expansion --></xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="psg">./CTS?withXSLT=chs-gp&amp;request=GetPassagePlus&amp;urn=<xsl:value-of select="."/></xsl:variable>
					<xsl:element name="a">
						<xsl:attribute name="href">
							<xsl:value-of select="$psg"/>
						</xsl:attribute>view passage</xsl:element>
					<xsl:if test="//cts:request/cts:level">
						<xsl:variable name="level">
							<xsl:value-of select="//cts:request/cts:level"/>
						</xsl:variable>
						<xsl:variable name="minimumLeaf">
							<xsl:value-of select="//cts:request/cts:minimumLeaf"/>
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="$level &lt; $minimumLeaf">
								<xsl:variable name="newLevel">
									<xsl:value-of select="$level + 1"/>
								</xsl:variable>
								<!-- no inventory: using default -->
								<xsl:variable name="url">./CTS?withXSLT=chs-gvr&amp;request=GetValidReff&amp;urn=<xsl:value-of select="."/>&amp;level=<xsl:value-of select="$newLevel"
									/></xsl:variable>
								<xsl:text> : </xsl:text>
								<xsl:element name="a">
									<xsl:attribute name="href">
										<xsl:value-of select="$url"/>
									</xsl:attribute>
                                            expand one level
                                        </xsl:element>
							</xsl:when>
							<xsl:otherwise><!-- no expansion --></xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:template>
	<xsl:template name="urnPsg">
		<xsl:param name="urnStr"/>
		<xsl:choose>
			<xsl:when test="contains($urnStr,':')">
				<xsl:call-template name="urnPsg">
					<xsl:with-param name="urnStr">
						<xsl:value-of select="substring-after($urnStr,':')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$urnStr"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="@*|node()" priority="-1">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
