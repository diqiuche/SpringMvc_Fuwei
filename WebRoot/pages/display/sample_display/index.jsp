<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@page import="com.fuwei.entity.Sample"%>
<%@page import="com.fuwei.entity.Salesman"%>
<%@page import="com.fuwei.entity.User"%>
<%@page import="com.fuwei.commons.Pager"%>
<%@page import="com.fuwei.util.DateTool"%>
<%@page import="com.fuwei.commons.SystemCache"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Pager pager = (Pager) request.getAttribute("pager");
	if (pager == null) {
		pager = new Pager();
	}
	List<Sample> samplelist = new ArrayList<Sample>();
	if (pager != null & pager.getResult() != null) {
		samplelist = (List<Sample>) pager.getResult();
	}
	String productNumber = (String) request.getAttribute("productNumber");
	String productNumber_str = "";
	if (productNumber != null) {
		productNumber_str = productNumber;
	}
%>
<!DOCTYPE html>

<html>
	<head>
		<base href="<%=basePath%>">
		<title>样品展示 -- 桐庐富伟针织厂</title>
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
		<script src="<%=basePath%>js/plugins/WdatePicker.js"></script>
		<script src="js/common/common.js" type="text/javascript"></script>
		<link href="css/sample/sample.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<%@ include file="../../common/head.jsp"%>
		<div id="Content">
			<div id="main">
				<div class="breadcrumbs" id="breadcrumbs">
					<ul class="breadcrumb">
						<li>
							<i class="fa fa-home"></i>
							<a href="user/index">首页</a>
						</li>
						<li class="active">
							样品展示
						</li>
					</ul>
				</div>
				<div class="body">

					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12 tablewidget">
								<!-- Table -->
								<div clas="navbar navbar-default">
									<form class="form-horizontal searchform form-inline"
										role="form">
										<input type="hidden" name="page" id="page"
											value="1">
										<div class="form-group salesgroup">
											<label for="productNumber" class="col-sm-3 control-label" style="width:auto;">
												款号
											</label>
											<div class="col-sm-9">
												<input class="form-control" type="text" name="productNumber" id="productNumber" value="<%=productNumber_str%>" />
											</div>
										</div>
										<button class="btn btn-primary" type="submit">
														搜索
													</button>
									</form>
									<ul class="pagination">
										<li>
											<a
												href="sample_display/index?productNumber=<%=productNumber_str%>&page=1">«</a>
										</li>

										<%
											if (pager.getPageNo() > 1) {
										%>
										<li class="">
											<a
												href="sample_display/index?productNumber=<%=productNumber_str%>&page=<%=pager.getPageNo() - 1%>">上一页
												<span class="sr-only"></span> </a>
										</li>
										<%
											} else {
										%>
										<li class="disabled">
											<a disabled>上一页 <span class="sr-only"></span> </a>
										</li>
										<%
											}
										%>

										<li class="active">
											<a
												href="sample_display/index?productNumber=<%=productNumber_str%>&page=<%=pager.getPageNo()%>"><%=pager.getPageNo()%>/<%=pager.getTotalPage()%>，共<%=pager.getTotalCount()%>条<span
												class="sr-only"></span> </a>
										</li>
										<li>
											<%
												if (pager.getPageNo() < pager.getTotalPage()) {
											%>
										
										<li class="">
											<a
												href="sample_display/index?productNumber=<%=productNumber_str%>&page=<%=pager.getPageNo() + 1%>">下一页
												<span class="sr-only"></span> </a>
										</li>
										<%
											} else {
										%>
										<li class="disabled">
											<a disabled>下一页 <span class="sr-only"></span> </a>
										</li>
										<%
											}
										%>

										</li>
										<li>
											<a
												href="sample_display/index?productNumber=<%=productNumber_str%>&page=<%=pager.getTotalPage()%>">»</a>
										</li>
									</ul>
									<form class="form-inline pageform form-horizontal" role="form">
										<input type="hidden" name="productNumber"
											value="<%=productNumber_str%>">
										<div class="form-group">
											<div class="input-group">
												<span class="input-group-addon">去第</span>
												<input type="text" name="page" id="page"
													class="int form-control" placeholder="1,2,..."
													value="<%=pager.getPageNo()%>">

												<span class="input-group-addon">页</span>
												<span class="input-group-btn">
													<button class="btn btn-primary" type="submit">
														Go!
													</button> </span>
											</div>
										</div>
									</form>

								</div>
								<table class="table table-responsive">
									<thead>
										<tr>
											<th>
												序号
											</th>

											<th>
												图片
											</th>
											<th>
												名称
											</th>
											<th>
												款号
											</th>
											<th>
												材料
											</th>
											<th>
												克重
											</th>
											<th>
												尺寸
											</th>
										</tr>
									</thead>
									<tbody>
										<%
											int i = (pager.getPageNo()-1) * pager.getPageSize() + 0;
											for (Sample sample : samplelist) {
										%>
										<tr sampleId="<%=sample.getId()%>">
											<td><%=++i%></td>
											<td
												style="max-width: 120px; height: 120px; max-height: 120px;">
												<a target="_blank" class="cellimg"
													href="/<%=sample.getImg()%>"><img
														style="max-width: 120px; height: 120px; max-height: 120px;"
														src="/<%=sample.getImg_ss()%>"> </a>
											</td>
											<td><%=sample.getName()%></td>
											<td><%=sample.getProductNumber()%></td>
											<td><%=SystemCache.getMaterialName(sample.getMaterialId())%></td>
											<td><%=sample.getWeight()%></td>
											<td><%=sample.getSize()%></td>
										
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	<script type="text/javascript">
		/* 设置当前选中的页 */
			var $a = $("#left li a[href='sample_display/index']");
			setActiveLeft($a.parent("li"));
			/* 设置当前选中的页 */
	</script>
	</body>
</html>