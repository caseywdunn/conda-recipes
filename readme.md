# Conda recipes

A variety of [conda recipes](https://conda.io/docs/user-guide/tasks/build-packages/recipe.html) used in the [Dunn Lab](http://dunnlab.org).

*This is a work in progress. Documentation does not reflect what exists yet. Some recipes may work, some may not. These are provided with no warranty.*

Many of the recipes are are for dependencies of our tool
[agalma](https://bitbucket.org/caseywdunn/agalma). Others are things that we
frequently use for work in the lab.

We love [bioconda](http://bioconda.github.io) and are frequent users and
sometimes contributors. So why do we also maintain a separate set of conda
recipes that aren't part of bioconda? Sometimes our needs diverge a bit from
the design decisions that have been made for the bioconda project. These are
not bad decisions - just different from what we need sometimes. Here are a few
needs we have that are in conflict with the way bioconda is set up:

- Stability. Bioconda is a very open project, which is great for getting many
  recipes and efficiently updating the ones that are there. This means, though,
  that someone else can modify a recipe that is working for you in a way that
  breaks it for your application.

- Dependency version specification. Bioconda packages usually don't specify
  dependency versions. This reduces the chance of multiple packages that may be
  installed at once having conflicts in what versions they require for
  shared dependencies. It means, though, that a given tool may break when a new
  version of a dependency is uploaded and that version doesn't work with the
  existing tool.

- Non open-source packages. On rare occasions we need to create a package for
  a tool that has freely available executables but that is not open source.

## Using these packages

The packages specified by the recipes in this repository are available in the
[dunnlab anaconda channel](https://anaconda.org/dunnlab/). You don't need to
download anything directly from this git repository. First, install
[miniconda](https://conda.io/docs/user-guide/install/index.html) on
your system, for example on Ubuntu:

    apt-get update; apt-get install -y wget bzip2 # On Ubuntu, installs dependencies
    wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
    bash Miniconda2-latest-Linux-x86_64.sh -b
    echo 'export "PATH=$HOME/miniconda2/bin:$PATH"' >>~/.bashrc
    source ~/.bashrc


The following would create a new environment called `test_analyses`, install
`fastqc` into it from the dunnlab channel, and activate the environment:

    conda create -c dunnlab -n test_analyses fastqc
    source activate test_analyses

You can add the channel to your system so you don't have to specify it with:

    conda config --add channels dunnlab

The following will add a few other channels in addition to the dunnlab channel,
so you can draw from our channel as well as these others.

    conda config --add channels defaults
    conda config --add channels conda-forge
    conda config --add channels bioconda
    conda config --add channels dunnlab

For more on conda, see my [cheet sheat](https://gist.github.com/caseywdunn/59c94fc81db53c5916ff9930b72d4e71).

## Development

Recipes should conform to [bioconda guidelines](http://bioconda.github.io/guidelines.html)
where possible.

### Local execution

During development you should do local building, installation, and testing.
Here are some examples of how to do this.

Paths below are relative to the root of this repository.

Local use phylobayes example:

    conda build -n phylobayes .
    conda install --use-local phylobayes

Local use phylobayes_mpi example:

    conda build --channel conda-forge -n phylobayes_mpi .
    conda install -c conda-forge --use-local phylobayes_mpi
