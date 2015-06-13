<!-- 
	alert (fn + " / " + url + " / " + data);
vim: set et ts=4 sw=4 fdm=marker:

    Copyright (C) 2008 Jesse Hogan <jessehogan0@gmail.com>
    All rights reserverd

-->
<%@page language="java" contentType="text/html"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-15" />
    <script type="text/javascript" src="jquery-1.2.6.js"></script>
    <script type="text/javascript" src="ajax.js"></script>
    <script type="text/javascript">
        function btnSearch_Click(){
            search = $('#txtSearch').val();
            fn='getBook("' + search + '")'
            alert('txt : ' + fn);
            call(fn, 'abook', '', function(data){ add_book(data); });
        }
        function setup_book(){
            $('#divMoreBook').css('display', 'none');
            $('#divBookReview').css('display', 'none');
            $('#divPublishersSummary').css('display', 'none');

            fn0=function(){
                $('#divSummary').css({'font-size': '16px'});
                $('#divBook img').animate({height: '175px', width: '175px'}, 200);
                $('.divToWishList').animate({width: '175px'}, 200);
                $('#divBook').animate(
                    { 
                        height: '460px',
                        width:  '800px' 
                    }, 200)

                $('#divMoreBook').css({'display': 'block', 'overflow': 'auto'});
                $('#divPublishersSummary').fadeIn(2000);
                $('.divToCart').animate({width: '175px'}, 200); 
            }
            fn1=function(){
                $('#divSummary').css({'font-size': '12px'});
                $('#divBook img').animate({height: '100px', width: '100px'}, 200);
                $('.divToWishList').animate({width: '100px'}, 200);
                $('#divBook').animate(
                    { 
                        height: '100%' ,
                        width: '50%' 
                    }, 200)

                $('#divMoreBook').css({'display': 'none', 'overflow': 'visable'});
                $('#divPublishersSummary').fadeOut();
                $('.divToCart').animate({width: '100px'}, 200);

            }
            $('#aMore').toggle(fn0, fn1);

            fn0=function(){
                $('#divPublishersSummary').fadeOut();
                $('#divBookReview').fadeIn(2000);
                $(this).fadeOut(200, function(){$(this).html('Show Publishers Summary');});
                $(this).fadeIn(200);
            }
            fn1=function(){
                $('#divPublishersSummary').fadeIn(2000);
                $('#divBookReview').fadeOut();
                $(this).fadeOut(200, function(){$(this).html('Show Book Reviews');});
                $(this).fadeIn(200);
            }
            $('#aBookReviews').toggle(fn0, fn1);
        }
        function add_book(book){
            // instantiate dom elements
            divContent               = $('<div>').attr('id', 'divContent')[0];
            divContentBar            = $('<div>').attr('id', 'divContentBar')[0];
            divMoreBook              = $('<div>').attr('id', 'divMoreBook')[0];
            divPublishersSummary     = $('<div>').attr('id', 'divPublishersSummary')[0];
            divMore                  = $('<div>').attr('id', 'divMore')[0];
            aTitle                   = $('<a>').attr(  'href', 'abook').text(book.Title)[0];
            aShowBookReviews         = $('<a>').attr(  'href', '#').text("Show Book Reviews")[0];
            img                      = $('<img>').attr('src', 'plato.jpg')[0];
            divSummary               = $('<div>').attr('id', 'divSummary')[0];
            br                       = $('<br>')[0];
            

            // appendage
            $(divContentBar).appendTo(divContent);
            $(img).appendTo(divContent);
            $(divSummary).appendTo(divContent);
            $(divMoreBook).appendTo(divContent);
            $(aTitle).appendTo(divContentBar);

            $(divMoreBook).appendTo(divContent);
            $(aShowBookReviews).appendTo(divMoreBook);
            $(divPublishersSummary).appendTo(divMoreBook);


            // divSummary
            $("<span>").addClass('label').text('Data ').appendTo(divSummary);
            $("<span>").addClass('value').text(book.ReleaseDate).appendTo(divSummary);
            $("<br>").appendTo(divSummary);

            $("<span>").addClass('label').text('Price ').appendTo(divSummary);
            $("<span>").addClass('value').text(book.Price).appendTo(divSummary);
            $("<br>").appendTo(divSummary);

            $("<span>").addClass('label').text('Rating ').appendTo(divSummary);
            $("<span>").addClass('value').text(book.Ratings).appendTo(divSummary);
            $("<br>").appendTo(divSummary);

            $("<span>").addClass('label').text('Narrated By ').appendTo(divSummary);
            $("<span>").addClass('value').text(book.Narrator).appendTo(divSummary);
            $("<br>").appendTo(divSummary);

            $("<span>").addClass('label').text('Length ').appendTo(divSummary);
            $("<span>").addClass('value').text(book.Length).appendTo(divSummary);
            $("<br>").appendTo(divSummary);

            // divMoreBook
            $("<h1>").text("Publisher's Summary").appendTo(divPublishersSummary);
            $("<p>").text(book.Summary).appendTo(divPublishersSummary);

            // divBookReview
            for (i=0; i<book.Reviews.length; i++){
                review=book.Reviews[i];
                divBookReview            = $('<div>').attr('id', 'divBookReview')[0];
                pReviewHeader            = $('<p>')[0];
                pReviewBody              = $('<p>')[0];

                $(pReviewHeader).appendTo(divBookReview);
                $(pReviewBody).appendTo(divBookReview);
                $(divBookReview).appendTo(divMoreBook);

                $('<p>').attr('style', 'color: yellow; font-size: 12px').text('11 of 11 people  found this review helpful').appendTo(divBookReview);
                $('<p>').attr('style', 'font-weight: bold').text(review.Subject).appendTo(divBookReview);

                $("<a>").attr('href', '#').text(review.Author).appendTo(pReviewHeader);
                $("<i>").text(review.Date).appendTo(pReviewHeader);
                $(pReviewBody).text(review.Text)
            }
            $(divMore).appendTo(divContent);
            $("<a>").attr("id", "aMore").attr("href", "#").text("V").appendTo(divMore);

            $(divContent).appendTo('#divBook');
            setup_book();
        }

        $(function(){
            $("#btnSearch").click(btnSearch_Click);

            fn=function(event){ 
                if (this==event.target){
                    if ($(this).children().is(':hidden')){
                        $(this).css('list-style-image', 'url(minus.gif)')
                            .children().show();
                            
                    }else{
                        $(this).css('list-style-image', 'url(plus.gif)')
                            .children().hide();
                    }
                }
            }
	

            $('#divCat li:has(ul)').click(fn).css('cursor', 'pointer').click();

            $('#divCat li:not(:has(ul))').css({cursor: 'default', 'list-style-image':'none'});


            

        });
    </script>

    <style>
            body {
                background-color: white;
                font-size: 12px;
                font-family: arial, sans-serf;
            }

            #divAccount{ 
                float:right;
            }

            #divAccount li{
                display: inline;
                margin: 0% 0.5%;
                font-size:12px;
            }
			#divBar { 
                width:100%; 
                height:40px;
                background:blue;
                font-size: 100%;
                clear:both;
			}
            #ulBar{
                margin: 1% 15%;
            }
            #ulBar li {
                display: inline;
                font-size: 14px;
            }
			#divBar0 { 
                clear:left;
                float:left;
            }
            #ulBar0 ul {
                margin: 0px;
                padding: 0px;
            }
            #ulBar0 li {
                display: inline;
                border-left: 1px dotted;
                padding: 0px 5px;
            }
            #divMyBar { 
                height:20px;
                width:100%; 
                background: grey;
            }

            #ulMyBar li {
                display: inline;
                font-size:12px;
                padding: 0% 2%;
            }
            #txtSearch{
                width:60%;
                height:100%;
            }

            #divCat{
                background: green;
                float:left;
                margin: 1% 1%;
                font-size: 12px;
                clear: both;
                width:15%;
            }

            #divCat li{
                margin: 1% 1%;
                padding: 1% 1%;
            }


            #divBooks {
                float:left;
                margin: 1%;
                width: 70%;
                height:100%;
                border: 1px dotted black;
                background:silver;
            }
            #divBook {
                border: 1px solid black;
                background: #bbb;
                width: 50%;
            }
            #divBook img{
                height:100px;
                width:100px;
                float:left;
            }
            #divContent{
                margin: 0% 1%;
                font-size: 12px;
            }


            #divContent span.label{
                font-family:helvetic,sans-serif;

            }
            #divContent span.value{
                font-family:,arial,verdana,helvetic,sans-serif;
            }
            #divContentBar{
                font-size:16px;
                padding: .1%;
                background:green;
            }
            #divContentBar span.by{
                font-size:12px;
            }
            #divSummary{
            }

            #divMore{
                line-height: 70%;
                padding: .5%;
                text-align: center;
                width:100%;
                clear:left;
            }
            #divMore a{
                text-decoration:none;
            }
            #divMoreBook{
                border-top: 1px black dotted;
                height: 200px;
                clear:left;
            }
            .divAdd{
                text-align: center;
                float:left;
                clear:left;
            }
            .divAdd .divToCart{
                background: #dd0000;
                width: 100px;
                border-top: 2px #990000 solid;
                border-right: 3px #aa0000 solid;
                margin: 2px 0 2px 0;
            }
            .divAdd .divToWishList{
                background: #00dd00;
                width: 100px;
                border-top: 2px #009900 solid;
                border-right: 3px #00aa00 solid;
                margin: 20px 0 2px 0;
            }
    </style>
    <title>
        ABOOK
    </title>

