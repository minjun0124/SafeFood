package com.safefood.controller;

import com.safefood.dto.UserDto;
import com.safefood.model.domain.User;
import com.safefood.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/users")
public class UserController {

    private final UserService userService;

    private HttpSession session;

    @PostMapping("/register")
    private String userRegister(Model model, User user) {
        try {
            System.out.println(user.toString());
            userService.join(user);
            model.addAttribute("msg", "가입이 완료되었습니다. 다시 로그인 해주세요.");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "회원 저장에 실패했습니다.");
        }
        return "index";
    }

    @PostMapping("/login")
    private String userLogin(String id, String password, HttpServletRequest req) {
        log.info(id + "/" + password);
        String nextPage = "Error";
        try {
            HttpSession hs = req.getSession();
            if (userService.loginPass(id, password)) {
                hs.setAttribute("loginid", id);
                User user = userService.findById(id);
                hs.removeAttribute("msg");
                hs.setAttribute("isAdmin", user.getIsAdmin());
                hs.setAttribute("userallergy", user.getAllergy());
                nextPage = "index";
            } else {
                String msg = "아이디 또는 패스워드를 확인해주세요.";
                log.info(msg);
                req.setAttribute("loginerror", msg);
                nextPage = "redirect:/index";
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("msg", "로그인에 실패하였습니다. 잠시 후 사용해 주세요");
            nextPage = "Error";
        }
        return nextPage;
    }

    @GetMapping("/logout")
    private String userLogout(HttpServletRequest request) {
        logout(request);
        return "index";
    }

    private void logout(HttpServletRequest request) {
        session = request.getSession();
        session.removeAttribute("loginid");
        session.removeAttribute("isAdmin");
        session.removeAttribute("userallergy");
        session.setAttribute("msg", "로그아웃 되었습니다. 다시 로그인 해주세요.");
    }

    @GetMapping("/info")
    private String userMyPage(HttpServletRequest request) {
        User user;
        String sess_id = (String) request.getSession().getAttribute("loginid");
        log.info("id is: " + sess_id);
        user = userService.findById(sess_id);
        request.setAttribute("user", user);

        return "memInfo";
    }

    @GetMapping("/mod")
    private String userMod(HttpServletRequest request) {
        return "memMod";
    }

    @PostMapping("/update")
    private String userUpdate(UserDto userDto, HttpServletRequest request) {
        try {
            String id = (String) request.getSession().getAttribute("loginid");
            userDto.setId(id);
            log.info("id : " + id);
            log.info(userDto.toString());
            userService.updateUser(userDto);
            request.setAttribute("member", userDto);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/users/info";
    }

    @GetMapping("/withdraw")
    private String userDelete(HttpServletRequest request) {
        session = request.getSession();
        String id = (String) session.getAttribute("loginid");
        String nextPage = "Error";
        try {
            userService.withdrawUser(id);
            request.setAttribute("msg", "탈퇴가 완료되었습니다.");
            logout(request);
            nextPage = "index";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "탈퇴 실패하였습니다.");
            nextPage = "memInfo";
        }
        return nextPage;
    }

    @ResponseBody
    @PostMapping("/pwcheck")
    private int pwCheck(HttpServletRequest req) {
        try {
            System.out.println("isin");
            String userId = req.getParameter("id");
            String userPw = req.getParameter("pw");
            User user = userService.findById(userId);
            int result = 0;
            if (user.getPassword().equals(userPw)) {
                result = 1;
            }
            return result;
        } catch (Exception e) {
            System.out.println("error");
            e.printStackTrace();
        }
        return 0;
    }

}
