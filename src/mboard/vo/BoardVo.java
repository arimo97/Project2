package mboard.vo;

public class BoardVo {
	
	// Fields
	
	private int     bnum;
	private String  btitle;
	private String  btext;
	private String  id;
	private int     readcount;
	private String  bregdate;
	private String  bupdate;
	private String  nickname;
	private String  bdelete;
	
	// Constructor
	// 기본생성자
	public  BoardVo() {
		
	}
	
	// list.jsp
//	public BoardVo(int idx, String title, String writer, String regdate,
//			int readcount, int bnum, int lvl, int step, int nref) {
//		this.idx = idx;
//		this.title = title;
//		this.writer = writer;
//		this.regdate = regdate;
//		this.readcount = readcount;
//		this.bnum = bnum;
//		this.lvl = lvl;
//		this.step = step;
//		this.nref = nref;
//	}
	
	// list.jsp
	public BoardVo(int bnum, String btitle, String id, int readcount, String bregdate, String nickname, String bdelete) {
		this.bnum      = bnum;
		this.btitle    = btitle;
		this.id        = id;
		this.readcount = readcount;
		this.bregdate  = bregdate;	
		this.nickname  = nickname;	
		this.bdelete   = bdelete;	
	}

	
	//  view.jsp
//	public BoardVo(int idx, String menu_id, String title, String cont, String writer, String regdate, int readcount,
//			int bnum, int lvl, int step, int nref) {
//		this.idx = idx;
//		this.menu_id = menu_id;
//		this.title = title;
//		this.cont = cont;
//		this.writer = writer;
//		this.regdate = regdate;
//		this.readcount = readcount;
//		this.bnum = bnum;
//		this.lvl = lvl;
//		this.step = step;
//		this.nref = nref;
//	}
	
//  view.jsp
	public BoardVo(int bnum, String btitle, String btext, String id, int readcount, String bregdate,
			String bupdate, String nickname, String bdelete) {
		this.bnum = bnum;
		this.btitle = btitle;
		this.btext = btext;
		this.id = id;
		this.readcount = readcount;
		this.bregdate = bregdate;	
		this.bupdate = bupdate;	
		this.nickname = nickname;
		this.bdelete = bdelete;	
	}

	
	//write.jsp
	
//	public BoardVo(String menu_id, String writer, String title, String cont) {
//		this.menu_id  = menu_id;
//		this.title    = title;
//		this.writer   = writer;
//		this.cont     = cont;
//	}

	
	//write.jsp 
	public BoardVo(String id, String btitle, String btext, String nickname) {
		this.id       = id;
		this.btitle   = btitle;
		this.btext    = btext;
		this.nickname = nickname;
	}

	public int getBnum() {
		return bnum;
	}

	public void setBnum(int bnum) {
		this.bnum = bnum;
	}

	public String getBtitle() {
		return btitle;
	}

	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}

	public String getBtext() {
		return btext;
	}

	public void setBtext(String btext) {
		this.btext = btext;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getBregdate() {
		return bregdate;
	}

	public void setBregdate(String bregdate) {
		this.bregdate = bregdate;
	}

	public String getBupdate() {
		return bupdate;
	}

	public void setBupdate(String bupdate) {
		this.bupdate = bupdate;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getBdelete() {
		return bdelete;
	}

	public void setBdelete(String bdelete) {
		this.bdelete = bdelete;
	}

	@Override
	public String toString() {
		return "BoardVo [bnum=" + bnum + ", btitle=" + btitle + ", btext=" + btext + ", id=" + id + ", readcount="
				+ readcount + ", bregdate=" + bregdate + ", bupdate=" + bupdate + ", nickname=" + nickname
				+ ", bdelete=" + bdelete + "]";
	}


	
}
