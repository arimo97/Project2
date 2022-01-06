<%@page import="javax.swing.plaf.metal.MetalBorders.Flush3DBorder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
		pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String id = (String) session.getAttribute("id");
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">

<style>
	.btntoptopnav{ font-size: 12px; height: 30px; }
	.outtoptopnav{ height: 45px;}
</style>
		<%-- 	<div onclick="location.href='/mboard?cmd=HOME&id=<%=id%>'" class="toptopnavtitle"><i class="fas fa-info-circle">My코로나</i></div> --%>
		<c:choose>
		<c:when test="${id != null }">
	 	<nav class="py-2 bg-light border-bottom outtoptopnav">
	    <div class="container-fluid text-end">
	    	<a class="btn btn-outline-primary me-2 btntoptopnav" href="/mboard?cmd=LOGOUT"><i class="fas fa-sign-out-alt">로그아웃</i></a>
	    	<a class="btn btn-primary btntoptopnav" href="/mboard?cmd=MEMINFOFORM&id=<%=id%>"><i class="fas fa-user-edit">회원정보</i></a>
	      	<a class="btn btn-primary btntoptopnav" href="/mboard?cmd=COVIDINFOFORM&id=<%=id%>"><i class="fas fa-info-circle">개인코로나정보</i></a>
	    </div>
  		</nav>
		</c:when>
		</c:choose>
		
		<c:choose>
		<c:when test="${id == null }">
	 	<nav class="py-2 bg-light border-bottom outtoptopnav">
	    <div class="container-fluid text-end">
	      	<a href="/view/login.jsp" class="btn btn-outline-primary me-2 btntoptopnav"><i class="fas fa-sign-in-alt">로그인</i></a>
	      	<a href="/view/memReg.jsp" class="btn btn-primary btntoptopnav"><i class="fas fa-file-signature">회원가입</i></a>
	    </div>
  		</nav>
		</c:when>
		</c:choose>


		 
