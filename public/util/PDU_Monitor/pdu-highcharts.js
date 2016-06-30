$(document).ready(function() {
    document.getElementById('time').value = getNowDate();

    Highcharts.setOptions({
        global : {
            useUTC : false
        }
    });

    // Create the ampere1 chart
    $('#container-ampere1').highcharts('StockChart', {
        chart : {
            events : {
                load : function() {
                    setGraph('ampere1');
                    $("#container-ampere1").highcharts().redraw();
                    setInterval(function() {
                        setGraph('ampere1');
                        $("#container-ampere1").highcharts().redraw();
                    }, 5000);
                }
            }
        },

        rangeSelector: {
            buttons: [{
                count: 1,
                type: 'minute',
                text: '1M'
            }, {
                count: 5,
                type: 'minute',
                text: '5M'
            }, {
                type: 'all',
                text: 'All'
            }],
            inputEnabled: false,
            selected: 0
        },

        scrollbar : {
            liveRedraw : true
        },

        title : {
            text : 'PDU Ampere All'
        },

        series : [{
            name : "Ampere (A)",
            data : []
        }],

        exporting: {
            enabled: false
        },

    });

    // Create the ampere2 chart
    $('#container-ampere2').highcharts('StockChart', {
        chart : {
            events : {
                load : function() {
                    setGraph('ampere2');
                    $("#container-ampere2").highcharts().redraw();
                    setInterval(function() {
                        setGraph('ampere2');
                        $("#container-ampere2").highcharts().redraw();
                    }, 5000);
                }
            }
        },

        rangeSelector: {
            buttons: [{
                count: 1,
                type: 'minute',
                text: '1M'
            }, {
                count: 5,
                type: 'minute',
                text: '5M'
            }, {
                type: 'all',
                text: 'All'
            }],
            inputEnabled: false,
            selected: 0
        },

        scrollbar : {
            liveRedraw : true
        },

        title : {
            text : 'PDU Ampere B1'
        },

        series : [{
            name : "Ampere (A)",
            data : []
        }],

        exporting: {
            enabled: false
        },

    });

    // Create the ampere3 chart
    $('#container-ampere3').highcharts('StockChart', {
        chart : {
            events : {
                load : function() {
                    setGraph('ampere3');
                    $("#container-ampere3").highcharts().redraw();
                    setInterval(function() {
                        setGraph('ampere3');
                        $("#container-ampere3").highcharts().redraw();
                    }, 5000);
                }
            }
        },

        rangeSelector: {
            buttons: [{
                count: 1,
                type: 'minute',
                text: '1M'
            }, {
                count: 5,
                type: 'minute',
                text: '5M'
            }, {
                type: 'all',
                text: 'All'
            }],
            inputEnabled: false,
            selected: 0
        },

        scrollbar : {
            liveRedraw : true
        },

        title : {
            text : 'PDU Ampere B2'
        },

        series : [{
            name : "Ampere (A)",
            data : []
        }],

        exporting: {
            enabled: false
        },

    });



    function getNowDate(){
        var nowDate = new Date();
        var nowDateStr = ""
        nowDateStr += nowDate.getFullYear();
        var tempMonth = "0" + (nowDate.getMonth() + 1);
        nowDateStr += tempMonth.slice(-2);
        var tempDate = "0" + nowDate.getDate();
        nowDateStr += tempDate.slice(-2);
        var tempHours = "0" + nowDate.getHours();
        nowDateStr += tempHours.slice(-2);

        var searchDate = location.href.slice(-10);
        if(!isNaN(searchDate)) nowDateStr = searchDate;

        return nowDateStr;
    }

    function setGraph(kind){
        if(kind == 'ampere1'){
            d3.tsv(getNowDate() + "data.tsv", function(error, data) {
                var logdata = [];
                data.forEach(function(d) {
                    logdata.push([
                        Date.parse(d3.time.format("%Y-%m-%dT%H:%M:%S").parse(d.date)),
                        +d.ampere1||0
                        ]);
                });
                var chart1 = $('#container-ampere1').highcharts()
                chart1.series[0].setData(logdata);
            });
        }
	else if(kind == 'ampere2'){
            d3.tsv(getNowDate() + "data.tsv", function(error, data) {
                var logdata = [];
                data.forEach(function(d) {
                    logdata.push([
                        Date.parse(d3.time.format("%Y-%m-%dT%H:%M:%S").parse(d.date)),
                        +d.ampere2||0
                        ]);
                });
                var chart2 = $('#container-ampere2').highcharts()
                chart2.series[0].setData(logdata);
            });
        }
        else if(kind == 'ampere3'){
            d3.tsv(getNowDate() + "data.tsv", function(error, data) {
                var logdata = [];
                data.forEach(function(d) {
                    logdata.push([
                        Date.parse(d3.time.format("%Y-%m-%dT%H:%M:%S").parse(d.date)),
                        +d.ampere3||0
                        ]);
                });

                var chart3 = $('#container-ampere3').highcharts()
                chart3.series[0].setData(logdata);

            });
        }
    }
});
