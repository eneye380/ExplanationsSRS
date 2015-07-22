<%-- 
    Document   : viewproduct
    Created on : Jul 5, 2015, 2:09:41 PM
    Author     : eneye380
--%>

<%@page import="aspect.bean.ProductSB"%>
<%@page import="aspect.model.Queryproductandrecommendation"%>
<%@page import="java.util.ArrayList"%>
<%@page  import="aspect.bean.ProductSBLocal"%>
<%@page  import="aspect.bean.RecommendationSBLocal"%>

<%@include file="header.jsp" %>
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
        color:orange;
    }
</style>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.min.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.symbol.js" type="text/javascript" ></script>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.resize.js" type="text/javascript" ></script>
<script src="https://raw.github.com/xuanluo/flot-axislabels/master/jquery.flot.axislabels.js" type="text/javascript" ></script>



<div class="container">

    <div class="row" id="rowvp">

        <div class="col-md-3 col-sm-3 col-xs-12 well aspect">
            <div class="btn-group">
                <button type="button" class="btn btn-primary" id="button_aspect">Aspects</button>
            </div>
            <div class="aspect_selection">

                <div class="checkbox"><label><input type="checkbox" value="style">Style</label></div>
                <div class="checkbox"><label><input type="checkbox" value="performance">Performance</label></div>
                <div class="checkbox"><label><input type="checkbox" value="range">Range</label></div>
                <div class="checkbox"><label><input type="checkbox" value="sense">Sense</label></div>
                <div class="checkbox"><label><input type="checkbox" value="advantage">Advantage</label></div>
                <div class="checkbox"><label><input type="checkbox" value="result">Result</label></div>
                <div class="checkbox"><label><input type="checkbox" value="capability">Capabilty</label></div>
                <div class="checkbox"><label><input type="checkbox" value="color">Color</label></div>
                <div class="checkbox"><label><input type="checkbox" value="processing">Processing</label></div>
                <div class="checkbox"><label><input type="checkbox" value="notice">Notice</label></div>
            </div>
        </div>

        <div class="col-md-9 col-sm-9 col-xs-12">

            <div class="well">                
                <div class="row">

                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div>
                            <img class="img-responsive" src="../img/pentaxkr.jpg" alt="" >
                        </div>
                    </div>

                    <div class="col-md-6 col-sm-6 col-xs-12 text-center thumbnail" >
                        <p>Explanation Interface</p>
                        <div id="placeholder" style="height:200px"></div>                            
                    </div>                    
                </div>
                <div class="caption-full">

                    <h4 class="pull-right"></h4>
                    <h4><a href="#" onclick="retrievePaR1()">Product Name</a>
                    </h4>
                    <p><a target="_blank" href="http://bootsnipp.com"></a>.</p>
                    <p>
                        <strong><a href="http://maxoffsky.com/code-blog/laravel-shop-tutorial-1-building-a-review-system/"></a>
                        </strong></p>
                    <p id="display"> </p>
                </div>
                <!--div class="ratings">
                    <p class="pull-right">3 reviews</p>
                    <p>
                        <span class="glyphicon glyphicon-star"></span>
                        <span class="glyphicon glyphicon-star"></span>
                        <span class="glyphicon glyphicon-star"></span>
                        <span class="glyphicon glyphicon-star"></span>
                        <span class="glyphicon glyphicon-star-empty"></span>
                        4.0 stars
                    </p>
                </div-->
            </div>

            <div class="well">

                <div class="text-right">
                    <a class="btn btn-success">Compare</a>
                </div>


                <div class="row text-center">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <h4>Here are Product having Similar Aspects</h4>
                    </div>
                </div>

                <hr>

                <div class="row well recommendation">
                    <h4 class ="well rec_prodname_h4" id="rec_prodname_3">Product Name</h4>
                    <div class="col-md-12 col-sm-12 col-xs-12">  
                        <div class="row well">                            
                            <div class="col-md-4 col-sm-6 col-xs-12 thumbnail" >
                                <p class="nhidden">Product Name<span class="pull-right"></span></p>
                                <img class="img-responsive" src="../img/pentaxkr.jpg" alt="" style="height:180px">
                            </div>
                            <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail">
                                <p>Explanation Interface</p>
                                <div id="placeholder_1" style="height:180px"></div>                                    
                            </div>
                            <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail" >
                                <p>Description</p>
                                <div style="height:180px;overflow: auto">
                                    <div  style="background: grey;padding:2px"><div style="background: white;height:px" id="desc_1"></div></div>
                                </div>                                    
                            </div>
                        </div>
                        <span class="pull-left"></span>

                    </div>
                </div>

                <hr>

                <div class="row well recommendation">
                    <h4 class ="well rec_prodname_h4" id="rec_prodname_3">Product Name</h4>
                    <div class="col-md-12 col-sm-12 col-xs-12">                         
                        <div class="row well">                            
                            <div class="col-md-4 col-sm-6 col-xs-12 thumbnail" >
                                <p class="nhidden">Product Name<span class="pull-right"></span></p>
                                <img class="img-responsive" src="../img/pentaxkr.jpg" alt="" style="height:180px">
                            </div>
                            <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail">
                                <p>Explanation Interface</p>
                                <div id="placeholder_2" style="height:180px"></div>                                    
                            </div>
                            <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail" >
                                <p>Description</p>
                                <div style="height:180px;overflow: auto">
                                    <div  style="background: grey;padding:2px"><div style="background: white;height:px" id="desc_2"></div></div>
                                </div>                                    
                            </div>
                        </div>
                        <span class="pull-right"></span>

                    </div>
                </div>

                <hr>

                <div class="row well recommendation">
                    <h4 class ="well rec_prodname_h4" id="rec_prodname_3">Product Name</h4>
                    <div class="col-md-12 col-sm-12 col-xs-12">                       
                        <div class="row well">                            
                            <div class="col-md-4 col-sm-6 col-xs-12 thumbnail" >
                                <p class="nhidden">Product Name<span class="pull-right"></span></p>
                                <img class="img-responsive" src="../img/pentaxkr.jpg" alt="" style="height:180px">
                            </div>
                            <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail">
                                <p>Explanation Interface</p>
                                <div id="placeholder_3" style="height:180px"></div>                                    
                            </div>
                            <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail" >
                                <p>Description</p>
                                <div style="height:180px;overflow: auto">
                                    <div  style="background: grey;padding:2px"><div style="background: white;height:px" id="desc_3"></div></div>
                                </div>                                    
                            </div>
                        </div>
                        <span class="pull-right"></span>
                    </div>
                </div>

            </div>

        </div>

    </div>

</div>
<!-- /.container -->
<div class="container">

    <hr>

    <%@include file="footer.jsp" %>
