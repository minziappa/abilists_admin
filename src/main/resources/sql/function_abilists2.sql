CREATE ALIAS DATE_FORMAT AS '

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
@CODE
public String dateFormat(String date) throws Exception {
	System.out.println("test >>> " + date);

	String defaultFormat = "yyyy-MM";
	SimpleDateFormat sdf = new SimpleDateFormat(defaultFormat);
	return sdf.format(date);
}
';