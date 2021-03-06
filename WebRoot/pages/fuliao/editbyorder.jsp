<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@page import="com.fuwei.commons.SystemCache"%>
<%@page import="com.fuwei.entity.FuliaoType"%>
<%@page import="com.fuwei.entity.Factory"%>
<%@page import="com.fuwei.entity.Order"%>
<%@page import="com.fuwei.entity.producesystem.Fuliao"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	List<FuliaoType> fuliaoTypelist = SystemCache.fuliaotypelist;
	Fuliao fuliao = (Fuliao)request.getAttribute("fuliao");
%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>编辑辅料 -- 桐庐富伟针织厂</title>
		<meta charset="utf-8">
		<meta http-equiv="keywords" content="针织厂,针织,富伟,桐庐">
		<meta http-equiv="description" content="富伟桐庐针织厂">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<!-- 为了让IE浏览器运行最新的渲染模式 -->
		<link href="css/plugins/bootstrap.min.css" rel="stylesheet"
			type="text/css" />
		<link href="css/plugins/font-awesome.min.css" rel="stylesheet"
			type="text/css" />
		<link href="css/common/common.css" rel="stylesheet" type="text/css" />
		<script src="js/plugins/jquery-1.10.2.min.js"></script>
		<script src="js/plugins/bootstrap.min.js" type="text/javascript"></script>
		<script src="js/common/common.js" type="text/javascript"></script>
		<script src="js/plugins/jquery.form.js" type="text/javascript"></script>
		<script src="js/fuliao/edit.js" type="text/javascript"></script>
		<style type="text/css">
