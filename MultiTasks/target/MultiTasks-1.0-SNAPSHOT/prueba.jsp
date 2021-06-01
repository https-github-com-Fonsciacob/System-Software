<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
    <c:forEach var="lista" items="${listTask}">
        <p><c:out value="${lista.id}"></c:out></p>
        <p><c:out value="${lista.nombreLista}"></c:out></p>
    </c:forEach>

    <c:forEach var="lista" items="${tasks}">
        <p><c:out value="${lista.id}"></c:out></p>
        <p><c:out value="${lista.nombreTarea}"></c:out></p>
    </c:forEach>

    <c:forEach var="lista" items="${user}">
        <p><c:out value="${lista.id}"></c:out></p>
        <p><c:out value="${lista.nombre}"></c:out></p>
    </c:forEach>
    <p>Hola</p>
</body>
</html>
