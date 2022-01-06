package mboard.vo;
/**
 * 
 */

/**
 * @author aquilegia
 *
 */
public class GeoVo {
	public double x;
	public double y;
	public double z;
	
	/**
	 * 
	 */
	public GeoVo() {
		super();
	}
	
	/**
	 * @param x
	 * @param y
	 */
	public GeoVo(double x, double y) {
		super();
		this.x = x;
		this.y = y;
		this.z = 0;
	}
	
	/**
	 * @param x
	 * @param y
	 * @param y
	 */
	public GeoVo(double x, double y, double z) {
		super();
		this.x = x;
		this.y = y;
		this.z = z;
	}
	
	public double getX() {
		return x;
	}

	public double getY() {
		return y;
	}
	
	public double getZ() {
		return z;
	}
}
