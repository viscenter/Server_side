
# Homer Multitext · Image Citation Tool #

## Overview ##

This is a tool intended to be used with the [CITE Architecture](http://www.homermultitext.org/hmt-doc/cite/index.html "CITE Documentation"), the digital library architecture developed for the [Homer Multitext](http://www.homermultitext.org/ "Homer Multitext"). CITE defines a protocol for service-based discovery and retrieval of digital images using canonical citation in URN format. This tool helps users create canonical citations to rectangular regions-of-interest on digital images.

## CITE Image URNs ##

A CITE URN identifying a digital image looks like this: `urn:cite:fufolioimg:ChadRGB.Chad012`. That URN points to a Collection called `fufolioimg`, containing an image-group called `ChadRGB` (the RGB composite images of the St. Chad Gospels from Lichfield Cathedral in England), containing an image named `Chad012`. This citation points to an _abstract image_, and is independent of any particular binary representation, file format, or scale.

## CITE Image URNs with ROI Suffixes ##

A CITE URN to an image can have a _suffix_ identifying a rectangular region-of-interest. E.g.

	urn:cite:fufolioimg:ChadRGB.Chad012:0.1438,0.1914,0.1325,0.0281
	
This points to the image `Chad012` in the group `ChadRGB` in the Image Collection `fufolioimg`, and more particularly to a rectangle whose left side is 14.35% from the left side of the image, whose top is 19.14% from the top, whose width is 13.25% of the image’s width, and whose heightis 2.81% of the image’s height. This ROI includes the word “_bonum_” on the manuscript folio.

## Using the ICT ##

Instructions for using the ICT are [online](http://www.homermultitext.org/hmt-doc/guides/ict.html "ICT Instructions").

## Configuring the ICT ##

The file `js/imgROI.js` contains a few pre-coded variables that you can edit for a customized installation. These include the URN to load by default, the default width of the displayed image, and the default Image Service URL. 

## Practical Uses ##

Because the ICT can accept a URN as a request-parameter, it is simple to invite users to create citations to ROIs on particular images via `html` links on a page. An example of this is [this page of images of William Bartram’s botanical specimens](http://folio.furman.edu/projects/botanicacaroliniana/bartram-images-ewf.html "Bartram Images").

## License ##

The HMT·ICT is copyright 2012, C. Blackwell &amp; D.N. Smith. Its code is freely available under the [GPL 3.0 licence](http://www.gnu.org/licenses/gpl-3.0.txt "GPL 3.0"). This work received support from the Andrew W. Mellon Foundation.

## Contact ##

Christopher W. Blackwell. christopher.blackwell@furman.edu
