package com.fuwei.entity.producesystem;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import com.fuwei.util.DateTool;
import com.fuwei.util.NumberUtil;

import net.keepsoft.commons.annotation.IdentityId;
import net.keepsoft.commons.annotation.Table;
import net.keepsoft.commons.annotation.Temporary;

@Table("tb_fuliaoout")
public class FuliaoOut {
	@IdentityId
	private int id;
	private String number;//单号
	private Integer fuliaoout_noticeId;
	private Integer orderId;
	private String orderNumber;
	private Integer charge_employee;
	private int status;//一旦创建，status = 6
	private String state;//状态描述
	private Integer created_user;//创建人
	private Date created_at;
	private Integer receiver_employee;
	@Temporary
	private List<FuliaoOutDetail> detaillist;
	
	private String name;// 样品名称
	private String company_productNumber;//样品的公司货号
	
	/*是否打印、 是否打印辅料标签 属性*/
	private Boolean has_print;
	private Boolean has_tagprint;
	
	private Boolean is_cleaning;//是否是手动清库存单据 2016-4-9添加
	
	
	
	public Boolean getIs_cleaning() {
		return is_cleaning;
	}
	public void setIs_cleaning(Boolean is_cleaning) {
		this.is_cleaning = is_cleaning;
	}
	public Boolean getHas_print() {
		return has_print;
	}
	public void setHas_print(Boolean has_print) {
		this.has_print = has_print;
	}
	public Boolean getHas_tagprint() {
		return has_tagprint;
	}
	public void setHas_tagprint(Boolean has_tagprint) {
		this.has_tagprint = has_tagprint;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCompany_productNumber() {
		return company_productNumber;
	}
	public void setCompany_productNumber(String company_productNumber) {
		this.company_productNumber = company_productNumber;
	}
	public Integer getFuliaoout_noticeId() {
		return fuliaoout_noticeId;
	}
	public void setFuliaoout_noticeId(Integer fuliaoout_noticeId) {
		this.fuliaoout_noticeId = fuliaoout_noticeId;
	}
	
	public Integer getReceiver_employee() {
		return receiver_employee;
	}
	public void setReceiver_employee(Integer receiver_employee) {
		this.receiver_employee = receiver_employee;
	}
	public List<FuliaoOutDetail> getDetaillist() {
		return detaillist;
	}
	public void setDetaillist(List<FuliaoOutDetail> detaillist) {
		this.detaillist = detaillist;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	
	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public Integer getCharge_employee() {
		return charge_employee;
	}
	public void setCharge_employee(Integer charge_employee) {
		this.charge_employee = charge_employee;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Integer getCreated_user() {
		return created_user;
	}
	public void setCreated_user(Integer created_user) {
		this.created_user = created_user;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	
	public boolean isEditable(){
		if(this.status!=6){
			return true;
		}else{
			return false;
		}
	}
	public boolean isDeletable(){
		if(this.status!=6){
			return true;
		}else{
			return false;
		}
	}
	public String createNumber() throws ParseException{	
		return DateTool.getYear2() + "FC" + NumberUtil.appendZero(this.id, 4);
		
	}
	public String printStr(){
		if(this.has_print!=null && this.has_print){
			return "是";
		}
		else{
			return "否";
		}
	}
	
}
