#/!bin/sh

rm -rf doc/*
perl ../../../NaturalDocs/NaturalDocs --input . --output FramedHTML doc --project ../../../NaturalDocs/core-app --rebuild
