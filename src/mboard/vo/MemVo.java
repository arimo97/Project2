package mboard.vo;

public class MemVo {
	private String id;
	private String password;
	private String email;
	private String nickname;
	private int locstatus;
	
	public MemVo() {}

	public MemVo(String id, String password, String email, String nickname, int locstatus) {
		super();
		this.id = id;
		this.password = password;
		this.email = email;
		this.nickname = nickname;
		this.locstatus = locstatus;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getLocstatus() {
		return locstatus;
	}

	public void setLocstatus(int locstatus) {
		this.locstatus = locstatus;
	}

	@Override
	public String toString() {
		return "MemVo [id=" + id + ", password=" + password + ", email=" + email + ", nickname=" + nickname
				+ ", locstatus=" + locstatus + "]";
	}
	
}