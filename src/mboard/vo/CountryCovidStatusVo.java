package mboard.vo;

public class CountryCovidStatusVo {
	private String countryNum;
	private String nationNm;
	private String areaNm;	
	private String natDefCnt; 
	private String natDeathCnt; 
	private String natDeathRate; 
	private String stdDay;
	public CountryCovidStatusVo() {}
	public CountryCovidStatusVo(String countryNum, String nationNm, String areaNm, String natDefCnt, String natDeathCnt,
			String natDeathRate, String stdDay) {
		super();
		this.countryNum = countryNum;
		this.nationNm = nationNm;
		this.areaNm = areaNm;
		this.natDefCnt = natDefCnt;
		this.natDeathCnt = natDeathCnt;
		this.natDeathRate = natDeathRate;
		this.stdDay = stdDay;
	}
	public String getCountryNum() {
		return countryNum;
	}
	public void setCountryNum(String countryNum) {
		this.countryNum = countryNum;
	}
	public String getNationNm() {
		return nationNm;
	}
	public void setNationNm(String nationNm) {
		this.nationNm = nationNm;
	}
	public String getAreaNm() {
		return areaNm;
	}
	public void setAreaNm(String areaNm) {
		this.areaNm = areaNm;
	}
	public String getNatDefCnt() {
		return natDefCnt;
	}
	public void setNatDefCnt(String natDefCnt) {
		this.natDefCnt = natDefCnt;
	}
	public String getNatDeathCnt() {
		return natDeathCnt;
	}
	public void setNatDeathCnt(String natDeathCnt) {
		this.natDeathCnt = natDeathCnt;
	}
	public String getNatDeathRate() {
		return natDeathRate;
	}
	public void setNatDeathRate(String natDeathRate) {
		this.natDeathRate = natDeathRate;
	}
	public String getStdDay() {
		return stdDay;
	}
	public void setStdDay(String stdDay) {
		this.stdDay = stdDay;
	}
	@Override
	public String toString() {
		return "CountryCovidStatusVo [countryNum=" + countryNum + ", nationNm=" + nationNm + ", areaNm=" + areaNm
				+ ", natDefCnt=" + natDefCnt + ", natDeathCnt=" + natDeathCnt + ", natDeathRate=" + natDeathRate
				+ ", stdDay=" + stdDay + "]";
	}
	
	

}
