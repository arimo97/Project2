package mboard.vo;

public class LocVo {
	int address_num;
	String id;
	String name;
	String address;
	
	public LocVo(int address_num, String id, String name, String address) {
		this.address_num = address_num;
		this.id = id;
		this.name = name;
		this.address = address;
	}
	

	public int getAddress_num() {
		return address_num;
	}

	public void setAddress_num(int address_num) {
		this.address_num = address_num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "LocVo [address_num=" + address_num + ", id=" + id + ", name=" + name + ", address=" + address + "]";
	}
	
}
