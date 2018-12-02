## Create Virtual Environment
```
# You may escape this part
virtualenv --system-site-packages ~/jupyterlab_venv
source ~/jupyterlab_venv/bin/activate
```

## Installation
```
pip install jupyterlab
```

#### Installation Details
http://jupyterlab.readthedocs.io/en/stable/getting_started/installation.html


## Configuring JupyterLab
```
jupyter notebook --generate-config

vi ~/.jupyter/jupyter_notebook_config.py
#c.NotebookApp.ip = 'localhost'            # Change the IP Address for remotely access
#c.NotebookApp.notebook_dir = u''          # Change the base Directory
```

## Start JupyterLab
```
jupyter lab
```

## Issues
```
1 .
ImportError: No module named altair

pip install altair

2 .
import altair as alt
alt.renderers.enable('notebook')

To use the 'notebook' renderer, you must install the vega package and the associated Jupyter extension.
See https://altair-viz.github.io/getting_started/installation.html for more information.


pip install vega
```
