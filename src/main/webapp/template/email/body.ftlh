To ${model.userId?if_exists}

This is a test

<#if model??>
${model.url?if_exists}?token1=${model.token1?if_exists}&token2=${model.token2?if_exists}
</#if>
