from flask import Flask, request, jsonify
from recommend import recommend


app = Flask(__name__)


@app.route('/recommend', methods=['POST'])
def process_title():
    print(request.form.get('title'))

    data = request.form.get('title')

    # data = request.get_json()
    # title = data['title']

    result = recommend(data)

    # print(result)

    # # Do something with the title

    response = {'result': result}
    return jsonify(response), 200


if __name__ == '__main__':
    app.run()
