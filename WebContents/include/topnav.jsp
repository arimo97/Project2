<%@page import="javax.swing.plaf.metal.MetalBorders.Flush3DBorder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
		pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
	#topnavcontainer {z-index: 2;}
</style>

<nav class="navbar navbar-expand-lg navbar-light bg-light " id="topnavcontainer">
  <div class="container-fluid">
    <a class="navbar-brand px-3"  href="/mboard?cmd=HOME&id=${ memViewVo.id }">My Covid</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav nav-tabs ">
        <li class="nav-item px-3">
          <a class="nav-link active" aria-current="page" href="/mboard?cmd=HOME&id=${ memViewVo.id }">Home</a>
        </li>
        <li class="nav-item px-3">
          <a class="nav-link" href="/mboard?cmd=COVIDSTATUS&id=${ memViewVo.id }"><b>코로나 현재상황</b></a>
        </li>
        <li class="nav-item px-3">
          <a class="nav-link" href="/mboard?cmd=COUNTRYCOVIDSTATUS&id=${ memViewVo.id }"><b>해외코로나현황</b></a>
        </li>
        <li class="nav-item px-3">
          <a class="nav-link" href="/mboard?cmd=VACCINESTATICS&id=${ memViewVo.id }"><b>예방접종통계</b></a>
        </li>
        <li class="nav-item px-3">
          <a class="nav-link" href="/mboard?cmd=NOSHOWVACCINE"><b>잔여백신</b></a>
        </li>
        <li class="nav-item px-3">
          <a class="nav-link" href="/mboard?cmd=SCREENING&id=${ memViewVo.id }"><b>선별진료소</b></a>
        </li>
        <li class="nav-item px-3">
          <a class="nav-link" href="/mboard?cmd=VACCINATIONCENTER&id=${ memViewVo.id }"><b>예방접종센터</b></a>
        </li>
        <li class="nav-item px-3">
          <a class="nav-link" href="/mboard?cmd=BOARD&id=${ memViewVo.id }"><b>게시판</b></a>
        </li>
         <li class="nav-item dropdown px-3">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <b>뉴스</b>
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="/view/News.jsp">인터넷뉴스</a></li>
            <li><a class="dropdown-item" href="/view/YoutubNews.jsp">유튜브뉴스</a></li>
          </ul>
        </li>
        <li>
        	 <%@ include file="/include/chat.jsp" %>
        </li>
      </ul>
    </div>
    </div>
</nav>
