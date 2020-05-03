
ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER

USER root

# Install pre-requisites, for example:
# - Geckodriver for altair saver using selenium and firefox webdriver
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    firefox-geckodriver && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

# Install some conda packages
RUN conda install --quiet --yes \
    'altair=4' \
    'altair_saver' \
    'dash' \
    'fuzzywuzzy' \
    # 'jupyterlab-dash=0.1.0a3' \
    'jupytext' \
    'nbgrader' \
    'rise' \
    'pandas-profiling' \
    'vega_datasets' \
    'xgboost' \
    && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install jupyter lab extensions
RUN jupyter labextension install @aquirdturtle/collapsible_headings --no-build && \
    # jupyter labextension install jupyterlab-dash@0.1.0-alpha.3 --no-build && \
    # jupyter labextension install jupyterlab-drawio --no-build && \
    jupyter labextension install @jupyterlab/shortcutui --no-build && \
    jupyter labextension install @jupyterlab/toc --no-build && \
    jupyter lab build && \
    jupyter lab clean

# Add custom user settings from .jupyter folder
USER root
ENV NB_UID=$NB_UID \
    NB_GID=$NB_GID
ADD ./.jupyter /home/$NB_USER/.jupyter
RUN chown -R $NB_UID:$NB_GID /home/$NB_USER/.jupyter
RUN fix-permissions /home/$NB_USER/.jupyter

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID