# Conda recipes

*This is a work in progress. Documentation does not reflect what exists yet.
Some recipes may work, some may not. These are provided with no warranty.*


A variety of
[conda recipes](https://conda.io/docs/user-guide/tasks/build-packages/recipe.html)
used in the [Dunn Lab](http://dunnlab.org). These recipes define conda packages
that are available in our [dunnlab channel](https://anaconda.org/dunnlab/) on
Anaconda Cloud.

These packages serve a few purposes:

- Many are dependencies of our tool
[agalma](https://bitbucket.org/caseywdunn/agalma). Distributing these
dependencies here facilitates installation of that tool.

- We work across a variety of clusters, cloud computing services, and other
  computers. Putting our commonly used tools here makes it easy to get our
  analyses up and runnign wherever we are working.

We love [bioconda](http://bioconda.github.io), an excellent and much more
extensive channel for bioinformatics software. We are frequent bioconda users and
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

### Git model

To add or modify a recipe:

1. File an issue in the issue tracker describing what is to be done
2. Create a new branch from `master` named after the issue, eg `issue-5`.
3. Make all the changes in this branch.
4. Confirm that you can locally build, install, and execute the package.
5. Once it passes the above tests, merge the issue branch back into the
   `master` branch.
6. Build and upload the package to Anaconda Cloud as described below.

### Guidelines

Recipes should conform to [bioconda guidelines](http://bioconda.github.io/guidelines.html)
where possible.

All packages should work on linux. Some may also work on macOS.

All dependencies should be in dunnlab, ie now other channels should need to be
loaded to install a package from this channel. (We may revisit this decision at
a later date.)

Do not delete old versions of packages. Instead, move the contents of the
recipe directory into a subdirectory. See for example https://github.com/bioconda/bioconda-recipes/tree/master/recipes/samtools .

If I recipe for a given version of a given tool is changed in any way after
pushing to Anaconda Cloud, bump the build number.


### Local execution

During development you should do local building, installation, and testing.
Here are some examples of how to do this. This testing is best done in a
docker container.

Paths below are relative to the root of this repository.

Local use phylobayes example:

    conda build -n phylobayes .
    conda install --use-local phylobayes

Local use phylobayes_mpi example:

    conda build --channel conda-forge -n phylobayes_mpi .
    conda install -c conda-forge --use-local phylobayes_mpi

### Uploading packages to Anaconda Cloud

More on Anaconda Cloud can be found [here](https://docs.anaconda.com/anaconda-cloud/user-guide/tasks/work-with-packages).

Here is the procedure for uploading a specific package to Anaconda Cloud:

    docker run -it -v /path/to/conda-recipes/recipes:/recipes mhowison/conda-build bash # change path /path/to/conda-recipes/recipes to the recipes folder of this repository
    conda update -n root conda-build # make sure you have the latest conda and conda build
    cd /recipes/<package-name>
    conda build -c dunnlab .

If the test passes and the recipe builds successfully, upload/release the package on anaconda.org from within the Docker container with:

    anaconda login
    anaconda upload <path to built .tar.bz2>
