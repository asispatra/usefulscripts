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
