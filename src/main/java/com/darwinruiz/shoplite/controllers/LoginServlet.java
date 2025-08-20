package com.darwinruiz.shoplite.controllers;

import com.darwinruiz.shoplite.models.User;
import com.darwinruiz.shoplite.repositories.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Optional;


/**
 * Requisito: autenticar, regenerar sesión y guardar auth, userEmail, role, TTL.
 */
@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {

    private UserRepository users;

    @Override
    public void init() {
        try {
            users = new UserRepository(); // Conexión a PostgreSQL
        } catch (SQLException e) {
            throw new RuntimeException("Error inicializando UserRepository", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            User u = users.findByUsername(username);

            if (u == null || !u.getPassword().equals(password)) {
                // Credenciales inválidas
                resp.sendRedirect(req.getContextPath() + "/login.jsp?err=1");
                return;
            }

            // Invalidar sesión previa
            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) oldSession.invalidate();

            // Crear nueva sesión
            HttpSession session = req.getSession(true);
            session.setAttribute("auth", true);
            session.setAttribute("username", u.getUsername());
            session.setAttribute("role", u.getRole());
            session.setMaxInactiveInterval(30 * 60); // 30 minutos

            resp.sendRedirect(req.getContextPath() + "/home");

        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/login.jsp?err=2"); // error DB
        }
    }
}