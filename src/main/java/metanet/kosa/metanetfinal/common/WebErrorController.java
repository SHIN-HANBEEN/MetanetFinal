package metanet.kosa.metanetfinal.common;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class WebErrorController implements ErrorController {
	
	// 에러 페이지 정의
	private final String ERROR_403_PAGE_PATH = "error/403";
	private final String ERROR_404_PAGE_PATH = "error/404";
	private final String ERROR_500_PAGE_PATH = "error/500";
	private final String ERROR_ETC_PAGE_PATH = "error/error";
	
	@RequestMapping("/error")
    public String handleError(HttpServletRequest request) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

        if (status != null) {
            Integer statusCode = Integer.valueOf(status.toString());
            
            if(statusCode == HttpStatus.FORBIDDEN.value()) {
            	return ERROR_403_PAGE_PATH;
            }
            else if(statusCode == HttpStatus.NOT_FOUND.value()) {
                return ERROR_404_PAGE_PATH;
            }
            else if(statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
                return ERROR_500_PAGE_PATH;
            }
<<<<<<< HEAD

=======
            else if (statusCode == HttpStatus.valueOf(403).value()) {
            	return ERROR_403_PAGE_PATH;
			}
>>>>>>> 94127e10193d823be32ac8cc065d03ccc80696c3
        }
        return ERROR_ETC_PAGE_PATH;
    }


}
