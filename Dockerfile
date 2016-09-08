FROM jupyter/minimal-notebook

USER root

# libav-tools for matplotlib anim
RUN apt-get update && \
    apt-get install -y --no-install-recommends libav-tools git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

# Install Python 3 packages
# Remove pyqt and qt pulled in for matplotlib since we're only ever going to
# use notebook-friendly backends in these images
RUN conda install --quiet --yes \
    'pandas=0.18*' \
    'matplotlib=1.5*' \
    'scipy=0.17*' \
    'seaborn=0.7*' \
    'graphviz=2.38.*' \
    'patsy=0.4*' \
    'scikit-learn=0.17*' \
    'scikit-image=0.11*' \
    'statsmodels=0.6*' \
    'cloudpickle=0.1*' \
    'numba=0.23*' \
    'bokeh=0.11*' && \
    conda clean -tipsy

# Add shortcuts to distinguish pip for python2 and python3 envs
RUN ln -s $CONDA_DIR/envs/python2/bin/pip $CONDA_DIR/bin/pip2 && \
    ln -s $CONDA_DIR/bin/pip $CONDA_DIR/bin/pip3
