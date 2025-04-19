from flask import Flask, send_from_directory, render_template_string

app = Flask(__name__)

@app.route('/robots.txt')
def robots():
    return send_from_directory('.', 'robots.txt', mimetype='text/plain')

@app.route('/blog/article1')
def article1():
    with open('templates_article1.html') as f:
        return render_template_string(f.read())

@app.route('/private/secret')
def secret():
    with open('templates_secret.html') as f:
        return render_template_string(f.read())

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000, debug=True)