.addform input[type='file'] {
	outline: none !important;
}
span.location_size{margin-right:20px;font-size:20px;}
input[name='location_size']{height:20px;width:20px;}
</style>
	</head>
	<body>
		<%@ include file="../common/head.jsp"%>
		<div id="Content">
			<div id="main">
				<div class="breadcrumbs" id="breadcrumbs">
					<ul class="breadcrumb">
						<li>
							<i class="fa fa-home"></i>
							<a href="user/index">首页</a>
						</li>
						<li>
							<i class=""></i>
							<a href="order/detail/<%=fuliao.getOrderId() %>">订单详情</a>
						</li>
						<li>
							<i class=""></i>
							<a href="order/fuliao_progress/<%=fuliao.getOrderId()%>?tab=fuliaolist">辅料列表及出入库情况</a>
						</li>
						<li class="active">
							编辑辅料
						</li>
					</ul>
				</div>
				<div class="body">

					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12 formwidget">
								<div class="panel panel-primary">
									<div class="panel-heading">
										<h3 class="panel-title">
											编辑辅料, 编号： <%=fuliao.getFnumber() %>
										</h3>
									</div>
									<div class="panel-body">

										<form class="form-horizontal addform" role="form"
											enctype="multipart/form-data">
											<input type="hidden" name="id" value="<%=fuliao.getId() %>" />
											<input type="hidden" name="orderId" value="<%=fuliao.getOrderId() %>" />
											<input type="hidden" name="orderNumber" value="<%=fuliao.getOrderNumber() %>" />
											<div class="col-md-7">
												<fieldset>
													<legend>第一步、填写基本信息</legend>
													<div class="form-group">
													<label for="orderNumber" class="col-sm-3 control-label">
														厂订单号
													</label>
													<div class="col-sm-8">
														<input type="text" class="form-control"
															name="orderNumber" id="orderNumber" disabled placeholder="厂订单号" value="<%=fuliao.getOrderNumber() %>">
													</div>
													<div class="col-sm-1"></div>
												</div>
												<div class="form-group">
													<label for="file" class="col-sm-3 control-label">
														图片
													</label>
													<div class="col-sm-8">
														<input type="file" name="file" id="file"
															class="form-control" placeholder="图片" />

													</div>
													<div class="col-sm-1"></div>
												</div>
												<div class="form-group">
													<label for="fuliaoTypeId" class="col-sm-3 control-label">
														辅料类型
													</label>
													<div class="col-sm-8">
														<select class="form-control require" name="fuliaoTypeId"
															id="fuliaoTypeId">
															<option value="">
																未选择
															</option>
															<%
																for (FuliaoType fuliaoType : fuliaoTypelist) {
																	if(fuliaoType.getId() == fuliao.getFuliaoTypeId()){
															%>
															<option value="<%=fuliaoType.getId()%>" selected><%=fuliaoType.getName()%></option>
															<%
																}else{
															%>
															<option value="<%=fuliaoType.getId()%>"><%=fuliaoType.getName()%></option>
															<%
																}
																}
															%>
														</select>
													</div>
													<div class="col-sm-1"></div>
												</div>
												<div class="form-group">
													<label for="company_orderNumber" class="col-sm-3 control-label">
														公司订单号
													</label>
													<div class="col-sm-8">
														<input type="text" class="form-control require"
															name="company_orderNumber" id="company_orderNumber" value="<%=fuliao.getCompany_orderNumber() %>">
													</div>
													<div class="col-sm-1"></div>
												</div>
												<div class="form-group">
													<label for="company_productNumber" class="col-sm-3 control-label">
														公司款号
													</label>
													<div class="col-sm-8">
														<input type="text" class="form-control require"
															name="company_productNumber" id="company_productNumber"  value="<%=fuliao.getCompany_productNumber() %>">
													</div>
													<div class="col-sm-1"></div>
												</div>
												<div class="form-group">
													<label for="country" class="col-sm-3 control-label">
														国家/城市
													</label>
													<div class="col-sm-8">
														<input type="text" class="form-control"
															name="country" id="country"  value="<%=fuliao.getCountry() %>">
													</div>
													<div class="col-sm-1"></div>
												</div>
												<div class="form-group">
													<label for="color" class="col-sm-3 control-label">
														颜色
													</label>
													<div class="col-sm-8">
														<input type="text" class="form-control"
															name="color" id="color"  value="<%=fuliao.getColor() %>">
													</div>
													<div class="col-sm-1"></div>
												</div>
												<div class="form-group">
													<label for="size" class="col-sm-3 control-label">
														尺码
													</label>
													<div class="col-sm-8">
														<input type="text" class="form-control"
															name="size" id="size"  value="<%=fuliao.getSize() %>">
													</div>
													<div class="col-sm-1"></div>
												</div>
												<div class="form-group">
													<label for="batch" class="col-sm-3 control-label">
														批次
													</label>
													<div class="col-sm-8">
														<input type="text" class="form-control"
															name="batch" id="batch"  value="<%=fuliao.getBatch() %>">
													</div>
													<div class="col-sm-1"></div>
												</div>
												<div class="form-group">
													<label for="plan_quantity" class="col-sm-3 control-label">
														订单所需数量
													</label>
													<div class="col-sm-8">
														<input type="text" class="form-control positive_int require"
															name="plan_quantity" id="plan_quantity" placeholder="数量" value="<%=fuliao.getPlan_quantity() %>">
													</div>
													<div class="col-sm-1"></div>
												</div>
												<div class="form-group">
													<label for="memo" class="col-sm-3 control-label">
														备注
													</label>
													<div class="col-sm-8">
														<input type="text" class="form-control" name="memo"
															id="memo"  value="<%=fuliao.getMemo() %>">
													</div>
													<div class="col-sm-1"></div>
												</div>
												
												</fieldset>
												<fieldset>
													<legend>第二步、选择合适的库位</legend>
													<div class="form-group">
													<label for="location_size" class="col-sm-3 control-label">
														请选择库位容量，将为您自动匹配相应容量的库位
													</label>
													<div class="col-sm-8">
														<%if(fuliao.getLocation_size() == 3){ %>
														<input type="radio" name="location_size" id="location_size_3" value="3" checked/><span class="location_size">大</span>
														<%}else{ %>
														<input type="radio" name="location_size" id="location_size_3" value="3"/><span class="location_size">大</span>
														<%} %>
														<%if(fuliao.getLocation_size() == 2){ %>
														<input type="radio" name="location_size" id="location_size_2" value="2" checked/><span class="location_size">中</span>
														<%}else{ %>
														<input type="radio" name="location_size" id="location_size_2" value="2"/><span class="location_size">中</span>
														<%} %>
														<%if(fuliao.getLocation_size() == 1){ %>
														<input type="radio" name="location_size" id="location_size_1" value="1" checked/><span class="location_size">小</span>
														<%}else{ %>
														<input type="radio" name="location_size" id="location_size_1" value="1"/><span class="location_size">小</span>
														<%} %>
													</div>
													<div class="col-sm-1"></div>
												</div>
													<div class="form-group">
													<div class="col-sm-offset-3 col-sm-5">
														<button type="submit" class="btn btn-primary"
															data-loading-text="正在保存...">
															编辑
														</button>

													</div>
													<div class="col-sm-3">
														<button type="reset" class="reset btn btn-default">
															重置表单
														</button>
													</div>
													<div class="col-sm-1"></div>
												</div>
												</fieldset>
											</div>
											<div class="col-md-5" style="width: 400px;"
												id="previewWidget">
												<a href="#" class="thumbnail"> <img id="previewImg"
														alt="400 x 100%"  src="/<%=fuliao.getImg()%>"> </a>
											</div>
										</form>
									</div>

								</div>
							</div>


						</div>
					</div>

				</div>
			</div>
		</div>
	</body>
</html>