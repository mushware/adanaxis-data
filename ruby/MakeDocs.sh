#/!bin/sh

rm -rf doc/files doc/index doc/index.html doc/javascript doc/menu.html doc/styles
perl ../../../NaturalDocs/NaturalDocs --input . --output FramedHTML doc --exclude-input doxygen --project ../../../NaturalDocs/core-app --rebuild
ln -s ../../../../doxygen/html doc/files/doxygen