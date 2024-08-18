package com.service.wap;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ApplybusinessDAO;
import com.dao.AreaDAO;
import com.dao.BusinessDAO;
import com.dao.CityDAO;
import com.dao.HqlDAO;
import com.dao.ProvinceDAO;
import com.pojo.Applybusiness;
import com.pojo.Area;
import com.pojo.Business;
import com.pojo.City;
import com.pojo.Province;
import com.util.JsonFilter;
import com.util.MapUtil;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

@Service
public class WapApplyBusinessService {

	@Autowired
	private ProvinceDAO provinceDAO;
	@Autowired
	private AreaDAO areaDAO;
	@Autowired
	private CityDAO cityDAO;
	@Autowired
	private BusinessDAO businessDAO;
	@Autowired
	private HqlDAO hqlDAO;
	@Autowired
	private ApplybusinessDAO applybusinessDAO;
	
	public List<Province> FindProvinceAll() {
		List<Province> plist = provinceDAO.findAll();
		return plist;
	}

	public void addApply(String openid, String shopname, String realname, String shoptel, String shoptype, Short gender, Integer arid,
			String gpinpai, String describe, String cimages) {
		Applybusiness applybusiness2 = new Applybusiness();
		applybusiness2.setOpenid(openid);
		applybusiness2.setTel(shoptel);
		applybusinessDAO.save(applybusiness2);
		
		Business applybusiness = new Business();
		String hql = "from Area where arid = ?";
		Area area = areaDAO.findById(arid);
		String areaname = area.getArName();
		City city = area.getCity();
		String ctname = city.getCtName();
		Province p = city.getProvince();
		String pname = p.getPrName();
		
		applybusiness.setOpenid(openid);
		applybusiness.setShopname(shopname);
		applybusiness.setRealname(realname);
		applybusiness.setTel(shoptel);
		//applybusiness.setEmail(shopemail);
		applybusiness.setShoptype(shoptype);
		applybusiness.setGender(gender);
		applybusiness.setArea(area);
		applybusiness.setShopaddr(gpinpai);
		applybusiness.setShopDesc(describe);
		applybusiness.setShoplogo("daili/images/lunboimg/"+cimages);
		//System.out.println("daili/images/lunboimg/"+cimages);
		applybusiness.setStatus((short)0);//0未审核，1已通过，2被拒绝
		
		// applybusiness.setGimages("/admin/images/applybusiness/" + gimages);
		Double j = 0.0;
		Double w = 0.0;
		Double j_t=0.0;
		Double w_t=0.0;
		try {
			System.out.println( "拼地址："+pname+ctname+areaname+gpinpai);
			Map<String, Double> baidu_map=MapUtil.getLngAndLatByBaidu(pname+ctname+areaname+gpinpai);
			j = baidu_map.get("j");
			w = baidu_map.get("w");
			 
			Map<String, Double> tencen_map=MapUtil.getLngAndLatByTencent(j,w);
			j_t=tencen_map.get("j");
			w_t=tencen_map.get("w");
			applybusiness.setLatitude(w);
			applybusiness.setLongitude(j);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Date date = new Date();       
		Timestamp applytime = new Timestamp(date.getTime());
		applybusiness.setRegisttime(applytime);
		businessDAO.save(applybusiness);
	}

	public String findByidCity(int prid) {
		String hql="from City c where c.province.prId=?";
		List list=hqlDAO.findByHQL(hql,prid);
		JsonConfig config=new JsonConfig();
		JsonFilter.ignoredSet(config);
		String json=JSONArray.fromObject(list, config).toString();
		return json;
	}
	
	public String findByIdArea(int crid) {
		String hql="from Area  a where a.city.ctId=?";
		List list=hqlDAO.findByHQL(hql, crid);
		JsonConfig config=new JsonConfig();
		JsonFilter.ignoredSet(config);
		String json=JSONArray.fromObject(list, config).toString();
		return json;
	}

		 


}
