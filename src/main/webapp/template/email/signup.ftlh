To ${model.userId?if_exists}

This is a test

<#if model??>
${model.url?if_exists}?ntoken=${model.token1?if_exists}&tkn=${model.token2?if_exists}
</#if>
