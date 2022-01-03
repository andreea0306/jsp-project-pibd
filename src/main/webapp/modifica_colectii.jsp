<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tabela colectii</title>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<h1 align="center">Tabela colectii:</h1>
	<br />
	<p align="center">
		<a href="nou_colectii.jsp"><b>Adauga o noua colectie.</b></a> <a
			href="index.html"><b>Home</b></a>
	</p>
	<form action="m1_colectii.jsp" method="post">
		<table border="1" align="center">
			<tr>
				<td><b>Mark:</b></td>
				<td><b>IdColectie</b></td>
				<td><b>IdMuzician:</b></td>
				<td><b>NumeMuzician:</b></td>
				<td><b>PrenumePrenume:</b></td>
				<td><b>Trupa:</b></td>
				<td><b>IdStilMuzical:</b></td>
				<td><b>StilMuzical:</b></td>
				<td><b>NumeColectie:</b></td>
				<td><b>AnAparitie:</b></td>
			</tr>
			<%
			jb.connect();
			ResultSet rs = jb.vedeColectii();
			long x;
			while (rs.next()) {
				x = rs.getInt("idcolectie");
			%>
			<tr>
				<td><input type="checkbox" name="primarykey" value="<%=x%>" /></td>
				<td><%=x%></td>
				<td><%=rs.getInt("IDmuzician")%></td>
				<td><%=rs.getString("NumeMuzician")%></td>
				<td><%=rs.getString("PrenumeMuzician")%></td>
				<td><%=rs.getString("Trupa")%></td>
				<td><%=rs.getInt("IDstilmuzical")%></td>
				<td><%=rs.getString("stilmuzical")%></td>
				<td><%=rs.getString("NumeColectie")%></td>
				<td><%=rs.getString("AnAparitie")%></td>
				<%
				}
				%>
			</tr>
		</table>
		<br />
		<p align="center">
			<input type="submit" value="Modifica linia">
		</p>
	</form>
	<%
	jb.disconnect();
	%>
	<br />
	<p align="center">
		<a href="index.html"><b>Home</b></a> <br />
	</p>
</body>
</html>