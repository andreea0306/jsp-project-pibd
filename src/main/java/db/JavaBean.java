package db;

import java.sql.*;

public class JavaBean {
	String error;
	Connection con;

	public JavaBean() {
	}

	public void connect() throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/PIBD?useSSL=false", "root", "AAIaai0306!@");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundExceptio: Nu s-a gasit driverul bazei de date";
			throw new ClassNotFoundException(error);

		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	}

	public void connect(String bd) throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + bd, "root", "AAIaai0306!@");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotException: Nu s-a gasit driverul bazei de date";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exceptio: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date";
			throw new Exception(error);
		}
	}

	public void connect(String bd, String ip) throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://" + ip + ":3306/" + bd, "root", "AAIaai0306");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	}

	public void disconnect() throws SQLException {
		try {
			if (con != null) {
				con.close();
			}
		} catch (SQLException sqle) {
			error = ("SQLException: Nu se poate inchide conexiunea la baza de date.");
			throw new SQLException(error);
		}
	}

	public void adaugaMuzician(String Nume, String Prenume, String DataNasterii, String Trupa)
			throws SQLException, Exception {
		if (con != null) {
			
			try {
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into muzicieni(nume, prenume, datanasterii, trupa) values('" + Nume + "', '"
						+ Prenume + "', '" + DataNasterii + "', '" + Trupa + "');");
			} catch (SQLException sqle) {
				error = "ExceptionSQL: Reactualizare nereusita; este posibil sa existe duplicare";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta";
			throw new Exception(error);
		}
	}

	public void adaugaStilMuzical(String stilMuzical) throws SQLException, Exception {
		if (con != null) {
			try {
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into stilurimuzicale(stilmuzical) values('" + stilMuzical + "' );");
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	}

	public void adaugaColectie(int idmuzician, int idstilmuzical, String nume, String anaparitie)
			throws SQLException, Exception {
		if (con != null) {
			try {
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into colectii(idmuzician, idstilmuzical, name, anaparitie) values('" + idmuzician + "' , '" + idstilmuzical + "', '" + nume + "', '" + anaparitie + "');");
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}

	}

	public ResultSet vedeTabela(String tabel) throws SQLException, Exception {
		ResultSet rs = null; 
		try {
			String queryString = ("select * from `PIBD`.`" + tabel + "`;");
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	}

	public ResultSet vedeColectii() throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select a.nume NumeMuzician, a.prenume PrenumeMuzician,"
					+ " a.datanasterii DataNasterii, a.trupa Trupa, b.stilmuzical StilMuzical,"
					+ "c.idcolectie, c.idmuzician IDmuzician, c.idstilmuzical IDstilmuzical, "
					+ "c.name NumeColectie, c.anaparitie AnAparitie from muzicieni a, "
					+ "stilurimuzicale b, colectii c where"
					+ " a.idmuzician = c.idmuzician and b.idstilmuzical = c.idstilmuzical;");
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	}

	public void stergeDateTabela(String[] primaryKeys, String tabela, String dupaID) throws SQLException, Exception {
		if (con != null) {
			try {
				long aux;
				PreparedStatement delete;
				delete = con.prepareStatement("DELETE FROM " + tabela + " WHERE " + dupaID + "=?;");
				for (int i = 0; i < primaryKeys.length; i++) {
					aux = java.lang.Long.parseLong(primaryKeys[i]);
					delete.setLong(1, aux);
					delete.execute();
				}
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			} catch (Exception e) {
				error = "A aparut o exceptie in timp ce erau sterse inregistrarile.";
				throw new Exception(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	}

	public void modificaTabela(String tabela, String IDTabela, int ID, String[] campuri, String[] valori)
			throws SQLException, Exception {
		String update = "update " + tabela + " set ";
		String temp = "";
		if (con != null) {
			try {
				for (int i = 0; i < campuri.length; i++) {
					if (i != (campuri.length - 1)) {
						temp = temp + campuri[i] + "='" + valori[i] + "', ";
					} else {
						temp = temp + campuri[i] + "='" + valori[i] + "' where " + IDTabela + " = '" + ID + "';";
					}
				}
				update = update + temp;
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate(update);

			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	}

	public ResultSet intoarceLinie(String tabela, int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			// Execute query
			String queryString = ("SELECT * FROM " + tabela + " where idmuzician=" + ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	}

	public ResultSet intoarceLinieDupaId(String tabela, String denumireId, int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			// Execute query
			String queryString = ("SELECT * FROM " + tabela + " where " + denumireId + "=" + ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	}

	public ResultSet intoarceColectieId(int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("SELECT a.nume NumeMuzician, a.prenume PrenumeMuzician, "
					+ "a.datanasterii, a.trupa, b.stilmuzical StilMuzical, "
					+ "c.idcolectie, c.idmuzician IDmuzician, c.idstilmuzical IDstilmuzical,"
					+ " c.name NumeColectie, c.anaparitie AnAparitie FROM muzicieni a, stilurimuzicale b, "
					+ "colectii c WHERE a.idmuzician = c.idmuzician AND "
					+ "b.idstilmuzical = c.idstilmuzical and idcolectie = '" + ID + "';");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); // sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	}

}
