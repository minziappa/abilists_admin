var timeout;

function interverKeystroke(e, num) {
	clearTimeout(timeout);
	timeout = setTimeout(function() {
	  console.log("You stopped typing. num=" + num);
	  autoSearch(e, num);
	}, 500);
}

function exceptionKeyByObj(e) {
    if(e.keyCode==37 || e.keyCode==38 || 
    		e.keyCode==39 || e.keyCode==40 ) {
        return false;
    }
    return true;
}

var ajaxLastNum = 0;

function autoSearch(e, num) {

	if(!exceptionKeyByObj(e)) {
		return false;
	}

	$(document).ready(function() {

		// Make a object
		var $inputSname = $('#searchForm').find('input[name=userId]:eq(' + num + ')');

		// Validate value's length
		if($inputSname.val().length < 2) {
			return false;
		}

		$inputSname.popover('destroy');
		
		var availableTags = [];
		var currentAjaxNum = ajaxLastNum;

        $.ajax({
            type: 'POST',
            url: '/admin/users/sltUsersListAjax',
            contentType: "application/json",
            dataType: "json",
            data: '{"userId" : "' + $inputSname.val() + '"}',
            cache: false,
            beforeSend: function(xhr, settings) {

            	ajaxLastNum = ajaxLastNum + 1;

            	// $('#search' + num).removeClass('input-search');
            	$('#search' + num).addClass('input-spinner');
            },
            success: function(data, textStatus, request) {

            	$('#search' + num).removeClass('input-spinner');
            	// $('#search' + num).addClass('input-search');

            	if(currentAjaxNum == ajaxLastNum - 1) {
                	
                	if(!isBlank(data)) {
                		console.log(data);
                		availableTags = data;
                		$('#statuses').html('<li>' + data + '</li>');
                	}
                	var availableNames = [];

                	for (var i in availableTags) {
                		availableNames[i] = availableTags[i].map1;
                	}

                	$inputSname.autocomplete();

                    // Close if already visible
                	if ($inputSname.autocomplete("widget").is(":visible")) {
                		$inputSname.autocomplete("close");
                		return false;
                	}

                	$inputSname.autocomplete({source: availableTags, 
                		autoFocus: true, 
                		minLength: 0,
                		create: function( event, ui ) {
                			console.log(" create >> ");
                		    if($(this).autocomplete('widget').is(':visible')) {
                		    	console.log(" create >> visible");
                		    } else {
                		    	console.log(" create >> desable");
                		    }
                			return true;
                		},
                		close: function( event, ui ) {
                			console.log(" close >> ");
                		},
                		open: function( event, ui ) {
                			console.log(" open >> ");
                			return true;
                		},
                		search: function( event, ui ) {
                			console.log(" search >> ");
                			return true;
                		},
                		focus: function( event, ui ) {
                			console.log(" focus >> " + ui.item.userId);
                			$inputSname.val( ui.item.userId );
                			// $(this).autocomplete("search");
                			return false;
                		},
                		select: function( event, ui ) {
                			console.log(" select >> " + ui.item.userId);
                			$inputSname.val( ui.item.userId );
                			return false;
                		}
                	})
                	.data( "ui-autocomplete" )._renderItem = function( ul, item ) {
                        return $( "<li>" ).attr( "data-value", item.userId )
                        .append("id : " + item.userId + ", name : " + item.userName + ' <img src="' + item.userImgData +'" height="50" width="50">' )
                        .appendTo( ul );
                    };

    	            // fire search event
                	$inputSname.autocomplete("search", "");
                	$inputSname.focus();

            	}

            },
            complete: function(xhr, textStatus) {
            	//$inputSname.attr('disabled', false);
            },
            error: function(xhr, status) {
            	console.log(xhr.responseText);
                var contentType = xhr.getResponseHeader("Content-Type");
                if (xhr.status === 200 && contentType.toLowerCase().indexOf("text/html") >= 0) {
                    // Login has expired - reload our current page
                    window.location.reload();
                }
            }
        });

	});
}
