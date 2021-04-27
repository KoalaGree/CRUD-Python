from flask import Flask, render_template, request, redirect, url_for, flash
from flask_mysqldb import MySQL



app = Flask(__name__)
app.secret_key = 'many random bytes'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'crud'

mysql = MySQL(app)



@app.route('/')
def Index():
    cur = mysql.connection.cursor()
    cur.execute("SELECT  * FROM karyawan")
    data = cur.fetchall()
    cur.execute("SELECT * FROM cuti")
    data2 = cur.fetchall()
    cur.execute("SELECT * FROM karyawan WHERE tanggal_gabung < DATE('2006-09-06')")
    tanggal = cur.fetchall()
    cur.execute("SELECT karyawan.no_induk, karyawan.nama, cuti.tanggal_cuti, cuti.ket FROM karyawan INNER JOIN cuti ON karyawan.no_induk=cuti.no_induk WHERE cuti.lama_cuti > 1 ")
    cuti = cur.fetchall()
    cur.execute("SELECT karyawan.no_induk, karyawan.nama, cuti.tanggal_cuti, cuti.ket FROM karyawan RIGHT JOIN cuti ON karyawan.no_induk=cuti.no_induk")
    cuti2 = cur.fetchall()
    cur.execute("""SELECT karyawan.no_induk, karyawan.nama, 12 - IFNULL(SUM(cuti.lama_cuti), 0) AS sisa_cuti
                FROM karyawan
                LEFT JOIN cuti ON karyawan.no_induk=cuti.no_induk
                GROUP BY karyawan.no_induk""")
    cuti12 = cur.fetchall()
    cur.close
    return render_template('index2.html', karyawans=data, cutis=data2, tanggals=tanggal, cutisekarangs=cuti, cuticins=cuti2, cutis12=cuti12 )


@app.route('/insert', methods = ['POST'])
def insert():

    if request.method == "POST":
        flash("Data Inserted Successfully")
        if 'nama' in request.form:
            noind = request.form['no_induk']
            nama = request.form['nama']
            alamat = request.form['alamat']
            tanggal_lahir = request.form['tanggal_lahir']
            tanggal_gabung = request.form['tanggal_gabung']
            cur = mysql.connection.cursor()
            cur.execute("INSERT INTO karyawan (no_induk, nama, alamat, tanggal_lahir, tanggal_gabung) VALUES (%s, %s, %s, %s, %s)", (noind, nama, alamat, tanggal_lahir, tanggal_gabung))
            mysql.connection.commit()
        else:
            noind1 = request.form['no_induk']
            tangcut = request.form['tanggal_cuti']
            lamcut = request.form['lama_cuti']
            ket = request.form['ket']
            cur = mysql.connection.cursor()
            cur.execute("INSERT INTO cuti (no_induk, tanggal_cuti, lama_cuti, ket) VALUES (%s, %s, %s, %s)", (noind1, tangcut, lamcut, ket))
            mysql.connection.commit()
        return redirect(url_for('Index'))




@app.route('/delete/<string:id_data>', methods = ['GET'])
def delete(id_data):
    flash("Record Has Been Deleted Successfully")
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM karyawan WHERE id=%s", (id_data,))
    mysql.connection.commit()
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM cuti WHERE id_cuti=%s", (id_data,))
    mysql.connection.commit()
    return redirect(url_for('Index'))





@app.route('/update',methods=['POST','GET'])
def update():

    if request.method == 'POST':
        if 'id' in request.form:
            id_data = request.form['id']
            noind = request.form['no_induk']
            nama = request.form['nama']
            alamat = request.form['alamat']
            tanggal_lahir = request.form['tanggal_lahir']
            tanggal_gabung = request.form['tanggal_gabung']
            cur = mysql.connection.cursor()
            cur.execute("""
                UPDATE karyawan
                SET no_induk=%s, nama=%s, alamat=%s, tanggal_lahir=%s, tanggal_gabung=%s
                WHERE id=%s
                """, (noind, nama, alamat, tanggal_lahir, tanggal_gabung, id_data))
        else:
            idcut = request.form['id_cuti']
            noind1 = request.form['no_induk']
            tangcut = request.form['tanggal_cuti']
            lamcut = request.form['lama_cuti']
            ket = request.form['ket']
            cur = mysql.connection.cursor()
            cur.execute("""
                UPDATE cuti
                SET no_induk=%s, tanggal_cuti=%s, lama_cuti=%s, ket=%s
                WHERE id_cuti=%s
                """, (noind1, tangcut, lamcut, ket, idcut))
        flash("Data Updated Successfully")
        mysql.connection.commit()
        return redirect(url_for('Index'))









if __name__ == "__main__":
    app.run(debug=True)
