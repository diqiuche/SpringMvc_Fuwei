package com.fuwei.service.producesystem;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fuwei.entity.producesystem.FuliaoChangeLocation;
import com.fuwei.entity.producesystem.FuliaoOut;
import com.fuwei.entity.producesystem.Location;
import com.fuwei.service.BaseService;


@Component
public class LocationService extends BaseService {
	private Logger log = org.apache.log4j.LogManager.getLogger(LocationService.class);
	@Autowired
	JdbcTemplate jdbc;
	@Autowired
	FuliaoCurrentStockService fuliaoCurrentStockService;
	@Autowired
	FuliaoChangeLocationService fuliaoChangeLocationService;
	@Autowired
	FuliaoOutService fuliaoOutService;
	@Autowired
	SelfFuliaoOutService selfFuliaoOutService;
	// 库位存放辅料，修改库存数量
	@Transactional
	public synchronized int addQuantity(int locationId,int fuliaoId, int add_quantity) throws Exception {
		try{
			Location location = this.get(locationId);
			if(!location.getIsempty() && location.getFuliaoId() != fuliaoId){
				throw new Exception("该库位已经有辅料，请选择另一个库位存放");
			}
			int quantity = location.getQuantity() + add_quantity ;
			return dao.update(
					"UPDATE tb_location SET isempty=?,fuliaoId=?,quantity=? WHERE id = ?",
					false,fuliaoId, quantity ,locationId);
		}catch(Exception e){
			throw e;
		}

	}
	
	// 库位出库辅料，减少库存数量
	public synchronized int deleteQuantity(int locationId,int fuliaoId, int delete_quantity) throws Exception {
		try{
			Location location = this.get(locationId);
			if(location.getIsempty() || location.getFuliaoId() != fuliaoId){
				throw new Exception("该库位没有您需要出库的辅料");
			}
			int quantity = location.getQuantity() - delete_quantity ;
			boolean isempty = false;
			Integer temp_fuliaoId = fuliaoId;
			if(quantity < 0){
				throw new Exception("库位"+location.getNumber()+"库存不足");
			}
			if(quantity == 0){
				isempty = true;
				temp_fuliaoId = null;
			}
			return dao.update(
					"UPDATE tb_location SET isempty=?,fuliaoId=?,quantity=? WHERE id = ?",
					isempty,temp_fuliaoId, quantity ,locationId);
		}catch(Exception e){
			throw e;
		}

	}
	
	// 库位存放采购单的自购辅料，修改库存数量
	@Transactional
	public synchronized int addQuantity_purchase(int locationId,int fuliaoPurchaseOrderDetailId, int add_quantity) throws Exception {
		try{
			Location location = this.get(locationId);
			if(!location.getIsempty() && location.getFuliaoPurchaseOrderDetailId() != fuliaoPurchaseOrderDetailId){
				throw new Exception("该库位已经有辅料，请选择另一个库位存放");
			}
			int quantity = location.getQuantity() + add_quantity ;
			return dao.update(
					"UPDATE tb_location SET isempty=?,fuliaoPurchaseOrderDetailId=?,quantity=? WHERE id = ?",
					false,fuliaoPurchaseOrderDetailId, quantity ,locationId);
		}catch(Exception e){
			throw e;
		}

	}
	
	// 库位出库辅料，减少库存数量
	public synchronized int deleteQuantity_purchase(int locationId,int fuliaoPurchaseOrderDetailId, int delete_quantity) throws Exception {
		try{
			Location location = this.get(locationId);
			if(location.getIsempty() || location.getFuliaoPurchaseOrderDetailId() != fuliaoPurchaseOrderDetailId){
				throw new Exception("该库位没有您需要出库的辅料");
			}
			int quantity = location.getQuantity() - delete_quantity ;
			boolean isempty = false;
			Integer temp_fuliaoPurchaseOrderDetailId = fuliaoPurchaseOrderDetailId;
			if(quantity < 0){
				throw new Exception("库位"+location.getNumber()+"库存不足");
			}
			if(quantity == 0){
				isempty = true;
				temp_fuliaoPurchaseOrderDetailId = null;
			}
			return dao.update(
					"UPDATE tb_location SET isempty=?,fuliaoPurchaseOrderDetailId=?,quantity=? WHERE id = ?",
					isempty,temp_fuliaoPurchaseOrderDetailId, quantity ,locationId);
		}catch(Exception e){
			throw e;
		}

	}
	
