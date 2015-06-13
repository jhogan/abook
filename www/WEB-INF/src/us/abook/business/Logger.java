package us.abook.business;
import javax.servlet.http.*;
// vim: set et ts=4 sw=4 fdm=marker:
public class Logger{
    private static Logger _me;
    private HttpServletResponse _httpServletResponse;
    public Logger(HttpServletResponse res){
        this.setHttpServletResponse(res);
    }
	public HttpServletResponse getHttpServletResponse(){
		return _httpServletResponse;
	}
	public void setHttpServletResponse(HttpServletResponse res){
		_httpServletResponse=res;
	}
	public void log( String msg, int level){
        HttpServletResponse res = this.getHttpServletResponse();
        if (res == null) return;
        StackTraceElement ste = new Throwable().getStackTrace()[level];
        String src = ste.getClassName();
        src+= "." + ste.getMethodName();
        src+="(" + ste.getLineNumber() + ")";
        msg = src + ": " + msg;
        try{
            res.getWriter().print(msg + "<br/>");
        }
        catch(java.io.IOException ex){
        }
	}
}
