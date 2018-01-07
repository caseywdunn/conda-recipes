# Conda recipes

A variety of [conda recipes](https://conda.io/docs/user-guide/tasks/build-packages/recipe.html) used in the [Dunn Lab](http://dunnlab.org). Some may work, some may not. These are provided with no warranty.

For more on conda, see my [cheet sheat](https://gist.github.com/caseywdunn/59c94fc81db53c5916ff9930b72d4e71).

## Recipes

Paths below are relative to the root of this repository.

### phylobayes

Local use example:

    conda build -n phylobayes .
    conda install --use-local phylobayes

### phylobayes_mpi

Local example:

    conda build --channel conda-forge -n phylobayes_mpi .
    conda install -c conda-forge --use-local phylobayes_mpi
