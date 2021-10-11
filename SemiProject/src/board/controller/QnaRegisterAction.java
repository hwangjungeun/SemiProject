package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;

public class QnaRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();

		InterBoardDAO bdao = new BoardDAO();
		
		String board_num = request.getParameter("board_num");
		System.out.println("board_num:"+board_num);
		String board_subject =request.getParameter("board_subject");
		System.out.println("board_subject:"+board_subject);
		String board_id = request.getParameter("board_id"); 
		System.out.println("board_id:"+board_id);
		String board_count = request.getParameter("board_count");
		System.out.println("board_count:"+board_count);
		String board_date = request.getParameter("board_date");
		System.out.println("board_date:"+board_date);

		request.setAttribute("board_num", board_num);
		request.setAttribute("board_id", board_id);
		request.setAttribute("board_subject", board_subject);
		request.setAttribute("board_count", board_count);
		request.setAttribute("board_date", board_date);
		
		
        //	super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/qnaRegister.jsp");	
		
		return;

	}

}
