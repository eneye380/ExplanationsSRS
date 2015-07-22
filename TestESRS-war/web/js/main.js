/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
console.log("Testing 1:- am working");
$(document).ready(function () {

    $("#productimage").click(function () {

    });

    $("#button_category").click(function () {


        $(".category_selection").slideToggle();
    });
    $("#button_aspect").click(function () {

        //$(".aspect_selection").slideToggle();

    });
    $("#aspects_scores").css("display","none");
        
    $("#table").click(function(){
        
        $("#product_reviews").css("display","none");
        $("#aspects_scores").css("display","none");
        $("#aspects_table").css("display","block");
        
        
    });
    $("#aspect").click(function(){
        $("#product_reviews").css("display","none");
        $("#aspects_table").css("display","none");
        $("#aspects_scores").css("display","block");
        
    });
    $("#review").click(function(){   
        
        $("#aspects_table").css("display","none");
        $("#aspects_scores").css("display","none");
        $("#product_reviews").css("display","block");
    });
    
    $("#hide").click(function(){   
        
        $(".explanationbar").css("display","none");
        $(".explanationscatter").css("display","none");
        
    });
    $("#bar").click(function(){   
        
        $(".explanationscatter").css("display","none");
        $(".explanationbar").css("display","block");
        
    });
    $("#scatter").click(function(){   
        
        $(".explanationbar").css("display","none");
        $(".explanationscatter").css("display","block");
        
    });
    
    

});

$(document).ready(function () {


});
function setDataArr(x){
    console.log("x-x:");
    console.log(x);
    var y = new Array();
    y = x;
    console.log(y[6]);
}


function retrievePRJSONDetail(queryProduct,u) {

    console.log("Testing 2: retrievePRJSONDetail() working");
    console.log("Ajax call: Function Start");
    var ext = "recommendation";
    var url = "/TestESRS-war/" + ext;
    console.log("URL: " + url);
    var type = "GET";
    var data = "product=" + queryProduct;
    console.log("Data: " + data);
    var status = true;
    var dtype = 'json';

    $.ajax({
        type: type,
        url: url,
        data: data,
        datatype: dtype,
        success: function (msg) {
            console.log("Ajax call: start");

            setProductJSONDetails(msg);
            setQRArrayOfProductList(msg);
            setQRJSONOfProductDetails(msg,queryProduct);
            console.log(msg);
            console.log("Ajax call: stop");

            writeMe(u);

            status = true;
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error: " + jqXHR + " ,Status: " + textStatus + " ,ErrorThrown: " + errorThrown);
        }

    });
    console.log("Ajax call: Function End");
    return status;
}
var completeDetail = null;
function setProductJSONDetails(msg) {
    completeDetail = msg;
}
function getProductJSONDetails() {
    return completeDetail;
}
function displayScores() {
    n("inyene");
}

var p = [];
function readMe() {
    var array = getQRArrayOfProductList();
    var details = getQRJSONOfProductDetails();
    for (var i = 0; i < array.length; i++) {
        var prodid = array[i];
        var detail = details[prodid];
        var q = new ProductDetail(prodid, detail);
        q.displayProductID();
        p.push(q);
    }
    return p;
}

function writeMe(n) {
    var aspect1 = "camera";
    var aspect2 = "lens";
    var aspect3 = "quality";
    var aspect4 = "focus";
    var aspect5 = "dslr";
    var aspect = [];
    aspect.push(aspect1);
    aspect.push(aspect2);
    aspect.push(aspect3);
    aspect.push(aspect4);
    aspect.push(aspect5);

    var xaxis;
    var datum;

    var obj = readMe();

    for (var y = 0; y < obj.length; y++) {

        var i = obj[y];
        console.log(y);
        console.log(i.productID);
        var data = [];
        var ticks = [];
        var data1 = [];
        var ticks1 = [];
        
        var s = sum(i,aspect);
        console.log(s);
        for (var k = 0; k < aspect.length; k++) {
            var q = 0.0;            
            q = value(i.getJsonDetail().aspects[aspect[k]].score,s);
            var v = parseFloat(q);
            xaxis = [];
            datum = [];
            xaxis.push(k);
            xaxis.push(aspect[k]);
            datum.push(k);
            datum.push(i.jsonDetail.aspects[aspect[k]].score);

            ticks.push(xaxis);
            data.push(datum);

            ticks1.push(aspect[k]);
            //data1.push(i.jsonDetail.aspects[aspect[k]].score);
            //data1.push(i.getJsonDetail().aspects[aspect[k]].score);
            data1.push(v);
            console.log(i.getJsonDetail());
            console.log(v);
        }
        if (n === "1") {
            setSeries(data1, y + 1);
            var id = obj[0].getProductID();
            if (y === obj.length - 1) {
                setOptionsS(id, ticks1);
                myChartS();
            }
        } else if (n === "2") {
            setOptions(i.getProductID(), data1, ticks1);
            myChart();
        }
        //var createPlot = "c";
        //createPlot += y;
        //var m = new CreatePlot(data, ticks, i.productID, createPlot);
        //var p = "#";
        //p += i.productID;
        //loadChart(p, data, ticks);
        //setOptions(i.productID,data, ticks);
        //setOptions(i.getProductID(), data1, ticks1);
        //myChart();
    }
}

