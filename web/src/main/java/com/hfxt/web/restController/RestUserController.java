package com.hfxt.web.restController;


import com.hfxt.domain.Pager;
import com.hfxt.domain.User;
import com.hfxt.service.IUserService;
import com.hfxt.utils.PasswordUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@RequestMapping("/user")
public class RestUserController {

    @Autowired
    private IUserService userService;

    private Pager pager = new Pager();


    @ResponseBody
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(String username,String password){

        System.out.println("开始登陆"+username+"--"+password);

        UsernamePasswordToken token = new UsernamePasswordToken(username,password);

        try{
            Subject sb = SecurityUtils.getSubject();
            sb.login(token);
            return "success";
        }catch (ExcessiveAttemptsException e){
            return "NUMOUT";
        }catch (UnknownAccountException e1){
            return "NOEXITS";
        }catch (IncorrectCredentialsException e1){
            return "passError";
        }catch (AuthenticationException e1){
            e1.printStackTrace();
            return "error";
        }

    }

    @RequestMapping("/logout")
    public String logout(){
        SecurityUtils.getSubject().logout();
        return "/login.jsp";
    }


    @RequestMapping(value = "/get/{id}",produces = "text/html;charset=utf-8")
    public ModelAndView getUserById(@PathVariable("id") Integer id){
        ModelAndView mv = new ModelAndView();
        User user = userService.getUserById(id);
        mv.setViewName("/userView.jsp");
        mv.addObject("USER",user);
        return mv;
    }

    @RequestMapping(value = "/update/{id}",produces = "text/html;charset=utf-8")
    public ModelAndView getUserToUpdate(@PathVariable("id") Integer id){
        ModelAndView mv = new ModelAndView();
        User user = userService.getUserById(id);
        mv.setViewName("/userUpdate.jsp");
        mv.addObject("USER",user);
        return mv;
    }

    @RequestMapping(value = "/getAll",produces = "text/html;charset=utf-8")
    public ModelAndView getAllUser(Pager pager, String name){
        ModelAndView mv = new ModelAndView();
        if (pager==null){
            pager = this.pager;
        }
        if(name!=null){
            name = name.trim();
        }
        List<User> userList = userService.getAllUserByPage(name, pager);
        mv.setViewName("/userList.jsp");
        mv.addObject("NAME",name);
        mv.addObject("PAGE",pager);
        mv.addObject("USERLIST",userList);
        return mv;
    }


    @RequestMapping(value = "/update",method = RequestMethod.POST)
    @ResponseBody
    public String updateUser(HttpServletRequest req){

        String id = req.getParameter("id");
        String modifyBy = req.getParameter("modifyBy");
        String userName = req.getParameter("userName");
        String gender = req.getParameter("gender");
        String birthday = req.getParameter("birthday");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String userType = req.getParameter("userType");
        User user = new User();
        user.setId(Integer.parseInt(id));
        user.setModifyBy(Integer.parseInt(modifyBy));
        user.setUserName(userName);
        user.setGender(Integer.parseInt(gender));
        try {
            user.setBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(birthday));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        user.setPhone(phone);
        user.setAddress(address);
        user.setUserType(Integer.parseInt(userType));
        String s = userService.updateUserById(user);
        return s;
    }


    @RequestMapping(value = "/del/{id}",method = RequestMethod.POST)
    @ResponseBody
    public String delete(@PathVariable Integer id){
        Subject sb = SecurityUtils.getSubject();
        User user = (User)sb.getPrincipal();
        if(user.getId()==id){
            return "NOTDEL";
        }
        User u = userService.getUserById(id);
        if(u.getUserType()==1){
            return "NOTPERM";
        }
        String s = userService.delUserById(id);
        return s;
    }

    @RequestMapping("/test")
    @ResponseBody
    public String isExitsUserCode(String userCode){
        if(userCode==null){
            return "error";
        }
        User user = userService.getUserByUserCode(userCode);
        if(user!=null){
            return "exits";
        }else
            return "none";

    }

    @RequestMapping("/add")
    @ResponseBody
    public String addUser(HttpServletRequest req){
        String salt =  new SecureRandomNumberGenerator().nextBytes().toHex();
        User user = new User();
        user.setSalt(salt);
        user.setUserCode(req.getParameter("userId"));
        user.setCreateBy(Integer.parseInt(req.getParameter("createdBy")));
        user.setUserName(req.getParameter("userName"));
        user.setUserPassword(PasswordUtils.enctypePassword(req.getParameter("userpassword"),salt));
        user.setGender(Integer.parseInt(req.getParameter("gender")));
        try {
            user.setBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(req.getParameter("data")));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        user.setPhone(req.getParameter("userphone"));
        user.setAddress(req.getParameter("userAddress"));
        user.setUserType(Integer.parseInt(req.getParameter("userType")));
        String s = userService.saveUserById(user);
        return s;
    }

    @RequestMapping("/edit")
    @ResponseBody
    public String editPass(String oldPassword,String newPassword){
        User user = (User)SecurityUtils.getSubject().getPrincipal();

        if(!user.getUserPassword().equals(PasswordUtils.enctypePassword(oldPassword.trim(),user.getSalt()))){
            return "PSSWORDERROR";
        }
        user.setUserPassword(PasswordUtils.enctypePassword(newPassword.trim(),user.getSalt()));
        user.setModifyBy(user.getId());
        String s = userService.updateUserById(user);
        return s;
    }



}
