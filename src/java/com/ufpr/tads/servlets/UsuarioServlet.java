/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ufpr.tads.servlets;

import com.ufpr.tads.beans.Usuario;
import com.ufpr.tads.facades.UsuarioFacade;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ArtVin
 */
@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        session = request.getSession(); 
        Usuario usuarioLogado = (Usuario) session.getAttribute("loginBean");
        RequestDispatcher rd = null;
        String action = (String) request.getParameter("action");
        if(action == null){
             action = (String) request.getAttribute("action");
        }
        if(action != null){
            switch(action){
                case "login" :
                    String login = (String) request.getParameter("login");
                    String senha = (String) request.getParameter("senha");
                    Usuario u = UsuarioFacade.usuarioLogin(login, senha);
                    if(u != null){
                        session.setAttribute("loginBean", u);
                        rd = getServletContext().getRequestDispatcher("/portal.jsp");
                    }
                    else{
                        request.setAttribute("msg", "Usuário/senha invalidos");
                        rd = getServletContext().getRequestDispatcher("/login.jsp");
                    }
                    break;
                case "formLogin":
                    rd = getServletContext().getRequestDispatcher("/login.jsp");   
                    break;
                case "formCliente":
                    request.setAttribute("estados", UsuarioFacade.getEstados());
                    rd = getServletContext().getRequestDispatcher("/clienteForm.jsp");
                    break;
                default :
                    rd = getServletContext().getRequestDispatcher("/index.jsp");
                    break;
            }
        }
        rd.forward(request, response);
       
    }
   
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
