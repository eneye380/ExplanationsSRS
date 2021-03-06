<%-- 
    Document   : index
    Created on : Jul 16, 2015, 1:30:21 PM
    Author     : eneye380
--%>

<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%--Visitor/explanations/products/product-recommendation-detail.jsp--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="aspect.bean.CategorySB"%>
<%@page import="aspect.bean.ProductSetSB"%>
<%@page import="aspect.model.Productdetail"%>
<%@page import="aspect.bean.ProductSB"%>
<%@page import="aspect.model.Queryproductandrecommendation"%>
<%@page import="java.util.ArrayList"%>
<%@page  import="aspect.bean.ProductSBLocal"%>
<%@include file="../header/headerproductview.jsp" %>
<!-- Page Content -->
<script>


</script>
<style>
    .a,.b,.c{

    }
    .c{

    }
    .recommendation{
        /**background: rgb(60,90,100);*/
        background: rgb(10,50,50);

    }
    .rec_prodname_h4{
        color: grey;
    }
    .nhidden{
        color:white;
    }
    .aspect{
        background: rgb(10,50,50);
        /**background: #204d74;*/
        color:orange;
    }

    .top_m1{
        position:relative;
        top:-10px;        
    }
    .top_m2{
        position:relative;
        top:-20px;        
    }
    .top_m3{
        position:relative;
        top:-30px;        
    }
    .top_m4{
        position:relative;
        top:-40px;        
    }
    .top_m5{
        position:relative;
        top:-50px;        
    }
    .top_m6{
        position:relative;
        top:-60px;        
    }
    .top_m7{
        position: relative;
        top:-70px;
    }
    .desc{
        color:sienna;    
        text-align: center;
    }
    span.stars, span.stars span {
        display: block;
        background: url(../../../img/stars.png) 0 -16px repeat-x;
        width: 80px;
        height: 16px;        
    }

    span.stars span {
        background-position: 0 0;
    }
</style>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.min.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.symbol.js" type="text/javascript" ></script>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.resize.js" type="text/javascript" ></script>
<!--script src="https://raw.github.com/xuanluo/flot-axislabels/master/jquery.flot.axislabels.js" type="text/javascript" ></script-->
<script src="https://cdn.jsdelivr.net/jquery.flot.tooltip/0.8.4/jquery.flot.tooltip.min.js" type="text/javascript" ></script>
<script src="http://code.highcharts.com/highcharts.js" type="text/javascript" ></script>






<jsp:useBean id="recommend" class="aspect.bean.ProductSetSB" scope="request"/>
<jsp:setProperty name="recommend" property="queryProduct" param="product" />
<%
%>

<%    String s = recommend.getQueryProduct();
    //String r1,r2,r3;
    //r1 = recommend.getProduct1();
    //r2 = recommend.getProduct2();
    //r3 = recommend.getProduct3();
    ArrayList<ProductSetSB> p = recommend.getSet();
    ArrayList<String> myR = new ArrayList();
    if (p.size() > 1) {
        for (int i = 0; i < p.size(); i++) {
            ProductSetSB l = p.get(i);
            //out.println(l.getProduct());
            myR.add(l.getProduct());
        }
    }

%>
<jsp:useBean id="detail" class="aspect.bean.ProductDetailSB" scope="request"/>
<jsp:setProperty name="detail" property="prodid" value="<%=s%>"/>
<jsp:setProperty name="detail" property="recommSet" value="<%=myR%>"/>

<%
    ArrayList<Productdetail> d = detail.retrieveDetail();
%>  

<%
    Productdetail pdqp = d.get(0);
%>

<jsp:useBean id="aspectScore" class="aspect.bean.AspectScoreSB" scope="request"/>
<jsp:setProperty name="aspectScore" property="prodid" value="<%=s%>"/>
<jsp:setProperty name="aspectScore" property="recommSet" value="<%=myR%>"/>
<%--
    Map<String, Map<String, Map<String, Number>>> scores = new HashMap();
    scores = aspectScore.retrieveAspectScores();
--%>
<%
    Map<String, Map<String, Map<String, Number>>> productScoresMap = new HashMap();
    productScoresMap = aspectScore.retrieveAspectScores();
