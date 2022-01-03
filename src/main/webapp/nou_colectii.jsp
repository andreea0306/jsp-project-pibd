<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Adauga colectie</title>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<%
	int idmuzician, idstilmuzical;
	String id1, id2, NumeMuzician, PrenumeMuzician, DataNasterii, Trupa, StilMuzical, NumeColectie, AnAparitie;
	id1 = request.getParameter("idmuzician");
	id2 = request.getParameter("idstilmuzical");
	NumeColectie = request.getParameter("name");
	AnAparitie = request.getParameter("anaparitie");
	if (id1 != null) {
		jb.connect();
		jb.adaugaColectie(java.lang.Integer.parseInt(id1), java.lang.Integer.parseInt(id2), NumeColectie, AnAparitie);
		jb.disconnect();
	%>
	<p>Datele au fost adaugate.</p>
	<%
	} else {
	jb.connect();
	ResultSet rs1 = jb.vedeTabela("muzicieni");
	ResultSet rs2 = jb.vedeTabela("stilurimuzicale");
	%>
	<h1>Suntem in tabela colectii.</h1>
	<form action="nou_colectii.jsp" method="post">
		<table>
			<tr>
				<td align="right">idMuzician:</td>
				<td>Selectati muzicianul: <SELECT NAME="idmuzician">
						<%
						while (rs1.next()) {
							idmuzician = rs1.getInt("idmuzician");
							NumeMuzician = rs1.getString("nume");
							PrenumeMuzician = rs1.getString("prenume");
							DataNasterii = rs1.getString("datanasterii");
							Trupa = rs1.getString("trupa");
						%>
						<OPTION VALUE="<%=idmuzician%>"><%=idmuzician%>,<%=NumeMuzician%>,<%=PrenumeMuzician%>,<%=DataNasterii%>,<%=Trupa%></OPTION>
						<%
						}
						%>
				</SELECT>

				</td>
			</tr>
			<tr>
				<td align="right">idstilmuzical:</td>
				<td>Selectati stilul muzical: <SELECT NAME="idstilmuzical">
						<!-- OPTION selected="yes" VALUE="iris1">Iris 1</OPTION -->
						<%
						while (rs2.next()) {
							idstilmuzical = rs2.getInt("idstilmuzical");
							StilMuzical = rs2.getString("stilmuzical");
						%>
						<OPTION VALUE="<%=idstilmuzical%>"><%=idstilmuzical%>,<%=StilMuzical%></OPTION>
						<%
						}
						%>
				</SELECT>
				</td>
			</tr>
			<tr>
				<td align="right">NumeColectie:</td>
				<td><input type="text" name="name" size="30" /></td>
			</tr>
			<tr>
				<td align="right">AnAparitie:</td>
				<td><input type="text" name="anaparitie" size="30" /></td>
			</tr>
		</table>
		<input type="submit" value="Adauga colectia" />
	</form>
	<%
	}
	%>
	<br />
	<a href="index.html"><b>Home</b></a>
	<br />
</body>
</html>