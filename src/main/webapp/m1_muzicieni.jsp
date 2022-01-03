<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tabela muzicieni</title>
        <link href="table.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <jsp:useBean id="jb" scope="session" class="db.JavaBean" />
    <jsp:setProperty name="jb" property="*" />
    <body>
        <h1 align="center">Tabela muzicieni:</h1>
        <br/>
        <p align="center"><a href="nou_muzician.jsp"><b>Adauga un nou muzician.</b></a> <a href="index.html"><b>Home</b></a></p>
        <%
            jb.connect();
            int aux = java.lang.Integer.parseInt(request.getParameter("primarykey"));
            ResultSet rs = jb.intoarceLinieDupaId("muzicieni", "idmuzician", aux);
            rs.first();
            String Nume = rs.getString("nume");
            String Prenume = rs.getString("prenume");
            String DataNasterii = rs.getString("datanasterii");
            String Trupa = rs.getString("trupa");
            rs.close();
            jb.disconnect();
        %>
        <form action="m2_muzicieni.jsp" method="post">
            <table align="center">
                <tr>
                    <td align="right">idMuzician:</td>
                    <td> <input type="text" name="idmuzician" size="30" value="<%= aux%>" readonly/></td>
                </tr>
                <tr>
                    <td align="right">Nume muzician:</td>
                    <td> <input type="text" name="nume" size="30" value="<%= Nume%>"/></td>
                </tr>
                <tr>
                    <td align="right">Prenume muzician:</td>
                    <td> <input type="text" name="prenume" size="30" value="<%= Prenume%>"/></td>
                </tr>
                <tr>
                    <td align="right">DataNasterii:</td>
                    <td> <input type="text" name="datanasterii" size="30" value="<%= DataNasterii%>"/></td>
                </tr>
                 <tr>
                    <td align="right">Trupa:</td>
                    <td> <input type="text" name="trupa" size="30" value="<%= Trupa%>"/></td>
                </tr>
            </table><p align="center">
                <input type="submit" value="Modifica linia">
            </p>
        </form>
        <p align="center">
            <a href="index.html"><b>Home</b></a>
            <br/>
    </body>
</html>