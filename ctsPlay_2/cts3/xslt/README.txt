The CTS servlet looks for an HTTP parameter named "withXSLT":  if it finds
one, it attaches to the XML of its reply a processing instruction
associating an XSLT file named "xslt/${withXSLT}.xsl"

You can therefore select from multiple possible transformations of your 
CTS reply.  Note that if you apply an XSLT transformation embedding 
links to other CTS calls, you should select an appropriate value for
the optional "withXSLT" parameter.

This implies that in general you will probably want to plan suites of
XSLT transformations that link to each other:  one for GetCapabilities,
one for GetValidReff, and one for GetPassage* requests.

One example of such a suite is the trio of stylesheets chs-gc.xsl,
chs-gvr.xsl and chs-gp.xsl.


