<script>
/* Show the complete message to save.*/
var ecompany = document.getElementById("completeId");
<#if save??>
	<#if "completed" == "${save?if_exists}">
	function fadeOutCompleted() {
		fadeOut(ecompany);
	}
	addLoadEvent(fadeOutCompleted);
	</#if>
<#else>
	ecompany.style.display = "none";
</#if>
</script>