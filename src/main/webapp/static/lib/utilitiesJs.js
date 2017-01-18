// Auto Complete to search users.
var timeout;
function interverKeystroke(e, num) {
	clearTimeout(timeout);
	timeout = setTimeout(function() {
	  console.log("You stopped typing.");
	  autoSearch(e, num);
	}, 500);
}

var ajaxLastNum = 0;
function autoSearch(e, num) {

	if(!exceptionKey(e)) {
		return false;
	}

	$(document).ready(function() {

		var $inputAname = $('form').find('input[name=aname]:eq(' + num + ')');

		if($inputAname.val().length < 2) {
			return false;
		}

		$inputAname.popover('destroy');
		var availableTags = [];
		var currentAjaxNum = ajaxLastNum;

        $.ajax({
            type: 'POST',
            url: 'http://localhost:9001/auth/earchUsersAjax',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "json",
            data: 'body={ "text" : "' + $inputAname.val() + '"}',
            cache: false,
            beforeSend: function(xhr, settings) {

            	ajaxLastNum = ajaxLastNum + 1;

            	$('#search' + num).removeClass('input-search');
            	$('#search' + num).addClass('input-spinner');
            },
            success: function(data, textStatus, request) {
            	
            	if(currentAjaxNum == ajaxLastNum - 1) {
                	
                	if(!isBlank(data.aaa)) {
                		console.log(data.aaa);
                		availableTags = data.aaa;
                		$('#statuses').html('<li>' + data.aaa + '</li>');
                	}
                	var availableNames = [];

                	for (var i in availableTags) {
                		availableNames[i] = availableTags[i].map1;
                	}
                	console.log(availableNames);

                	var position = $inputAname.position();
                	console.log( "left: " + position.left + ", top: " + position.top );

                	createList("t01", num, availableNames);

                	$('#search' + num).removeClass('input-spinner');
                	$('#search' + num).addClass('input-search');
            	}

            },
            complete: function(xhr, textStatus) {
            	//$inputAname.attr('disabled', false);

            },
            error: function(xhr, status) {
            	console.log(xhr.responseText);
            	//alert(xhr.responseText);
            }
        });

	    console.log("4");
	});
}