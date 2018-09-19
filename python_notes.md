## Take input
```
h=raw_input('Hello')
```

## Read and write file using pickle
```
import cPickle as pickle
pickle.dump(arrays, open('filename.pickle', 'wb'))
arrays = pickle.load(open('filename.pickle', 'rb'))
```

## Install openCV on RHEL ppc64le
```
# Install OpenCV and create symbolic links.

yum install opencv-devel python-devel opencv-python boost-python snappy-devel
ln -s /usr/lib64/python2.7/site-packages/cv.py /opt/anaconda2/envs/dli/lib/python2.7/site-packages/cv.py
ln -s /usr/lib64/python2.7/site-packages/cv.pyc /opt/anaconda2/envs/dli/lib/python2.7/site-packages/cv.pyc
ln -s /usr/lib64/python2.7/site-packages/cv.pyo /opt/anaconda2/envs/dli/lib/python2.7/site-packages/cv.pyo
ln -s /usr/lib64/python2.7/site-packages/cv2.so /opt/anaconda2/envs/dli/lib/python2.7/site-packages/cv2.so
```