var qandrPList = [];
function setQRArrayOfProductList(msg) {
    qandrPList = msg.productlist.arrayrecomm;
}
function getQRArrayOfProductList() {
    return qandrPList;
}
var qandrPDetail = {};
function setQRJSONOfProductDetails(msg,productid) {
    qandrPDetail = msg.productdetails;
    //generateScatterGrapgh(productid);
}
function getQRJSONOfProductDetails() {
    return qandrPDetail;
}

var ProductDetail = function (productid, detail) {
    this.productID = productid;
    this.jsonDetail = detail;
    console.log("ProductDetail Object Created");
};
ProductDetail.prototype.displayProductID = function () {
    console.log("Object representing " + this.productID + " has been created...");
};
ProductDetail.prototype.getProductID = function () {
    return this.productID;
};
ProductDetail.prototype.getJsonDetail = function () {
    return this.jsonDetail;
};

function plotChart() {

}

var n = function (name) {
    console.log(name);
};

var CreatePlot = function (data1, ticks1, prodid1, chart) {
    //var data = [[0, 81], [1, 19]];
    var data = [];
    var ticks = [];
    var prodid = "";
    var label = "Aspects";
    data = data1;
    ticks = ticks1;
    prodid = prodid1;
    //var data2 = [[0, 85], [1, 15]];
    //var data3 = [[0, 82], [1, 18]];
    //var data4 = [[0, 100], [1, 0]];
    var dataset = [{label: label, data: data, color: "#5482FF"}];
    //var dataset2 = [{label: "Aspects", data: data2, color: "#5482FF"}];
    //var dataset3 = [{label: "Aspects", data: data3, color: "#5482FF"}];
    //var dataset4 = [{label: "Aspects", data: data4, color: "#5482FF"}];

    //var ticks = [[0, "camera"], [1, "picture"]];

    var options = {
        series: {
            bars: {
                show: true
            }
        },
        bars: {
            align: "center",
            barWidth: 0.5
        },
        xaxis: {
            axisLabel: "Aspect",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Verdana, Arial',
            axisLabelPadding: 10,
            ticks: ticks
        },
        yaxis: {
            axisLabel: "S-score",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Verdana, Arial',
            axisLabelPadding: 3,
            minTickSize: 0.5,
            tickFormatter: function (v, axis) {
                return v + "";
            }
        },
        legend: {
            noColumns: 0,
            labelBoxBorderColor: "#000000",
            position: "nw"
        },
        grid: {
            hoverable: true,
            borderWidth: 2,
            backgroundColor: {colors: ["#ffffff", "#EDF5FF"]}
        }
    };

    $(document).ready(function () {

    });

    function start() {
        console.log("kknnkk");
        var p = "#";
        p += prodid;

        console.log("y:" + chart);

        var Dis = function (placeholder, dataset) {
            this.name = "Abdulmumin Eneye Abdulkarim";
            this.q = placeholder;
            this.datase = dataset;
        };
        Dis.prototype.sayHello = function () {
            console.log("Hello, I'm " + this.name + " " + this.q + " " + this.datase);
            chart = $.plot($(this.q), this.datase, options);
            $(this.q).UseTooltip();

        };
        var x = new Dis(p, dataset);
        x.sayHello();

    }
    ;

    function gd(year, month, day) {
        return new Date(year, month, day).getTime();
    }
    ;

    var previousPoint = null, previousLabel = null;

    $.fn.UseTooltip = function () {
        $(this).bind("plothover", function (event, pos, item) {
            if (item) {
                if ((previousLabel !== item.series.label) || (previousPoint !== item.dataIndex)) {
                    previousPoint = item.dataIndex;
                    previousLabel = item.series.label;
                    $("#tooltip").remove();

                    var x = item.datapoint[0];
                    var y = item.datapoint[1];

                    var color = item.series.color;

                    //console.log(item.series.xaxis.ticks[x].label);                

                    showTooltip(item.pageX,
                            item.pageY,
                            color,
                            "<strong>" + item.series.label + "</strong><br>" + item.series.xaxis.ticks[x].label + " : <strong>" + y + "</strong> ");
                }
            } else {
                $("#tooltip").remove();
                previousPoint = null;
            }
        });
    };

    function showTooltip(x, y, color, contents) {
        $('<div id="tooltip">' + contents + '</div>').css({
            position: 'absolute',
            display: 'none',
            top: y - 40,
            left: x - 120,
            border: '2px solid ' + color,
            padding: '3px',
            'font-size': '9px',
            'border-radius': '5px',
            'background-color': '#fff',
            'font-family': 'Verdana, Arial, Helvetica, Tahoma, sans-serif',
            opacity: 0.9
        }).appendTo("body").fadeIn(200);
    }
    ;
    start();
};
$(document).ready(function () {


});

