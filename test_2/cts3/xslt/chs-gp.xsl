<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:cts="http://chs.harvard.edu/xmlns/cts3"
	xmlns:dc="http://purl.org/dc/elements/1.1"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include
		href="tei-html.xsl"/>
	<!-- Framework for main body of document -->
	<xsl:template
		match="/">
		<!-- can some of the reply contents in xsl variables
			for convenient use in different parts of the output -->
		<xsl:variable
			name="urnString">
			<xsl:value-of
				select="//cts:request/cts:requestUrn"/>
		</xsl:variable>
		<xsl:variable
			name="psg">
			<xsl:value-of
				select="//cts:request/cts:psg"/>
		</xsl:variable>
		<xsl:variable
			name="workUrn">
			<xsl:value-of
				select="//cts:request/cts:workUrn"/>
		</xsl:variable>
		<html>
			<head>
				<title><xsl:value-of
						select="//cts:request/cts:groupname"/>, <xsl:value-of
						select="//cts:request/cts:title"/> : <xsl:value-of
						select="//cts:request/cts:label"/>
				</title>
				<style media="screen" type="text/css">
                    @import "normalize.css";
                    @import "app.css";
	@import "tei.css";
				</style>
				
			</head>
			<body>
				<script src="getPassage.js" type="text/javascript"/>
				<ul
					class="data">
					<xsl:element
						name="li">
						<xsl:attribute
							name="id">workUrn</xsl:attribute>
						<xsl:attribute
							name="value">
							<xsl:value-of
								select="$workUrn"/>
						</xsl:attribute>
						<xsl:value-of
							select="$workUrn"/>
					</xsl:element>
					<xsl:element
						name="li">
						<xsl:attribute
							name="id">psg</xsl:attribute>
						<xsl:attribute
							name="value">
							<xsl:value-of
								select="$psg"/>
						</xsl:attribute>
						<xsl:value-of
							select="$psg"/>
					</xsl:element>
				</ul>
				<header>Center for Hellenic Studies: Canonical Text Services</header>
				
				<nav>
					<p>
						<xsl:variable
							name="inv">
							<xsl:value-of
								select="//cts:inv"/>
						</xsl:variable>
						<xsl:variable
							name="gcparams">./CTS?inv=<xsl:value-of
								select="$inv"/>&amp;request=GetCapabilities&amp;withXSLT=chs-gc</xsl:variable>
						CTS: <a
							href="home">home</a> | <xsl:element
							name="a">
							<xsl:attribute
								name="href"><xsl:value-of
									select="$gcparams"/></xsl:attribute>catalog of texts
						</xsl:element> | <a
							href="credits">credits</a>
					</p>
				</nav>
				<article>
					<div
					class="cts-content">
					<xsl:choose>
						<xsl:when
							test="/cts:CTSError">
							<xsl:apply-templates
								select="cts:CTSError"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when
									test="//cts:request/cts:edition">
									<h1><xsl:value-of
											select="//cts:request/cts:groupname"/>, <em>
											<xsl:value-of
												select="//cts:request/cts:title"/>
										</em>: <xsl:value-of
											select="//cts:request/cts:psg"/>
									</h1>
									<h2>
										<xsl:value-of
											select="//cts:request/cts:label"/>
									</h2>
								</xsl:when>
								<xsl:when
									test="//cts:request/cts:translation">
									<h1>
										<xsl:value-of
											select="//cts:request/cts:groupname"/>, <em>
											<xsl:value-of
												select="//cts:request/cts:title"/>
										</em>: <xsl:value-of
											select="//cts:request/cts:psg"/></h1>
									<h2>
										<xsl:value-of
											select="//cts:request/cts:label"/>
									</h2>
								</xsl:when>
								<xsl:when
									test="//cts:request/cts:title">
									<h1>
										<xsl:value-of
											select="//cts:request/cts:groupname"/>, <em>
											<xsl:value-of
												select="//cts:request/cts:title"/>: <xsl:value-of
												select="//cts:request/cts:psg"/>
										</em></h1>
									<h2>
										<xsl:value-of
											select="//cts:request/cts:label"/>
									</h2>
								</xsl:when>
								<xsl:when
									test="//cts:request/cts:groupname">
									<h1>
										<xsl:value-of
											select="//cts:request/cts:groupname"/>
									</h1>
									<h2>
										<xsl:value-of
											select="//cts:request/cts:label"/>
									</h2>
								</xsl:when>
							</xsl:choose>
							<p
								class="urn"> ( = <xsl:value-of
									select="$urnString"/> ) </p>
							<xsl:apply-templates
								select="//cts:reply"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when
							test="//cts:inv">
							<xsl:variable
								name="inv">
								<xsl:value-of
									select="//cts:inv"/>
							</xsl:variable>
							<xsl:variable
								name="lnkVar">./CTS?inv=<xsl:value-of
									select="$inv"/>&amp;request=GetPassagePlus&amp;urn=<xsl:value-of
									select="//cts:requestUrn"/></xsl:variable>
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
								name="lnkVar">./CTS?request=GetPassagePlus&amp;urn=<xsl:value-of
									select="//cts:requestUrn"/></xsl:variable>
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
				</div>
				<div
					class="form">
					<form
						action="./CTS"
						onsubmit="return setUrn();">
						<fieldset>
							<legend>Go directly to passage</legend>
							<ol>
								<li>
									<label
										for="psgInput">reference</label>
									<input
										id="psgInput"
										name="psg"
										value="{$psg}"/>
								</li>
							</ol>
							<input
								name="request"
								type="hidden"
								value="GetPassagePlus"/>
							<input
								name="withXSLT"
								type="hidden"
								value="chs-gp"/>
							<input
								name="urn"
								type="hidden"
								value="{$urnString}"/>
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
							Lines of context: <select
								name="context">
								<option
									value="0">none</option>
								<option>5</option>
								<option>10</option>
								<option>20</option>
							</select>
						</fieldset>
						<fieldset
							class="submit">
							<input
								type="submit"
								value="Get passage"/>
						</fieldset>
					</form>
				</div>
				</article>
				<footer>
					<xsl:value-of
						select="//cts:versionInfo"/>
				</footer>
			</body>
		</html>
	</xsl:template>
	<!-- End Framework for main body document -->
	<!-- Match elements of the CTS reply -->
	<xsl:template
		match="cts:reply">
		<xsl:element
			name="div">
			<xsl:attribute
				name="lang">
				<xsl:value-of
					select="@xml:lang"/>
			</xsl:attribute>
			<!--
			<xsl:if
				test="(//cts:reply/@xml:lang = 'grc') or (//cts:reply/@xml:lang = 'lat')">
				<xsl:attribute
					name="class">cts-content alpheios-enabled-text</xsl:attribute>
			</xsl:if> -->
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template
		match="cts:CTSError">
		<h1>CTS Error</h1>
		<p
			class="cts:error">
			<xsl:apply-templates
				select="cts:message"/>
		</p>
		<p>Error code: <xsl:apply-templates
				select="cts:code"/></p>
		<p>Error code: <xsl:apply-templates
				select="cts:code"/></p>
		<p>CTS library version: <xsl:apply-templates
				select="cts:libraryVersion"/>
		</p>
		<p>CTS library date: <xsl:apply-templates
				select="cts:libraryDate"/>
		</p>
	</xsl:template>
	<xsl:template
		match="cts:contextinfo">
		<xsl:variable
			name="ctxt">
			<xsl:value-of
				select="cts:context"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="$ctxt > 0">
				<div
					class="prevnext">
					<span
						class="prv">
						<xsl:choose>
							<xsl:when
								test="//cts:inv">
								<xsl:variable
									name="inv">
									<xsl:value-of
										select="//cts:inv"/>
								</xsl:variable>
								<xsl:variable
									name="prvVar">./CTS?inv=<xsl:value-of
										select="$inv"/>&amp;request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
											select="cts:contextback"/>&amp;context=<xsl:value-of
												select="$ctxt"/></xsl:variable>
								<xsl:element
									name="a">
									<xsl:attribute
										name="href">
										<xsl:value-of
											select="$prvVar"/>
									</xsl:attribute> back </xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<xsl:variable
									name="prvVar">./CTS?request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
										select="cts:contextback"/>&amp;context=<xsl:value-of
											select="$ctxt"/></xsl:variable>
								<xsl:element
									name="a">
									<xsl:attribute
										name="href">
										<xsl:value-of
											select="$prvVar"/>
									</xsl:attribute> back </xsl:element>
							</xsl:otherwise>
						</xsl:choose>
					</span>| <span
						class="nxt">
						<xsl:choose>
							<xsl:when
								test="//cts:inv">
								<xsl:variable
									name="inv">
									<xsl:value-of
										select="//cts:inv"/>
								</xsl:variable>
								<xsl:variable
									name="nxtVar">./CTS?inv=<xsl:value-of
										select="$inv"/>&amp;request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
											select="cts:contextforward"/>&amp;context=<xsl:value-of
												select="$ctxt"/></xsl:variable>
								<xsl:element
									name="a">
									<xsl:attribute
										name="href">
										<xsl:value-of
											select="$nxtVar"/>
									</xsl:attribute> forward </xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<xsl:variable
									name="nxtVar">./CTS?request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
										select="cts:contextforward"/>&amp;context=<xsl:value-of
											select="$ctxt"/></xsl:variable>
								<xsl:element
									name="a">
									<xsl:attribute
										name="href">
										<xsl:value-of
											select="$nxtVar"/>
									</xsl:attribute> forward </xsl:element>
							</xsl:otherwise>
						</xsl:choose>
					</span>
				</div>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>
	<xsl:template
		match="cts:prevnext">
		<xsl:variable
			name="ctxt">
			<xsl:value-of
				select="//cts:context"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="$ctxt > 0">
				<!-- Do nothing! -->
			</xsl:when>
			<xsl:otherwise>
				<div
					class="prevnext">
					<span
						class="prv">
						<xsl:if
							test="cts:prev != ''">
							<xsl:choose>
								<xsl:when
									test="//cts:inv">
									<xsl:variable
										name="inv">
										<xsl:value-of
											select="//cts:inv"/>
									</xsl:variable>
									<xsl:variable
										name="prvVar">./CTS?inv=<xsl:value-of
											select="$inv"/>&amp;request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
												select="cts:prev"/></xsl:variable>
									<xsl:element
										name="a">
										<xsl:attribute
											name="href">
											<xsl:value-of
												select="$prvVar"/>
										</xsl:attribute> prev </xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<xsl:variable
										name="prvVar">./CTS?request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
											select="cts:prev"/></xsl:variable>
									<xsl:element
										name="a">
										<xsl:attribute
											name="href">
											<xsl:value-of
												select="$prvVar"/>
										</xsl:attribute> prev </xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</span> | <span
						class="nxt">
						<xsl:if
							test="cts:next != ''">
							<xsl:choose>
								<xsl:when
									test="//cts:inv">
									<xsl:variable
										name="inv">
										<xsl:value-of
											select="//cts:inv"/>
									</xsl:variable>
									<xsl:variable
										name="nxtVar">./CTS?inv=<xsl:value-of
											select="$inv"/>&amp;request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
												select="cts:next"/></xsl:variable>
									<xsl:element
										name="a">
										<xsl:attribute
											name="href">
											<xsl:value-of
												select="$nxtVar"/>
										</xsl:attribute> next </xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<xsl:variable
										name="nxtVar">./CTS?request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
											select="cts:next"/></xsl:variable>
									<xsl:element
										name="a">
										<xsl:attribute
											name="href">
											<xsl:value-of
												select="$nxtVar"/>
										</xsl:attribute> next </xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</span>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!--<xsl:template
		match="cts:prevnext">
		<div
			class="prevnext">
			<span
				class="prv">
				<xsl:if
					test="cts:prev != ''">
					<xsl:choose>
						<xsl:when
							test="//cts:inv">
							<xsl:variable
								name="inv">
								<xsl:value-of
									select="//cts:inv"/>
							</xsl:variable>
							<xsl:variable
								name="prvVar">./CTS?inv=<xsl:value-of
									select="$inv"/>&amp;request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
									select="cts:prev"/></xsl:variable>
							<xsl:element
								name="a">
								<xsl:attribute
									name="href">
									<xsl:value-of
										select="$prvVar"/>
								</xsl:attribute> prev </xsl:element>
						</xsl:when>
						<xsl:otherwise>
							<xsl:variable
								name="prvVar">./CTS?request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
									select="cts:prev"/></xsl:variable>
							<xsl:element
								name="a">
								<xsl:attribute
									name="href">
									<xsl:value-of
										select="$prvVar"/>
								</xsl:attribute> prev </xsl:element>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</span> | <span
				class="nxt">
				<xsl:if
					test="cts:next != ''">
					<xsl:choose>
						<xsl:when
							test="//cts:inv">
							<xsl:variable
								name="inv">
								<xsl:value-of
									select="//cts:inv"/>
							</xsl:variable>
							<xsl:variable
								name="nxtVar">./CTS?inv=<xsl:value-of
									select="$inv"/>&amp;request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
									select="cts:next"/></xsl:variable>
							<xsl:element
								name="a">
								<xsl:attribute
									name="href">
									<xsl:value-of
										select="$nxtVar"/>
								</xsl:attribute> next </xsl:element>
						</xsl:when>
						<xsl:otherwise>
							<xsl:variable
								name="nxtVar">./CTS?request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
									select="cts:next"/></xsl:variable>
							<xsl:element
								name="a">
								<xsl:attribute
									name="href">
									<xsl:value-of
										select="$nxtVar"/>
								</xsl:attribute> next </xsl:element>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</span>
		</div>
	</xsl:template>
	-->
	<!-- Default: replicate unrecognized markup -->
	<xsl:template
		match="@*|node()"
		priority="-1">
		<xsl:copy>
			<xsl:apply-templates
				select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
