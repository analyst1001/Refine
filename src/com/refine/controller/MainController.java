package com.refine.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class MainController
 */
@WebServlet("/MainController")
public class MainController extends HttpServlet {
        private static final long serialVersionUID = 1L;
        
        public static String listProjectsJSP = "./listProjects.jsp";
        public static String mainJSP = "./main.jsp";
       
         protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                        String pathInfo = request.getPathInfo();
                        System.out.println(pathInfo);
         }
        
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//                String forward="";
//            // Get a map of the request parameters
//            @SuppressWarnings("unchecked")
//            Map parameters = request.getParameterMap();
//            if (parameters.containsKey("listProjects")) {
//                forward = listProjectsJSP;
//              } else if (parameters.containsKey("main")){
//                forward = mainJSP;
//              }
//            RequestDispatcher view = request.getRequestDispatcher(forward);
//            view.forward(request, response);


        }

}