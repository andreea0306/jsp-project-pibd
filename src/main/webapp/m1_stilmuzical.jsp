<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tabela stiluri muzicale</title>
        <link href="table.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <jsp:useBean id="jb" scope="session" class="db.JavaBean" />
    <jsp:setProperty name="jb" property="*" />
    <body>
        <h1 align="center">Tabela stiluri muzicale:</h1>
        <br/>
        <p align="center"><a href="nou_Medic.jsp"><b>Adauga un nou stil muzical.</b></a> <a href="index.html"><b>Home</b></a></p>
        <%
            jb.connect();
            int aux = java.lang.Integer.parseInt(request.getParameter("primarykey"));
            ResultSet rs = jb.intoarceLinieDupaId("stilurimuzicale", "idstilmuzical", aux);
            rs.first();
            String StilMuzical = rs.getString("stilmuzical");
            rs.close();
            jb.disconnect();
        %>
        <form action="m2_stilmuzical.jsp" method="post">
            <table align="center">
                <tr>
                    <td align="right">idStilMuzical:</td>
                    <td> <input type="text" name="idstilmuzical" size="30" value="<%= aux%>" readonly/></td>
                </tr>
                <tr>
                    <td align="right">StilMuzical:</td>
                    <td> <input type="text" name="stilmuzical" size="30" value="<%= StilMuzical%>"/></td>
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