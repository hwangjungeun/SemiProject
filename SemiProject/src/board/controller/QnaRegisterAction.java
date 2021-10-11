package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.BoardDAO;
import board.model.BoardVO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;

public class QnaRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();

		BoardVO bvo = new BoardVO();
		
		bvo.setBoard_id(request.getParameter("board_id"));
		bvo.setBoard_subject(request.getParameter("board_subject"));
		bvo.setBoard_content(request.getParameter("board_content"));
		
		InterBoardDAO bdao = new BoardDAO();
		bdao.registerQna(bvo);
		
		
        //	super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/qnaRegister.jsp");	
		
		return;

	}

}