	// 获取列表
	public List<Location> getList() throws Exception {
		try {
			List<Location> locationList = dao.queryForBeanList(
					"SELECT * FROM tb_location", Location.class);
			return locationList;
		} catch (Exception e) {
			throw e;
		}
	}
	
	// 获取列表 locationType是需要更改库位的原库位的类型
	public List<Location> getChangeLocationList(int fuliaoId,int locationType) throws Exception {
		try {
			List<Location> locationList = dao.queryForBeanList(
					"SELECT * FROM tb_location where (isempty=0 and fuliaoId=?)  or (isempty=1 and type=?)", Location.class,fuliaoId,locationType);
			return locationList;
		} catch (Exception e) {
			throw e;
		}
	}
	// 获取列表 locationType是需要更改库位的原库位的类型
	public List<Location> getChangeLocationList_purchase(int fuliaoPurchaseOrderDetailId,int locationType) throws Exception {
		try {
			List<Location> locationList = dao.queryForBeanList(
					"SELECT * FROM tb_location where (isempty=0 and fuliaoPurchaseOrderDetailId=?)  or (isempty=1 and type=?)", Location.class,fuliaoPurchaseOrderDetailId,locationType);
			return locationList;
		} catch (Exception e) {
			throw e;
		}
	}

	// 添加材料
	@Transactional
	public int add(Location location) throws Exception {
		try{
			location.setIsempty(true);
			return this.insert(location);
		}catch(Exception e){
			throw e;
		}
	}

	// 删除材料
	public int remove(int id) throws Exception {
		try{
			return dao.update("delete from tb_location WHERE  id = ?", id);
		}catch(Exception e){
			SQLException sqlException = (java.sql.SQLException)e.getCause();
			if(sqlException!=null && sqlException.getErrorCode() == 1451){//外键约束
				log.error(e);
				throw new Exception("已被引用，无法删除，请先删除与库位有关的引用");
			}
			throw e;
		}
	}

	// 编辑材料
	public int update(Location location) throws Exception {
		try{
			return this.update(location, "id", "quantity,fuliaoId,created_at,created_user,number,isempty",true);
		}catch(Exception e){
			throw e;
		}

	}
	
	// 获取材料
	public List<Location> getByFuliao(int fuliaoId) throws Exception {
		try {
			List<Location> locationlist = dao.queryForBeanList(
					"select * from tb_location where fuliaoId = ?", Location.class,
					fuliaoId);
			return locationlist;
		} catch (Exception e) {
			throw e;
		}
	}
	
	// 获取自购辅料当前库存
	public List<Location> getByPurchase(int fuliaoPurchaseOrderDetailId) throws Exception {
		try {
			List<Location> locationlist = dao.queryForBeanList(
					"select * from tb_location where fuliaoPurchaseOrderDetailId = ?", Location.class,
					fuliaoPurchaseOrderDetailId);
			return locationlist;
		} catch (Exception e) {
			throw e;
		}
	}
	
	// 获取材料
	public List<Map<String,Object>> getMapByFuliao(int fuliaoId) throws Exception {
		try {
			List<Map<String,Object>> map = dao.queryForListMap(
					"select fuliaoId,id locationId from tb_location where fuliaoId = ?",fuliaoId);
			return map;
		} catch (Exception e) {
			throw e;
		}
	}
	
