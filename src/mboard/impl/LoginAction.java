package mboard.impl;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mboard.base.Action;

public class LoginAction implements Action {
	
	private String id;
	private String pw;
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, ParseException {
		
		request.setCharacterEncoding("UTF-8");
		id = request.getParameter("id");
		pw = request.getParameter("pw");
		
		String path = "/login";
		request.getRequestDispatcher(path).forward(request, response);
	}

		
		
	}



