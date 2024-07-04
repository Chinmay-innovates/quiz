<%-- 
    Document   : userSignUpAction
    Created on : Jun 28, 2024, 11:24:21 AM
    Author     : surya2
--%>

<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        // Hash the password using BCrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection to the database
        Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/onlinequiz", 
        "root", 
        "root"
        );

        // Prepare an SQL statement using PreparedStatement
        String sql = "INSERT INTO USER (name, email, username, password) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, username);
        pstmt.setString(4, hashedPassword);

        // Execute the statement
        int i = pstmt.executeUpdate();

        // Check if the insertion was successful
        if (i > 0) {
%>
<script type="text/javascript">
    alert("Signup Success");
    window.location.href = "user.html";
</script>
<%
        } else {
%>
<script type="text/javascript">
    alert("Signup Failed");
    window.location.href = "userSignUp.html";
</script>
<%
        }

        // Close the statement and connection
        pstmt.close();
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

<%-- 
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequiz", "root", "root");
        Statement st = con.createStatement();
        int i = st.executeUpdate("INSERT INTO USER VALUES ("
                + "'" + name + "',"
                + "'" + email + "',"
                + "'" + username + "',"
                + "'" + password + "')"
        );
        if (i > 0) {
%>
<script type="text/javascript">
    alert("Signup Success");
    window.location.href = "user.html";
</script>

<%
} else {
%>
<script type="text/javascript">
    alert("Signup Failed");
    window.location.href = "userSignUp.html";
</script>
<%
        }
    } catch (Exception e) {
        out.println(e);
    }
%>
 --%>
