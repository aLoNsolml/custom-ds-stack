# My Custom DataScience Jupyter Docker Stack

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/aLoNsolml/custom-ds-stack/master?urlpath=lab)

A personal Jupyter Dockerfile based on `jupyter/datascience-notebook` with some custom packages, extensions and settings. More info in [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io). Try it with binder!

 This setup contains everything that includes `jupyter/datascience-notebook` and the following:

* conda packages:
    - altair
    - altair_saver
    - dash
    - geopandas
    - jupytext
    - nbgrader
    - pandas-profiling
    - plotly
    - rise
    - vega_datasets
    - xgboost
* JupyterLab extensions:
    - Collpasible Headings
    - Drawio
    - Shortcutui
    - System Monitor
    - Table of Contents
    - Theme Darcula
* Custom JupyrLab user settings
    - Dark theme for the terminal
    - More shortcuts:
        * Restart Kernel and Clear All: `Alt+O`
        * Restart Kernel and Run All: `Alt+P`

Additionally, it includes packages for save [Altair](https://altair-viz.github.io/) charts objects using `selenium` method and Firefox webdriver. For example, the following lines save a simple scatter-plot to PNG.

```python
import altair as alt
from vega_datasets import data

chart = alt.Chart(data.cars.url).mark_point().encode(
    x='Horsepower:Q',
    y='Miles_per_Gallon:Q',
    color='Origin:N'
)

chart.save('chart.png', method="selenium", webdriver="firefox")
```

More info about saving Altair charts [here](https://altair-viz.github.io/user_guide/saving_charts.html).

## Add more features

You can add other packages from conda or pip, even jupyter notebook/lab extensions modifying the `Dockerfile`.

In order to add more custom settings you should copy necessary folders and files in the `.jupyter` folder as any other JupyterLab installation.

## Docker usage

In order to build the image run in the same directory where `Dockerfile` is:

`docker build -t <YOUR-IMAGE-TAG>  .`

Then, start a container based on your new image using JupyterLab running:

`docker run --name <YOUR-CONTAINER-NAME> -p <LOCAL-PORT>:8888 -v <YOUR-WORK-DIRECTORY>:/home/jovyan/work <YOUR-IMAGE-TAG> start.sh jupyter lab`

I usually run my containers without token on my local machine using the following code:

`docker run --name <YOUR-CONTAINER-NAME> -p <LOCAL-PORT>:8888 -v <YOUR-WORK-DIRECTORY>:/home/jovyan/work <YOUR-IMAGE-TAG> start.sh jupyter lab --LabApp.token=''`

You can stop the container with:

`docker stop <YOUR-CONTAINER-NAME>`

Finally, when you want to use your container you have to run:

`docker start <YOUR-CONTAINER-NAME>`

Alternatively, it is possible to use `Visual Studio Code` with a [Docker extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) in order to launch your container as development environment and [work with Jupyter Notebooks](https://code.visualstudio.com/docs/python/jupyter-support).
