package mboard.base;

import mboard.impl.BoardActionDelete;
import mboard.impl.BoardActionUpdate;
import mboard.impl.BoardActionUpdateForm;
import mboard.impl.BoardActionView;
import mboard.impl.BoardActionWrite;
import mboard.impl.BoardActionWriteForm;
import mboard.impl.BoardListAction;
import mboard.impl.CommentDelete;
import mboard.impl.CommentOptionAction;
import mboard.impl.CommentUpdate;
import mboard.impl.CoronaDistanceAction;
import mboard.impl.CountryCovidStatusAction;
import mboard.impl.CovidDeleteAction;
import mboard.impl.CovidInfoAction;
import mboard.impl.CovidInfoFormAction;
import mboard.impl.CovidInfoListAction;
import mboard.impl.CovidInfoUpdateAction;
import mboard.impl.CovidStatusAction;
import mboard.impl.CovidViewAction;
import mboard.impl.HomeAction;
import mboard.impl.LoginAction;
import mboard.impl.LogoutAction;
import mboard.impl.MemInfoFormAction;
import mboard.impl.MemJoinAction;
import mboard.impl.MemRegstraionAction;
import mboard.impl.MemUpdateAction;
import mboard.impl.NewsAction;
import mboard.impl.NoShowVaccineAction;
import mboard.impl.ScreeningClinicAction;
import mboard.impl.VaccinationCenterAction;
import mboard.impl.VaccineStaticsAction;

public class ActionFactory {
	
	public  Action  getAction(String command) {
		
		Action   action = null;
		switch (command) {
		// Menu
		case "LOGIN":   // 로그인
			action     =  new  LoginAction();
			break;
		case "LOGOUT": // 로그아웃
			action 	   =  new LogoutAction();
			break;
		case "REGISTRATION": // 가입정보 저장
			action = new MemRegstraionAction();
			break;
		case "MEMJOIN": // 가입페이지
			action = new MemJoinAction();
			break;
		case "MEMINFOFORM": // 회원정보 수정
			action = new MemInfoFormAction();
			break;
		case "MEMINFOUPDATE": // 회원정보 수정
			action = new MemUpdateAction();
			break;
		case "HOME":   // 홈
			action     =  new  HomeAction();
			break;
		case "CORONADISTANCE":   // 사회적거리두기
			action     =  new  CoronaDistanceAction();
			break;
		case "VACCINESTATICS":   // 백신통계
			action     =  new  VaccineStaticsAction();
			break;
		case "COVIDINFOFORM":   // 개인코로나정보 
			action     =  new  CovidInfoFormAction();
			break;
		case "COVIDINFO":   // 개인코로나정보 저장
			action     =  new  CovidInfoAction();
			break;
		case "COVIDINFOLIST":   // 개인코로나정보 목록
			action     =  new  CovidInfoListAction();
			break;
		case "COVIDVIEW":   // 개인코로나정보 목록
			action     =  new  CovidViewAction();
			break;
		case "COVIDINFODELETE":   // 개인코로나정보 목록
			action     =  new  CovidDeleteAction();
			break;
		case "COVIDINFOUPDATE":   // 개인코로나정보 목록
			action     =  new  CovidInfoUpdateAction();
			break;
		case "COVIDSTATUS":      // 코로나 현재 상황
			action     =  new  CovidStatusAction();
			break;
		case "COUNTRYCOVIDSTATUS":      // 코로나 현재 상황
			action     =  new  CountryCovidStatusAction();
			break;
		case "NEWS":
			action	   =  new  NewsAction();
			break;
		case "SCREENING":
			action     =  new  ScreeningClinicAction();
			break;
		case "NOSHOWVACCINE" :
			action	   =  new  NoShowVaccineAction();
			break;
		case "VACCINATIONCENTER" :
			action	   =  new  VaccinationCenterAction();
			break;
			
			
			
		case "BOARD":      // 코로나 현재 상황
			action     =  new  BoardListAction();
			break;
			// Board
		case "WRITEFORM":  // 새글 쓰기 
			action   =  new  BoardActionWriteForm();
			break;
		case "WRITE":       
			action   =  new  BoardActionWrite();
			break;
		case "VIEW":       
			action   =  new  BoardActionView();
			break;
		case "DELETE":       
			action   =  new  BoardActionDelete();
			break;

		case "UPDATEFORM":       
			action   =  new  BoardActionUpdateForm();
			break;
		case "UPDATE":       
			action   =  new  BoardActionUpdate();
			break;

			// Comment
		case "COMMENTUPDATE":
			action   =  new  CommentUpdate();
			break;
			
		case "COMMENTDELETE":
			action   =  new  CommentDelete();
			break;
		case "COMMENTOPTION":
			action   =  new  CommentOptionAction();
			break;
	
			
		
		  

		default:
			break;
		}
		
		return action;
		
	} 
	
}






