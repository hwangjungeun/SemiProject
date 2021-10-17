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
		
		
			String method = request.getMethod();
			
			InterBoardDAO bdao = new BoardDAO();
			
			List<BoardVO> boardList =  bdao.selectPagingboard();
			
			// System.out.println("확인용 boardList " + boardList);
			
			request.setAttribute("boardList", boardList);
			
	        //	super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/qnaList.jsp");	
			
			return;

		}
		
	}

