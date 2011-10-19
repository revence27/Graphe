Graphe: Static HTML Bible
=========================

Graphe generates a Bible in static HTML, with the filesystem serving as the markers. It is not capable of search, unless the system you are running it on provides a useful general file system search. At the very least, it is an equivalent of the paper Bible in terms of laying out the content.

It uses the XML format (and, for that matter, the files) found at [the Church Software project at Google Code](http://code.google.com/p/churchsoftware/downloads/list).

The effective code is the file `graphe.rb` which requires a HTML template file. The bare-minimum template file is included as `template.html`.

To generate the Bible:

  ruby graphe.rb template.html destinationdir bible.xml

And then it runs; after a while, processing that XML file, you have a static HTML Bible in the location you chose (`destinationdir`), which need not exist beforehand.