%>
<!--jsp:getProperty name="aspectScore" property="scoreSet"/-->
<!--%=scores%-->
<body id="body" onload="retrievePRJSONDetail('<%=s%>', '2')">

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation" >
        <div class="container-fluid" >
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="../welcome/">ESRS</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li>
                        <a href="#">Products</a>
                    </li>
                    <li>
                        <a href="#">Concept</a>
                    </li>
                    <li>
                        <a href="#" onclick="">About</a>
                    </li>
                </ul>
                <span class="pull-right" style="color:rgb(255,247,217)"><%=dd%></span>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>


    <div class="container" id="pbody">
        <div class="row">

            <!--div class="col-md-2 col-sm-2 col-xs-12 well aspect">
            <%@include file="../sidebar/sidebar.jsp" %>
        </div-->

            <!--Side Bar Start><-->


            <div class="col-md-2 col-sm-2 col-xs-12 well aspect">
                <jsp:useBean id="category_1" class="aspect.bean.CategorySB" scope="request"/>
                <%--jsp:getProperty name="category" property="catSet"/--%>
                <%
                    ArrayList<CategorySB> cc = category_1.getCatSet();

                %>


                <div class="btn-group" style="margin-top: 5px;">
                    <button type="button" class="btn btn-primary" id="button_category">Category</button>
                </div>
                <div class="category_selection" style="margin-top: 5px;display1:none">
                    <div class="list-group ">
                        <%for (int r = 0; r < cc.size(); r++) {%>
                        <%CategorySB ct = cc.get(r);%>


                        <a href="../products/category.jsp?category=<%=ct.getCategory()%>" class="list-group-item "><%=ct.getCategory()%></a>                    
                        <%}%>
                    </div>

                </div>
                <!-- Algorithm to finds common aspects-->
                <% ArrayList<Double> l = new ArrayList();%>
                <%
                    //array storing common aspects
                    ArrayList<String> e = new ArrayList();%>
                <%
                    Map<String, Map<String, Number>> qPS = productScoresMap.get(s);
                    Set k = qPS.keySet();
                    Iterator i = k.iterator();
                    int count = 0;
                    while (i.hasNext()) {

                        String key = (String) i.next();
                        //Map<String, Number> value = (Map) qPS.get(key);
                        int sent = myR.size();
                        for (int b = 0; b < myR.size(); b++) {
                            Map<String, Map<String, Number>> rPS = productScoresMap.get(myR.get(b));
                            if (rPS.containsKey(key)) {
                                sent--;
                            }
                            if (sent == 0) {
                                if (!e.contains(key)) {
                                    e.add(key);
                                    count++;
                                }
                            }
                        }
                    }

                %>

                <!--div class="btn-group" style="margin-top: 10px">
                    <button type="button" class="btn btn-primary btn-xs" id="button_aspect">Shared Aspects</button>
                    <button type="button" class="btn btn-primary btn-xs" id="button_aspect_reset" onclick="clearSelection('1')">Reset</button>
                </div>
                <div class="aspect_selection" style="display1:none;height:300px;overflow: auto">

                    <form>
                        <%if (myR.size() != 0) {%>
                        <%for (int r = 0; r < e.size(); r++) {%>
                        <%String key = e.get(r);%>
                        <div class="checkbox"><label><input type="checkbox" value="<%=key%>" name="aspect<%=key%>" class="aspect_cb" onclick="aspectSelect(this, '1')"><%=key%></label></div>                            
                                <%}%>

                        <%} else if (productScoresMap.containsKey(s)) {%>
                        <%
                            Map<String, Map<String, Number>> productScores = productScoresMap.get(s);
                            Set keyset = productScores.keySet();
                            Iterator ite = keyset.iterator();

                        %>
                        <%while (ite.hasNext()) {%>
                        <%
                            String key = (String) ite.next();
                            Map<String, Number> value = (Map) productScores.get(key);
                            Number a = value.get("score");
                            double val = a.doubleValue();
                            double absVal = Math.abs(val);
                            double ii = val / absVal;
                            l.add(val);

                        %>
                        <%--if (ii == 1.0) {--%>
                        <!--li><%=key%> : <%=a%></li-->
                        <!--label class='checkbox-inline'><input type="checkbox" value="<%=key%>"><%=key%></label-->
                        <div class="checkbox"><label><input type="checkbox" value="<%=key%>" name="aspect<%=key%>" class="aspect_cb" onclick="aspectSelect(this, '2')"><%=key%></label></div>                            
                        <!--li><%=key%></li-->
                        <%--}--%>
                        <%}%>
                        <%}%>

                    </form>

                </div-->
            </div>
            <%--=e--%>
            <!--Side Bar End><-->

            <!--Main Content Start><-->

            <div class="col-md-10 col-sm-10 col-xs-12">


                <div class="thumbnail">
                    <div class="well">
                        <!--name container of query product-->
                        <div class="row">
                            <div class="col-lg-12 text-center">
                                <h5 style="color:royalblue"><%=pdqp.getName()%></h5>
                            </div>
                        </div>
                        <!--/name-->
                        <div class="row thumbnail aspect">
                            <div class="col-md-8 col-sm-8 col-xs-8">                                
                                <div class="well" style="height:470px;overflow:scroll">
                                    <!--detail of query product-->
                                    <div class="row">
                                        <div class="col-md-3 col-sm-3 col-xs-4">
                                            <!--image container for query product-->
                                            <div>
                                                <a href="product-detail.jsp?product=<%=pdqp.getProdid()%>"><img class="img-responsive " id="productimage" src="../../../img/<%=pdqp.getProdid()%>.jpg" alt="image of <%=pdqp.getProdid()%>" id="query_prod_img" style="heighth:90px"></a>
                                            </div>
                                            <!--/image-->
                                            <%//star rating
                                                String r = pdqp.getRating();
                                                double sr = 0.0;
                                                if (r != null) {
                                                    if (!r.equalsIgnoreCase("null")) {
                                                        sr = Double.parseDouble(r);
                                                    }
                                                }
                                            %>
                                            <!--star rating of query product-->
                                            <div style="position: relative;top: 5px;"><span class="stars"><%=sr%></span></div>
                                            <!--/star-->
                                        </div>
                                        <div class="col-lg-9 col-md-9 col-sm-9 col-xs-8">
                                            <!--description of query product-->
                                            <table class="table text-center text-info" style="font-size: x-small;background: white">
                                                <tr><th><span class="desc">Price</span></th>
                                                    <th><span class="desc">Rating</span></th>
                                                    <th><span class="desc">Rank</span></th>
                                                    <th><span class="desc">Date</span></th>
                                                </tr>
                                                <tr>
                                                    <td><%=pdqp.getPrice()%></td>
                                                    <td><%=pdqp.getRating()%>/5</td>
                                                    <td><%=pdqp.getRank()%></td>
                                                    <td><%=pdqp.getDate()%></td>
                                                </tr> 
                                                <tr><th><span class="desc">Category</span></th>
                                                    <th><span class="desc">No. of Questions</span></th>
                                                    <th><span class="desc">No. of Comments</span></th>
                                                    <th><span class="desc">No. of Reviews</span></th>
                                                </tr>
                                                <tr>
                                                    <td><%=pdqp.getCategory()%></td>
                                                    <td><%=pdqp.getNquestions()%></td>
                                                    <td><%=pdqp.getNcomments()%></td>
                                                    <td><%=pdqp.getNreviews()%></td>
                                                </tr> 
                                            </table> 
                                            <!--/description-->                                                                          
                                        </div>
                                    </div>
                                    <!--/detail-->
                                    <!-- qp_graph of query product-->

                                    <div class="row">
                                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                            <div id="<%=s%>" id1="container" style="height:150px;background:white" onmouseover="showMult(this,'1')"></div>                            
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                            <div id="<%=s%>_r" id1="container" style="height:150px;background:white" onmouseover="showMult(this,'2')"></div>                            
                                        </div>
                                    </div>

                                    <!--/qp_graph-->
                                    <hr>
                                    <!--recommended products-->
                                    <div class="row text-left">
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                            <p class="" style="position: relative;top: -20px"><strong>RECOMMENDED PRODUCTS</strong><span class="pull-right"><%=count%> common aspects</span></p>
                                            <!--p style="position: relative;top: -20px">(<%=count%>) common aspects</p-->
                                            <p class="" style="position: relative;top: -20px"><a href="product-recommendation-comparison.jsp?product=<%=pdqp.getProdid()%>" class="btn btn-success btn-sm btn- pull-right">Compare</a></p>
                                        </div>
                                    </div>
                                    <div class="row" style="position: relative;top: -20px">                            
                                        <div class="col-md-12 col-sm-12 col-xs-12">  
                                            <div class="row text-center ">

                                                <%Productdetail pdr = null;%>
                                                <%if ((d.size() > 1)) {%>
                                                <%--for (int m = 0; m < d.size(); m++) {--%>
                                                <%for (int m = 0; m < 4; m++) {%>
                                                <%if (m != 0) {%>
                                                <%pdr = d.get(m);%>

                                                <div class="col-md-3 col-sm-6 col-xs-12 thumbnail"  id="23">
                                                    <!--img src="../../../img/<%=pdr.getProdid()%>.jpg" alt="" class="img-thumbnail" style="height:80px"-->
                                                    <a href="product-recommendation-detail.jsp?product=<%=pdr.getProdid()%>"><img class="img-responsive " onmouseover="showDes(this)" name="<%=pdr.getProdid()%>" src="../../../img/<%=pdr.getProdid()%>.jpg" alt="image of <%=pdqp.getProdid()%>" id="query_prod_img" style="height:85px"></a>
                                                    <div class="caption">     

                                                        <div style="height: 20px;overflow: hidden"><h6><%=pdr.getName()%></h6></div>
                                                        <!--product rating-->        
                                                        <%//star rating
                                                            String vv = pdr.getRating();
                                                            double rPsr = 0.0;
                                                            if (vv != null) {
                                                                if (!vv.equalsIgnoreCase("null")) {
                                                                    rPsr = Double.parseDouble(vv);
                                                                }
                                                            }
                                                        %>
                                                        <div style="position: relative;top: 5px;"><span class="stars"><%=rPsr%></span></div>
                                                        <!--/product-->
                                                        <p>

                                                        <form action="product-recommendation-detail.jsp" style="display:inline">
                                                            <input type="hidden" name="product" id="prod_4" value="<%=pdr.getProdid()%>">
                                                            <input type="submit" value="View" class="btn btn-primary btn-xs" >
                                                        </form>
                                                        <form action="product-detail.jsp" style="display:inline">
                                                            <input type="hidden" name="product" id="prod_4" value="<%=pdr.getProdid()%>">
                                                            <input type="submit" value="Detail" class="btn btn-primary btn-xs" >
                                                        </form>
                                                        </p>
                                                    </div>
                                                    <span class="pull-left" style="color:white"></span>
                                                </div> 



                                                <!--hr-->
                                                <%}%>
                                                <%}%>
                                                <%} else {%>                    
                                                <h4 style="color:red">Sorry No Available Recommendations</h4>
                                                <%}%>
                                            </div>
                                        </div>
                                    </div>
                                    <!--recommended-->
                                </div>                               
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-4">
                                <div class="well">
                                    
                                    <div class="thumbnail" style="height:195px;overflow:auto">
                                        <div class="product_graph_d text-center">
                                            <p style="color:black;font-weight: bold" class="text-uppercase">
                                            Display of Multi Bar
                                            Chart by Hovering Over
                                            the chart on the left
                                            </p>
                                        </div>
                                        <div id="<%=s%>_mult_sentiment"  style="height:195px;display:none" class="product_graph_d"></div>  
                                        <div id="<%=s%>_r_mult_rating"  style="height:195px;display:none" class="product_gragh_d"><p>hello</p></div>                            
                                    </div>
                                    
                                    <div class="thumbnail" style="height:195px;overflow: auto">
                                        
                                        <div class="product_desc_d text-center">
                                            <p style="color:black;font-weight: bold" class="text-uppercase">
                                            Hover Over the 
                                            Recommended product to view details
                                            </p>
                                        </div>
                                        
                                        <%Productdetail pdr_1 = null;%>
                                        <%if ((d.size() > 1)) {%>
                                        <%--for (int m = 0; m < d.size(); m++) {--%>
                                        <%for (int m = 0; m < 4; m++) {%>
                                        <%if (m != 0) {%>
                                        <%pdr_1 = d.get(m);%>

                                        <div style="display:none" id="i_<%=pdr_1.getProdid()%>" class="product_desc_d">
                                            <h6 style="color: green"><%=pdr_1.getName()%></h6>
                                            <p><span class="desc">Rating: </span><%=pdr_1.getRating()%></p>
                                            <p class="top_m1"><span class="desc">Price: </span><%=pdr_1.getPrice()%></p>
                                            <p class="top_m2"><span class="desc">Rank: </span><%=pdr_1.getRank()%></p>
                                            <p class="top_m3"><span class="desc">Date: </span><%=pdr_1.getDate()%></p>
                                            <p class="top_m4"><span class="desc">Category: </span><%=pdr_1.getCategory()%></p>
                                            <p class="top_m5"><span class="desc">No. of Questions: </span><%=pdr_1.getNquestions()%></p> 
                                            <p class="top_m6"><span class="desc">No. of Comments: </span><%=pdr_1.getNcomments()%></p>                                                
                                            <p class="top_m7"><span class="desc">No. of Reviews: </span><%=pdr_1.getNreviews()%></p>
                                        </div>

                                        <%}%>
                                        <%}%>
                                        <%} else {%>                    
                                        <h4 style="color:red">Sorry No Available Recommendations</h4>
                                        <%}%>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>

            <!--Main Content End><-->

        </div>
        <!-- /.container -->
        <!--div class="container"-->

        <hr>

        <%@include file="../footer/footer.jsp" %>
