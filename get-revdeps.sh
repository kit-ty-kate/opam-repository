#!/bin/bash -e

rm -f jst-revdeps.tmp

for pkg in $(cat jst-packages.txt); do
  echo "Checking $pkg..."
  opam list -s --all-versions --repos=default --no-switch --available --depends-on "$pkg>=v0.14" >> jst-revdeps.tmp
done

sort -u jst-revdeps.tmp > jst-revdeps.txt
rm -f jst-revdeps.tmp
