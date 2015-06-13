/* vim: set et ts=4 sw=4 fdm=marker:

    Copyright (C) 2008 Jesse Hogan <jessehogan0@gmail.com>
    All rights reserverd

*/
<script type="text/javascript" src="jquery-1.2.6.js"></script>
function ajaxok(data){
    alert("ajaxok");
    alert(data);
}
function ajaxerr(req, status, errorThrown){
    alert("ajaxerr: " + status);
}
function call(fn, url, params, ok){
	data = "fn=" + fn;
	if (params && params.length > 0) data += '&' + params; 
	//alert (fn + " / " + url + " / " + data);
	$.ajax({
            url: url,
            data: data,
            success: ok,
            error: ajaxerr,
            dataType: 'json'
            }
    )

}
