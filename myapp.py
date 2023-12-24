from flask import Flask, jsonify, request
import pandas as pd
import numpy as np
import joblib
import traceback
from flask_restful import reqparse

app = Flask(__name__)

@app.route("/", methods=['GET'])
def hello():
    return "hey"


# Add a new route to get the list of questions
@app.route('/get_questions', methods=['GET'])
def get_questions():
    try:
        # Load the model columns (questions)
        model_columns = joblib.load("model_cols_subset.pkl")

        # Return the list of questions as JSON
        return jsonify({'questions': model_columns})

    except Exception as e:
        return jsonify({'error': str(e)})

# #  origin version with degubbing (what i'm using)


# # load the pickle model

@app.route('/predict', methods=['POST'])
def predict():
    lr = joblib.load("model_subset.pkl")
    if lr:
        try:
            json_data = request.get_json()
            print('Received JSON data:', json_data) 


            if isinstance(json_data, list) and len(json_data) > 0 and isinstance(json_data[0], dict):
                # Assuming json_data is a list of dictionaries, take the first element
                temp = list(json_data[0].values()) # here's the error

                model_columns = joblib.load("model_cols_subset.pkl")
                print("Model Columns:", model_columns)
                print("Length of temp:", len(temp))

                # Check that the length of temp matches the number of features expected by the model
                if len(temp) == len(model_columns):
                    vals = np.array(temp)
                    prediction = lr.predict([vals])
                    


                    if prediction is not None:
                        return jsonify({'prediction': str(prediction[0])})
                    else:
                        return jsonify({'prediction': 'Prediction is None'})
                else:
                    return jsonify({'prediction': 'Mismatched number of features'})
            else:
                return jsonify({'prediction': 'Invalid data format'})

        except Exception as e:
            return jsonify({'trace': traceback.format_exc()})
    else:
        return jsonify({'prediction': 'No model here to use'})

if __name__ == '__main__':
    app.run(debug=True)

 


# origin basic version
 
# @app.route('/predict', methods=['POST'])
# def predict():
# 	lr = joblib.load("model.pkl")
# 	if lr:
# 		try:
# 			json = request.get_json()	 
# 			model_columns = joblib.load("model_cols.pkl")
# 			temp=list(json[0].values())
# 			vals=np.array(temp)
# 			prediction = lr.predict(temp)
# 			print("here:",prediction)        
# 			return jsonify({'prediction': str(prediction[0])})

# 		except:        
# 			return jsonify({'trace': traceback.format_exc()})
# 	else:
# 		return ('No model here to use')
    


# if __name__ == '__main__':
#     app.run(debug=True) 

# ...




# probability version

# @app.route('/predict', methods=['POST'])
# def predict():
#     lr = joblib.load("model.pkl")
#     if lr:
#         try:
#             json_data = request.get_json()
#             print('Received JSON data:', json_data)

#             if isinstance(json_data, list) and len(json_data) > 0 and isinstance(json_data[0], dict):
#                 # Assuming json_data is a list of dictionaries, take the first element
#                 temp = list(json_data[0].values())  # here's the error

#                 model_columns = joblib.load("model_cols.pkl")
#                 print("Model Columns:", model_columns)

#                 # Check that the length of temp matches the number of features expected by the model
#                 if len(temp) == len(model_columns):
#                     vals = np.array(temp)

#                     # Get class probabilities from the model
#                     class_probabilities = lr.predict_proba([vals])[0]

#                     # Get the most probable class index
#                     most_probable_class_index = np.argmax(class_probabilities)

#                     return jsonify({'prediction': most_probable_class_index})
#                 else:
#                     return jsonify({'prediction': 'Mismatched number of features'})
#             else:
#                 return jsonify({'prediction': 'Invalid data format'})

#         except Exception as e:
#             return jsonify({'trace': traceback.format_exc()})
#     else:
#         return jsonify({'prediction': 'No model here to use'})

# if __name__ == '__main__':
#     app.run(debug=True)



