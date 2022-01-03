<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adauga stil muzical</title>
    </head>
    <jsp:useBean id="jb" scope="session" class="db.JavaBean" />
    <jsp:setProperty name="jb" property="*" />
    <body>
        <%
            String StilMuzical = request.getParameter("stilmuzical");
            if (StilMuzical != null) {
                jb.connect();
                jb.adaugaStilMuzical(StilMuzical);
                jb.disconnect();
        %>
        <p>Datele au fost adaugate.</p><%
        } else {
        %>
        <h1> Suntem in tabela stiluri muzicale.</h1>
        <form action="nou_stilmuzical.jsp" method="post">
            <table>
                <tr>
                    <td align="right">Stil Muzical:</td>
                    <td> <input type="text" name="stilmuzical" size="40" /></td>
                </tr>
             </table>
            <input type="submit" value="Adauga stilul muzical" />
        </form>
        <%
            }
        %>
        <br/>
        <a href="index.html"><b>Home</b></a>
        <br/>
    </body>
</html>