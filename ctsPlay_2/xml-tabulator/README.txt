SUMMARY
Tabulator is a utility that takes an XML source file documented in
a TextInventory, and creates from it a tabular text file that you can
import into a relational database or a Google's BigTable.

VERSION
Release candidate 1 (compiled Aug. 19, 2009).

INSTALLING THE APPLICATION
If you are reading this file, it should be correctly installed
already.  You can move the tabulator directory anywhere you like, but
do not move the location of the lib directory and Tabulator.jar file
within the directory.

PREREQUISITES
You'll need one or more XML files, and a TextInventory that
validates against the version 3.0 TextInventory schema. 

SAMPLE CONTENT INCLUDED IN THIS PACKAGE
The Tabulator package is distributed with a directory called "inventories" that 
includes a sample TextInventory, sampleinventory.xml, along with the the 
Relax NG schema it validates against.  If you use the oXygen XML editor, you
can use the  included CSS stylesheet textinventory.css for "tagless" editing.
You can use the included XSLT stylesheet inventory.xsl to view the inventory 
as XHTML.

In the directory called "testcorpus" you will find the XML files described 
in sampleinventory.xml.  You can test your validator installation with this data
set, or use this material as a model for creating your text inventory and coordinated
corpus of xml texts to tabulate.

STARTING TABULATOR
On some operating systems, you should be able to double-click
Tabulator.jar, or open Tabulator.jar from a right-clicked pop-up menu.

In any case, "java -jar Tabulator.jar" should work.

USING TABULATOR
In the main application window, you must first select a TextInventory, 
a directory with the XML texts documented in the TextInventory, and
a directory where the new tabular files should be saved.

After selecting a TextInventory, you will see a list of available texts
in the bottom of the pane. Select one or more texts from the list, then,
from the "Tabulate" menu, choose "Tabulate selected online texts in
inventory" (control-T for short, or apple-T on Macintosh systems).

Text files will be added to the specified output directory, with the
file name defined by the work component of the text's plus ".txt".

You can choose the number of records to write to each file with the
setting labelled "Break output into units of".

MORE INFORMATION
A fuller manual is currently being written as the application is being
tested.
