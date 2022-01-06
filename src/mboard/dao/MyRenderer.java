package mboard.dao;

import java.awt.Color;
import java.awt.Component;

import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;



public class MyRenderer extends DefaultTableCellRenderer 
{
	private static String sido;
    @Override
    public Component getTableCellRendererComponent(JTable table, Object value, boolean   isSelected, boolean hasFocus, int row, int column)
    {
        Component c = super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
//        if (! table.isRowSelected(row)) //현재 선택된 행의 색상은 변경하지 않고 선택 해제된 경우에만 배경색상을 변경한다
//        {
        
		sido = LoginDao.getSido();
		if(sido.equals("전국")) 
			sido = "전국";
		if(sido.equals("서울특별시")) 
			sido = "서울";
		if(sido.equals("부산광역시")) 
			sido = "부산";
		if(sido.equals("대구광역시")) 
			sido = "대구";
		if(sido.equals("인천광역시")) 
			sido = "인천";
		if(sido.equals("대전광역시")) 
			sido = "대전";
		if(sido.equals("세종특별자치시")) 
			sido = "세종";
		if(sido.equals("울상광역시")) 
			sido = "울산";
		if(sido.equals("경기도")) 
			sido = "경기";
		if(sido.equals("강원도")) 
			sido = "강원";
		if(sido.equals("충청북도")) 
			sido = "충북";
		if(sido.equals("충청남도")) 
			sido = "충남";
		if(sido.equals("전라북도")) 
			sido = "전북";
		if(sido.equals("전라남도")) 
			sido = "전남";
		if(sido.equals("경상북도")) 
			sido = "경북";
		if(sido.equals("경상남도")) 
			sido = "경남";
		if(sido.equals("제주특별자치도")) 
			sido = "제주";

		
            if(table.getValueAt(row, 0).toString().contains(sido)) { // 특정한 값을 가진 셀을 찾아서 그 셀만 배경색상을 변경한다
                c.setBackground(Color.lightGray);
            }else{
                c.setBackground(Color.white);
            }
//        }
        return c;
    }
}
