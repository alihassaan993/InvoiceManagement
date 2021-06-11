<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

	request.getSession().removeAttribute("userName");

	response.sendRedirect("login.jsp");

%>