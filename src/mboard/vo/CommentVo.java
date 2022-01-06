package mboard.vo;

public class CommentVo {

	// field
	
	private int cnum;
	private int bnum;
	private String ctext;
	private String id;
	private String cregdate;
	private String cupdate;
	private String cdelete;
	private String nickname;
	
	public CommentVo() {
		
	}
	
	// 댓글 전체
	
	public CommentVo(int cnum, int bnum, String ctext, String id, String cregdate, String cupdate, String cdelete,
			String nickname) {
		this.cnum = cnum;
		this.bnum = bnum;
		this.ctext = ctext;
		this.id = id;
		this.cregdate = cregdate;
		this.cupdate = cupdate;
		this.cdelete = cdelete;
		this.nickname = nickname;
	}
	
	// 해당 게시글 댓글 목록
	
	public CommentVo(int cnum, String ctext, String id, String cregdate, String cupdate, String cdelete,
			String nickname) {
		this.cnum = cnum;
		this.ctext = ctext;
		this.id = id;
		this.cregdate = cregdate;
		this.cupdate = cupdate;
		this.cdelete = cdelete;
		this.nickname = nickname;
	}
	
	public CommentVo(int bnum, String ctext, String id, String nickname) {
		this.bnum = bnum;
		this.ctext = ctext;
		this.id = id;
		this.nickname = nickname;
	}

	public int getCnum() {
		return cnum;
	}

	public void setCnum(int cnum) {
		this.cnum = cnum;
	}

	public int getBnum() {
		return bnum;
	}

	public void setBnum(int bnum) {
		this.bnum = bnum;
	}

	public String getCtext() {
		return ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCregdate() {
		return cregdate;
	}

	public void setCregdate(String cregdate) {
		this.cregdate = cregdate;
	}

	public String getCupdate() {
		return cupdate;
	}

	public void setCupdate(String cupdate) {
		this.cupdate = cupdate;
	}

	public String getCdelete() {
		return cdelete;
	}

	public void setCdelete(String cdelete) {
		this.cdelete = cdelete;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	@Override
	public String toString() {
		return "CommentVo [cnum=" + cnum + ", bnum=" + bnum + ", ctext=" + ctext + ", id=" + id + ", cregdate="
				+ cregdate + ", cupdate=" + cupdate + ", cdelete=" + cdelete + ", nickname=" + nickname + "]";
	}
	
	
	
	
}
