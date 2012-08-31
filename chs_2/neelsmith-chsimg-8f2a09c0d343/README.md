# CHS Image service

`chsimg` is a groovlet (java servlet written in Groovy) implementing the CHS Image Extension for CITE Collections.  In addition to requests for standard textual data about images (rights, and caption information), the CHS Image Extension defines a request for binary image data.  This implementation uses a JDBC database to manage the information about the images.  Binary image data is retrieved from a local or remote installation of [IIPImage server](http://iipimage.sourceforge.net/).  If an installation of IIPImage server is accessible from the same domain name that CHS Image Service is running on, then a further request getting information needed to create zoomable/pannable images and attaching an XSL stylesheet setting up a zoomable interface can be viewed interactively in a web browser.

By default, the included `build.gradle` file is configured with a dependency on postgres for its JDBC data source.  To use a different JDBC source, substitute the appropriate dependency for the postgres dependency.


## Configuration


1. To use the included build.gradle file, copy `gradle.properties-dist` to `gradle.properties`
2. Edit `src/main/webapp/configs/citeconfig.xml`.  Supply appropriate values for your database in the attributes of the `jdbcConfig` element.  On the `iipimage` element, supply a URL to an IIP server for your installation.  Note that it may be a remote URL, but if it is not available on the same host as `chsimg`, you should set the `includeZoomable` attribute to "false".  You may also set this attribute to "false" if you wish to turn off zooming and panning with IIPMooViewer for an IIP server on the same host as your CHS image service.

## Building and running ##

The standard gradle tasks for a servlet are available, including

`gradle war`
: builds a war file you can drop into a servlet container

`gradle jettyRunWar`
: builds a war file, and runs it locally in a jetty container on the port configured in the `build.gradle` file


## License
All source code  is licensed under the GNU General Public License version 3 ([http://www.gnu.org/licenses/gpl.html](http://www.gnu.org/licenses/gpl.html)).

## Contact
Neel Smith :  nsmith@holycross.edu

