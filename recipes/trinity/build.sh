#!/bin/bash

set -e

ln -s $CC $PREFIX/bin/gcc
ln -s $CXX $PREFIX/bin/g++

BINARY=Trinity
BINARY_HOME=$PREFIX/bin
TRINITY_HOME=$PREFIX/opt/trinity-$PKG_VERSION

cd $SRC_DIR

sed -i~ 's/configure CC=gcc CXX=g++/configure CC="$(CC)" CXX="$(CXX)" LDFLAGS="-fopenmp"/' trinity-plugins/Makefile
sed -i~ 's/(MAKE)/(MAKE) CFLAGS="$(CFLAGS) $(LDFLAGS)"/' trinity-plugins/Makefile
sed -i~ '/^SYS_INC/c\SYS_INCS += -I.' Chrysalis/Makefile_g++

make CC="$CC" CXX="$CXX" CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS -fopenmp" LDFLAGS="$LDFLAGS" all

# remove the sample data
rm -rf $SRC_DIR/sample_data

# remove .git directory
rm -rf $SRC_DIR/trinity-plugins/htslib/.git

# copy source to bin
mkdir -p $PREFIX/bin
mkdir -p $TRINITY_HOME
cp -R $SRC_DIR/* $TRINITY_HOME/
cd $TRINITY_HOME && chmod +x Trinity
cd $BINARY_HOME && ln -s $TRINITY_HOME/Trinity $BINARY
ln -s $TRINITY_HOME/util/* .
ln -s $TRINITY_HOME/Analysis/DifferentialExpression/PtR
ln -s $TRINITY_HOME/Analysis/DifferentialExpression/run_DE_analysis.pl
ln -s $TRINITY_HOME/Analysis/DifferentialExpression/analyze_diff_expr.pl
ln -s $TRINITY_HOME/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl
ln -s $TRINITY_HOME/util/support_scripts/get_Trinity_gene_to_trans_map.pl

rm $PREFIX/bin/gcc $PREFIX/bin/g++