function loadChart(o, data, ticks) {
    $(o).highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: 'Sentiment Scores'
        },
        xAxis: {
            categories: ticks
        },
        yAxis: {
            title: {
                text: 'Scores'
            }
        },
        series: [{
                name: 'Aspect',
                data: data
            }]
    });
}
;
var series = [];
function setSeries(data, p) {
    var input = {};
    input = {
        name: p,
        data: data
    };
    series.push(input);
}
function getSeries() {
    return series;
}
var options;
function setOptions(placeholder, data, ticks) {
    options = null;
    options = {
        chart: {
            renderTo: placeholder,
            type: 'column'
        },
        title: {
            text: ''
        },
        xAxis: {
            categories: ticks
        },
        yAxis: {
            title: {
                text: 'Scores'
            }
        },
        series: [{
                name: 'Aspect',
                data: data
            }]
    };


}
//
function getOptions() {
    return options;
}
//
function myChart() {
    var chart = null;
    chart = new Highcharts.Chart(getOptions());
}
function setOptionsS(placeholder, ticks) {
    options = null;
    options = {
        chart: {
            renderTo: placeholder,
            type: 'column'
        },
        title: {
            text: ''
        },
        xAxis: {
            categories: ticks
        },
        yAxis: {
            title: {
                text: 'Scores'
            }
        },
        series: getSeries()
    };
}
function getOptionsS() {
    return options;
}
function myChartS() {
    var chart = null;
    chart = new Highcharts.Chart(getOptionsS());
}
function sum(i,aspect){
    
    var sum = 0;
    for(var h = 0;h<aspect.length;h++){
        var score = i.getJsonDetail().aspects[aspect[h]].score;
        var absScore = Math.abs(score);
        console.log(absScore);
        sum += absScore;
    }
    //var s = sum.toFixed(2);
    return sum;
}
function value(n,sum){
    var value = 0.0;
    var v = 0.0;
    var q = 0.0;
    value = (n/sum);
    v = value.toFixed(2);
    q = value.toPrecision(2);
    //console.log(v);
    return v;
    
}
var ob = {};
var ar = [];

function generateScattergraph(){
    var obj = readMe();
}
function generateScatterGrapgh(productid,scatter){
    console.log("qpq: "+productid);
    //var obj = readMe();
    var details = getQRJSONOfProductDetails();
    console.log("qpq: "+details);
    ob = details[productid];
    console.log(details);
    ar = ob.aspectList;
    var a=[];
    var b;
    var c;
    var d = [];
    for(var i = 0;i<ar.length;i++){
        b={};
        c=[];
        console.log(ar[i]);
        console.log(ob.aspects[ar[i]].score);
        console.log(ob.aspects[ar[i]].freq);
        var v = parseFloat(ob.aspects[ar[i]].score);
        var w = parseInt(ob.aspects[ar[i]].freq);
        //console.log(v);
        //console.log(w);
        c.push(v);
        c.push(w);
        b={
            name: ar[i],
            color: 'rgba(223, 83, 83, .5)',
            data: c

        };
        a.push(b);
        d.push(c);
    }
    var p = "#";
    p += productid + scatter;
    scatterChart(d,p);
    console.log(d);
}

function scatterChart(data,p){
    $(p).highcharts({
        chart: {
            type: 'scatter',
            zoomType: 'xy'
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            title: {
                enabled: true,
                text: 'Sentiment Scores'
            },
            startOnTick: true,
            endOnTick: true,
            showLastLabel: true
        },
        yAxis: {
            title: {
                text: 'Frequency'
            }
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            verticalAlign: 'top',
            x: 100,
            y: 70,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
            borderWidth: 1
        },
        plotOptions: {
            scatter: {
                marker: {
                    radius: 5,
                    states: {
                        hover: {
                            enabled: true,
                            lineColor: 'rgb(100,100,100)'
                        }
                    }
                },
                states: {
                    hover: {
                        marker: {
                            enabled: false
                        }
                    }
                },
                tooltip: {
                    headerFormat: '<b>{series.name}</b><br>',
                    pointFormat: '{point.x} , {point.y} '
                }
            }
        },
        series: [{
            name: 'aspect',
            color: 'rgba(223, 50, 50, .5)',
            data: data
        }]
    });
}

da = [{
            name: 'aspect',
            color: 'rgba(223, 50, 50, .5)',
            data: data
        }];