from flask import Flask, jsonify
import sqlite3

app = Flask(__name__)

# Function to fetch data from SQLite database
def fetch_hats():
    conn = sqlite3.connect('hats.db')  # Connect to the database
    cursor = conn.cursor()
    cursor.execute("SELECT id, name, price FROM hats")  # Query the 'hats' table
    rows = cursor.fetchall()  # Fetch all rows
    conn.close()
    return [{"id": row[0], "name": row[1], "price": row[2]} for row in rows]

# API route to serve hat data
@app.route('/hats', methods=['GET'])
def get_hats():
    hats = fetch_hats()
    return jsonify(hats)

if __name__ == '__main__':
    app.run(debug=True)
