# Tensorflow and DL

```py
import tensorflow as tf

tf.Constant(3, shape=[2,3])
td.Variable([1,2,3,4,5,6], dtype=tf.float32)
tf.ones((2,2,2)) - Tensor

tf.constant()
tf.zeros()
tf.zeros_like(input_tensor)
tf.ones()
tf.ones_like(input_tensor)
tf.fill([3,3], 7)
tensor.numpy() - To change to a numpy array


gradient() - Computes the slope of a function at a point
reshape() - Reshapes a tensor (e.g. 10x10 to 100x1)
random() - Populates tensor with entries drawn from a probability distribution

tf.cast(pandas_col, tf.float32/tf.bool) - To convert datatype

```

### New model

```py

predictors = df.drop(['survived'], axis=1).values
predictors = np.asarray(predictors).astype('float32')
# Convert the target to categorical: target
target = to_categorical(df.survived)

n_cols = predictors.shape[1]

# Set up the model
model = Sequential()

# Add the first layer
model.add(Dense(32, activation='relu', input_shape=(n_cols,)))

# Add the output layer
model.add(Dense(2, activation='softmax'))

# Compile the model
model.compile(optimizer='sgd', loss='categorical_crossentropy', metrics=['accuracy'])

# Fit the model
model.fit(predictors, target)
			- batch_size
			- epochs
			- validation_split

model.evaluate(x_test, y_test)

#Save and load model

from tensforlow.keras.models import load_model
model.save('model_file.h5')
my_model = load_model('model_file.h5')
predictions = my_model.predict(data_to_predict_with)

---

#For a new model

activation() 
	- 'softmax'
	- 'relu'
	- 'sigmoid'
	
optimizer()
	- 'adam'
	- 'sgd'
	- 'RMSprop'
	
loss()
	- 'mean_squared_error', or
	- 'mse'
	- 'binary_crossentropy'
	- 'categorical_crossentropy' #for classification
```