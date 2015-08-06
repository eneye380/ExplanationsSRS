<%-- 
    Document   : index
    Created on : Jul 16, 2015, 1:30:21 PM
    Author     : eneye380
--%>

<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%--Visitor/explanations/products/products.jsp--%>
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
<body id="body" onload="retrievePRJSONDetail('<%=s%>', '1')">

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
                <!---start of aspect selection->
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
                <!--/end of aspect selection-->
            </div>
            <%--=e--%>
            <!--Side Bar End><-->

            <!--Main Content Start><-->

            <div class="col-md-10 col-sm-10 col-xs-12">


                <div class="thumbnail">
                    <div class="well" style="height: 550px;overflow: scroll">
                        <!--name container of query product-->
                        <div class="row">
                            <div class="col-lg-12 text-center">
                                <!--h4 style="color:royalblue"><%=pdqp.getName()%></h4-->
                                <h4 style="color: #101010">Product Comparison</h4>
                            </div>
                        </div>
                        <!--/name-->
                        <div class="row thumbnail aspect">
                            <!--explantion interface-->
                            <div class="well">
                                <h5>Sentiment Score Graph</h5>
                                <div style="height:250px">
                                    <div id="<%=s%>" class="explanationbar" style="height:250px"></div>  
                                </div>
                                <h5>Aspect Selection</h5>
                                <div class="thumbnail">
                                    <div class="">
                                        <div class="" style="margin-top: 10px">
                                            <button type="button" class="btn btn-primary btn-xs" id="button_aspect">view/hide Aspects</button>
                                            <button type="button" class="btn btn-primary btn-xs" id="button_aspect_reset" onclick="clearSelection('1')">Reset Graph</button>
                                            <span class="pull-right" style="color:black"><%=count%> common aspects</span>
                                        </div>
                                        <p class='text-primary'>Select aspect's from the check box below to change graph (<span class='text-danger '>maximum:10</span>)</p>
                                        <div class="aspect_selection" style="height:50px;overflow: auto">
                                            
                                            <form style='color: rgb(50,50,10)'>
                                                <%if (myR.size() != 0) {%>
                                                <%for (int r = 0; r < e.size(); r++) {%>
                                                <%String key = e.get(r);%>
                                                <!--div class="checkbox"--><label class='checkbox-inline' ><input type="checkbox" value="<%=key%>" name="aspect<%=key%>" class="aspect_cb" onclick="aspectSelect(this, '1')"><%=key%></label><!--/div-->                            
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
                                                <!--div class="checkbox"--><label class='checkbox-inline'><input type="checkbox" value="<%=key%>" name="aspect<%=key%>" class="aspect_cb" onclick="aspectSelect(this, '2')"><%=key%></label><!--/div-->                            
                                                <!--li><%=key%></li-->
                                                <%--}--%>
                                                <%}%>
                                                <%}%>

                                            </form>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--/explanation-->
                            <!--aspect selection-->
                            <div class="well">

                            </div>
                            <!--/aspect-->

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
