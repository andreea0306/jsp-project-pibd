<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adauga muzician</title>
    </head>
    <jsp:useBean id="jb" scope="session" class="db.JavaBean" />
    <jsp:setProperty name="jb" property="*" />
    <body>
        <%
            String nume = request.getParameter("nume");
            String prenume = request.getParameter("prenume");
            String datanasterii = request.getParameter("datanasterii");
            String trupa = request.getParameter("trupa");
            if (nume != null) {
                jb.connect();
                jb.adaugaMuzician(nume, prenume, datanasterii, trupa);
                jb.disconnect();
        %>
        <p>Datele au fost adaugate.</p><%
        } else {
        %>
        <h1> Suntem in tabela muzicieni.</h1>
        <form action="nou_muzician.jsp" method="post">
            <table>
                <tr>
                    <td align="right">Nume muzician:</td>
                    <td> <input type="text" name="nume" size="40" /></td>
                </tr>
                <tr>
                    <td align="right">Prenume muzician:</td>
                    <td> <input type="text" name="prenume" size="30" /></td>
                </tr>
                <tr>
                    <td align="right">Data nasterii:</td>
                    <td> <input type="text" name="datanasterii" size="30" /></td>
                </tr>
                <tr>
                    <td align="right">Trupa:</td>
                    <td> <input type="text" name="trupa" size="30" /></td>
                </tr>
            </table>
            <input type="submit" value="Adauga muzicianul." />
        </form>
        <%
            }
        %>
        <br/>
        <a href="index.html"><b>Home</b></a>
        <br/>
    </body>
</html>