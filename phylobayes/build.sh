#!/bin/bash

cd sources
make

mkdir -p $PREFIX/bin

cp ../data/ancestral $PREFIX/bin
cp ../data/bf $PREFIX/bin
cp ../data/bpcomp $PREFIX/bin
cp ../data/cvrep $PREFIX/bin
cp ../data/pb $PREFIX/bin
cp ../data/ppred $PREFIX/bin
cp ../data/readcv $PREFIX/bin
cp ../data/readdiv $PREFIX/bin
cp ../data/readpb $PREFIX/bin
cp ../data/stopafter $PREFIX/bin
cp ../data/stoppb $PREFIX/bin
cp ../data/subdata $PREFIX/bin
cp ../data/subsample $PREFIX/bin
cp ../data/sumcv $PREFIX/bin
cp ../data/tracecomp $PREFIX/bin
cp ../data/tree2ps $PREFIX/bin
