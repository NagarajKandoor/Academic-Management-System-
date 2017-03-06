<%-- 
    Document   : update_books
    Created on : May 24, 2013, 1:22:22 PM
    Author     : sudhir
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="java.util.Vector"%>
<%
HttpSession obj=request.getSession(false);

      String var_oldpwd,var_loginid;

        var_loginid=obj.getAttribute("session_loginid").toString();
        var_oldpwd=obj.getAttribute("session_pwd").toString();
%>


<%!
  
    Connection conn = null;
    PreparedStatement stmt = null;
    String msg="";
    String var_dno123;
    String var_dname123;
    String var_hod123;
    
        Vector vec_dno=new Vector();
        Vector vec_dname=new Vector();
        Vector vec_hod=new Vector();
        void connect() {
        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            conn = DriverManager.getConnection("jdbc:db2://localhost:50000/AMS", "db2admin", "ngk555");
        } catch (Exception e) {
            msg = e.getMessage();
        }
    }
   
        public void fetch() {
        try {
            stmt = conn.prepareStatement("select dno,dname,hod from department");
           
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                
                vec_dno.add(rs.getString("dno"));
                vec_dname.add(rs.getString("dname"));
                vec_hod.add(rs.getString("hod"));
            }
            
            
            rs.close();
            stmt.clearParameters();
            stmt.close();

         
        }

        catch (Exception ex) {
            msg =ex.getMessage();
        }
               }
         public void getdept(HttpServletRequest request){
             try{
                 var_dno123=request.getParameter("txt_dno");
                 var_dname123=request.getParameter("txt_dname");
                  var_hod123=request.getParameter("txt_hod");
                 
             }
             catch(Exception ex){
                 msg=ex.getMessage();
             }
         }
         public void update(){
             try{
                 stmt = conn.prepareStatement("update department set hod=?,dname=? where dno=?");
            stmt.setString(1,var_hod123);
            stmt.setString(2,var_dname123);
            stmt.setString(3,var_dno123);
            stmt.executeUpdate();
            stmt.clearParameters();
            stmt.close();
            conn.close();
            msg="Updation Successful";
                 
             }
             catch(Exception ex){
                 msg=ex.getMessage();
             }
         }
    %>

<%
    if(request.getParameter("btn_sub")!=null){
        connect();
        getdept(request);
        update();
    }
       else{
    connect();
    fetch();
    }
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>updating of book quantities</title>
    </head>
    <body bgcolor="#FFFFCC">
        <form method="POST" action="newupdate.jsp" >
        <div id="page">
        <table width="98">
                <tr><td><img src="Images/854.gif" width="1348" height="146" /></td>
                </tr>
            </table>
            </br>
            </br>
        <table border="1" bordercolor="blue" align="center">
            <tr align="center"><td align="center" colspan="3">Department Details</td></tr>
            <tr>
                <td>d-no</td>
                <td>d-name</td>
                <td>hod</td>
                
            </tr>
             <%
            for(int i=0;i<vec_dno.size();i++)
                              {
               %>
           <tr>
                <td><%=vec_dno.get(i)%></td>
                <td><%= vec_dname.get(i) %></td>
                <td><%=vec_hod.get(i) %></td>
               
           </tr>            
            <%}
                vec_dno.clear();
                vec_dname.clear();
                vec_hod.clear();
               
                %>
        </table>
                <br>
                    
                <table border="1" bordercolor="blue" align="center">
                    <tr><td colspan="2" align="center">If you wish to Update department</td></tr>
                <tr>
                    <td>Enter the D-no</td>
                    <td><input type="text" name="txt_dno"/></td>
                </tr>
                    <tr>
                    <td>Enter the D-name</td>
                    <td><input type="text" name="txt_dname" /></td>
                </tr>
                            <tr>
                    <td>Enter the HOD</td>
                    <td><input type="text" name="txt_hod"/></td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><input type="submit"  name="btn_sub" value="Update"/></td>
                </tr>
                </table>
                </div>
        <h1> <a href="adminhome.jsp">Back</a></h1>
        
               
        </form>
                <script>
                    <%
                    if(request.getParameter("btn_sub")!=null) {%>
                        alert("<%= msg %>");
                        <% } %>
                </script>
    </body>
</html>
