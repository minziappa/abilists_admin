To ${model.userId?if_exists}

Reset your password, and we'll get you on your way.

To change your Abilists password, click here or paste the following link into your browser:
If you didn't make this request, ignore this email. 

<#if model??>
${model.url?if_exists}?ntoken=${model.token1?if_exists}&tkn=${model.token2?if_exists}&userStatus=1
</#if>

This link will expire in 24 hours, so be sure to use it right away.

Thank you for using Abilists!

The Abilists Team