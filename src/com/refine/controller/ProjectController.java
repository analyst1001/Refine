package com.refine.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

/**
 * Servlet implementation class ProjectController
 */
@WebServlet(name = "ProjectController", urlPatterns = { "/project/*" })
public class ProjectController extends HttpServlet {
        private static final long serialVersionUID = 1L;

        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        	Map parameters = request.getParameterMap();
            if (parameters.containsKey("colExprFormSubmit")) {
            	AddColumnByExprOperation op = new AddColumnByExprOperation();
            	op.doOperation(request.getPathInfo().substring(1), request.getParameter("colName"), request.getParameter("colExpr"));
            }
            request.setAttribute("tableName", request.getPathInfo().substring(1));
            
            //System.out.println(request.getAttribute("tableName"));
            RequestDispatcher view = getServletContext().getRequestDispatcher("/tableContent.jsp");
            view.forward(request, response);
        }
        
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                request.setAttribute("tableName", request.getPathInfo().substring(1));
                
                //System.out.println(request.getAttribute("tableName"));
                RequestDispatcher view = getServletContext().getRequestDispatcher("/tableContent.jsp");
                view.forward(request, response);
                
        }

}