	// 获取自购辅料当前库存
	public List<Map<String,Object>> getMapByPurchase(int fuliaoPurchaseOrderDetailId) throws Exception {
		try {
			List<Map<String,Object>> map = dao.queryForListMap(
					"select fuliaoPurchaseOrderDetailId,id locationId from tb_location where fuliaoPurchaseOrderDetailId = ?",fuliaoPurchaseOrderDetailId);
			return map;
		} catch (Exception e) {
			throw e;
		}
	}
	
	// 获取
	public Location get(int id) throws Exception {
		try {
			Location location = dao.queryForBean(
					"select * from tb_location where id = ?", Location.class,
					id);
			return location;
		} catch (Exception e) {
			throw e;
		}
	}
	
	// 获取
	public Location get(String number) throws Exception {
		try {
			Location location = dao.queryForBean(
					"select * from tb_location where number = ?", Location.class,
					number);
			return location;
		} catch (Exception e) {
			throw e;
		}
	}
	
	//更改库位, fuliaoId需更改库位的辅料， locationId是更改后的库位
	@Transactional
	public boolean changeLocation(int fuliaoId, int locationId,FuliaoChangeLocation handle) throws Exception{
		dao.update("update tb_location a ,  (select sum(quantity) quantity from tb_location where fuliaoId=?) b set a.isempty=?,a.fuliaoId=?,a.quantity=b.quantity where a.id=?",fuliaoId,false,fuliaoId,locationId);
		dao.update("update tb_location set isempty=? ,fuliaoId = ?,quantity=? where fuliaoId=? and id<>?", 1,null,0,fuliaoId,locationId);
		fuliaoChangeLocationService.add(handle);
		return true;
	}
	
	//更改库位, fuliaoId需更改库位的辅料， locationId是更改后的库位
	@Transactional
	public boolean changelocation_purchase(int fuliaoPurchaseOrderDetailId, int locationId,FuliaoChangeLocation handle) throws Exception{
		dao.update("update tb_location a ,  (select sum(quantity) quantity from tb_location where fuliaoPurchaseOrderDetailId=?) b set a.isempty=?,a.fuliaoPurchaseOrderDetailId=?,a.quantity=b.quantity where a.id=?",fuliaoPurchaseOrderDetailId,false,fuliaoPurchaseOrderDetailId,locationId);
		dao.update("update tb_location set isempty=? ,fuliaoId = ?,fuliaoPurchaseOrderDetailId=?,quantity=? where fuliaoPurchaseOrderDetailId=? and id<>?", 1,null,null,0,fuliaoPurchaseOrderDetailId,locationId);
		fuliaoChangeLocationService.add(handle);
		return true;
	}
	
//	//清空库位, locationId需清空的库位ID
//	@Transactional(rollbackFor=Exception.class)
//	public boolean cleanstock(int locationId,int userId) throws Exception{
//		//即创建一个与当前库存数量一致的辅料出库单即可
//		fuliaoOutService.addByLocationId(locationId, userId);
//		return true;
//	}
	
	//清空库位, locationId需清空的库位ID ,返回清空生成的出库单列表
	@Transactional(rollbackFor=Exception.class)
	public String cleanstock_batch(int[] locationIds,int userId) throws Exception{
		String ids = "";
		for(int i = 0 ;i < locationIds.length ; ++i){
			int locationId = locationIds[i];
			Location location = this.get(locationId);
			if(location.getIsempty()){
				continue;
			}else{
				if(location.getFuliaoId()!=null && location.getFuliaoId()!=0){//大货辅料清空库存
					int newfuliaoOutId = fuliaoOutService.addByLocationId(location, userId);
					if(newfuliaoOutId > 0){
						ids += newfuliaoOutId + ",";
					}
				}else{//自购辅料清空库存
					int newselffuliaoOutId = selfFuliaoOutService.addByLocationId(location, userId);
					if(newselffuliaoOutId > 0){
						ids += newselffuliaoOutId + ",";
					}
				}
			}
			
		}
		ids = ids.substring(0, ids.length()-1);
		return ids;
	}
}