</head>
<body>
    <h1 style="font-size:16px;float: left;">ABOOKS.com</h1>
    <div id="divNav">
        <div id="divAccount">
            <ul>
                <li>
                    Hello Jesse
                </li>
                <li>
                    <a href="">Log out</a>
                </li>
                <li>
                    <a href="">Account Details</a>
                </li>
            </ul>
        </div>

        <div id="divBar0">
            <ul id="ulBar0">
                <li>
                    <a href="#">New Releases</a>
                </li>
                <li>
                    <a href="#">Best Sellers</a>
                </li>
                <li>
                    <a href="#">Award Winners</a>
                </li>
                <li>
                    <a href="#">Just Added</a>
                </li>
                <li>
                    <a href="#">The List of Lists</a>
                </li>
            </ul>
        </div>
        <div id="divBar">
            <ul id="ulBar"> 
                <li>
                    <select id="cboSearch">
                        <option>Keyword</option>
                        <option>Title</option>
                        <option>Author</option>
                    </select>
                </li>
                <li>
                    <input id="txtSearch" type="text" value=""/>
                </li>
                <li>
                    <button id="btnSearch" type="button">Search</button>
                </li>
            </ul>
        </div>
        <div id="divMyBar">
            <ul id="ulMyBar">
                <li> <a href="">Library</a> </li>
                <li> <a href="">Wish List</a> </li>
                <li> <a href="">Next Listen</a> </li>
            </ul>
        </div>
    </div>
    <div id="divCat">
        <ul>
            <li id='biz'>
                Business
                <ul>
                    <li>Buzzword Builders</li>
                    <li id='douch'>
                        Douchbag Inspirationals
                        <ul>
                            <li id='chuck'>
                                Chuck Norris
                            </li>
                        </ul>
                    </li>
                </ul>
            </li>
            <li>Classics</li>
            <li>Education</li>
            <li>Erotica &amp; Sexuality</li>
            <li>Fiction</li>
            <li>History</li>
            <li>Kids &amp; Young Adults</li>
            <li>Mysteries &amp; Thrillers</li>
            <li>Romance</li>
            <li>Sci-Fi &amp; Fantasy</li>
            <li>Self Development</li>
            <li>More Categories</li>
        </ul>
    </div>

    <div id="divBooks">
        <div id="divBook"/>
    </div>
</body>
