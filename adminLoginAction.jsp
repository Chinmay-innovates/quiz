<%-- 
    Document   : adminLoginAction
    Created on : Jun 28, 2024, 1:01:13 PM
    Author     : surya2
--%>

<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection to the database
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequiz", "root", "root");

        // Prepare an SQL statement using PreparedStatement
        String sql = "SELECT password FROM ADMIN WHERE username = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, username);

        // Execute the query
        ResultSet rs = pstmt.executeQuery();

        // Check if a result is returned
        if (rs.next()) {
            // Retrieve the stored hashed password
            String storedPassword = rs.getString("password");

            // Verify the password
            if (BCrypt.checkpw(password, storedPassword)) {
%>
<script type="text/javascript">
    alert("Login Success");
    window.location.href = "adminHome.jsp";
</script>
<%
            } else {
%>
<script type="text/javascript">
    alert("Login Failed");
    window.location.href = "admin.html";
</script>
<%
            }
        } else {
%>
<script type="text/javascript">
    alert("Login Failed");
    window.location.href = "admin.html";
</script>
<%
        }

        // Close resources
        rs.close();
        pstmt.close();
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<%-- 
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequiz", "root", "root");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM ADMIN WHERE username='"+username+"'AND password='"+password+"'  ");
        if (rs.next()) {
%>
<script type="text/javascript">
    alert("Login Success");
    window.location.href = "adminHome.jsp";
</script>

<%
} else {
%>
<script type="text/javascript">
    alert("Login Failed");
    window.location.href = "admin.html";
</script>
<%
        }
    } catch (Exception e) {
        out.println(e);
    }
%> --%>

