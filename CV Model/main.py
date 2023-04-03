import joblib
from flask import Flask, request, jsonify
from model_files.ml_model import predict_number


app = Flask('tf-21')

@app.route('/', methods=['POST'])
def predict():
    vehicle = request.get_json()
    print(vehicle)
    predictions = predict_number(vehicle)
    return jsonify(predictions)

#@app.route('/ping', methods=['GET'])
#def ping():
#    return "Pinging Model!!"

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=9696)