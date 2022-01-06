package mboard.vo;

public class MemViewVo {
   private String id;
   private String passwd;
   private String name;
   private String birth;
   private String gender;
   private String tel;
   private String email;
   private String sido;
   private String sigungu;
   private String eup_myeon_dong;
   private String li;
   private String doro;
   private int doro_bon;
   private int doro_bu;
   private String sigungu_build_name;
   private String build_detail;
   private String address_detail;
   public MemViewVo() {}
   public MemViewVo(String id, String passwd, String name, String birth, String gender, String tel, String email, String sido,
		String sigungu, String eup_myeon_dong, String li, String doro, int doro_bon, int doro_bu,
		String sigungu_build_name, String build_detail, String address_detail) {
	this.id = id;
	this.passwd = passwd;
	this.name = name;
	this.birth = birth;
	this.gender = gender;
	this.tel = tel;
	this.email = email;
	this.sido = sido;
	this.sigungu = sigungu;
	this.eup_myeon_dong = eup_myeon_dong;
	this.li = li;
	this.doro = doro;
	this.doro_bon = doro_bon;
	this.doro_bu = doro_bu;
	this.sigungu_build_name = sigungu_build_name;
	this.build_detail = build_detail;
	this.address_detail = address_detail;
	
}
public MemViewVo(String o_mem_id, String o_mem_name, String o_mem_birth, String o_mem_gender, String o_mem_tel,
		String o_mem_email, String o_mem_sido, String o_mem_sigungu, String o_mem_eup_myeon_dong, String o_mem_li,
		String o_mem_doro, int o_mem_doro_bon, int o_mem_doro_bu, String o_mem_sigungu_build_name,
		String o_mem_build_detail, String o_mem_address_detail) {
	this.id = id;
	this.name = name;
	this.birth = birth;
	this.gender = gender;
	this.tel = tel;
	this.email = email;
	this.sido = sido;
	this.sigungu = sigungu;
	this.eup_myeon_dong = eup_myeon_dong;
	this.li = li;
	this.doro = doro;
	this.doro_bon = doro_bon;
	this.doro_bu = doro_bu;
	this.sigungu_build_name = sigungu_build_name;
	this.build_detail = build_detail;
	this.address_detail = address_detail;
}
public MemViewVo(String id, String name, String tel, String email, String sido,
		String sigungu, String eup_myeon_dong) {
	this.id = id;
	this.name = name;
	this.tel = tel;
	this.email = email;
	this.sido = sido;
	this.sigungu = sigungu;
	this.eup_myeon_dong = eup_myeon_dong;
}
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getPasswd() {
	return passwd;
}
public void setPasswd(String passwd) {
	this.passwd = passwd;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getBirth() {
	return birth;
}
public void setBirth(String birth) {
	this.birth = birth;
}
public String getGender() {
	return gender;
}
public void setGender(String gender) {
	this.gender = gender;
}
public String getTel() {
	return tel;
}
public void setTel(String tel) {
	this.tel = tel;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getSido() {
	return sido;
}
public void setSido(String sido) {
	this.sido = sido;
}
public String getSigungu() {
	return sigungu;
}
public void setSigungu(String sigungu) {
	this.sigungu = sigungu;
}
public String getEup_myeon_dong() {
	return eup_myeon_dong;
}
public void setEup_myeon_dong(String eup_myeon_dong) {
	this.eup_myeon_dong = eup_myeon_dong;
}
public String getLi() {
	return li;
}
public void setLi(String li) {
	this.li = li;
}
public String getDoro() {
	return doro;
}
public void setDoro(String doro) {
	this.doro = doro;
}
public int getDoro_bon() {
	return doro_bon;
}
public void setDoro_bon(int doro_bon) {
	this.doro_bon = doro_bon;
}
public int getDoro_bu() {
	return doro_bu;
}
public void setDoro_bu(int doro_bu) {
	this.doro_bu = doro_bu;
}
public String getSigungu_build_name() {
	return sigungu_build_name;
}
public void setSigungu_build_name(String sigungu_build_name) {
	this.sigungu_build_name = sigungu_build_name;
}
public String getBuild_detail() {
	return build_detail;
}
public void setBuild_detail(String build_detail) {
	this.build_detail = build_detail;
}
public String getAddress_detail() {
	return address_detail;
}
public void setAddress_detail(String address_detail) {
	this.address_detail = address_detail;
}
@Override
public String toString() {
	return "MemVo [id=" + id + ", passwd=" + passwd + ", name=" + name + ", birth=" + birth + ", gender=" + gender
			+ ", tel=" + tel + ", email=" + email + ", sido=" + sido + ", sigungu=" + sigungu + ", eup_myeon_dong="
			+ eup_myeon_dong + ", li=" + li + ", doro=" + doro + ", doro_bon=" + doro_bon + ", doro_bu=" + doro_bu
			+ ", sigungu_build_name=" + sigungu_build_name + ", build_detail=" + build_detail + ", address_detail="
			+ address_detail + "]";
}

}
