package mboard.dao;

import mboard.vo.GeoVo;

public class Test_geoconvert {
	public static void main(String[] args) {
		GeoVo in_pt = new GeoVo(129.1023126, 35.1385167);
		System.out.println("geo in : xGeo="  + in_pt.getX() + ", yGeo=" + in_pt.getY());
		GeoVo tm_pt = GeoTrans.convert(GeoTrans.GEO, GeoTrans.TM, in_pt);
		System.out.println("tm : xTM=" + tm_pt.getX() + ", yTM=" + tm_pt.getY());
		GeoVo katec_pt = GeoTrans.convert(GeoTrans.TM, GeoTrans.KATEC, tm_pt);
		System.out.println("katec : xKATEC=" + katec_pt.getX() + ", yKATEC=" + katec_pt.getY());
		GeoVo out_pt = GeoTrans.convert(GeoTrans.KATEC, GeoTrans.GEO, katec_pt);
		System.out.println("geo out : xGeo=" + out_pt.getX() + ", yGeo=" + out_pt.getY());
		GeoVo in2_pt = new GeoVo(128., 38.);
		System.out.println("geo distance between (127,38) and (128,38) =" + GeoTrans.getDistancebyGeo(in_pt, in2_pt) + "km");
	}
}

/*
	geo in : xGeo=129.1023126, yGeo=35.1385167
	tm : xTM=391534.5501087281, yTM=184178.4486754043
	katec : xKATEC=546168.0238363734, yKATEC=283461.4568991752
	geo out : xGeo=129.10231262597011, yGeo=35.13851680266061
	geo distance between (127,38) and (128,38) =333.3421660770819km

	
	<a href="https://map.kakao.com/?urlX=978977&urlY=461200&urlLevel=3&map_type=TYPE_MAP&map_hybrid=false" target="_blank"><img width="504" height="310" src="https://map2.daum.net/map/mapservice?FORMAT=PNG&SCALE=2.5&MX=978977&MY=461200&S=0&IW=504&IH=310&LANG=0&COORDSTM=WCONGNAMUL&logo=kakao_logo" style="border:1px solid #ccc"></a><div class="hide" style="overflow:hidden;padding:7px 11px;border:1px solid #dfdfdf;border-color:rgba(0,0,0,.1);border-radius:0 0 2px 2px;background-color:#f9f9f9;width:482px;"><strong style="float: left;"><img src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/common/logo_kakaomap.png" width="72" height="16" alt="카카오맵"></strong><div style="float: right;position:relative"><a style="font-size:12px;text-decoration:none;float:left;height:15px;padding-top:1px;line-height:15px;color:#000" target="_blank" href="https://map.kakao.com/?urlX=978977&urlY=461200&urlLevel=3&map_type=TYPE_MAP&map_hybrid=false">지도 크게 보기</a></div></div>
	35.1385167, 129.1023126
	
	urlX=978836&urlY=460445

*/

/*
	geo in : xGeo=127.0, yGeo=38.0
tm : xTM=199934.8753709018, yTM=499702.5110405184
katec : xKATEC=356293.5017769094, yKATEC=599819.5382985716
geo out : xGeo=127.00000003159852, yGeo=38.0000001110145
geo distance between (127,38) and (128,38) =87.69801962758204km


	<a href="https://map.kakao.com/?urlX=532470&urlY=1230953&urlLevel=9&map_type=TYPE_MAP&map_hybrid=false" target="_blank"><
	img width="504" height="310" src="https://map2.daum.net/map/mapservice?FORMAT=PNG&SCALE=160&MX=532470&MY=1230953&S=0&IW=504&IH=310&LANG=0&COORDSTM=WCONGNAMUL&logo=kakao_logo" style="border:1px solid #ccc"></a><div class="hide" style="overflow:hidden;padding:7px 11px;border:1px solid #dfdfdf;border-color:rgba(0,0,0,.1);border-radius:0 0 2px 2px;background-color:#f9f9f9;width:482px;"><strong style="float: left;"><img src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/common/logo_kakaomap.png" width="72" height="16" alt="카카오맵"></strong><div style="float: right;position:relative"><a style="font-size:12px;text-decoration:none;float:left;height:15px;padding-top:1px;line-height:15px;color:#000" target="_blank" href="https://map.kakao.com/?urlX=532470&urlY=1230953&urlLevel=9&map_type=TYPE_MAP&map_hybrid=false">
	지도 크게 보기</a></div></div>


	urlX=499835&urlY=1249255
*/

