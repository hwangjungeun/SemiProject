package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class QnaShowAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		String method = request.getMethod();
		
        //	super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/qnaShow.jsp");	
		
		return;
		
	}

}
