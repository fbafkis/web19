package controllers;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.MedicoDTO;
import dto.PazienteDTO;

/**
 *  
 */
@WebServlet("/medico/DettagliPaziente")
public class DettagliPaziente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		//TODO per mettere le info nel parco pazienti devo caricare gia la lista pazienti con relative info
		MedicoDTO user= (MedicoDTO) request.getSession().getAttribute("user");
		int id_paziente = Integer.parseInt(request.getParameter("id"));
		PazienteDTO paziente = user.getPazienteById(id_paziente);//cerca il paziente corrispondente nella lista dei suoi pazienti
		
		
		request.getSession().setAttribute("paziente", paziente);
				
		response.sendRedirect(request.getContextPath()+"/medico/dettagliPaziente.jsp");
		
	}

}
