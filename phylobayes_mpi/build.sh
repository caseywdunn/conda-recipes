#!/bin/bash

cd sources

make

cp ../data/bpcomp $PREFIX/bin
cp ../data/cvrep $PREFIX/bin
cp ../data/pb_mpi $PREFIX/bin
cp ../data/readpb_mpi $PREFIX/bin
cp ../data/tracecomp $PREFIX/bin
