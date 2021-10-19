package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends AbstractController{

/*	
	@Override
	public String toString() { // 모든클래스의 최상위 부모클래스가 Object클래스인데, 그것의 toString을 재정의
		return "@@@ 클래스 MainController 의 인스턴스 메소드 toString() 호출됨 @@@";
	}
*/
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// MainController 클래스의 인스턴스 메소드 // 따라서, 이 메소드가 작동하려면 객체가 필요함

		// System.out.println("@@@ MainController 클래스의 excute() 메소드 호출됨 @@@");
		
		super.setRedirect(true);
		super.setViewPage("index.go"); // /SemiProject/index.go 페이지로 이동한다.
		
	}

}
