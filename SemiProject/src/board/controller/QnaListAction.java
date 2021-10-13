package board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.BoardVO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;

public class QnaListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
			InterBoardDAO bdao = new BoardDAO();
			
			String board_id = request.getParameter("board_id");
			String board_subject = request.getParameter("board_subject");
			String board_content = request.getParameter("board_content");
			if(board_id != null && board_subject != null && board_content != null) {
				bdao.register(board_id,board_subject,board_content);
			
			}
			
			
			List<BoardVO> boardList =  bdao.selectPagingboard();
			
			
			/////////////////////////////////////////////////////
			
			request.setAttribute("boardList", boardList);
			
	        //	super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/qnaList.jsp");	
			
			return;

		}
		
	}

