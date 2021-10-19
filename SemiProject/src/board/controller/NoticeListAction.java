package board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.InterMemberDAO_KMK;
import member.model.MemberDAO_KMK;
import member.model.MemberVO_KMK;

public class NoticeListAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

	   

	     InterNoticeDAO ndao = new NoticeDAO();
		
		 String notice_id = request.getParameter("notice_id");
		 String notice_subject = request.getParameter("notice_subject");
		 String notice_content = request.getParameter("notice_content");
		 
		 if(notice_id != null && notice_subject != null && notice_content != null) {
			ndao.register(notice_id,notice_subject,notice_content);
		
		}
	
		
		List<NoticeVO> noticeList =  ndao.selectPagingnotice();
		
		
		/////////////////////////////////////////////////////
		
		request.setAttribute("noticeList", noticeList);
		
   //	super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/noticeList.jsp");	
		
		return;	
	   
   }

 }
