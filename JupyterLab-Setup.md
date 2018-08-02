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
