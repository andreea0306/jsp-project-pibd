<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tabela colectii</title>
        <link href="table.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <jsp:useBean id="jb" scope="session" class="db.JavaBean" />
    <jsp:setProperty name="jb" property="*" />
    <body>
        <h1 align="center">Tabela colectii:</h1>
        <br/>
        <p align="center"><a href="nou_colectii.jsp"><b>Adauga o noua colectie.</b></a> <a href="index.html"><b>Home</b></a></p>
        <%
            jb.connect();
            String NumeMuzician, PrenumeMuzician, DataNasterii, Trupa, StilMuzical, NumeColectie, AnAparitie;

            int aux = java.lang.Integer.parseInt(request.getParameter("primarykey"));
            System.out.print(aux);
            ResultSet rs = jb.intoarceColectieId(aux);
            rs.first();
            int id1 = rs.getInt("idmuzician");
            int id2 = rs.getInt("idstilmuzical");

            NumeMuzician = rs.getString("NumeMuzician");
            PrenumeMuzician = rs.getString("PrenumeMuzician");
            DataNasterii = rs.getString("DataNasterii");
            Trupa = rs.getString("Trupa");
            StilMuzical = rs.getString("StilMuzical");
            NumeColectie = rs.getString("NumeColectie");
            AnAparitie = rs.getString("AnAparitie");
            ResultSet rs1 = jb.vedeTabela("muzicieni");
            ResultSet rs2 = jb.vedeTabela("stilurimuzicale");
            int idmuzician, idstilmuzical;


        %>
        <form action="m2_colectii.jsp" method="post">
            <table align="center">
                <tr>
                    <td align="right">idColectie:</td>
                    <td> <input type="text" name="idcolectie" size="30" value="<%= aux%>" readonly/></td>
                </tr>
                <tr>
                    <td align="right">idmuzician:</td>
                    <td> 
                        <SELECT NAME="idmuzician">
                            <%
                                while (rs1.next()) {
                                    idmuzician = rs1.getInt("idmuzician");
                                    NumeMuzician = rs1.getString("nume");
                                    PrenumeMuzician = rs1.getString("prenume");
                                    DataNasterii = rs1.getString("datanasterii");
                                    Trupa = rs1.getString("trupa");
                                    if (idmuzician != id1) {
                            %>
                            <OPTION VALUE="<%= idmuzician%>"><%= idmuzician%>, <%= NumeMuzician%>, <%= PrenumeMuzician%>, <%= DataNasterii%>,<%=Trupa %></OPTION>
                                <%
                                        } else {
                                %>                
                            <OPTION selected="yes" VALUE="<%= idmuzician%>"><%= idmuzician%>, <%= NumeMuzician%>, <%= PrenumeMuzician%>, <%= DataNasterii%>,<%=Trupa %></OPTION>
                                <%
                                        }
                                    }
                                %>
                        </SELECT>

                    </td>
                </tr>
                <tr>
                    <td align="right">idstilmuzical:</td>
                    <td> 
                        <SELECT NAME="idstilmuzical">
                            <%
                                while (rs2.next()) {
                                	idstilmuzical = rs2.getInt("idstilmuzical");
                                	StilMuzical = rs2.getString("stilmuzical");
                            if (idstilmuzical != id2) {
                            %>
                            <OPTION VALUE="<%= idstilmuzical%>"><%= idstilmuzical%>, <%= StilMuzical%></OPTION>
                                <%
                                        } else {
                                %>                
                            <OPTION selected="yes" VALUE="<%= idstilmuzical%>"><%= idstilmuzical%>, <%= StilMuzical%></OPTION>
                                <%
                                        }
                                    }
                                %>
                        </SELECT>

                    </td>
                </tr>
                <tr>
                    <td align="right">Nume Colectie:</td>
                    <td> <input type="text" name="name" size="30" value="<%= NumeColectie%>"/></td>
                </tr>
                <tr>
                    <td align="right">An Aparitie:</td>
                    <td> <input type="text" name="anaparitie" size="30" value="<%= AnAparitie%>"/></td>
                </tr>
            </table><p align="center">
                <input type="submit" value="Modifica linia">
            </p>
        </form>
        <p align="center"">
            <a href="index.html"><b>Home</b></a>
            <br/>
    </body>
    <%
        rs.close();
        rs1.close();
        rs2.close();
        jb.disconnect();
    %>
</html>